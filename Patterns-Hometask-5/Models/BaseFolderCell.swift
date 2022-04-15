//
//  BaseFolderCell.swift
//  Patterns-Hometask-5
//
//  Created by Anton Lebedev on 12.04.2022.
//

import UIKit

class BaseFolderCell: UITableViewCell {
    
    @IBOutlet weak var taskName: UILabel!
    
    @IBOutlet weak var counterForLevel2Tasks: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurator(taskName: String, counterForLevel2Tasks: Int) {
        self.taskName.text = taskName
        self.counterForLevel2Tasks.text = String("\(counterForLevel2Tasks)")
    }
}
