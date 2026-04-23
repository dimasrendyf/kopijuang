//
//  CascadingQuizView.swift
//  KopiJuang
//

import SwiftUI
import SwiftData

struct CascadingQuizView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userProgresses: [UserProgress]

    @State private var viewModel: CascadingQuizViewModel

    init(
        evaluation: SensoryEvaluation,
        selectedPrimaryCategory: FlavorCategory,
        parentNodeId: String
    ) {
        _viewModel = State(
            wrappedValue: CascadingQuizViewModel(
                evaluation: evaluation,
                selectedPrimaryCategory: selectedPrimaryCategory,
                parentNodeId: parentNodeId
            )
        )
    }

    var body: some View {
        VStack(spacing: 20) {
            if let parent = viewModel.parentNode {
                Text("Eksplorasi Rasa \(parent.layer == 1 ? "Secondary" : "Spesifik")")
                    .font(.title2.bold())

                Text(viewModel.transitionPrompt(for: parent))
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(parent.children) { child in
                        Button {
                            viewModel.selectChild(child)
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
                            .background(
                                viewModel.selectedNode?.id == child.id ? Color.brown.opacity(0.15) : Color(.systemBackground)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(viewModel.selectedNode?.id == child.id ? Color.brown : Color(.systemGray4), lineWidth: 1)
                            )
                            .cornerRadius(16)
                            .foregroundStyle(Color.primary)
                        }
                    }
                }
                .padding()

                VStack(spacing: 10) {
                    if let selectedNode = viewModel.selectedNode {
                        Text("Pilihanmu: \(selectedNode.name).")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Pilih satu opsi yang paling mendekati sensasi kamu.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Button {
                        viewModel.continueExploration(modelContext: modelContext, userProgresses: userProgresses)
                    } label: {
                        Text(viewModel.primaryActionTitle)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedNode == nil ? Color.gray.opacity(0.25) : Color.brown)
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                    .disabled(viewModel.selectedNode == nil)
                }
                .padding(.horizontal)
            } else {
                ProgressView()
            }

            Spacer()
        }
        .padding(.top)
        .background(Color(.secondarySystemBackground))
        .navigationTitle(viewModel.parentNode?.name ?? "Eksplorasi")
        .navigationDestination(isPresented: $viewModel.navigateToNext) {
            if let selected = viewModel.selectedNode {
                CascadingQuizView(
                    evaluation: viewModel.evaluation,
                    selectedPrimaryCategory: viewModel.selectedPrimaryCategory,
                    parentNodeId: selected.id
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToFinalAnalysis) {
            FinalAnalysisView(
                evaluation: viewModel.evaluation,
                primaryCategory: viewModel.selectedPrimaryCategory,
                selectedNode: viewModel.selectedNode
            )
        }
    }
}
