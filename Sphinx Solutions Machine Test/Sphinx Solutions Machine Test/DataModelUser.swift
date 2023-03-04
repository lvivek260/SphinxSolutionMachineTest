//
//  DataModelUser.swift
//  Sphinx Solutions Machine Test
//
//  Created by Admin on 04/03/23.
//

import Foundation

struct DataModelUser{
    let id:Int
    let name:String
    let gender:String
    
    init(id: Int, name: String, gender: String) {
        self.id = id
        self.name = name
        self.gender = gender
    }
}
