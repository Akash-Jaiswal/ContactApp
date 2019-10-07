//
//  ContactDetailPresenter.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
class ContactsDetailsPresenter {
    var viewController: IContactsDetailsViewable?
}
extension ContactsDetailsPresenter : IResponseHandler {
    func didReceiveResponse<T>(response: T) {
        if T.self ==  ContactDetails.self {
            var viewmodel =  ContactDetailsPresentationModel()
            if let contactdetails = (response as? ContactDetails) {
                viewmodel.contactdetails = contactdetails
            }
            viewController?.getContactsDetailsSuccess(viewModel: viewmodel)
        }
    }
    
    func didReceiveError(err: [APIErrorInfo]) {
    }
}
