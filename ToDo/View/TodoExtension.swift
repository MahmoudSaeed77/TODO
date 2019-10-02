//
//  ViewControllerExtension.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/28/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit


extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoCell
        
        if let myItem = item?[indexPath.row] {
            cell.textLabel?.text = myItem.name
            
            cell.accessoryType = myItem.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No item added"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let theItem = item?[indexPath.row] {
            do {
                try realm.write {
//                    for update
                    theItem.done = !theItem.done
//                    for delete
//                    realm.delete(theItem)
                }
            }catch{
                print("Error update done status \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension TodoVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        item = item?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
