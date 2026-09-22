//
//  AddReportView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
import PhotosUI

struct AddReportView: View {
    @EnvironmentObject var reportController: ReportController
    @Environment(\.dismiss) private var dismiss

    @State private var description = ""
    @State private var location = ""
    @State private var date = ""
    @State private var condition = "Injured"
    @State private var additionalInformation = ""
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil

    private let conditions = ["Healthy", "Injured", "Sick", "Unknown"]

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
                                .foregroundStyle(.black)
                        }
                        Text("Report Stray Cat")
                            .font(.title2.bold())
                    }

                    Group {
                        Text("Cat Description").font(.subheadline).fontWeight(.semibold)
                        TextField("Orange tabby, medium size", text: $description, axis: .vertical)
                            .roundedField()
                    }

                    Group {
                        Text("Location").font(.subheadline).fontWeight(.semibold)
                        HStack {
                            Image(systemName: "mappin.and.ellipse").foregroundStyle(.secondary)
                            TextField("Maple Street Park", text: $location)
                        }
                        .roundedField()
                    }

                    Group {
                        Text("Date Spotted").font(.subheadline).fontWeight(.semibold)
                        HStack {
                            Image(systemName: "calendar").foregroundStyle(.secondary)
                            TextField("Today, September 3, 2026", text: $date)
                        }
                        .roundedField()
                    }

                    Group {
                        Text("Condition").font(.subheadline).fontWeight(.semibold)
                        Menu {
                            ForEach(conditions, id: \.self) { option in
                                Button(option) { condition = option }
                            }
                        } label: {
                            HStack {
                                Text(condition).foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundStyle(.secondary)
                            }
                            .roundedField()
                        }
                    }

                    Group {
                        Text("Additional Information").font(.subheadline).fontWeight(.semibold)
                        TextField("Found near the playground entrance...", text: $additionalInformation, axis: .vertical)
                            .lineLimit(3...6)
                            .roundedField()
                    }

                    Group {
                        Text("Add Photo").font(.subheadline).fontWeight(.semibold)
                        
                        PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                            if let selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "camera")
                                        .font(.title)
                                        .foregroundStyle(Theme.accentPurple)
                                    Text("Tap to add photo")
                                        .foregroundStyle(Theme.accentPurple)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [6]))
                                        .foregroundStyle(.gray.opacity(0.5))
                                )
                            }
                        }
                        .onChange(of: selectedPhotoItem) { oldItem, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = uiImage
                                }
                            }
                        }
                    }

                    Button(action: {
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
                    }) {
                        Text("Submit Report")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Theme.accentYellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .disabled(description.isEmpty || location.isEmpty)
                }
                .padding(24)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    AddReportView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
