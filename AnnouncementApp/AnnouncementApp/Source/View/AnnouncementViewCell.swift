//
//  AnnouncementViewCell.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

class AnnouncementViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(with announcement:AnnounceMent)  {
        
        self.titleLabel?.text = announcement.title ?? ""
        self.dateLabel?.text = announcement.date ?? ""
    }

}
