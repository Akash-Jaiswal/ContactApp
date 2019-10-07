//
//  IResponseHandler.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public protocol IResponseHandler: IDomainReachable {
    func didReceiveResponse<T>(response: T)
    func didReceiveError(err: [APIErrorInfo])
}
