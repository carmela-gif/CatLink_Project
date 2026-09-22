//
//  ReportDetailsView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/18/26.
//
 
import SwiftUI
 
struct ReportDetailsView: View {
    @Environment(\.dismiss) private var dismiss
 
    let report: StrayReport
 
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
 
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
 
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
 
                    HStack {
                        Text("Current Status")
                            .font(.headline)
                        Spacer()
                        StatusBadge(text: report.status, color: Theme.accentYellow)
                    }
                    .padding(.horizontal)
 
                    VStack(spacing: 12) {
                        InfoCard(label: "Description", value: report.description)
                        InfoCard(label: "Location", value: report.location)
                        InfoCard(label: "Date Reported", value: report.date)
                        InfoCard(label: "Condition", value: report.condition)
                    }
                    .padding(.horizontal)
 
                    Text("Status Timeline")
                        .font(.headline)
                        .padding(.horizontal)
 
                    TimelineCard(steps: report.timeline, accent: Theme.accentYellow)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
                .padding(.top, 8)
            }
        }
        .navigationTitle("Report Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
            }
        }
    }
}
 
struct TimelineStep: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let isCompleted: Bool
    let isCurrent: Bool
}

extension StrayReport {
    var timeline: [TimelineStep] {
        let stages = ["Needs Assistance", "Under Observation", "Rescued", "Adopted", "Resolved"]
        let currentIndex = stages.firstIndex(of: status) ?? 0
 
        return stages.enumerated().map { index, stage in
            let subtitle: String
            if index == currentIndex {
                subtitle = "Reported Today"
            } else if index == currentIndex + 1 {
                subtitle = "Pending dispatch"
            } else if index < currentIndex {
                subtitle = "Completed"
            } else {
                subtitle = "Upcoming"
            }
 
            return TimelineStep(
                title: stage,
                subtitle: subtitle,
                isCompleted: index < currentIndex,
                isCurrent: index == currentIndex
            )
        }
    }
}
 
private struct StatusBadge: View {
    let text: String
    let color: Color
 
    var body: some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.black)
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(color)
            .clipShape(Capsule())
    }
}
 
private struct InfoCard: View {
    let label: String
    let value: String
 
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body.weight(.semibold))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
 
private struct TimelineCard: View {
    let steps: [TimelineStep]
    let accent: Color
 
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                HStack(alignment: .top, spacing: 14) {
                    VStack(spacing: 0) {
                        Circle()
                            .fill(step.isCurrent ? accent : (step.isCompleted ? .black : Color.gray.opacity(0.3)))
                            .frame(width: step.isCurrent ? 14 : 10, height: step.isCurrent ? 14 : 10)
                        if index < steps.count - 1 {
                            Rectangle()
                                .fill(Color.gray.opacity(0.25))
                                .frame(width: 2)
                                .frame(minHeight: 36)
                        }
                    }
 
                    VStack(alignment: .leading, spacing: 2) {
                        Text(step.title)
                            .font(.subheadline.weight(step.isCurrent ? .bold : .semibold))
                            .foregroundStyle(step.isCurrent || step.isCompleted ? .black : .secondary)
                        Text(step.subtitle)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.bottom, index < steps.count - 1 ? 16 : 0)
 
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
 
#Preview {
    NavigationStack {
        ReportDetailsView(
            report: StrayReport(
                description: "Orange tabby, medium size, friendly",
                location: "Maple Street Park",
                date: "September 3, 2026",
                condition: "Injured — left front paw",
                additionalInformation: "Found near the playground entrance.",
                status: "Needs Assistance"
            )
        )
    }
}
 
