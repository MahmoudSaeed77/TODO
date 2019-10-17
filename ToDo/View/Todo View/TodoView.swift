//
//  TodoView.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 10/14/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

class TodoView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        addSubview(tableView)
        addSubview(searchBar)
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalTo: widthAnchor),
            
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
            ])
    }
}
