//
//  MaskTableViewCell.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import UIKit

class MaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var childMask: UILabel!
    
    @IBOutlet weak var adultMask: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(object: Feature) {
        
        name.text = "診所：\(object.properties.name)"
        
        phone.text = "診所電話：\(object.properties.phone)"
        
        childMask.text = "小孩口罩：\(object.properties.maskChild)"
        
        adultMask.text = "成人口罩：\(object.properties.maskAdult)"
        
    }
    
}
