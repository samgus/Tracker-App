//
//  DetailsCell.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/18/22.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var cellCompanyLabel: UILabel!
    @IBOutlet weak var cellStatusLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
