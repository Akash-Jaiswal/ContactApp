//
//  ContactDetailModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public enum ContactDetailModel {
    public struct Request: Codable {
        public var id: Int?
        public var first_name, last_name, email, phone_number: String?
        public var favorite: Bool?
        public var created_at, updated_at: String?
        public init() {
        }
    }
}
public struct ContactDetails: Codable {
    public var id: Int?
    public var first_name, last_name, email, phone_number: String?
    public var profile_pic: String?
    public var favorite: Bool?
    public var created_at, updated_at: String?
    public init() {
    }
    public init(id: Int?,first_name: String?, last_name: String?,email: String?, phone_number: String?, profile_pic: String?, favorite: Bool?, url: String?) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone_number = phone_number
        self.profile_pic = profile_pic
        self.favorite = favorite
    }
}
