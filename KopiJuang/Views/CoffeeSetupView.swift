//
//  CoffeeSetupView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct CoffeeSetupView: View {
    @State private var beanName: String = ""
    @State private var beanOrigin: String = ""
    @State private var roastLevel: String = "" // Jangan isi default
    @State private var processLevel: String = "" // Jangan isi default
    
    let roastOptions: [String] = ["Light", "Medium", "Dark", "Omni"]
    let processOptions: [String] = ["Natural", "Wash", "Honey", "Anaerobic", "Wet Hulled"]
    
    var body: some View {
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
                LabeledTextField(icon: "leaf.fill", placeholder: "Nama Kopi (contoh: Gayo)", text: $beanName)
                LabeledTextField(icon: "map.fill", placeholder: "Origin (contoh: Ethiopia)", text: $beanOrigin)
                
                // FIX PICKER: Tambahkan tag kosong
                Picker("Roast Level", selection: $roastLevel) {
                    Text("Pilih Level...").tag("")
                    ForEach(roastOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.menu)
                
                if !roastLevel.isEmpty {
                    Text(roastDescription(for: roastLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Picker("Process", selection: $processLevel) {
                    Text("Pilih Proses...").tag("")
                    ForEach(processOptions, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.menu)
                
                if !processLevel.isEmpty {
                    Text(processDescription(for: processLevel))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            if !roastLevel.isEmpty && !processLevel.isEmpty {
                Section("Prediksi Karakter Cangkir") {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Insight Roast", systemImage: "flame.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.brown)
                        Text(roastDescription(for: roastLevel))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        Label("Insight Process", systemImage: "drop.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(.brown)
                        Text(processDescription(for: processLevel))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Divider()
                        
                        Text("Fokus rasa awal: \(focusHint(roast: roastLevel, process: processLevel))")
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
                NavigationLink(destination: SensoryInputView(beanName: beanName, beanOrigin: beanOrigin, roastLevel: roastLevel, processLevel: processLevel)) {
                    Label("Mulai", systemImage: "checkmark").bold()
                }
                .disabled(beanName.isEmpty || roastLevel.isEmpty || processLevel.isEmpty)
            }
        }
    }
    
    func roastDescription(for level: String) -> String {
        switch level {
        case "Light": return "Acidity lebih terbaca, body ringan, notes origin lebih jelas."
        case "Medium": return "Balance antara acidity dan body."
        case "Dark": return "Body tebal, bitterness dominan, notes roast (cokelat, smoky)."
        case "Omni": return "Fleksibel untuk filter maupun espresso."
        default: return ""
        }
    }
    
    func processDescription(for process: String) -> String {
        switch process {
        case "Natural": return "Cenderung fruity, body lebih tebal, sweetness tinggi."
        case "Wash": return "Clean, acidity lebih jelas, notes lebih defined."
        case "Honey": return "Di antara natural dan washed, sweetness menonjol."
        case "Anaerobic": return "Notes eksotik, seringkali ada karakter fermentasi/winey."
        case "Wet Hulled": return "Body sangat tebal, acidity rendah, notes earthy/spicy khas Indonesia."
        default: return ""
        }
    }
    
    func focusHint(roast: String, process: String) -> String {
        switch (roast.lowercased(), process.lowercased()) {
        case ("light", "natural"):
            return "cek acidity cerah + sweetness fruity."
        case ("light", "wash"), ("light", "washed"):
            return "cek kejernihan acidity dan clean finish."
        case ("dark", _):
            return "cek body, bitterness, dan ketebalan aftertaste."
        case (_, "honey"):
            return "cek sweetness round dan mouthfeel nyaman."
        case (_, "wet hulled"):
            return "cek body tebal dan earthy note."
        default:
            return "cek keseimbangan acidity, sweetness, bitterness, dan body."
        }
    }
}

struct LabeledTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: icon)
                .foregroundStyle(.brown)
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.words)
        }
    }
}

#Preview {
    CoffeeSetupView()
}
