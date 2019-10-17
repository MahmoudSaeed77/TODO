//
//  CategoryExtension.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 10/2/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = category?[indexPath.row].name ?? "No Category Added"
        cell.delegate = self
        
        if let color = colors?[indexPath.row].color {
            cell.backgroundColor = UIColor(hexString: color)!.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(category.count))
            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TodoVC()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectCategory = category?[indexPath.row]
            vc.title = category?[indexPath.row].name
        }
        
        navigationController?.show(vc, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoryVC: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let item = self.category?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(item)
                    }
                }catch{
                    print("Error Delete: \(error)")
                }
            }
        }
        
        deleteAction.image = UIImage(named: "Trash-Icon")?.withRenderingMode(.alwaysOriginal)
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var option = SwipeTableOptions()
        option.expansionStyle = .destructive
        
        return option
        
    }
    
    
}
