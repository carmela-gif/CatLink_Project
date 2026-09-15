//
//  Cat.swift
//  CatLink_Project
//
//  Created by Mac-LAB on 9/8/26.
//

import Foundation

struct Cat: Identifiable {
    let id = UUID()
    var name: String
    var breed: String
    var age: String
    var weight: String
    var gender: String
    var healthInformation: String
}
