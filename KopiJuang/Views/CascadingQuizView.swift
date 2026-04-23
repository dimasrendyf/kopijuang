//
//  CascadingQuizView.swift
//  KopiJuang
//

import SwiftUI
import SwiftData

struct CascadingQuizView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var userProgresses: [UserProgress]
    
    let evaluation: SensoryEvaluation
    let parentNodeId: String
    
    @State private var parentNode: FlavorWheelNode?
    @State private var showingFeedback = false
    @State private var isCorrect = false
    @State private var selectedNode: FlavorWheelNode?
    
    // For navigation to specific/achievement
    @State private var navigateToNext = false
    @State private var navigateToAchievement = false
    @State private var isFinished = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let parent = parentNode {
                Text("Tebak Rasa \(parent.layer == 1 ? "Secondary" : "Spesifik")")
                    .font(.title2.bold())
                
                Text("Kamu sudah menebak bahwa kopi ini dominan rasa \(parent.name). Sekarang, rasa spesifik apa yang paling kamu rasakan?")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(parent.children) { child in
                        Button {
                            handleGuess(child)
                        } label: {
                            VStack(spacing: 8) {
                                Text(child.name)
                                    .font(.headline)
                                Text(child.description)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(selectedNode?.id == child.id ? Color.brown.opacity(0.15) : Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(selectedNode?.id == child.id ? Color.brown : Color(.systemGray4), lineWidth: 1)
                            )
                            .cornerRadius(16)
                            .foregroundStyle(Color.primary)
                        }
                    }
                }
                .padding()
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .padding(.top)
        .background(Color(.secondarySystemBackground))
        .navigationTitle(parentNode?.name ?? "Quiz")
        .onAppear {
            parentNode = FlavorWheelNode.findNode(by: parentNodeId)
        }
        .sheet(isPresented: $showingFeedback) {
            FeedbackView(
                isCorrect: isCorrect,
                message: isCorrect ? "Luar biasa! Pengecapanmu sangat presisi!" : "Sayang sekali, masih kurang tepat. Coba terus bereksplorasi!",
                category: FlavorCategory(rawValue: parentNode?.name ?? "Fruity") ?? .fruity, // Fallback
                nextAction: {
                    showingFeedback = false
                    if isCorrect {
                        if selectedNode?.children.isEmpty == false {
                            // Go to specific
                            navigateToNext = true
                        } else {
                            // Finish and show achievement
                            saveSession(completed: true)
                            navigateToAchievement = true
                        }
                    }
                }
            )
        }
        .navigationDestination(isPresented: $navigateToNext) {
            if let selected = selectedNode {
                CascadingQuizView(evaluation: evaluation, parentNodeId: selected.id)
            }
        }
        .navigationDestination(isPresented: $navigateToAchievement) {
            AchievementView(evaluation: evaluation)
        }
    }
    
    private func handleGuess(_ child: FlavorWheelNode) {
        selectedNode = child
        // Karena ini belajar mandiri, di sini tebakan kita anggap "benar" saja untuk memberi reward (atau bisa dikasih logika khusus)
        // MVP: anggap benar karena tidak ada cara tahu pasti tanpa validator.
        isCorrect = true
        
        let progress = userProgresses.first ?? UserProgress()
        if userProgresses.isEmpty {
            modelContext.insert(progress)
        }
        
        if child.layer == 2 {
            progress.unlockedSecondaryNotes.append(child.name)
        } else if child.layer == 3 {
            progress.unlockedSpecificNotes.append(child.name)
        }
        progress.totalCorrectGuesses += 1
        
        try? modelContext.save()
        showingFeedback = true
    }
    
    private func saveSession(completed: Bool) {
        let progress = userProgresses.first ?? UserProgress()
        if userProgresses.isEmpty {
            modelContext.insert(progress)
        }
        let history = SessionHistory(
            beanName: evaluation.beanName,
            roastLevel: evaluation.roastLevel,
            processLevel: evaluation.processLevel,
            finalCategory: evaluation.tasteCategory.rawValue
        )
        progress.completedSessions.append(history)
        try? modelContext.save()
    }
}
