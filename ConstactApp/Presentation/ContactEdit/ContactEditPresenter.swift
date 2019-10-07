//
//  ContactEditPresenter.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation

class ContactEditPresenter {
    var viewController: IContactsEditViewable?
}
extension ContactEditPresenter : IContactEditResponseHandler {
    func didReceiveAddContactResponse(response: ContactDetails) {
        DispatchQueue.main.async {
            var viewmodel =  ContactDetailsPresentationModel()
            viewmodel.contactdetails = response
            self.viewController?.addContactsSuccess(viewModel: viewmodel)
        }
    }
    
    func didReceiveAddContactError(err: [APIErrorInfo]) {
    }
    
    func didReceiveUpdateContactResponse(response: ContactDetails) {
        DispatchQueue.main.async {
            var viewmodel =  ContactDetailsPresentationModel()
            viewmodel.contactdetails = response
            self.viewController?.updateContactsSuccess(viewModel: viewmodel)
        }
    }
    
    func didReceiveUpdateContactError(err: [APIErrorInfo]) {
    }
}
