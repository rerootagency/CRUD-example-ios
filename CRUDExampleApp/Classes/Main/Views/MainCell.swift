//
//  MainCell.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 02/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import UIKit

final class MainCell: TableViewCell {
    
    private let nameLabel: UILabel = {
        
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let arrowImageView: UIImageView = {
        
        let i = UIImageView(frame: .zero)
        i.image = UIImage(named: "ic_arrow_right")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override func loadViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(arrowImageView)
        setupConstraints()
    }
    
    override func setupConstraints() {
        nameLabel.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview().offset(16)
            maker.trailing.bottom.equalToSuperview().offset(-16)
        }
        arrowImageView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().offset(-8)
            maker.width.height.equalTo(24)
            maker.centerY.equalToSuperview()
        }
        setupViews()
    }
    
    override func setupViews() {
        
    }
    
    func configure(with model: StudentViewModel) {
        nameLabel.text = "\(model.id). \(model.fullName())" 
    }
}
