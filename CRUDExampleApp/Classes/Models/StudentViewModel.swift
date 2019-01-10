//
//  StudentViewModel.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//
import UIKit

struct StudentViewModel: Equatable {
    
    static func == (lhs: StudentViewModel, rhs: StudentViewModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.lastName == rhs.lastName && lhs.position == rhs.position && lhs.email == rhs.email
    }
    
    
    let id: String
    var email: String
    var name: String
    var lastName: String
    var loginDate: String
    var position: String
    
    init(m: StudentModel) {
        id = m.id
        email = m.email
        name = m.name
        lastName = m.lastName
        position = m.position
        loginDate = StudentViewModel.formatLoginDate(loginDate: m.loginDate)
    }
    
    //MARK: Custom init
    init(id: Int, name: String, lastName: String, email: String, position: String, loginDate: String) {
        self.id = "\(id)"
        self.name = name
        self.lastName = lastName
        self.loginDate = loginDate
        self.position = position
        self.email = email
    }
    
    //MARK: preparing data for UI
    
    func fullName() -> String {
        return "\(name) \(lastName)"
    }
    
    private static func formatLoginDate(loginDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm, dd.MM.yyyy."
        
        if let date = dateFormatterGet.date(from: loginDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "There was an error decoding the string"
        }
    }
}
