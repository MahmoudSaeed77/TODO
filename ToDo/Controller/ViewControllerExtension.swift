//
//  ViewControllerExtension.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/28/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellClass
        
        let myItem = item[indexPath.row]
        
        cell.textLabel?.text = myItem.name
        
        cell.accessoryType = myItem.done == true ? .checkmark : .none
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        the next line is for updating values.
//        item[indexPath.row].setValue("Hi", forKey: "name")
        
//        the next 2 line is for deleting.
//        context.delete(item[indexPath.row])
//        item.remove(at: indexPath.row)
        
        item[indexPath.row].done = !item[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
