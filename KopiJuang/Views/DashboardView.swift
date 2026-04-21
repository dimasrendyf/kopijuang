//
//  DashboardView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var showGuide = false
    
    let sessions: [CoffeeSession] = [
        CoffeeSession(title: "Ethiopia Yirgacheffe", flavor: "Fruity", isCompleted: true),
        CoffeeSession(title: "Sumatra Mandheling", flavor: "Earthy", isCompleted: true),
        CoffeeSession(title: "Java Frinsa", flavor: "Floral", isCompleted: false)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 1. Motivational Greeting
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Halo, Future Barista!")
                                .font(.title2.bold())
                            Text("Setiap tegukan adalah langkah menuju keahlian.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal)
                        
                        // 2. Pro Tip Card (New!)
                        ProTipCard()
                            .padding(.horizontal)
                        
                        // 3. History Section
                        VStack(alignment: .leading, spacing: 20) {
                            if sessions.contains(where: { !$0.isCompleted }) {
                                Text("Target Icip")
                                    .font(.headline)
                                    .padding(.horizontal)
                                ForEach(sessions.filter { !$0.isCompleted }) { session in
                                    SessionRow(session: session)
                                }
                            }
                            
                            Text("Riwayat Palate")
                                .font(.headline)
                                .padding(.horizontal)
                            ForEach(sessions.filter { $0.isCompleted }) { session in
                                SessionRow(session: session)
                            }
                        }
                    }
                    .padding(.top)
                }
                .navigationTitle("Palate")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { showGuide = true } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .sheet(isPresented: $showGuide) {
                MasterPrepGuideView(isFirstRun: false)
            }
            
            HStack{
                Spacer()
                NavigationLink(destination: CoffeeSetupView()) {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.brown)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
            }
            .padding(.trailing)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SessionRow: View {
    let session: CoffeeSession
    var body: some View {
        HStack {
            Image(systemName: session.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(session.isCompleted ? .green : .secondary)
            
            VStack(alignment: .leading) {
                Text(session.title).font(.body.bold())
                Text(session.flavor).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ProTipCard: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "lightbulb.fill")
                .font(.title)
                .foregroundStyle(.yellow)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Pro Tip: Sensory Window")
                    .font(.subheadline.bold())
                Text("Sensitivitas lidah terhadap asam & manis berada di puncak pada suhu 50-60°C.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

#Preview {
    DashboardView()
}
