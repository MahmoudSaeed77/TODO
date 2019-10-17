//
//  TodoVC.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/16/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import RealmSwift

class TodoVC: UIViewController {
    var todoView = TodoView()
    let cellId = "cellId"
    var selectCategory: Category? {
        didSet{
            loadData()
            print("qwe")
        }
    }
    
    
    
    var item: Results<Items>!
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = todoView
        
        setupNavigation()
        
        registerClasses()
        delegate()
        
        
        loadData()
    }
    
    func setupNavigation(){
        let addButton = UIBarButtonItem(image: UIImage(named: "more"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addAction))
//        title = "ToDo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        navigationItem.rightBarButtonItem = addButton
    }
    
    func registerClasses(){
        todoView.tableView.register(TodoCell.self, forCellReuseIdentifier: cellId)
    }
    
    func delegate(){
        todoView.tableView.delegate = self
        todoView.tableView.dataSource = self
        todoView.searchBar.delegate = self
    }
    
    
    
    
    @objc func addAction(){
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "Please fill text field!", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let currenyCategory = self.selectCategory {
                do {
                    try self.realm.write {
                        let newItem = Items()
                        newItem.name = textField.text!
                        newItem.dateCreated = Date()
                        currenyCategory.item.append(newItem)
                    }
                }catch{
                    print("Error Saving item: \(error)")
                }
            }
            
            
            self.todoView.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(item: Items) {

        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("error saving \(error)")
        }
        
        self.todoView.tableView.reloadData()
    }
    
    func loadData() {
        item = selectCategory?.item.sorted(byKeyPath: "dateCreated", ascending: true)
        todoView.tableView.reloadData()
    }
}





