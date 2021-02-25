//
//  QTableViewHeaderFooterView.swift
//  Flypie
//
//  Created by Apple on 2018/3/16.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import Reusable

class QTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configurtionUI()
        contentView.backgroundColor = UIColor.white
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QTableViewHeaderFooterView {
    
    @objc func configurtionUI() {
        
    }
}
