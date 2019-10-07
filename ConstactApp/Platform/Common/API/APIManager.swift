//
//  APIManager.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
import Alamofire
class APIManager:APIService {
    
    
    // MARK: - Protocol Properties
    static let shared = APIManager(baseURL: Api.BaseUrl)
    private var baseURL: String = ""
    private var sessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    required init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func requestAPI<Req: Codable, Res: Codable>(request: APIRequest<Req>, decodingType: Res.Type, completion: ((APIResponseHandler<Res>) -> Void)?) {
        let url = self.baseURL + request.url
        let error = NSError(domain: "\(url)", code: -1302, userInfo: [NSLocalizedDescriptionKey: "Invalid arguements passed"]) as Error
        guard let headers = request.headers, let baseUrl = URL(string: url), HTTPMethod(rawValue: request.method.rawValue) != nil else {
            completion?(APIResponseHandler.onFailure(error: error))
            return
        }
        var urlRequest = URLRequest(url: baseUrl)
        urlRequest.httpMethod = request.method.rawValue
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let requestBody = request.params {
            let inputData = try? JSONEncoder().encode(requestBody)
            urlRequest.httpBody = inputData
        }
        sessionManager.request(urlRequest)
            .validate(statusCode: 200...500)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 200...500:
                            if let responseObj = try? JSONDecoder().decode(Res.self, from: data) {
                                 completion?(APIResponseHandler.onSuccess(value: responseObj))
                            } else {
                                let error = NSError(domain: "\(url)", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Error From Server"])
                                completion?(APIResponseHandler.onFailure(error: error))
                            }
                        default:
                            break
                        }
                    }
                case .failure(let error):
                    completion?(APIResponseHandler.onFailure(error: error))
                }
            })
    }
}
