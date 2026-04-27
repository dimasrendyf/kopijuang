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

                    if viewModel.currentGuidance != nil {
                        Button {
                            viewModel.showGuidanceSheet = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "questionmark.circle")
                                    .font(.subheadline)
                                Text("Bingung pilih yang mana?")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundStyle(.brown)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.brown.opacity(0.5), lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $viewModel.showGuidanceSheet) {
                    if let guidance = viewModel.currentGuidance,
                       let parent = viewModel.parentNode {
                        FlavorGuidanceSheet(guidance: guidance, parentNode: parent)
                    }
                }
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

// MARK: - Guidance Sheet

struct FlavorGuidanceSheet: View {
    @Environment(\.dismiss) private var dismiss
    let guidance: FlavorNodeGuidance
    let parentNode: FlavorWheelNode

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Intro
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Cara membedakan", systemImage: "lightbulb.fill")
                            .font(.caption.bold())
                            .foregroundStyle(.brown)
                            .textCase(.uppercase)
                            .tracking(0.6)

                        Text(guidance.intro)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.brown.opacity(0.07))
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                    // Per-child hints
                    VStack(spacing: 12) {
                        ForEach(parentNode.children) { child in
                            if let hint = guidance.hints.first(where: { $0.nodeId == child.id }) {
                                FlavorHintRow(node: child, hint: hint.sensoryHint)
                            }
                        }
                    }

                    // SCA note
                    Text("Panduan ini berdasarkan SCA Flavor Wheel & WCR Sensory Lexicon. Deskriptor bersifat subjektif — catat apa yang kamu rasakan, bukan apa yang seharusnya.")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .padding(.top, 4)
                }
                .padding()
            }
            .navigationTitle("Panduan \(parentNode.name)")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.fill")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

private struct FlavorHintRow: View {
    let node: FlavorWheelNode
    let hint: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 2) {
                Text(node.name)
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(node.description)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)

            Rectangle()
                .frame(width: 1)
                .foregroundStyle(Color(.systemGray4))

            Text(hint)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}
