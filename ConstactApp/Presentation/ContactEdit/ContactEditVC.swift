//
//  ContactEditVC.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit

class ContactEditVC: UIViewController {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    public var contactDetail: ContactDetails? {
        didSet {
            tfFirstName.text = self.contactDetail?.firstName
            tfLastName.text = self.contactDetail?.lastName
            tfMobile.text = self.contactDetail?.phoneNumber
            tfEmail.text = self.contactDetail?.email
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        // Do any additional setup after loading the view.
    }
    func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc func cancelTapped (){
       self.navigationController?.popViewController(animated: false)
    }
    @objc func doneTapped (){
    }
    @IBAction func cameraTapped(_ sender: Any) {
        
    }
}
