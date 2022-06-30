//
//  MaskTableViewCell.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit

class MaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(object: String) {
        
        name.text = "縣市：\(object)"
        
        
    }
    
}
