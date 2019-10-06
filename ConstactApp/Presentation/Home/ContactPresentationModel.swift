//
//  ContactPresentationModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public struct ContactPresentationModel {
   public var contactNumbers: [Contact]?
   public init() {
    }
}

public class Contact {
    public var id: Int?
    public var firstName, lastName: String?
    public var profilePic: String?
    public var favorite: Bool?
    public var url: String?
    public init() {
    }
    public init(id: Int?, firstName:String?, lastName: String?, profilePic:String?, favorite:Bool?, url:String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePic = profilePic
        self.favorite = favorite
    }
    
}
