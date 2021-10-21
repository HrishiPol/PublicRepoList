//
//  RepoTableViewCell.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 21/10/21.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avtarImageView.layer.cornerRadius = avtarImageView.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
