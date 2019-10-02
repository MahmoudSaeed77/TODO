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
    let cellId = "cellId"
    var selectCategory: Category? {
        didSet{
            loadData()
            print("qwe")
        }
    }
    
    
    
    var item: Results<Items>!
    
    let realm = try! Realm()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavigation()
        setupView()
        registerClasses()
        delegate()
        addConstraints()
        
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
        tableView.register(TodoCell.self, forCellReuseIdentifier: cellId)
    }
    
    func delegate(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func setupView(){
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
            ])
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
            
            
            self.tableView.reloadData()
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
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        item = selectCategory?.item.sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
}





