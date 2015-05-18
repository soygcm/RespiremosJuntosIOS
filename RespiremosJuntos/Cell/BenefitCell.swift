//
//  BenefitCell.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 11/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

class BenefitCell: UITableViewCell {
    @IBOutlet weak var progressView: UIProgressView!

    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var beneficio: Benefit!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(){
        
        self.descriptionLabel?.text = beneficio.text
        self.percentLabel.text = beneficio.percentFormated()
        self.progressView.progress = beneficio.percent()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
