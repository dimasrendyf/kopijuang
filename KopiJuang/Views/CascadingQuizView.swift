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
    let selectedPrimaryCategory: FlavorCategory
    let parentNodeId: String
    
    @State private var parentNode: FlavorWheelNode?
    @State private var showingFeedback = false
    @State private var isCorrect = false
    @State private var selectedNode: FlavorWheelNode?
    
    // For navigation to specific/final analysis
    @State private var navigateToNext = false
    @State private var navigateToFinalAnalysis = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let parent = parentNode {
                Text("Eksplorasi Rasa \(parent.layer == 1 ? "Secondary" : "Spesifik")")
                    .font(.title2.bold())
                
                Text("Kamu memilih \(parent.name). Dari opsi di bawah, mana yang paling mendekati pengalaman rasamu?")
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
                message: isCorrect ? "Tercatat. Semakin sering kamu melatih note ini, semakin tinggi familiarity-mu." : "Coba lagi dan pilih yang paling mendekati sensasi yang kamu rasakan.",
                category: FlavorCategory(rawValue: parentNode?.name ?? "Fruity") ?? .fruity, // Fallback
                nextAction: {
                    showingFeedback = false
                    if isCorrect {
                        if selectedNode?.children.isEmpty == false {
                            // Go to specific
                            navigateToNext = true
                        } else {
                            // Finish and show final analysis
                            saveSession(completed: true)
                            navigateToFinalAnalysis = true
                        }
                    }
                }
            )
        }
        .navigationDestination(isPresented: $navigateToNext) {
            if let selected = selectedNode {
                CascadingQuizView(
                    evaluation: evaluation,
                    selectedPrimaryCategory: selectedPrimaryCategory,
                    parentNodeId: selected.id
                )
            }
        }
        .navigationDestination(isPresented: $navigateToFinalAnalysis) {
            FinalAnalysisView(
                evaluation: evaluation,
                primaryCategory: selectedPrimaryCategory,
                selectedNode: selectedNode
            )
        }
    }
    
    private func handleGuess(_ child: FlavorWheelNode) {
        selectedNode = child
        // Tahap ini eksploratif, tidak memakai benar/salah.
        isCorrect = true
        
        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        
        if child.layer == 2 {
            if !progress.unlockedSecondaryNotes.contains(child.name) {
                progress.unlockedSecondaryNotes.append(child.name)
            }
        } else if child.layer == 3 {
            if !progress.unlockedSpecificNotes.contains(child.name) {
                progress.unlockedSpecificNotes.append(child.name)
            }
        }
        progress.experiencedNotes.append(child.name)
        progress.totalCorrectGuesses += 1
        
        do {
            try modelContext.save()
        } catch {
            print("Failed saving Cascading guess: \(error.localizedDescription)")
        }
        showingFeedback = true
    }
    
    private func saveSession(completed: Bool) {
        guard completed else { return }

        let progress = UserProgressStore.primary(from: userProgresses, in: modelContext)
        let history = SessionHistory(
            beanName: evaluation.beanName,
            roastLevel: evaluation.roastLevel,
            processLevel: evaluation.processLevel,
            finalCategory: selectedPrimaryCategory.rawValue
        )
        modelContext.insert(history)
        progress.completedSessions.append(history)
        do {
            try modelContext.save()
        } catch {
            print("Failed saving session history: \(error.localizedDescription)")
        }
    }
}
