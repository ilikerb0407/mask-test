//
//  NextTableViewCell.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/30.
//

import UIKit

class NextTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var adultmask: UILabel!
    

    @IBOutlet weak var childrenmask: UILabel!
    
    @IBOutlet weak var clinic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell( model : Feature) {
        
        adultmask.text = "成人口罩數量：\(model.properties.maskAdult)"
        
        childrenmask.text = "小孩口罩數量：\(model.properties.maskChild)"
        
        clinic.text = "診所名稱：\(model.properties.name)"
    }
    
}
