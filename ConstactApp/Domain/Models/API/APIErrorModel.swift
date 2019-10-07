//
//  APIErrorModel.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
public struct APIErrorInfo: Codable {
    public struct SourceInfo: Codable {
        public var pointer: [String]?
        public init(pointer: [String]?) {
            self.pointer = pointer
        }
    }
    public var status: Int?
    public var code: String?
    public var source: SourceInfo?
    public var value: [String?]?
    public var message: String?
    public init(status: Int, code: String?, source: SourceInfo?, value: [String]?, message: String?) {
        self.status = status
        self.code = code
        self.source = source
        self.value = value
        self.message = message
    }
}
