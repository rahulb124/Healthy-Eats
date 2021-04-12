//
//  IngredientTableViewCell.swift
//  Nutrition
//
//  Created by Cass Tao on 2/2/19.
//  Copyright © 2019 Cass Tao. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
