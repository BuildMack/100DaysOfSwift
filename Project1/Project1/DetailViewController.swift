//
//  DetailViewController.swift
//  Project1
//
//  Created by Mitchell Mackenzie Sell on 2021-05-11.
//
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numberViewed: Int?
    var numberOfPictures: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let numberViewed = numberViewed {
            if let numberOfPictures = numberOfPictures {
                title = "Image \(numberViewed) / \(numberOfPictures)"
            }
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage{
            
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.hidesBarsOnTap = true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.hidesBarsOnTap = false
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

