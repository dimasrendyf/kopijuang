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
        NavigationStack {
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
                    
                    if !roastLevel.isEmpty {
                        Text(roastDescription(for: roastLevel))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Picker("Process", selection: $processLevel) {
                        Text("Pilih Proses...").tag("")
                        ForEach(processOptions, id: \.self) { Text($0).tag($0) }
                    }
                    
                    if !processLevel.isEmpty {
                        Text(processDescription(for: processLevel))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SensoryInputView(beanName: beanName, beanOrigin: beanOrigin, roastLevel: roastLevel, processLevel: processLevel)) {
                        Label("Mulai", systemImage: "checkmark").bold()
                    }
                    .disabled(beanName.isEmpty || roastLevel.isEmpty || processLevel.isEmpty)
                }
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
}

struct LabeledTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.brown)
            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    CoffeeSetupView()
}
