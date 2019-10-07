//
//  IDomainReachable.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 06/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
import UIKit
public protocol IDomainReachable {
    func onDomainReachableError(error: Error)
}

extension IDomainReachable {
    func onDomainReachableError(error: Error) {
        if let topController = UIApplication.topViewController() {
            topController.view.activityStopAnimating()
           topController.alert(message: error.localizedDescription)
        }
        
    }
}
