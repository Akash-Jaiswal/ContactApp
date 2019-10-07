//
//  ContactCell.swift
//  ConstactApp
//
//  Created by Jaiswal, Akash on 05/10/19.
//  Copyright © 2019 Jaiswal, Akash. All rights reserved.
//

import UIKit
import SDWebImage
class ContactCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!
    public var contactDetail: Contact? {
        didSet {
             lblUserName.text = "\( self.contactDetail?.first_name ?? "") \( self.contactDetail?.last_name ?? "")"
            favouriteImage.isHidden = self.contactDetail?.favorite ?? false ? false :true
            profileImage.sd_setImage(with: URL(string: contactDetail?.profile_pic ?? "placeholder_photo"), placeholderImage: UIImage(named: "placeholder_photo"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
