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
    @State private var selectedNode: FlavorWheelNode?
    
    // For navigation to specific/final analysis
    @State private var navigateToNext = false
    @State private var navigateToFinalAnalysis = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let parent = parentNode {
                Text("Eksplorasi Rasa \(parent.layer == 1 ? "Secondary" : "Spesifik")")
                    .font(.title2.bold())
                
                Text(transitionPrompt(for: parent))
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
                
                VStack(spacing: 10) {
                    if let selectedNode {
                        Text("Pilihanmu: \(selectedNode.name).")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Pilih satu opsi yang paling mendekati sensasi kamu.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Button {
                        continueExploration()
                    } label: {
                        Text(parent.children.first(where: { $0.id == selectedNode?.id })?.children.isEmpty == false ? "Lanjut ke Layer Berikutnya" : "Selesai & Lihat Analisis Final")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedNode == nil ? Color.gray.opacity(0.25) : Color.brown)
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                    .disabled(selectedNode == nil)
                }
                .padding(.horizontal)
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .padding(.top)
        .background(Color(.secondarySystemBackground))
        .navigationTitle(parentNode?.name ?? "Eksplorasi")
        .onAppear {
            parentNode = FlavorWheelNode.findNode(by: parentNodeId)
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
    }
    
    private func continueExploration() {
        guard let node = selectedNode else { return }
        saveExploration(for: node)
        
        if node.children.isEmpty {
            saveSession(completed: true)
            navigateToFinalAnalysis = true
        } else {
            navigateToNext = true
        }
    }
    
    private func transitionPrompt(for parent: FlavorWheelNode) -> String {
        if parent.layer == 1 {
            return "\(parent.name) itu luas. Turunan rasa mana yang paling mendekati rasa kopimu?"
        }
        return "Bagus. Sekarang pilih note paling spesifik yang paling terasa dari \(parent.name)."
    }
    
    private func saveExploration(for child: FlavorWheelNode) {
        
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
        progress.appendExperiencedNote(child.name)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed saving Cascading guess: \(error.localizedDescription)")
        }
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
