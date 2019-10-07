//
//  ContactsUsecase.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public protocol IContactsUsecase {
    func getContacts(request: APIRequest<ContactModel.Request>)
}
