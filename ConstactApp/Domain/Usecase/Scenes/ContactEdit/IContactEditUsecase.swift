//
//  ContactEditUsecase.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public protocol IContactEditUsecase {
    func addContact(request: APIRequest<ContactDetailModel.Request>)
    func updateContact(request: APIRequest<ContactDetailModel.Request>)
}
