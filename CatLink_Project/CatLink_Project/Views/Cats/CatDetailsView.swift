//
//  CatDetails.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct CatDetailsView: View {
    let cat: Cat

    var body: some View {
        Form {
            Section("Cat Information") {
                LabeledContent("Name", value: cat.name)
                LabeledContent("Age", value: cat.age)
                LabeledContent("Weight", value: cat.weight)
                LabeledContent("Breed", value: cat.breed)
                LabeledContent("Gender", value: cat.gender)
                LabeledContent("Health Status", value: cat.healthInformation)
            }

            Section("Recent Logs") {
                Text("No care records yet.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(cat.name)
    }
}
