//
//  UserTableViewCell.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 17.01.2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with user: User) {
        nameLabel.text = user.name
    }
}
