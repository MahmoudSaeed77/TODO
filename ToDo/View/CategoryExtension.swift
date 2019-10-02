//
//  CategoryExtension.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 10/2/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.textLabel?.text = category?[indexPath.row].name ?? "No Category Added"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoVC()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectCategory = category?[indexPath.row]
            vc.title = category?[indexPath.row].name
        }
        
        navigationController?.show(vc, sender: self)
    }
}
