//
//  EditGameVC.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 11/4/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class EditGameVC: UIViewController {
    var library = Library.sharedInstance
    
    var game = VideoGame(title: "a", genre: .strategy, ESRB: .E, description: "b")
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
    var allowEditing = false
    var newGame: VideoGame?
    //MARK: Outlets
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var ratingController: UISegmentedControl!
    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var toggleEditingButton: UIBarButtonItem!
    @IBOutlet weak var updateGameButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        //This disables everything from the beginning
        titleText.isEnabled = false
        descriptionText.isEditable = false
        ratingController.isEnabled = false
        genrePicker.isUserInteractionEnabled = false
        //This sets up all the data from the game so the user can check the information to determine if it is correct
        titleText.text = game.title
        let index = recieveIndex(game.ESRB.rawValue)
        ratingController.selectedSegmentIndex = index
        let pickerIndex = genreIndex()
        genrePicker.selectRow(pickerIndex, inComponent: 0, animated: false)//This sets the starting point of the picker view
        descriptionText.text = game.description
    }
    
    func recieveIndex(_ ESRB: String) -> Int{//How to recieve the index for the rating
        switch ESRB {
        case "EC":
            return 0
        case "E":
            return 1
        case "E10+":
            return 2
        case "T":
            return 3
        case "M":
            return 4
        case "AO":
            return 5
        case "RP":
            return 6
        default:
            return 7
        }
    }
    
    func genreIndex () -> Int{//How to recieve the index for the genre
        switch game.genre.rawValue{
        case "Adventure":
            return 0
        case "Action":
            return 1
        case "Fighting":
            return 2
        case "Platformer":
            return 3
        case "Puzzle":
            return 4
        case "Racing":
            return 5
        case "Role Playing Game":
            return 6
        case "Shooter":
            return 7
        case "Simulation":
            return 8
        case "Sports":
            return 9
        case "Strategy":
            return 10
        default:
            return 11
        }
    }
    
    @IBAction func toggleEditingButtonTapped(_ sender: Any) {//This will occur if the "toggleediting button is pressed
        if allowEditing == false{//if everything is disabled then turn everything to be able to be enabled
            allowEditing = true
            updateGameButton.isEnabled = true
            titleText.isEnabled = true
            descriptionText.isEditable = true
            ratingController.isEnabled = true
            genrePicker.isUserInteractionEnabled = true
        } else if allowEditing == true {//if everything is enabled then turn everything to disable
            allowEditing = false
            updateGameButton.isEnabled = false
            titleText.isEnabled = false
            descriptionText.isEditable = false
            ratingController.isEnabled = false
            genrePicker.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func updateGameButtonPressed(_ sender: Any) { //this function will delete the original game and append the new game to that spot
        guard let title = titleText.text, title != "" else {return}
        //let newGame = VideoGame(title: title, genre: changeGenre(selectedGenre), ESRB: changeRating(ratingSegmentedController.selectedSegmentIndex), description: descriptionTextView.text)
        if let index = library.games.firstIndex(where: {$0 === game}){
            newGame = VideoGame(title: title, genre: changeGenre(selectedGenre), ESRB: changeRating(ratingController.selectedSegmentIndex), description: descriptionText.text)
            library.games[index] = newGame!
            let successAlert = UIAlertController(title: "Success", message: "Successfully edited \(title) to the library", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            })
            successAlert.addAction(dismissAction)
            self.present(successAlert, animated: true, completion: nil)
        }
    }
    
    func changeGenre(_ index: String) -> Genre{ //this determines the genre based on the string from the picker view
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
    func changeRating(_ index: Int) -> ESRBRating{//takes the segmented controller index and converts it to the rating
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

extension EditGameVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
