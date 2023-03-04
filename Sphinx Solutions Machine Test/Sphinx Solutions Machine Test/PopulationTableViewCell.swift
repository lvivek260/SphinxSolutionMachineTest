//
//  PopulationTableViewCell.swift
//  Sphinx Solutions Machine Test
//
//  Created by Admin on 04/03/23.
//

import UIKit

class PopulationTableViewCell: UITableViewCell {

    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var population: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
