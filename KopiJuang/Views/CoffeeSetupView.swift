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
    @State private var roastLevel: String = ""
    @State private var processLevel: String = ""
    
    let roastOptions: [String] = ["Light", "Medium", "Dark", "Omni"]
    let processOptions: [String] = ["Natural", "Wash", "Honey", "Anaerobic", "Wet Hulled"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Informasi Beans")) {
                    TextField("Nama Kopi", text: $beanName)
                    
                    TextField("Origin", text: $beanOrigin)
                    
                    Picker("Roast Level", selection: $roastLevel) {
                        ForEach(roastOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    
                    Picker("Process Level", selection: $processLevel) {
                        ForEach(processOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                }
            }
            .navigationTitle("Persiapan Sesi")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: SensoryInputView(
                            beanName: beanName,
                            beanOrigin: beanOrigin,
                            roastLevel: roastLevel,
                            processLevel: processLevel
                        )
                    ) {
                        Label("Mulai", systemImage: "checkmark")
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brown)
                    .disabled(beanName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    CoffeeSetupView()
}
