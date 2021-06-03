import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
            
            if allWords.isEmpty {
                
                allWords = ["silkworm"]
            
            }
        
        }
        
        startGame()
    }
    
    @objc func startGame() {
        
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
    return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isShortorSame(word: String) -> Bool {
        if word.count < 3 {
            return false
        } else if word == title?.lowercased() {
            return false
        }
        else {
            return true
        }
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        
    }
    
    func submit(_ answer: String) {
       let lowerAnswer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isShortorSame(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        //tableView.reloadData() Using this would just make it appear like a snap
                        
                        //Using the following is better as when it makes a new row it forces the view controller to also reload showing our new row text
                        
                        // This results in making it look like the row is sliding in!
                        
                        let indexPath = IndexPath(row: 0, section: 0)

                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    } else {
                        //for isReal check
                        errorTitle = "Word not recognized"
                        errorMessage = "You can't just make them up"
                        showError(errorTitle, errorMessage)
                    }
                } else {
                    //for isShortorRepeat check
                errorTitle = "Uh Oh"
                errorMessage = "You must use words longer than 3 characters that are NOT the original word :) "
                showError(errorTitle, errorMessage)
                    
            }
            } else {
                //for isOriginal check
                errorTitle = "Word Already Used"
                errorMessage = "Be more original"
                showError(errorTitle, errorMessage)
            }
            
        } else {
            //for isPossible check
            guard let title = title else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title.lowercased())"
            showError(errorTitle, errorMessage)
            
        }
    }
    
    
    func showError(_ errorTitle: String, _ errorMessage: String) {
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}
