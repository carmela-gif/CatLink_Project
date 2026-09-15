//
//  CareReminder.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import Foundation

struct CareReminder: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: String
}
