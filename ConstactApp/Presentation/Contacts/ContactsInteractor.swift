//
//  ContactInteractor.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
protocol IContactInteractable {
    func getContacts()
}
class ContactsInteractor {
    var presenter: IResponseHandler?
}
extension ContactsInteractor: IContactInteractable {
    func getContacts() {
        let requestAPI =  APIRequest<ContactModel.Request>(method: APIRequest.HTTPMethod.get, url: ApiEndPoint.getContacts, params: nil, paramsEncoding: .json)
        if let responseHandler = presenter {
            let interfaceObj = ContactUseCase(handler: responseHandler)
            interfaceObj.getContacts(request: requestAPI)
        }
    }
}
