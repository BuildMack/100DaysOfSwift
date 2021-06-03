//
//  ViewController.swift
//  Project7
//
//  Created by Mitchell Mackenzie Sell on 2021-05-25.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filtered = [Petition]()
    var originalPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString: String
            
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterPetitions))
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(resetPetitions))
        
        var barButtonItems = [search, clear]
        
        navigationItem.leftBarButtonItems = barButtonItems
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source", style: .plain, target: self, action: #selector(source))
        
        if  navigationController?.tabBarItem.tag == 0 {
          urlString  = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
            // "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString) {
            
            if let data = try? Data(contentsOf: url) {
                
                // Okay to parse data
                parse(json: data)
                return
            }
            
        
        showError()
            
        print("Here is2: \(filtered)")
            
    }
        
    }

    func showError() {
        
        let ac = UIAlertController(title: "Loading error...", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert )
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        print(type(of: jsonPetitions))
        petitions = jsonPetitions.results
        originalPetitions = petitions
        tableView.reloadData()
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petitionInstance = petitions[indexPath.row]
        cell.textLabel?.text = petitionInstance.title
        cell.detailTextLabel?.text = petitionInstance.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func filterPetitions() {
        
        let ac = UIAlertController(title: "Filter Petitions For:", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
    
        let search = UIAlertAction(title: "Search", style: .default) {
        [weak ac] _ in
           
            
            guard let criteria = ac?.textFields?[0].text?.lowercased() else {return}
           
           // guard let petitions = self.petitions else {return}
            
            for petition in self.petitions {
                
                
                if petition.title.lowercased().contains(criteria) {
                    
                    self.filtered.append(petition)
                    print("Here is1: \(self.filtered)")
                    
                }
                
            }
            
            self.petitions = self.filtered
            self.tableView.reloadData()
            self.filtered = []
        
        }
        
        ac.addAction(search)
         
        present(ac,animated: true)
        
        }
        
    
    @objc func resetPetitions() {
        
        petitions = originalPetitions
        
        tableView.reloadData()
        
    }
    
    @objc func source() {
        
        let ac = UIAlertController(title: "Source:", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Close", style: .cancel)
        
        ac.addAction(action)
        
        present(ac, animated: true)
        
        
    }
            
            
    }
        
        

