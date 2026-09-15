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
    @State private var health = ""

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            Form {
                TextField("Cat Name", text: $name)
                TextField("Breed", text: $breed)
                TextField("Age", text: $age)
                TextField("Weight", text: $weight)

                Picker("Gender", selection: $gender) {
                    Text("Female").tag("Female")
                    Text("Male").tag("Male")
                }

                TextField("Health Information", text: $health)

                Button("Add Cat") {
                    let cat = Cat(
                        name: name,
                        breed: breed,
                        age: age,
                        weight: weight,
                        gender: gender,
                        healthInformation: health
                    )
                    catController.addCat(cat)
                    dismiss()
                }
                .disabled(name.isEmpty || breed.isEmpty)
                .tint(Color(red: 255/255, green: 199/255, blue: 44/255))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Add Cat")
    }
}
