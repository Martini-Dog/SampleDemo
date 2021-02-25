//
//  QCollectionReusableView.swift
//  Flypie
//
//  Created by Apple on 2019/6/14.
//  Copyright © 2019 Flypie. All rights reserved.
//

import UIKit
import Reusable

class QCollectionReusableView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurtionUI()
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QCollectionReusableView {
    
    @objc func configurtionUI() {
        
    }
}
