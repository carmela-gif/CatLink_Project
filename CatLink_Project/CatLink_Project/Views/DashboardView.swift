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
 
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
 
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dashboard")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.secondary)
                            Text("Good Morning, \(authController.user.fullName.components(separatedBy: " ").first ?? "there") 👋")
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
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
 
            VStack(alignment: .leading) {
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
