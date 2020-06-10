//
//  DataTableViewCell.swift
//  Covid19
//
//  Created by Saud Almutlaq on 11/05/2020.
//  Copyright © 2020 Saud Soft. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var incremetCases: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var recoverdCases: UILabel!
    @IBOutlet weak var deathCases: UILabel!
    @IBOutlet weak var recoverdToday: UILabel!
    @IBOutlet weak var deathsToday: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
