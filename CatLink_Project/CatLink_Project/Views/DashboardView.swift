//
//  Dashboard.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI
 
struct DashboardView: View {
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var catController: CatController
    @EnvironmentObject var reminderController: ReminderController
    @EnvironmentObject var reportController: ReportController
 
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
 
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dashboard")
                                .font(.title3.weight(.bold))
                            Text("Good Day, \(authController.user.fullName.components(separatedBy: " ").first ?? "there") ")
                                .font(.title.bold())
                            Text("\(catController.cats.map(\.name).joined(separator: " & ")) are doing great today!")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
 
                        HStack(spacing: 14) {
                            Image(systemName: "pawprint.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Theme.accentPurple)
 
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Your Cat Family").font(.headline)
                                Text(catController.cats.map { "\($0.name) (\($0.age))" }.joined(separator: " • "))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
 
                            Spacer()
 
                            Text("\(catController.cats.count) Cats")
                                .font(.caption.weight(.semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Theme.accentYellow.opacity(0.3))
                                .clipShape(Capsule())
                        }
                        .padding()
                        .background(Theme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
 
                        Text("Quick Actions").font(.headline)
 
                        NavigationLink {
                            MyCatsView()
                        } label: {
                            ActionCard(title: "My Cats", subtitle: "\(catController.cats.count) Cats",
                                       icon: "cat.fill", tint: Theme.accentYellow.opacity(0.35))
                        }
 
                        NavigationLink {
                            AddReportView()
                        } label: {
                            ActionCard(title: "Report Stray Cat", subtitle: "Help a stray",
                                       icon: "mappin.and.ellipse", tint: Theme.accentPurple.opacity(0.15))
                        }

                        NavigationLink {
                            ReportsView()
                        } label: {
                            ActionCard(title: "Reports", subtitle: "\(reportController.reports.count) Reports",
                                       icon: "list.bullet.clipboard", tint: Theme.accentYellow.opacity(0.2))
                        }
 
                        HStack {
                            Text("Upcoming Reminders").font(.headline)
                            Spacer()
                            NavigationLink("See All") {
                                RemindersView()
                            }
                            .tint(Theme.accentPurple)
                            .font(.subheadline)
                        }
 
                        VStack(spacing: 12) {
                            ForEach(reminderController.upcoming.prefix(3)) { reminder in
                                HStack {
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(reminder.tag.color)
                                        .frame(width: 4, height: 36)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(reminder.title).font(.subheadline.weight(.semibold))
                                        Text(reminder.description).font(.caption).foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Text(reminder.date).font(.caption).foregroundStyle(.secondary)
                                }
                                .padding()
                                .background(Theme.cardBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                        }

                        if !reportController.reports.isEmpty {
                            HStack {
                                Text("Recent Reports").font(.headline)
                                Spacer()
                                NavigationLink("See All") {
                                    ReportsView()
                                }
                                .tint(Theme.accentPurple)
                                .font(.subheadline)
                            }

                            VStack(spacing: 12) {
                                ForEach(reportController.reports.prefix(3)) { report in
                                    NavigationLink {
                                        ReportDetailsView(report: report)
                                    } label: {
                                        HStack {
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
                                        }
                                        .padding()
                                        .background(Theme.cardBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding(24)
                    .foregroundStyle(.black)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
 
struct ActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    var tint: Color = Theme.accentYellow
 
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
     
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(.secondary)
        }
        .padding()
        .background(tint)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(.black)
    }
}

#Preview {
    DashboardView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
