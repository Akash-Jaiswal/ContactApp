//
//  APIResponseModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public enum APIResponseHandler<T: Codable> {
    case onSuccess(value: T)
    case onFailureResponse(error: [APIErrorInfo])
    case onFailure(error: Error)
}
//public struct APIResponse<T: Codable>: Codable {
//    public var status: String?
//    public var data: T?
//    public var errors: [APIErrorInfo]?
//
//    public init(status: String?, data: T?, errors: [APIErrorInfo]?) {
//        self.status = status
//        self.data = data
//        self.errors = errors
//    }
//    public init() {
//    }
//}
