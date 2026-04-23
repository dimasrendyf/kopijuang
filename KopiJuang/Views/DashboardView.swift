//
//  DashboardView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    @Query(sort: \SessionHistory.date, order: .reverse) private var allSessions: [SessionHistory]
    
    var completedSessions: [SessionHistory] {
        allSessions
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        return NavigationStack {
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
                        
                        // 2. Big Learning Section
                        SensoryFlowShowcase()
                            .padding(.horizontal)
                        
                        // 3. Quick Tip
                        ProTipCard()
                            .padding(.horizontal)
                        
                        // 4. History Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Riwayat Palate")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            if completedSessions.isEmpty {
                                EmptyHistoryCard()
                                    .padding(.horizontal)
                            } else {
                                ForEach(completedSessions) { session in
                                    SessionRow(session: session)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.bottom, 90)
                }
                .navigationTitle("KopiJuang")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { viewModel.showGuide = true } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                NavigationLink(destination: CoffeeSetupView()) {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.brown)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing)
                .padding(.bottom, 18)
            }
            .sheet(isPresented: $viewModel.showGuide) {
                MasterPrepGuideView(isFirstRun: false)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SessionRow: View {
    let session: SessionHistory
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            
            VStack(alignment: .leading) {
                Text(session.beanName).font(.body.bold())
                Text(session.finalCategory).font(.caption).foregroundStyle(.secondary)
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

private struct SensoryFlowShowcase: View {
//    let flow: SensoryFlow
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Kenali notes kopimu, bertahap")
                        .font(.headline)
                    Text("Tiga langkah sederhana yang bikin hidung + lidahmu makin peka.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "sparkles")
                    .foregroundStyle(.brown)
            }
            
            TabView {
                FlowPage(
                    icon: "nose.fill",
                    title: "Fragrance",
                    subtitle: "Kopi kering (tanpa air)",
                    bodyText: "Cium bubuk kopi. Tangkap kategori dominan sebelum air mengubah karakter aromanya."
                )
                FlowPage(
                    icon: "drop.circle.fill",
                    title: "Aroma",
                    subtitle: "Kopi basah (bloom)",
                    bodyText: "Saat air panas masuk, karakter bisa “bergeser”. Catat perubahan—ini insight mahal."
                )
                FlowPage(
                    icon: "mouth.fill",
                    title: "Taste",
                    subtitle: "Diseruput + retronasal",
                    bodyText: "Seruput dengan sedikit udara, lalu hembuskan lewat hidung. Rasa jadi lebih utuh."
                )
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 200)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.brown.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.brown.opacity(0.18), lineWidth: 1)
        )
    }
}

private struct FlowPage: View {
    let icon: String
    let title: String
    let subtitle: String
    let bodyText: String
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.brown.opacity(0.12))
                    .frame(width: 54, height: 54)
                Image(systemName: icon)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.brown)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemBackground))
                        .clipShape(Capsule())
                }
                Text(bodyText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

private struct EmptyHistoryCard: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.title2)
                .foregroundStyle(.brown)
            VStack(alignment: .leading, spacing: 2) {
                Text("Belum ada sesi")
                    .font(.subheadline.bold())
                Text("Mulai 1 sesi untuk mulai membangun “palate memory”.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

#Preview {
    DashboardView()
}
