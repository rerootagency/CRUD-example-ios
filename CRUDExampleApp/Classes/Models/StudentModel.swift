//
//  StudentModel.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import Foundation

struct StudentModel: Codable {
    let id: String
    let email: String
    let name: String
    let lastName: String
    let loginDate: String
    let position: String
    
    enum CodingKeys : String, CodingKey {
        case id = "sifra"
        case email
        case name = "ime"
        case lastName = "prezime"
        case loginDate = "datumprijave"
        case position = "uloga"
    }
}
