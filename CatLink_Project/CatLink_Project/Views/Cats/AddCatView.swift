//
//  AddCatView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct AddCatView: View {
    @EnvironmentObject var catController: CatController
    @Environment(\.dismiss) private var dismiss
 
    @State private var name = ""
    @State private var breed = ""
    @State private var age = ""
    @State private var weight = ""
    @State private var gender = "Female"
    @State private var colorPattern = ""
    @State private var health = ""
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Group {
                        Text("Cat Name").font(.subheadline).fontWeight(.semibold)
                        TextField("Luna", text: $name).roundedField()
                    }
 
                    Group {
                        Text("Breed").font(.subheadline).fontWeight(.semibold)
                        TextField("British Shorthair", text: $breed).roundedField()
                    }
 
                    HStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Age").font(.subheadline).fontWeight(.semibold)
                            TextField("1 Year", text: $age).roundedField()
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Weight").font(.subheadline).fontWeight(.semibold)
                            TextField("4.2 kg", text: $weight).roundedField()
                        }
                    }
 
                    Group {
                        Text("Gender").font(.subheadline).fontWeight(.semibold)
                        HStack(spacing: 0) {
                            genderButton("Male")
                            genderButton("Female")
                        }
                        .padding(4)
                        .background(Color.white.opacity(0.6))
                        .clipShape(Capsule())
                    }
 
                    Group {
                        Text("Color / Pattern").font(.subheadline).fontWeight(.semibold)
                        TextField("Lilac-Cream", text: $colorPattern).roundedField()
                    }
 
                    Group {
                        Text("Health Information").font(.subheadline).fontWeight(.semibold)
                        TextField("Allergies, vaccinations, notes...", text: $health, axis: .vertical)
                            .lineLimit(3...6)
                            .roundedField()
                    }
 
                    Button(action: {
                        let cat = Cat(
                            name: name,
                            breed: breed,
                            age: age,
                            weight: weight,
                            gender: gender,
                            healthInformation: health,
                            colorPattern: colorPattern
                        )
                        catController.addCat(cat)
                        dismiss()
                    }) {
                        Text("Add Cat")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.accentYellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .disabled(name.isEmpty || breed.isEmpty)
                }
                .padding(24)
            }
        }
        .navigationTitle("Add Cat")
        .navigationBarTitleDisplayMode(.inline)
    }
 
    private func genderButton(_ value: String) -> some View {
        Button {
            gender = value
        } label: {
            Text(value)
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(gender == value ? Color.white : Color.clear)
                .clipShape(Capsule())
                .foregroundStyle(.black)
        }
    }
}
 
#Preview {
    AddCatView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
