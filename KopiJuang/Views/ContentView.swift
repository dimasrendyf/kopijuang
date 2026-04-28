//
//  ContentView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 10/04/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedFirstSession") private var hasCompletedFirstSession = false

    var body: some View {
        VStack {
            Spacer()

            VStack {
                Image("img_coffee")
                    .resizable()
                    .frame(width: 250, height: 250)

                Text("Buka rahasia di balik setiap tegukan")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.medium)

                Text("Jangan cuma diminum, yuk kenalan sama karakter unik di setiap beans yang kamu seduh")
                    .padding(.top, 4)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .fontWeight(.light)
            }

            Spacer()

            Button {
                hasCompletedFirstSession = true
            } label: {
                Text("Mulai")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 16)
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
