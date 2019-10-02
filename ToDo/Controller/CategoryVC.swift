//
//  CategoryVC.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/16/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryVC: UIViewController {
    let cellId = "cellId"
    let realm = try! Realm()
    var category: Results<Category>!
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        delegate()
        register()
        setupConstraints()
        loadItems()
    }
    
    func setupView(){
        title = "todo"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
    }
    
    func delegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addButtonPressed))
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func register(){
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        print("Loaded")
        category = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    @objc func addButtonPressed(sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Adding", message: "Add New Category", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "type here..."
            textField = alertTextfield
        }
        let action = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            let item = Category()
            item.name = textField.text!
            
            self.save(category: item)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}



