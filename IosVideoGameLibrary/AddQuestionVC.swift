//
//  AddQuestionVC.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 10/29/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class AddGameVC: UIViewController {
    let library = Library.sharedInstance
    var newVideoGame: VideoGame?
    var genres = ["adventure",
                  "action",
                  "fighting",
                  "platformer",
                  "puzzle",
                  "racing",
                  "roleplaying",
                  "shooter",
                  "simulation",
                  "sports",
                  "strategy",
                  "misc"]
    var selectedGenre: String = "adventure"
    
    //Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ratingSegmentedController: UISegmentedControl!
    @IBOutlet weak var genrePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
    }
    
    
    @IBAction func addGame(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all fields or press cancel to return to the main screen", preferredStyle: UIAlertController.Style.alert)
            
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in})
            errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        let newGame = VideoGame(title: title, genre: changeGenre(selectedGenre), ESRB: changeRating(ratingSegmentedController.selectedSegmentIndex), description: descriptionTextView.text)
        let successAlert = UIAlertController(title: "Success", message: "Successfully added \(title) to the library", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in
            self.library.games.append(newGame)
            self.navigationController?.popViewController(animated: true)
        })
        successAlert.addAction(dismissAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    func changeGenre(_ index: String) -> Genre{
        switch index {
        case "action":
            return .action
        case "adventure":
            return .adventure
        case "fighting":
            return .fighting
        case "platformer":
            return .platformer
        case "puzzle":
            return .puzzle
        case "racing":
            return .racing
        case "roleplaying":
            return .roleplaying
        case "shooter":
            return .shooter
        case "simulation":
            return .simulation
        case "sports":
            return .sports
        case "strategy":
            return .strategy
        default:
            return .misc
        }
    }
    func changeRating(_ index: Int) -> ESRBRating{
        switch index {
        case 0:
            return .EC
        case 1:
            return .E
        case 2:
            return .E10Up
        case 3:
            return .T
        case 4:
            return .M
        case 5:
            return .AO
        case 6:
            return .RP
        case 7:
            return .NR
        default:
            return .NR
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
}
extension AddGameVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGenre = genres[row]
    }
    
}
