//
//  TextField.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 10/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//

import Foundation
import UIKit

final class TextField: UITextField {
    
    private let separatorView: UIView = {
       
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.gray
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSeparatorView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSeparatorView() {
        self.addSubview(separatorView)
        separatorView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.equalTo(1)
        }
    }
    
}
