//
//  CoffeeSetupView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 20/04/26.
//

import SwiftUI

struct CoffeeSetupView: View {
    @State private var beansName: String = ""
    @State private var grindSize: String = "Medium"
    @State private var packagingNotes: String = ""
    
    let grindOptions = ["Coarse", "Medium", "Fine"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informasi Beans")) {
                    TextField("Nama Kopi / Origin", text: $beansName)
                    
                    Picker("Grind Size", selection: $grindSize) {
                        ForEach(grindOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                }
                
                Section(header: Text("Catatan Kemasan (Optional)")) {
                    TextEditor(text: $packagingNotes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Persiapan Sesi")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SensoryInputView()) {
                        Label("Mulai", systemImage: "checkmark")
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brown)
                    .disabled(beansName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    CoffeeSetupView()
}
