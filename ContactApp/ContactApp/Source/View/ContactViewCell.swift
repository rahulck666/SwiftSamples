//
//  ContactViewCell.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/19/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(contact: Contact)  {
        emailLabel.text = contact.email ?? ""
        nameLabel.text = contact.fullName ?? ""
        mobileNumberLabel.text = contact.mobile ?? ""
        contactImageView.image = contact.profilePic        
    }

}
