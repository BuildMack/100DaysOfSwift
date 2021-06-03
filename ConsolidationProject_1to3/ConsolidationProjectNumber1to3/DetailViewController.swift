//
//  DetailViewController.swift
//  ConsolidationProjectNumber1to3
//
//  Created by Mitchell Mackenzie Sell on 2021-05-19.
//

import UIKit

class DetailViewController: UIViewController {
    
    
   
    @IBOutlet var imageView: UIImageView!
    var selectImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = selectImage
        navigationItem.largeTitleDisplayMode = .never
        

        if let imagetoLoad = selectImage {
            
            imageView.image = UIImage(named: imagetoLoad)
        }
        
        }

    
    
}
