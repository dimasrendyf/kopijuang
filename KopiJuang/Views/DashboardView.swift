//
//  DashboardView.swift
//  KopiJuang
//
//  Created by Dimas Rendy Febianto on 19/04/26.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \SessionHistory.date, order: .reverse) private var allSessions: [SessionHistory]
    
    var completedSessions: [SessionHistory] {
        allSessions
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // 1. Motivational Greeting
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Halo, Future Barista!")
                            .font(.title2.bold())
                        Text("Setiap tegukan adalah langkah menuju keahlian.")
                            .font(.subheadline)
                            .foregroundStyle(Color.primary.opacity(0.72))
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
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        if completedSessions.isEmpty {
                            EmptyHistoryCard()
                                .padding(.horizontal)
                        } else {
                            ForEach(completedSessions) { session in
                                NavigationLink {
                                    SessionHistoryDetailView(session: session)
                                } label: {
                                    SessionRowLabel(session: session)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.top)
                .padding(.bottom, 90)
            }
            .navigationTitle("KopiJuang")
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SessionRowLabel: View {
    let session: SessionHistory
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            
            VStack(alignment: .leading) {
                Text(session.beanName).font(.body.bold())
                Text(session.finalCategory).font(.caption).foregroundStyle(Color.primary.opacity(0.72))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.primary.opacity(0.45))
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ProTipCard: View {
    @State private var currentIndex: Int = 0

    private var tip: CoffeeTip { CoffeeTipData.all[safe: currentIndex] ?? CoffeeTipData.all[0] }
    private var totalTips: Int { CoffeeTipData.all.count }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(CoffeeTipData.all.indices, id: \.self) { index in
                    ProTipPage(tip: CoffeeTipData.all[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 116)
            
            HStack(spacing: 5) {
                ForEach(0..<totalTips, id: \.self) { index in
                    Capsule()
                        .frame(width: index == currentIndex ? 16 : 5, height: 5)
                        .foregroundStyle(index == currentIndex ? tip.iconColor : Color(.tertiarySystemFill))
                        .animation(.spring(response: 0.3), value: currentIndex)
                }
                Spacer()
                Text("\(currentIndex + 1)/\(totalTips)")
                    .font(.caption2)
                    .foregroundStyle(Color.primary.opacity(0.55))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

private struct ProTipPage: View {
    let tip: CoffeeTip

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: tip.icon)
                    .font(.title2)
                    .foregroundStyle(tip.iconColor)
                    .frame(width: 36, height: 36)
                    .background(tip.iconColor.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text("Pro Tip")
                            .font(.caption2.bold())
                            .foregroundStyle(Color.primary.opacity(0.65))
                            .textCase(.uppercase)
                            .tracking(0.8)

                        Text(tip.source)
                            .font(.caption2.bold())
                            .foregroundStyle(tip.iconColor)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(tip.iconColor.opacity(0.12))
                            .clipShape(Capsule())
                    }

                    Text(tip.title)
                        .font(.subheadline.bold())
                }
            }

            Text(tip.body)
                .font(.caption)
                .foregroundStyle(Color.primary.opacity(0.72))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
                    Text("Tiga langkah sederhana yang bikin hidung dan lidahmu makin peka.")
                        .font(.subheadline)
                        .foregroundStyle(Color.primary.opacity(0.72))
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
                    bodyText: "Cium bubuk kopi sebelum diseduh. Ini kesempatan pertamamu — begitu air masuk, aromanya akan berubah."
                )
                FlowPage(
                    icon: "drop.circle.fill",
                    title: "Aroma",
                    subtitle: "Kopi basah (setelah bloom)",
                    bodyText: "Tuang sedikit air panas, lalu cium lagi. Aromanya beda dari tadi? Normal — air mengubah karakter kopi. Catat bedanya."
                )
                FlowPage(
                    icon: "mouth.fill",
                    title: "Taste",
                    subtitle: "Seruput pelan, hirup udara",
                    bodyText: "Jangan langsung ditelan. Seruput sambil sedikit hirup udara, lalu hembuskan lewat hidung. Rasanya jadi jauh lebih kaya."
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
                        .foregroundStyle(Color.primary.opacity(0.65))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemBackground))
                        .clipShape(Capsule())
                }
                Text(bodyText)
                    .font(.subheadline)
                    .foregroundStyle(Color.primary.opacity(0.72))
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
                    .foregroundStyle(Color.primary.opacity(0.72))
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

private extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    DashboardView()
}
