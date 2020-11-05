//
//  RockPaperScissorsViewController.swift
//  RockPaperScissors
//
//  Created by Gabrielle Miller-Messner on 10/30/14.
//  Copyright (c) 2014 Gabrielle Miller-Messner. All rights reserved.
//
//  History:
//      added func showHistoryVC()
//

import UIKit

// MARK: - RockPaperScissorsViewController: UIViewController

class RockPaperScissorsViewController: UIViewController {

    // MARK: Properties
    
    var match: RPSMatch!
    
    // Here is the history array which will hold the results of each match that is played in a session.
    var history = [RPSMatch]()
    
    // MARK: Outlets
    
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated:Bool) {
        historyButton.isHidden = true  // hide the history button till after a match
    }

    
    // MARK: Actions
    
    @IBAction func makeYourMove(_ sender: UIButton) {
        
        // The RPS enum holds a player's move
        switch (sender) {
        case self.rockButton:
            throwDown(RPS.rock)
            
        case self.paperButton:
            throwDown(RPS.paper)

        case self.scissorsButton:
            throwDown(RPS.scissors)

        default:
            assert(false, "An unknown button is invoking makeYourMove()")
        }
    }   /* makeYourMove */
    
    // MARK: Play!
    
    func throwDown(_ playersMove: RPS) {
        // The RPS enum generates the opponent's move
        let computersMove = RPS()
        
        // The RPSMatch struct stores the results of a match
        let match = RPSMatch(p1: playersMove, p2: computersMove)
        
        // Here we add a match to the history array. 
        history.append(match)
        
        //Here are the 3 ways of presenting a View Controller
        
        // 1st Way: Programmatic View Controller Presentation
        
        // Get the storyboard and ResultViewController
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        
        // Communicate the match to the ResultsViewController
        resultVC.match = match
        self.present(resultVC, animated: true, completion: nil)
        
        self.match = match
        historyButton.isHidden = false  // make it visible
    
    }   /* throwDown */
    
    // @IBAction func showHistoryVC() {
    //     performSegue(withIdentifier: "showHistorySegue", sender: self)
    // }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if ((segue.identifier == "throwDownPaper") || (segue.identifier == "throwDownScissors")) {

            //Notice that this code works for both Scissors and Paper
            let controller = segue.destination as! ResultViewController
            controller.match = self.match

        } else if (segue.identifier == "showHistorySegue") {
            let controller = segue.destination as! HistoryViewController
            controller.history = self.history
            controller.match   = self.match
        }
    }   /* prepare for segue */
    
}
