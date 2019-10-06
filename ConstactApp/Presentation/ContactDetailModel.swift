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
        public var username: String?
        public init() {
        }
        public init(username: String?) {
            self.username = username
        }
    }
    public struct Response: Codable {
        public var id: Int?
        public var firstName, lastName, email, phoneNumber: String?
        public var profilePic: String?
        public var favorite: Bool?
        public var createdAt, updatedAt: String?
        public init() {
        }
        public init(id: Int?,firstName: String?, lastName: String?,email: String?, phoneNumber: String?, profilePic: String?, favorite: Bool?, url: String?) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.firstName = email
            self.lastName = phoneNumber
            self.profilePic = profilePic
            self.favorite = favorite
        }
    }
}
