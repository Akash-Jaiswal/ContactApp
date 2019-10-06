//
//  UIExtension.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var addTopBorderWithColor : UIColor  {
        set {
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        layer.addSublayer(border)
        }
        get {
            return UIColor.lightGray
        }
    }
}

protocol Reusable {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {
        return "\(self)"
    }
}
extension UITableViewCell: Reusable {}
extension UIViewController:Reusable {}
