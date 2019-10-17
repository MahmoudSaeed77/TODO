//
//  CategoryVC.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/16/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryVC: UIViewController {
    
    var categoryView = CategoryView()
    let cellId = "cellId"
    let realm = try! Realm()
    var category: Results<Category>!
    var colors: Results<Colors>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = categoryView
        setupNavigation()
        targets()
        delegate()
        register()
        
        loadItems()
    }
    
    func setupNavigation(){
        title = "todo"
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightButton = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addButtonPressed))
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        navigationItem.rightBarButtonItem = rightButton
    }
    func targets(){
        categoryView.redColorButton.addTarget(self, action: #selector(redTapped), for: .touchUpInside)
    }
    func delegate(){
        categoryView.tableView.delegate = self
        categoryView.tableView.dataSource = self
    }
    func register(){
        categoryView.tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
    }
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving: \(error)")
        }
        categoryView.tableView.reloadData()
    }
    
    func saveColor(color: Colors){
        do {
            try realm.write {
                realm.add(color)
            }
        } catch {
            print("Error Saving: \(error)")
        }
        categoryView.tableView.reloadData()
    }
    
    func loadItems(){
        print("Loaded")
        category = realm.objects(Category.self)
        colors = realm.objects(Colors.self)
        categoryView.tableView.reloadData()
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
    
    @objc func redTapped(){
        let cc = Colors()
        let color: String = FlatRed().hexValue()
        cc.color = color
        saveColor(color: cc)
        categoryView.tableView.reloadData()
    }
}



