//
//  ContactDetailVC.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit

protocol IContactsDetailsViewable {
    func getContactsDetailsSuccess(viewModel: ContactDetailsPresentationModel)
    func getContactsDetailsFailure(viewModel: ContactDetailsPresentationModel)
}
class ContactDetailVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    public var userId: Int = 0
    
    @IBOutlet weak var btnFavourite: UIButton! {
        didSet {
            self.btnFavourite.setImage(UIImage(named: "favourite_button"), for: .normal)
            self.btnFavourite.setImage(UIImage(named: "favourite_button_selected"), for: .selected)
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
    //var router: IHomeRoutable?
    // MARK: Object lifecycle
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

        // Do any additional setup after loading the view.
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
