//
//  Cell.swift
//  CoreDataUpdate
//
//  Created by Khalida Aliyeva on 01.11.24.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    
    func configureLabel() {
        myLabel.textAlignment = .center
        myLabel.textColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
