//
//  My.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import SwiftUI

struct MyCatsView: View {
    @EnvironmentObject var catController: CatController

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 244/255, blue: 212/255)
                .ignoresSafeArea()

            List {
                ForEach(catController.cats) { cat in
                    NavigationLink {
                        CatDetailsView(cat: cat)
                    } label: {
                        HStack {
                            Image(systemName: "cat.fill")
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(cat.name).font(.headline)
                                Text(cat.breed).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("My Cats")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddCatView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
