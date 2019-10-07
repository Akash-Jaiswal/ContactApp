//
//  ContactDetailUsecase.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
internal class ContactDetailUseCase: IContactDetailUsecase {
    func getContactDetail(request: APIRequest<ContactDetailModel.Request>) {
        APIManager.shared.requestAPI(request: request, decodingType: ContactDetails.self, completion: { response in
            switch response {
            case .onSuccess(let jsonData):
                self.responseHandler.didReceiveResponse(response: jsonData)
            case .onFailureResponse(let error):
                self.responseHandler.didReceiveError(err: error)
            case .onFailure(let error):
                self.responseHandler.onDomainReachableError(error: error)
            }
        })
    }
    
    var responseHandler: IResponseHandler
    init(handler: IResponseHandler) {
        self.responseHandler = handler
    }
}
