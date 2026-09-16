//
//  CatDetails.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct CatDetailsView: View {
    let cat: Cat
 
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "cat.fill")
                        .font(.system(size: 50))
                        .frame(width: 120, height: 120)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Circle())
 
                    Text(cat.displayID)
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Capsule())
 
                    LazyVGrid(columns: columns, spacing: 14) {
                        infoCard("Name", cat.name)
                        infoCard("Breed", cat.breed)
                        infoCard("Age", cat.age)
                        infoCard("Gender", cat.gender)
                        infoCard("Weight", cat.weight)
                        infoCard("Health Status", cat.healthInformation, valueColor: .green)
                    }
 
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Logs")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
 
                        HStack(alignment: .top, spacing: 10) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.green)
                                .frame(width: 4)
                            Text("No care records yet.")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Theme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding(24)
            }
        }
        .navigationTitle(cat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
 
    private func infoCard(_ label: String, _ value: String, valueColor: Color = .black) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.headline).foregroundStyle(valueColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
 
#Preview {
    CatDetailsView(cat: Cat(
        name: "Luna", breed: "British Shorthair", age: "2 Years",
        weight: "4.2 kg", gender: "Female", healthInformation: "Healthy",
        colorPattern: "Lilac-Cream"
    ))
}
