//
//  ContactEditUsecase.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
internal class ContactEditUseCase: IContactEditUsecase {
    var responseHandler: IContactEditResponseHandler
    init(handler: IContactEditResponseHandler) {
        self.responseHandler = handler
    }
    func addContact(request: APIRequest<ContactDetailModel.Request>) {
        APIManager.shared.requestAPI(request: request, decodingType: ContactDetails.self, completion: { response in
            switch response {
            case .onSuccess(let jsonData):
                self.responseHandler.didReceiveAddContactResponse(response: jsonData)
            case .onFailureResponse(let error):
                self.responseHandler.didReceiveAddContactError(err: error)
            case .onFailure(let error):
                self.responseHandler.onDomainReachableError(error: error)
            }
        })
    }
    
    func updateContact(request: APIRequest<ContactDetailModel.Request>) {
        APIManager.shared.requestAPI(request: request, decodingType: ContactDetails.self, completion: { response in
            switch response {
            case .onSuccess(let jsonData):
                self.responseHandler.didReceiveUpdateContactResponse(response: jsonData)
            case .onFailureResponse(let error):
                self.responseHandler.didReceiveUpdateContactError(err: error)
            case .onFailure(let error):
                self.responseHandler.onDomainReachableError(error: error)
            }
        })
    }
}
