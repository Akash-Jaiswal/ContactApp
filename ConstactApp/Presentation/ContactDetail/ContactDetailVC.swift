//
//  ContactDetailVC.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    public var contactDetail: ContactDetails? {
        didSet {
            lblName.text = "\( self.contactDetail?.firstName ?? "") \( self.contactDetail?.lastName ?? "")"
           lblMobileNumber.text = self.contactDetail?.phoneNumber
           lblEmail.text = self.contactDetail?.email
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        // Do any additional setup after loading the view.
    }
    func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    
    @objc func editTapped (){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ContactEditVC.reuseID)  {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
