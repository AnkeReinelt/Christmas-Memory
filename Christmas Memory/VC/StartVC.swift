//
//  StartVC.swift
//  Christmas Memory
//
//  Created by Student on 15.12.20.
//

import UIKit

class StartVC: UIViewController {
    
    private var santaclause:GFXBox!
    
    private func createSantaClause(){
        santaclause = GFXBox(str: "santaclause.gif", frame: CGRect(x: 50, y: 310, width: 200,height: 100))
        santaclause.layer.zPosition = 7
        self.view.addSubview(santaclause)
        }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }
    
   private func setDefaults(){
        createSantaClause()
   }
 }
