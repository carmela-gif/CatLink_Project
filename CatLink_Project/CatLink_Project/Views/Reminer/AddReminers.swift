//
//  AddReminers.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//


import SwiftUI
 
struct AddReminderView: View {
    @EnvironmentObject var reminderController: ReminderController
    @Environment(\.dismiss) private var dismiss
 
    @State private var title = ""
    @State private var description = ""
    @State private var date = ""
    @State private var tag: ReminderTag = .feeding
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 36, height: 36)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        Text("Add Reminder")
                            .font(.title2.bold())
                    }
 
                    Group {
                        Text("Reminder Title").font(.subheadline).fontWeight(.semibold)
                        TextField("e.g. Feed Luna", text: $title)
                            .roundedField()
                    }
 
                    Group {
                        Text("Description").font(.subheadline).fontWeight(.semibold)
                        TextField("e.g. Wet food • 1/2 can", text: $description, axis: .vertical)
                            .roundedField()
                    }
 
                    Group {
                        Text("Date & Time").font(.subheadline).fontWeight(.semibold)
                        HStack {
                            Image(systemName: "calendar").foregroundStyle(.secondary)
                            TextField("e.g. Today, 6:00 PM", text: $date)
                        }
                        .roundedField()
                    }
 
                    Group {
                        Text("Category").font(.subheadline).fontWeight(.semibold)
                        HStack(spacing: 10) {
                            categoryButton(.feeding, label: "Feeding")
                            categoryButton(.medication, label: "Medication")
                            categoryButton(.vet, label: "Vet")
                            categoryButton(.grooming, label: "Grooming")
                        }
                    }
 
                    Button(action: {
                        let reminder = CareReminder(
                            title: title,
                            description: description,
                            date: date,
                            tag: tag
                        )
                        reminderController.addReminder(reminder)
                        dismiss()
                    }) {
                        Text("Add Reminder")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.accentYellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .disabled(title.isEmpty || date.isEmpty)
                }
                .padding(24)
            }
        }
        .navigationBarHidden(true)
    }
 
    @ViewBuilder
    private func categoryButton(_ value: ReminderTag, label: String) -> some View {
        Button {
            tag = value
        } label: {
            Text(label)
                .font(.footnote.weight(.semibold))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(tag == value ? value.color.opacity(0.25) : Color.white)
                .foregroundStyle(tag == value ? .black : .gray)
                .clipShape(Capsule())
        }
    }
}
 
#Preview {
    AddReminderView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
 
