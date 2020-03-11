//
//  DispTableViewCell.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 02/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit

class DispTableViewCell: UITableViewCell {

    @IBOutlet weak var icone: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var texto: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
