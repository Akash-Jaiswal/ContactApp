//
//  ContactEditVC.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit
protocol IContactsEditViewable {
    func addContactsSuccess(viewModel: ContactDetailsPresentationModel)
    func addContactsFailure(viewModel: ContactDetailsPresentationModel)
    func updateContactsSuccess(viewModel: ContactDetailsPresentationModel)
    func updateContactsFailure(viewModel: ContactDetailsPresentationModel)
}
class ContactEditVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tfEmail: UITextField! {
        didSet {
            tfEmail.tag = 3
            tfEmail.delegate = self
        }
    }
    @IBOutlet weak var tfMobile: UITextField! {
        didSet {
            tfMobile.tag = 2
            tfMobile.delegate = self
        }
    }
    @IBOutlet weak var tfLastName: UITextField! {
        didSet {
            tfLastName.tag = 1
            tfLastName.delegate = self
        }
    }
    @IBOutlet weak var tfFirstName: UITextField! {
        didSet {
            tfFirstName.tag = 0
            tfFirstName.delegate = self
        }
    }
    public var contactDetail: ContactDetails? = ContactDetails()
    var interactor: ContactEditInteractor?
    var presenter: ContactEditPresenter?
    public var isEdit: Bool = false
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: Setup
    private func setup() {
        interactor = ContactEditInteractor()
        presenter = ContactEditPresenter()
        interactor?.presenter = presenter
        presenter?.viewController = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        self.tfFirstName.text = self.contactDetail?.first_name
        self.tfLastName.text = self.contactDetail?.last_name
        self.tfMobile.text = self.contactDetail?.phone_number
        self.tfEmail.text = self.contactDetail?.email
        self.profileImage.sd_setImage(with: URL(string: contactDetail?.profile_pic ?? "placeholder_photo"), placeholderImage: UIImage(named: "placeholder_photo"))
        self.tfFirstName.becomeFirstResponder()
    }
    func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc func cancelTapped (){
        self.navigationController?.popViewController(animated: false)
    }
    @objc func doneTapped() {
        self.view.activityStartAnimating()
        if(isEdit) {
            if let detail  = contactDetail , let id = detail.id {
                interactor?.updateContactDetails(id: id, userdetail: detail)
            }
        }
        else {
            if let detail  = contactDetail {
                interactor?.addContactDetails(userdetail: detail)
            }
        }
    }
    @IBAction func cameraTapped(_ sender: Any) {
    }
}
extension ContactEditVC :UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            contactDetail?.first_name = textField.text
        case 1:
            contactDetail?.last_name = textField.text
        case 2:
            contactDetail?.phone_number = textField.text
        case 3:
            contactDetail?.email = textField.text
        default:
            break
        }
    }
}
extension ContactEditVC: IContactsEditViewable {
    func addContactsSuccess(viewModel: ContactDetailsPresentationModel) {
        self.navigationController?.popViewController(animated: true)
        self.view.activityStopAnimating()
        
    }
    
    func addContactsFailure(viewModel: ContactDetailsPresentationModel) {
        self.view.activityStopAnimating()
    }
    
    func updateContactsSuccess(viewModel: ContactDetailsPresentationModel) {
        self.navigationController?.popViewController(animated: true)
        self.view.activityStopAnimating()
        
    }
    
    func updateContactsFailure(viewModel: ContactDetailsPresentationModel) {
        self.view.activityStopAnimating()
    }
    
    
}
