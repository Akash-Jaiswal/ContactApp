//
//  ViewController.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList.append(Contact(id: 0, firstName: "Akash", lastName: "Jaiswal", profilePic: nil, favorite: true, url: nil))
        contactList.append(Contact(id: 1, firstName: "Bhabhi", lastName: "Jaiswal", profilePic: nil, favorite: false, url: nil))
        contactList.append(Contact(id: 2, firstName: "Gaurav", lastName: "Jaiswal", profilePic: nil, favorite: false, url: nil))
        // 1
        for contact in contactList {
            let contactKey = String(contact.firstName?.prefix(1) ?? "")
            if var carValues = contactDictionary[contactKey] {
                carValues.append(contact)
                contactDictionary[contactKey] = carValues
            } else {
                contactDictionary[contactKey] = [contact]
            }
        }
        
        // 2
        contactSectionTitles = [String](contactDictionary.keys)
        contactSectionTitles = contactSectionTitles.sorted(by: { $0 < $1 })
        configNavBar()
        
    }
    func configNavBar() {
        navigationItem.title = "Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Group", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.tintColor = Theme.PrimaryColor
    }
    
    @objc func addTapped (){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ContactDetailVC.reuseID)  {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSectionTitles[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactSectionTitles
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID) as? ContactCell {
            cell.contactDetail = self.contactList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}

