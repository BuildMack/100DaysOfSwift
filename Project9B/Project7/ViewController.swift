//
//  ViewController.swift
//  Project7
//
//  Created by Mitchell Mackenzie Sell on 2021-05-25.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }

    @objc func fetchJSON() {
        
        let urlString: String
            
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
            
            }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError() {

        let ac = UIAlertController(title: "Loading error...", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert )
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        print(type(of: jsonPetitions))
        petitions = jsonPetitions.results
        
            performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            
        } else {
            
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            
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
}

