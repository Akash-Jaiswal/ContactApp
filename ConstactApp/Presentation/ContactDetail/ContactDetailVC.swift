//
//  ContactDetailVC.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit
import MessageUI
protocol IContactsDetailsViewable {
    func getContactsDetailsSuccess(viewModel: ContactDetailsPresentationModel)
    func getContactsDetailsFailure(viewModel: ContactDetailsPresentationModel)
}
class ContactDetailVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnFavourite: UIButton! {
        didSet {
            self.btnFavourite.setImage(UIImage(named: "favourite_button"), for: .normal)
            self.btnFavourite.setImage(UIImage(named: "favourite_button_selected"), for: .selected)
        }
    }
    
    var contactDetail: ContactDetails? {
        didSet {
            lblName.text = "\( self.contactDetail?.first_name ?? "") \( self.contactDetail?.last_name ?? "")"
            lblMobileNumber.text = self.contactDetail?.phone_number
            lblEmail.text = self.contactDetail?.email
            profileImage.sd_setImage(with: URL(string: contactDetail?.profile_pic ?? "placeholder_photo"), placeholderImage: UIImage(named: "placeholder_photo"))
        }
    }
    var interactor: ContactDetailsInteractor?
    var presenter: ContactsDetailsPresenter?
    public var userId: Int = 0
    
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
        interactor = ContactDetailsInteractor()
        presenter = ContactsDetailsPresenter()
        interactor?.presenter = presenter
        presenter?.viewController = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        btnFavourite.isSelected = self.contactDetail?.favorite ?? false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.activityStartAnimating()
        interactor?.getContactDetails(id: userId)
    }
    func configNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    
    @objc func editTapped (){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ContactEditVC.reuseID) as? ContactEditVC  {
            _ = self.view
            vc.isEdit = true
            vc.contactDetail = self.contactDetail
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func favoriteTapped(_ sender: Any) {
        if btnFavourite.isSelected  == true {
            btnFavourite.isSelected = false
        }
        else {
            btnFavourite.isSelected = true
        }
        contactDetail?.favorite = btnFavourite.isHighlighted
    }
    @IBAction func sendMessageTapped(_ sender: Any) {
        self.sendMessage()
    }
    @IBAction func sendEmailTapped(_ sender: Any) {
        self.sendEmail()
    }
    @IBAction func callTapped(_ sender: Any) {
        if let mobile = contactDetail?.phone_number {
            if let url = URL(string: "tel://\(mobile)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
extension ContactDetailVC : IContactsDetailsViewable {
    func getContactsDetailsSuccess(viewModel: ContactDetailsPresentationModel) {
        self.view.activityStopAnimating()
        self.contactDetail = viewModel.contactdetails
    }
    
    func getContactsDetailsFailure(viewModel: ContactDetailsPresentationModel) {
        self.view.activityStopAnimating()
    }
    
    
}
//MARK: -  To send Message
extension ContactDetailVC: MFMessageComposeViewControllerDelegate {
    func sendMessage() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hello Go-JEK Team"
            controller.recipients = [contactDetail?.phone_number] as? [String]
            controller.messageComposeDelegate = self
            self.navigationController?.present(controller, animated: true, completion: nil)
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
//MARK: -  To send Email
extension ContactDetailVC : MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if let email = contactDetail?.email, MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([email])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("Hello Go-JEK Team", isHTML: false)
            self.navigationController?.present(composeVC, animated: true, completion: nil)
        }
        
    }
    private func mailComposeController(controller: MFMailComposeViewController,
                                       didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

