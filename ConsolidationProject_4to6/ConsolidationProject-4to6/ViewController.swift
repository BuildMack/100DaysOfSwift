//
//  ViewController.swift
//  ConsolidationProject-4to6
//
//  Created by Mitchell Mackenzie Sell on 2021-05-24.
//

import UIKit

class ViewController: UITableViewController {

    var groceryList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Grocery List"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groceryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryItem", for: indexPath)
        cell.textLabel?.text = groceryList[indexPath.row]
        return cell
    }

    @objc func addItem() {
        
        
        let ac = UIAlertController.init(title: "Add Grocery Item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        ac.addAction(.init(title: "Submit", style: .default,handler: { [weak ac, weak self, weak stringq] _ in
            
            if let newItem = ac?.textFields?[0].text {
            
                if newItem == "" || self?.groceryList.contains(newItem) == true {
                    
                    let secondAC = UIAlertController.init(title: "Uh Oh", message: "You've got to enter a new item", preferredStyle: .alert)
                    
                    secondAC.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
                    
                    self?.present(secondAC, animated: true)
                } else {
                
                self?.groceryList.insert(newItem, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)

            self?.tableView.insertRows(at: [indexPath], with: .automatic) }
        }
          
        }
        ))
       
        ac.addAction(.init(title: "Nevermind", style: .default, handler: nil))

        
        present(ac, animated: true)
        
        
        
    }
    
    @objc func clearList() {
        
        groceryList = []
        
        tableView.reloadData()
        
    }
    
}

