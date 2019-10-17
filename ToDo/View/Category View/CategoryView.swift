//
//  CategoryView.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import ChameleonFramework

class CategoryView: UIView {
//    var categoryVc = CategoryVC()
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    let redColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.flatRed
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        backgroundColor = UIColor.white
        addSubview(tableView)
        addSubview(redColorButton)
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
            
            redColorButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            redColorButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            redColorButton.widthAnchor.constraint(equalToConstant: 40),
            redColorButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
}
