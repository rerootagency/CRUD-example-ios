//
//  TableViewCell.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupViews() {
        
    }
    
}
