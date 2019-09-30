//
//  DetailsVC.swift
//  ToDo
//
//  Created by Mohamed Ibrahem on 9/16/19.
//  Copyright © 2019 Mahmoud Saeed. All rights reserved.
//

import UIKit
import CoreData


class DetailsVC: UIViewController {
    let cellId = "cellId"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myItem = [Category]()
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))
        
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
        tableView.register(ItemCell.self, forCellReuseIdentifier: cellId)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }
    
    func saveItems(){
        do {
            try context.save()
        } catch {
            print("Error Saving: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            myItem = try context.fetch(request)
        } catch {
            print("Error loading: \(error)")
        }
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
            let item = Category(context: self.context)
            item.name = textField.text!
            self.myItem.append(item)
            self.saveItems()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ItemCell
        cell.textLabel?.text = myItem[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectCategory = myItem[indexPath.row]
        }
        
        navigationController?.show(vc, sender: self)
    }
}

class ItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
