//
//  ContactEditIneractor.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
protocol IContactEditInteractable {
    func addContactDetails(userdetail: ContactDetails)
    func updateContactDetails(id: Int,userdetail: ContactDetails)
}
class ContactEditInteractor {
    var presenter: IContactEditResponseHandler?
    
}
extension ContactEditInteractor: IContactEditInteractable {
    func addContactDetails(userdetail: ContactDetails) {
        var request =  ContactDetailModel.Request()
        request.first_name = userdetail.first_name
        request.last_name = userdetail.last_name
        request.email = userdetail.email
        request.phone_number = userdetail.phone_number
        request.favorite = userdetail.favorite
        request.created_at = ""
        request.updated_at = ""
        let requestAPI =  APIRequest<ContactDetailModel.Request>(method: APIRequest.HTTPMethod.post, url: ApiEndPoint.addContacts, params: request, paramsEncoding: .json)
        if let responseHandler = presenter {
            let interfaceObj = ContactEditUseCase(handler: responseHandler)
            interfaceObj.addContact(request: requestAPI)
        }
    }
    
    func updateContactDetails(id: Int, userdetail: ContactDetails) {
        var request =  ContactDetailModel.Request()
        request.id = userdetail.id
        request.first_name = userdetail.first_name
        request.last_name = userdetail.last_name
        request.email = userdetail.email
        request.phone_number = userdetail.phone_number
        request.favorite = userdetail.favorite
        let requestAPI =  APIRequest<ContactDetailModel.Request>(method: APIRequest.HTTPMethod.put, url: ApiEndPoint.updateContactDetail(id), params: request, paramsEncoding: .json)
        if let responseHandler = presenter {
            let interfaceObj = ContactEditUseCase(handler: responseHandler)
            interfaceObj.updateContact(request: requestAPI)
        }
    }
}
