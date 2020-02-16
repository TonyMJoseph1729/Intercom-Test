//
//  CustomerTableViewCell.swift
//  Intercom Test
//
//  Created by Tony on 15/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var customerUserIdLabel: UILabel!
    @IBOutlet weak var customerDistanceLabel: UILabel!
    
    let userIdText = "User Id:"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // Set the display labels
    func setLabels(_ customer: Customer) {
        self.customerNameLabel.text = customer.name
        self.customerUserIdLabel.text = "\(userIdText) \(String(customer.user_id))"
        self.customerDistanceLabel.text = distanceLabelText(customer)
        self.layer.cornerRadius = 50
    }
    
    // Get the label displaying the distance of customer from Intercom Office
    func distanceLabelText(_ customer: Customer) -> String {
        return "\(String(format: "%.2f" ,Utilities().distancefrom(customer))) kms"
    }
}
