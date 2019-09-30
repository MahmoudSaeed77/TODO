//
//  ViewController.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/16/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let cellId = "cellId"
    var selectCategory: Category? {
        didSet{
            loadData()
            print("qwe")
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var item = [Items]()
    
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
        
        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))
        
        setupNavigation()
        setupView()
        registerClasses()
        delegate()
        addConstraints()
        
        loadData()
    }
    
    func setupNavigation(){
        let addButton = UIBarButtonItem(image: UIImage(named: "more"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addAction))
        title = "ToDo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.blue
        navigationItem.rightBarButtonItem = addButton
    }
    
    func registerClasses(){
        tableView.register(CellClass.self, forCellReuseIdentifier: cellId)
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
            let newItem = Items(context: self.context)
            newItem.name = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectCategory
            self.item.append(newItem)
            
            self.saveData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {

        do {
            try context.save()
        } catch {
            print("error saving \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Items> = Items.fetchRequest(), predicate: NSPredicate? = nil) {
    
        let CategoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectCategory?.name! ?? "")
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate, additionalPredicate])
        } else {
            request.predicate = CategoryPredicate
        }
        
        
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate, predicate!])
        
//        request.predicate = compoundPredicate
        
        do {
            item = try context.fetch(request)
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadData(with: request, predicate: predicate)
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



