//
//  ReportsView.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/22/26.
//

import SwiftUI

struct ReportsView: View {
    @EnvironmentObject var reportController: ReportController

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Reports")
                        .font(.title2.bold())
                        .padding(.horizontal, 24)
                        .padding(.top, 12)

                    if reportController.reports.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.title)
                                .foregroundStyle(.secondary)
                            Text("No reports yet")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            NavigationLink {
                                AddReportView()
                            } label: {
                                Text("Report a Stray Cat")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Theme.accentYellow)
                                    .clipShape(Capsule())
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(reportController.reports) { report in
                                NavigationLink {
                                    ReportDetailsView(report: report)
                                } label: {
                                    ReportRow(report: report)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Reports")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddReportView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Theme.accentPurple)
                }
            }
        }
    }
}

private struct ReportRow: View {
    let report: StrayReport

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "photo.fill")
                .font(.title2)
                .foregroundStyle(Theme.accentPurple)
                .frame(width: 48, height: 48)
                .background(Theme.accentPurple.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 2) {
                Text(report.description)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                Text(report.location)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(report.status)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Theme.accentYellow.opacity(0.5))
                .clipShape(Capsule())

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    NavigationStack {
        ReportsView()
            .environmentObject(ReportController())
    }
}
