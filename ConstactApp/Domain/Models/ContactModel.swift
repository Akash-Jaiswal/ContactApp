//
//  ContactModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public enum ContactModel {
    public struct Request: Codable {
        public init() {
        }
    }
}
public struct Contact: Codable {
    public var  id: Int?
    public var  first_name, last_name: String?
    public var  profile_pic: String?
    public var  favorite: Bool?
    public var  url: String?
    public init() {
    }
    public init(id: Int?,firstName: String?, lastName: String?, profilePic: String?, favorite: Bool?, url: String?) {
        self.id = id
        self.first_name = firstName
        self.last_name = lastName
        self.profile_pic = profilePic
        self.favorite = favorite
        self.url = url
    }
}



