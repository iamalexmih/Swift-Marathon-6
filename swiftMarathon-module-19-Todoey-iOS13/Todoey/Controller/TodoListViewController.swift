//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
//TODO: Не меняется цвет нав бара урок 1, 07:40. Глянуть флеш чат, там было покрашенно.
    
    
    var listToDo = ["Сделать 19 модуль", "Почитать про память в Swift", "Почитать про  Responder Chain"]
    
    let userDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataList = userDefaults.array(forKey: "listToDoArray") as? [String] {
            listToDo = dataList
        }
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Добавить новый пункт", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            print("Success!")
            guard let text = textField.text else { return }
            self.listToDo.append(text)
            self.userDefaults.set(self.listToDo, forKey: "listToDoArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "введите текст"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }

}


// MARK: - TableView DataSource
extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listToDo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = listToDo[indexPath.row]
        return cell
    }
}


// MARK: - TableView Delegate

extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

