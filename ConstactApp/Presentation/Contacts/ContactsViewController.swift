//
//  ViewController.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit
protocol IContactsViewable {
    func getContactsSuccess(viewModel: ContactPresentationModel)
    func getContactsFailure(viewModel: ContactPresentationModel)
}
class ContactsViewController: UIViewController {
    var contactDictionary = [String: [Contact]]()
    var contactList = [Contact]()
    var contactSectionTitles = [String]()
    @IBOutlet weak var contactListTableView: UITableView! {
        didSet {
            self.contactListTableView.register(UINib(nibName: ContactCell.reuseID, bundle: nil), forCellReuseIdentifier: ContactCell.reuseID)
            self.contactListTableView.delegate = self
            self.contactListTableView.dataSource = self
            
        }
    }
    var interactor: ContactsInteractor?
    var presenter: ContactsPresenter?
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
        interactor = ContactsInteractor()
        presenter = ContactsPresenter()
        interactor?.presenter = presenter
        presenter?.viewController = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.activityStartAnimating()
        interactor?.getContacts()
        configNavBar()
        
    }
    func configNavBar() {
        navigationItem.title = "Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Group", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.tintColor = Theme.PrimaryColor
    }
    
    @objc func addTapped (){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ContactEditVC.reuseID) as? ContactEditVC  {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ContactsViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return contactSectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactKey = contactSectionTitles[section]
        if let contactValues = contactDictionary[contactKey] {
            return contactValues.count
        }
        return 0
    }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return  contactSectionTitles[section]
        }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactSectionTitles
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ContactDetailVC.reuseID) as? ContactDetailVC {
            let contactKey = contactSectionTitles[indexPath.section]
            if let contactValues = contactDictionary[contactKey] {
                vc.userId =  contactValues[indexPath.row].id ?? 0
            }
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID) as? ContactCell {
            let contactKey = contactSectionTitles[indexPath.section]
            if let contactValues = contactDictionary[contactKey] {
                cell.contactDetail =  contactValues[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
extension ContactsViewController : IContactsViewable {
    func getContactsSuccess(viewModel: ContactPresentationModel) {
       self.view.activityStopAnimating()
        contactList = viewModel.contactNumbers ?? []
        for contact in contactList {
            let contactKey = String(contact.first_name?.prefix(1) ?? "")
            if var carValues = contactDictionary[contactKey] {
                carValues.append(contact)
                contactDictionary[contactKey] = carValues
            } else {
                contactDictionary[contactKey] = [contact]
            }
        }
        contactSectionTitles = [String](contactDictionary.keys)
        contactSectionTitles = contactSectionTitles.sorted(by: { $0 < $1 })
        contactListTableView.reloadData()
    }
    
    func getContactsFailure(viewModel: ContactPresentationModel) {
        self.view.activityStopAnimating()
    }
}
