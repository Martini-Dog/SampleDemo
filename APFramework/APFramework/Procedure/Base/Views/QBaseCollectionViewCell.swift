//
//  QBaseCollectionViewCell.swift
//  Flypie
//
//  Created by Apple on 2018/3/23.
//  Copyright © 2018年 The_X. All rights reserved.
//

import UIKit
import Reusable

class QBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    open var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurtionUI()
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QBaseCollectionViewCell {
    
    @objc func configurtionUI() {
    
    }
}
