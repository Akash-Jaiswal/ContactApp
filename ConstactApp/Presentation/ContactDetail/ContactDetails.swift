//
//  File.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ContactDetails {
    public var id: Int?
    public var firstName, lastName, email, phoneNumber: String?
    public var profilePic: String?
    public var favorite: Bool?
    public var createdAt, updatedAt: String?
    public init() {
    }
}
