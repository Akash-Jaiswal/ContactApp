//
//  APIConstants.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
import Foundation

struct Api {
    static let BaseUrl = "http://gojek-contacts-app.herokuapp.com"
}

struct ApiEndPoint {
    static let getContacts = "/contacts.json"
    static let addContacts = "/contacts.json"
    
    public static func getContactDetail(_ id: Int) -> String {
        return "/contacts/\(id).json"
    }
    public static func updateContactDetail(_ id: Int) -> String {
        return "/contacts/\(id).json"
    }
    public static func deleteContactDetail(_ id: Int) -> String {
        return "/contacts/\(id).json"
    }
}
