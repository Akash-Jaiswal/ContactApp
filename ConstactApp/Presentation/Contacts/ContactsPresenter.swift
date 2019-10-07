//
//  ContactPresenter.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
class ContactsPresenter {
    var viewController: IContactsViewable?
}
extension ContactsPresenter : IResponseHandler {
    func didReceiveResponse<T>(response: T) {
        if T.self ==  [Contact].self {
            var model =  ContactPresentationModel()
            if let contacts = (response as? [Contact]) {
                model.contactNumbers = contacts
            }
            viewController?.getContactsSuccess(viewModel: model)
        }
    }
    
    func didReceiveError(err: [APIErrorInfo]) {
    }

}
