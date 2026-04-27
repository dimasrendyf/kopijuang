//
//  CoffeeSetupView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct CoffeeSetupView: View {
    @State private var viewModel = CoffeeSetupViewModel()
    @AppStorage("shouldExpandCuppingChecklistOnFirstOpen") private var shouldExpandChecklist = true
    @State private var checklistExpanded = true
    
    var body: some View {
        @Bindable var viewModel = viewModel
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Siapkan Cangkirmu")
                        .font(.title.bold())
                    
                    Text("Ceritakan sedikit tentang kopi ini. Kami memandu indramu menemukan rasa di cangkir.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .listRowBackground(Color.clear)
            
            CuppingChecklistSection(isExpanded: $checklistExpanded)
            
            Section {
                LabeledTextField(icon: "leaf.fill", placeholder: "Nama kopi (contoh: Gayo)", text: $viewModel.beanName)
                LabeledTextField(icon: "map.fill", placeholder: "Origin (contoh: Ethiopia)", text: $viewModel.beanOrigin)
                
                Picker("Roast", selection: $viewModel.roastLevel) {
                    Text("Pilih level…").tag("")
                    ForEach(viewModel.roastOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.navigationLink)
                if !viewModel.roastLevel.isEmpty {
                    Text(viewModel.roastDescription(for: viewModel.roastLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Picker("Proses", selection: $viewModel.processLevel) {
                    Text("Pilih proses…").tag("")
                    ForEach(viewModel.processOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.navigationLink)
                if !viewModel.processLevel.isEmpty {
                    Text(viewModel.processDescription(for: viewModel.processLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("Detail beans")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            .padding(.top, 24)
        }
        .scrollDismissesKeyboard(.interactively)
        .onAppear {
            if shouldExpandChecklist {
                checklistExpanded = true
                shouldExpandChecklist = false
            }
        }
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
