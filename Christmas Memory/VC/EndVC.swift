//
//  EndVC.swift
//  Christmas Memory
//
//  Created by Student on 15.12.20.
//

import UIKit
import AVFoundation

class EndVC: UIViewController {

    @IBOutlet var gameOverText: UILabel!
    private var santaclause:GFXBox!
  
    override func viewDidLoad(){
        super.viewDidLoad()
        createSantaClause()
        gameOverText.text = "Du hast das Memory in \(sVars.gameTime) Sekunden gelöst."
    }
    
    
    private func createSantaClause(){
        santaclause = GFXBox(str: "santaclause.gif", frame: CGRect(x: 50, y: 310, width: 200,height: 100))
        santaclause.layer.zPosition = 7
        self.view.addSubview(santaclause)
    }
    
  }//Ende EndVC
