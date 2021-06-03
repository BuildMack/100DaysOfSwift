//
//  ViewController.swift
//  Project8
//
//  Created by Mitchell Mackenzie Sell on 2021-05-27.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var levelImage: UIImage!
    var letterButtons = [UIButton]()
    var levelImages = [UIImage]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        
        didSet {
            
            scoreLabel.text = "Score: \(score)"
            
        }
    }
    
    var correctSolutions = 0
    
    var level = 2
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        //cluesLabel.font = UIFont.systemFont(ofSize: )
        cluesLabel.text = "Clues"
        cluesLabel.textAlignment = .left
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        levelImage = UIImage(named: "TheOffice.jpg")
        var imageView = UIImageView(image: levelImage!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.setContentHuggingPriority(UILayoutPriority(10), for: .vertical)
        view.addSubview(imageView)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        //answersLabel.font = UIFont.systemFont(ofSize: 20)
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .center
        answersLabel.text = "Answers"
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
  
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap Letters to Guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 30)
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.layer.borderWidth = 1
        //currentAnswer.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        currentAnswer.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        currentAnswer.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(currentAnswer)
        
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submit.layer.borderWidth = 2
        submit.layer.borderColor = UIColor(red: 0, green: 0.8, blue: 0.4, alpha: 1).cgColor
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.layer.borderWidth = 2
        clear.layer.borderColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 1).cgColor
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            
            imageView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            //imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            //imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.15),
            
            
            cluesLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -120),
            
            
            answersLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -80),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 20),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            submit.widthAnchor.constraint(equalToConstant: 74),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.widthAnchor.constraint(equalToConstant: 74),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        
        ])
        
        let width = 150
        
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW",for: .normal)
                
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                
            }
            
            
        }
        
//        cluesLabel.backgroundColor = .red
//        answersLabel.backgroundColor = .blue
//        buttonsView.backgroundColor = .green
//        scoreLabel.backgroundColor = .purple
//        letterButtons[1].backgroundColor = .red
        loadLevel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    @objc  func letterTapped(_ sender: UIButton) {
        
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        
        activatedButtons.append(sender)
        sender.isHidden = true // HIDES THE BUTTON!
    
    }
        
    
    @objc  func submitTapped(_ sender: UIButton) {
        
        
        guard let answerText = currentAnswer.text else {return}
        
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            
            
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            
            splitAnswers?[solutionPosition] = answerText
            
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            
            score += 1
            
            correctSolutions += 1
            
            if correctSolutions % 7 == 0 {
                
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: levelUp))
                
                present(ac, animated: true)
                
            }
            
        } else {
            
            let ac = UIAlertController(title: "Incorrect", message: "Try Again!", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: clearAnswer))
            
            present(ac,animated: true)
            
            score -= 1
        }
        
    }

    @objc func clearTapped(_ sender: UIButton){
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
            
            activatedButtons.removeAll()
        }
    }
    
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        var clues = [String]()
        
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL){
                
                var lines = levelContents.components(separatedBy: "\n")
                
                lines.shuffle()
                
                // My solution to breaking up the strings:
//                for var line in lines {
//
//                    while true {
//                        if let pipeFound = line.firstIndex(of: "|") {
//
//                            line.remove(at: pipeFound)
//
//                        }
//                break
//                }
//
//                    clues.append(contentsOf: line.components(separatedBy: ": "))
//                    clues.remove(at: clues.endIndex - 1)
//                    solutions.append(contentsOf: line.components(separatedBy: ": "))
//                    solutions.remove(at: solutions.endIndex - 2)
//                }
//                }
                

                //Paul's Solution:
                
                //This enumerates through each element of the array
                for (index, line) in lines.enumerated() {
                
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy:"|")
                    letterBits += bits
                }
                
//
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        letterButtons.shuffle()
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
            
        }
    }
    
    func clearAnswer(action: UIAlertAction) {
        
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
            activatedButtons.removeAll()
            
            
        
    }
    
    func levelUp(action: UIAlertAction) {
        
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for button in letterButtons {
            
            button.isHidden = false
            
        }
    }
}

