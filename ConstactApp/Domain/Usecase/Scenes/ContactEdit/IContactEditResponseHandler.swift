//
//  IContactEditResponseHandler.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public protocol IContactEditResponseHandler: IDomainReachable {
    func didReceiveAddContactResponse(response: ContactDetails)
    func didReceiveAddContactError(err: [APIErrorInfo])
    func didReceiveUpdateContactResponse(response: ContactDetails)
    func didReceiveUpdateContactError(err: [APIErrorInfo])
}
