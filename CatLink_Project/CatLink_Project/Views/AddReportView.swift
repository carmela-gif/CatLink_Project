//
//  AddReportView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct AddReportView: View {
    @EnvironmentObject var reportController: ReportController
    @Environment(\.dismiss) private var dismiss

    @State private var description = ""
    @State private var location = ""
    @State private var date = ""
    @State private var condition = ""
    @State private var additionalInformation = ""

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            Form {
                Section("Cat Description") {
                    TextField("Description", text: $description, axis: .vertical)
                }

                Section("Location") {
                    TextField("Location", text: $location)
                }

                Section("Date Spotted") {
                    TextField("Date", text: $date)
                }

                Section("Condition") {
                    TextField("Condition", text: $condition)
                }

                Section("Additional Information") {
                    TextField("Additional Information", text: $additionalInformation, axis: .vertical)
                }

                Button("Submit Report") {
                    let report = StrayReport(
                        description: description,
                        location: location,
                        date: date,
                        condition: condition,
                        additionalInformation: additionalInformation,
                        status: "Needs Assistance"
                    )
                    reportController.addReport(report)
                    dismiss()
                }
                .disabled(description.isEmpty || location.isEmpty)
                .tint(Color(red: 255/255, green: 199/255, blue: 44/255))
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Report Stray Cat")
    }
}
