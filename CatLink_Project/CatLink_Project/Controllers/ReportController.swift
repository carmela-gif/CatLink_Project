//
//  ReportController.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/7/26.
//

import Foundation
internal import Combine

@MainActor
final class ReportController: ObservableObject {
    @Published var reports: [StrayReport] = [
        StrayReport(
            description: "Orange tabby, medium size, friendly",
            location: "Maple Street Park",
            date: "September 3, 2026",
            condition: "Injured — left front paw",
            additionalInformation: "Found near the playground entrance.",
            status: "Needs Assistance"
        )
    ]

    func addReport(_ report: StrayReport) {
        reports.append(report)
    }
}
