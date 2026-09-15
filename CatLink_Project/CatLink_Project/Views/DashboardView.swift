//
//  Dashboard.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authController: AuthController

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack{
                    
                    Color(red: 255/255, green: 244/255, blue: 212/255)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Good Morning, \(authController.user.fullName.components(separatedBy: " ").first ?? "Annie")")
                            .font(.title2.bold())
                        
                        ZStack{
                            HStack{
                                Image("profile")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 70)
                                    .clipShape(Rectangle())
                                
                                VStack{
                                    Text("Your Cat Family")
                                        .font(.headline)
                                    HStack {
                                        
                                        CatMiniCard(name: "Luna")
                                        CatMiniCard(name: "Mochi")
                                    }

                                }
                                
                                Spacer()
                            }
                            
                        }
                        
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Text("Quick Actions")
                            .font(.headline)
                        
                        NavigationLink {
                            MyCatsView()
                        } label: {
                            ActionCard(title: "My Cats", subtitle: "2 Cats", icon: "cat.fill")
                        }
                        
                            .background(Color.white.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        NavigationLink {
                            AddReportView()
                        } label: {
                            ActionCard(title: "Report Stray Cat", subtitle: "Help a stray", icon: "mappin.and.ellipse")
                        }
                            .background(Color.red.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        HStack{
                            
                            Text("Upcoming Reminders")
                                .font(.headline)
                            
                            Spacer()
                            
                            NavigationLink("See All") {
                                RemindersView()
                            }
                                .tint(Color(red: 115/255, green: 86/255,  blue: 241/255))
                        }
                        
                        Text("Feed Luna • Today, 6:00 PM")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        Text("Vet Appointment • Sep 15, 10:00 AM")                   .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding()
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

struct CatMiniCard: View {
    let name: String

    var body: some View {
        VStack {
            
            Text(name)
                .font(.headline)
        }
    }
}

struct ActionCard: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        HStack {
            
            Image(systemName: icon)
                .font(.title2)
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }        .padding()
    }
}

#Preview {
    DashboardView()
        .environmentObject(AuthController())
        .environmentObject(CatController())
        .environmentObject(ReminderController())
        .environmentObject(ReportController())
}
