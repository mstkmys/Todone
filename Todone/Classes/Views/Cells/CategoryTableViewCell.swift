//
//  CategoryTableViewCell.swift
//  Todone
//
//  Created by Miyoshi Masataka on 2018/03/17.
//  Copyright © 2018年 Masataka Miyoshi. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        
        return label
        
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add Views
        [].forEach{ self.addSubview($0) }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        
        nameLabel.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 0)
        )
        
    }

}









