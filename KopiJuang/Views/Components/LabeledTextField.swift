//
//  LabeledTextField.swift
//  KopiJuang
//

import SwiftUI

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
