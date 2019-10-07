//
//  ContactDetailInteractor.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
protocol IContactDetailsInteractable {
    func getContactDetails(id: Int)
}
class ContactDetailsInteractor {
    var presenter: IResponseHandler?
   
}
extension ContactDetailsInteractor: IContactDetailsInteractable {
    func getContactDetails(id: Int) {
        let requestAPI =  APIRequest<ContactDetailModel.Request>(method: APIRequest.HTTPMethod.get, url: ApiEndPoint.getContactDetail(id), params: nil, paramsEncoding: .json)
        if let responseHandler = presenter {
            let interfaceObj = ContactDetailUseCase(handler: responseHandler)
            interfaceObj.getContactDetail(request: requestAPI)
        }
    }
}
