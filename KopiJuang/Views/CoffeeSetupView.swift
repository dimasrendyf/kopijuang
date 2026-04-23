//
//  CoffeeSetupView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct CoffeeSetupView: View {
    @State private var viewModel = CoffeeSetupViewModel()

    var body: some View {
        @Bindable var viewModel = viewModel
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Siapkan Cangkirmu")
                        .font(.title.bold())

                    Text("Ceritakan sedikit tentang kopi ini. Kami akan memandu indramu untuk menemukan rasa tersembunyi di dalamnya.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 10)
            }
            .listRowBackground(Color.clear)

            Section("Detail Beans") {
                LabeledTextField(icon: "leaf.fill", placeholder: "Nama Kopi (contoh: Gayo)", text: $viewModel.beanName)
                LabeledTextField(icon: "map.fill", placeholder: "Origin (contoh: Ethiopia)", text: $viewModel.beanOrigin)

                Picker("Roast Level", selection: $viewModel.roastLevel) {
                    Text("Pilih Level...").tag("")
                    ForEach(viewModel.roastOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.navigationLink)

                if !viewModel.roastLevel.isEmpty {
                    Text(viewModel.roastDescription(for: viewModel.roastLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Picker("Process", selection: $viewModel.processLevel) {
                    Text("Pilih Proses...").tag("")
                    ForEach(viewModel.processOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.navigationLink)

                if !viewModel.processLevel.isEmpty {
                    Text(viewModel.processDescription(for: viewModel.processLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if viewModel.showBeanInsight {
                Section("Prediksi Karakter Cangkir") {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Insight Roast", systemImage: "flame.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.brown)
                        Text(viewModel.roastDescription(for: viewModel.roastLevel))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Divider()

                        Label("Insight Process", systemImage: "drop.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.brown)
                        Text(viewModel.processDescription(for: viewModel.processLevel))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Divider()

                        Text("Fokus rasa awal: \(viewModel.focusHint(roast: viewModel.roastLevel, process: viewModel.processLevel))")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.brown)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: SensoryInputView(
                        beanName: viewModel.beanName,
                        beanOrigin: viewModel.beanOrigin,
                        roastLevel: viewModel.roastLevel,
                        processLevel: viewModel.processLevel
                    )
                ) {
                    Label("Mulai", systemImage: "checkmark").bold()
                }
                .disabled(!viewModel.canStart)
            }
        }
    }
}

#Preview {
    CoffeeSetupView()
}
