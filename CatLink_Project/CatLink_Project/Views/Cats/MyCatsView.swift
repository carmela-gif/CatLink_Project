//
//  MyCatsView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct MyCatsView: View {
    @EnvironmentObject var catController: CatController
 
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Theme.background.ignoresSafeArea()
 
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("My Cats").font(.largeTitle.bold())
                            Text("Manage pet logs, metrics & diets")
                                .foregroundStyle(.secondary)
                        }
 
                        VStack(spacing: 16) {
                            ForEach(catController.cats) { cat in
                                NavigationLink {
                                    CatDetailsView(cat: cat)
                                } label: {
                                    catCard(cat)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(24)
                    .padding(.bottom, 80)
                }
 
                NavigationLink {
                    AddCatView()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.black)
                        .frame(width: 56, height: 56)
                        .background(Theme.accentYellow)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(24)
            }
            .navigationBarHidden(true)
        }
    }
 
    private func catCard(_ cat: Cat) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: "cat.fill")
                .font(.system(size: 30))
                .foregroundStyle(.black.opacity(0.6))
                .frame(width: 64, height: 64)
                .background(Color.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 14))
 
            VStack(alignment: .leading, spacing: 4) {
                Text(cat.name).font(.title3.bold())
                Text(cat.breed).foregroundStyle(.secondary)
                HStack(spacing: 12) {
                    Label(cat.age, systemImage: "clock")
                    if !cat.colorPattern.isEmpty {
                        Label(cat.colorPattern, systemImage: "pawprint")
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
 
            Spacer()
 
            Text(cat.gender)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(cat.gender == "Female" ? Theme.accentPurple.opacity(0.15) : Color.blue.opacity(0.15))
                .foregroundStyle(cat.gender == "Female" ? Theme.accentPurple : .blue)
                .clipShape(Capsule())
        }
        .padding()
        .background(Theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
 
#Preview {
    MyCatsView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
