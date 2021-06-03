//
//  ViewController.swift
//  Project1
//
//  Created by Mitchell Mackenzie Sell on 2021-05-10.
//

import UIKit


class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        var count = 0
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items {
            
            count += 1
            
            if item.hasPrefix("nssl") {
                pictures.append(item)
        
        }
        }
        
        pictures.sort()
        
        print(pictures)

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let vc = storyboard?.instantiateViewController(identifier: "Detail")
            as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            
            vc.numberViewed = indexPath.row + 1
            
            vc.numberOfPictures = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    
    }
}
