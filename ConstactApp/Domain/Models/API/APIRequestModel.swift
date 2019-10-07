//
//  APIrequestModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public struct APIRequest<T: Codable> {
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    public enum Encoding {
        case urlEncoded
        case json
    }
    public var method: HTTPMethod
    public var url: String
    public var headers: [String: String]?
    public var params: T?
    public var paramsEncoding: Encoding
  
    
    public init(method: HTTPMethod, url: String, headers: [String: String] = ["Content-Type": "application/json"], params: T?, paramsEncoding: Encoding = .json) {
        self.method = method
        self.url = url
        self.headers = headers
        self.params = params
        self.paramsEncoding = paramsEncoding
    }
}
