//
//  HeaderTableViewCell.swift
//  expandable table view
//
//  Created by LYNX ART on 08/06/2021.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescreption: UILabel!
    @IBOutlet weak var imageArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
