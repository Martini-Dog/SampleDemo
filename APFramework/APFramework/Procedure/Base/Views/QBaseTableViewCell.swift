//
//  QBaseTableViewCell.swift
//  Flypie
//
//  Created by Apple on 2018/3/16.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import Reusable

class QBaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurtionUI()
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration UI

extension QBaseTableViewCell {

    @objc func configurtionUI() {
        
    }
}
