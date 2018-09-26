//
//  ViewController.swift
//  War
//
//  Created by Jake Kenniv on 9/4/18.
//  Copyright © 2018 Jake Kenniv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    @IBOutlet weak var leftPlayingCard: UIImageView!
    
    @IBOutlet weak var rightPlayingCard: UIImageView!
    
    @IBOutlet weak var dealButton: UIButton!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var cpuLabel: UILabel!  
    
    var leftScore = 0
    var rightScore = 0
    
    private var customView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customView?.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func warButtonPressed(_ sender: Any) {
        var leftRandomNumber = arc4random_uniform(13) + 2
        var rightRandomNumber = arc4random_uniform(13) + 2
        
        leftPlayingCard.image = UIImage(named: "card\(leftRandomNumber)")
        rightPlayingCard.image = UIImage(named: "card\(rightRandomNumber)")
        
        
        if leftRandomNumber > rightRandomNumber {
            //Update score
            leftScore += 1
            leftScoreLabel.text = String(leftScore)
        }
        
        else if rightRandomNumber > leftRandomNumber {
            //Update score
            rightScore += 1
            rightScoreLabel.text = String(rightScore)
        }
        
        else if leftRandomNumber == rightRandomNumber {
            
            //Load the popup window
            loadCustomViewIntoController()
            
            //In case multiple wars in a row...
            while(leftRandomNumber == rightRandomNumber) {
                //Disable the deal button while the war happens
                dealButton.isEnabled = false

                //Display the back of the card after delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.leftPlayingCard.image = UIImage(named: "cardBack")
                    self.rightPlayingCard.image = UIImage(named: "cardBack")
                })
            
                //Get new random numbers
                leftRandomNumber = arc4random_uniform(13) + 2
                rightRandomNumber = arc4random_uniform(13) + 2

                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.leftPlayingCard.image = UIImage(named: "card\(leftRandomNumber)")
                    self.rightPlayingCard.image = UIImage(named: "card\(rightRandomNumber)")
                    
                        if leftRandomNumber > rightRandomNumber {
                            //Update score and colors
                            self.leftScoreLabel.textColor = UIColor.red
                            self.playerLabel.textColor = UIColor.red
                            self.leftScore += 2
                            self.leftScoreLabel.text = String(self.leftScore)
                        }
                        else if rightRandomNumber > leftRandomNumber {
                            //Update score and colors
                            self.rightScoreLabel.textColor = UIColor.red
                            self.cpuLabel.textColor = UIColor.red
                            self.rightScore += 2
                            self.rightScoreLabel.text = String(self.rightScore)
                        }
                    
                    //Change score colors back to white and re-enable the deal button
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
                            self.leftScoreLabel.textColor = UIColor.white
                            self.playerLabel.textColor = UIColor.white
                            self.rightScoreLabel.textColor = UIColor.white
                            self.cpuLabel.textColor = UIColor.white
                            self.dealButton.isEnabled = true
                            self.customView?.isHidden = true
                        })
                    })
                }
            }
        }
    
    private func loadCustomViewIntoController() {
        let customViewFrame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        customView = UIView(frame: customViewFrame)
        
        view.addSubview(customView!)
        customView?.isHidden = false
        
        //Create a custom war frame label and display it on the storyboard

        var warLabelFrame:CGRect
        
        //If horizontal compact size class and landscape orientation
        if self.traitCollection.horizontalSizeClass.rawValue == 1 && UIDevice.current.orientation.isLandscape {
            warLabelFrame = CGRect.init(x: dealButton.center.x - 25, y: dealButton.center.y - 230, width: view.frame.width, height: view.frame.height)
        }
            
        else {
                warLabelFrame = CGRect.init(x: dealButton.center.x - 25, y: dealButton.center.y - 230, width: view.frame.width, height: view.frame.height)
        }
        let warLabel = UILabel(frame: warLabelFrame)
        warLabel.text = "WAR"
        warLabel.textColor = UIColor.red
        warLabel.shadowOffset = CGSize(width: -2, height: 0)
        warLabel.shadowColor = UIColor.black
        warLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        customView?.addSubview(warLabel)
        
        print("TEST");
        
    }
}

