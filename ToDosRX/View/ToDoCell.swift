//
//  ToDoCell.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 17.10.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import UIKit
import Foundation

class ToDoCell: UITableViewCell {
    
    
    let taskTitle:UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.numberOfLines = 1
        return title
    }()
    
    let aimTitle:UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 14.0)
        title.numberOfLines = 1
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubview(taskTitle)
        addSubview(aimTitle)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        taskTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        taskTitle.leftAnchor.constraint(equalTo: leftAnchor,  constant: 15).isActive = true
        taskTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        
        aimTitle.translatesAutoresizingMaskIntoConstraints = false
        aimTitle.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 5).isActive = true
        aimTitle.leftAnchor.constraint(equalTo: leftAnchor,  constant: 15).isActive = true
        aimTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        aimTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        
        
    }
}
