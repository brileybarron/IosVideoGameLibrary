//
//  LibraryVC.swift
//  IosVideoGameLibrary
//
//  Created by Briley Barron on 10/29/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryVC: UIViewController{
    //singleton
    let library = Library.sharedInstance
    var selectedCellGame: VideoGame?
    //tableview
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //This just adds four games in the game array to give starting values in the library
        library.games.append(VideoGame(title: "Skyrim", genre: .adventure, ESRB: .T, description: "Great game that takes a lot of time to find everything."))
        library.games.append(VideoGame(title: "Ultimate Chicken Horse", genre: .platformer, ESRB: .E10Up, description: "Has a horse and a chicken therefore it is awesome"))
        library.games.append(VideoGame(title: "Super Mario Bros. 3", genre: .platformer, ESRB: .E, description: "10/10 would recomend!"))
        library.games.append(VideoGame(title: "Super Smash Bros. 4", genre: .fighting, ESRB: .E10Up, description: "You should play this and learn everything about it then you can win."))
        
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EditGameVC {
            (segue.destination as! EditGameVC).game = (sender as! LibraryCell).game
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()//reload the data anytime the view appears again
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func checkOut(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.avaliability = .checkedOut(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! LibraryCell).setup()
    }
    
    func checkIn(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.avaliability = .checkedIn
        (tableView.cellForRow(at: indexPath) as! LibraryCell).setup()
    }
}

//This extension is used only by the tablevieww
extension LibraryVC: UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if library.games.count == 0 {
//            tableView.reloadData()
//        }
        return library.games.count//This gives how many rows there are
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Force casts the cell as a Library Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! LibraryCell
        //takes the row the table view is on
        let game = library.games[indexPath.row]
        //allows the cell to store this data
        cell.game = game
        //and sets up that game
        cell.setup()
        //then returns that cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //adds a new choice when the cell is swiped
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.library.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let game = library.games[indexPath.row]
        
        // If the game is checked out, we create and return the check in action.
        // If the game is checked in, we create and return the check out action.
        
        switch game.avaliability {
        case .checkedIn:
            let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                
                self.checkOut(at: indexPath)
                
            }
            
            return [deleteAction, checkOutAction]
            
        case .checkedOut:
            let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                self.checkIn(at: indexPath)
            }
            
            return [deleteAction, checkInAction]
            
        }
    }
    //DZNEmptyDataSet

    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Empty Library"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "There currently arent any games in your library"
        
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center
        
        let attribs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.paragraphStyle: para
        ]
        
        return NSAttributedString(string: text, attributes: attribs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "Add  Game"
        let attribs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: view.tintColor
        ]
        
        return NSAttributedString(string: text, attributes: attribs as [NSAttributedString.Key : Any])
    }
    
    func emptyDataSetDidTapButton(_ scrollView: UIScrollView!) {
        performSegue(withIdentifier: "unwindToLibrary", sender: Any.self)
    }
}

