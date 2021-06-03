//
//  ViewController.swift
//  Project2
//
//  Created by Mitchell Mackenzie Sell on 2021-05-13.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var audioCorrect: AVAudioPlayer?
    var audioIncorrect: AVAudioPlayer?
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCompleted = 0
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pathCorrect = Bundle.main.path(forResource: "correct", ofType: "mp4" )!
        let pathIncorrect = Bundle.main.path(forResource: "wrong", ofType: "mp4" )!
        let urlCorrect = URL(fileURLWithPath: pathCorrect)
        let urlIncorrect = URL(fileURLWithPath: pathIncorrect)
        
        audioCorrect = try? AVAudioPlayer.init(contentsOf: urlCorrect)
        audioIncorrect = try? AVAudioPlayer.init(contentsOf: urlIncorrect)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain","us", "uk"]
        
        askQuestion(action: nil)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }

    func askQuestion(action: UIAlertAction!) {
        
    
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named:countries[0]), for: .normal)
        button2.setImage(UIImage(named:countries[1]), for: .normal)
        button3.setImage(UIImage(named:countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) || Current Score: \(score) / \(questionsCompleted)"
        
    }
    

    @IBAction func ButtonTapped(_ sender: UIButton) {
        
        var title: String
        var ac: UIAlertController

        questionsCompleted += 1

        if sender.tag == correctAnswer {
            //Correct Answer Selected
            title = "Correct"
            score += 1

            if questionsCompleted == 10 {

                //One Game Is Complete

                ac = UIAlertController(title: title, message: "Final Score: \(score) / 10", preferredStyle: .alert)

                ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
                
                audioCorrect?.play()

                // reseting game
                score = 0
                questionsCompleted = 0

            } else {
                //Game is still in progress

                ac = UIAlertController(title: title, message: "Your score is \(score) / \(questionsCompleted)", preferredStyle: .alert)

                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                
                audioCorrect?.play()
            }

        } else {

            // Incorrect Answer Selected

            title = "Wrong"

            score -= 1

            ac = UIAlertController(title: title, message: "You selected the flag of: \(countries[sender.tag].uppercased()) ", preferredStyle: .alert)

            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

            audioIncorrect?.play()

        }

        present(ac, animated: true)
        
    }

    @objc func showScore() {
        
        let ac = UIAlertController(title: "Score", message: "Your current score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Return to Game", style: .default, handler: nil))
       
        present(ac, animated: true)
        
    }
    
}
