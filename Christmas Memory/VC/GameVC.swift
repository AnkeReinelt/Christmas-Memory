//
//  GameVC.swift
//  Christmas Memory
//
//  Created by Student on 15.12.20.
//

import UIKit
import AVFoundation

class GameVC: UIViewController {
   
    
    @IBOutlet var checkBtn: UIButton!
    @IBOutlet var time: UILabel!
    
    var player: AVAudioPlayer?
    var player2: AVAudioPlayer?
    private var interval:Timer!
    var tagArray = [Int]()
    var compareArray = [String]()
    var buttonArray = [UIButton]()
    var isShuffle:Bool = false
    var isCorrect:Bool = false
    var isOver = false
    var discoveredCards = 0
    var count = 0
    var imgArray = ["gift.jpg","christmastree.jpg","stick.jpg","angel.jpg","bell.jpg","luckyMoose.jpg","candle.jpg","weihnachtsman.jpg","snowman.jpg","gift.jpg","christmastree.jpg","stick.jpg","angel.jpg","bell.jpg","luckyMoose.jpg","candle.jpg","weihnachtsman.jpg","snowman.jpg"]
    var KartenArray:[Card] = []
    var solvedBtns = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sVars.gameTime = 0
        initializeCardArray()
        setDefaults()
        setEvents()
        interval = Timer.scheduledTimer(timeInterval:1 , target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        MusicHelper.sharedHelper.playBackgroundMusic()
      }

    private func initializeCardArray(){
        imgArray.shuffle()
        for i in 0 ..< imgArray.count {
            KartenArray.append(Card(image: UIImage(named: imgArray[i])!))
            }
        }
    
    
    @objc private func countTime(){
        sVars.gameTime += 1
        time.text = "Time: \(sVars.gameTime)"
      }

    
    private func setDefaults(){
        var xVersatz = 0
        var yVersatz = 0
        for i in 0 ..< 18{
            if (i%6 == 0 && i != 0){
                yVersatz += 100
                xVersatz += 540}
        let image = UIImage(named: "snowflake.jpg")
        let card = UIButton()
        card.frame = (CGRect(x:90*i+180-xVersatz, y:0*i+70+yVersatz, width: 80, height: 80))
        card.backgroundColor = UIColor(red: 201/255, green: 181/255, blue: 200/255, alpha: 1)
        card.setImage(image, for: .normal)
        card.layer.borderWidth = 1
        card.layer.borderColor = CGColor(red: 95/255, green: 181/255, blue: 204/255, alpha: 1)
        card.layer.cornerRadius = 5
        card.tag = i
        buttonArray.append(card)
        self.view.addSubview(card)
           }
    }//ENDE SetDefaults
 
    private func setEvents(){
        for i in 0 ..< imgArray.count{
        buttonArray[i].addTarget(self, action: #selector(btnDown), for: .touchUpInside)
        }
    }//ENDE SetEvents
    
    @objc private func coverCards(){
        buttonArray[tagArray[0]].setImage(UIImage(named:"snowflake.jpg" ), for: .normal)
        buttonArray[tagArray[1]].setImage(UIImage(named:"snowflake.jpg" ), for: .normal)
        tagArray.removeAll()
        compareArray.removeAll()
    }
    
    private func playmove(sender:UIButton){
        count += 1
        count = count%2
        switch count {
          case 1://erster Klick
          do {
                tagArray.insert(sender.tag, at: 0)
                compareArray.insert(imgArray[sender.tag], at: 0)
                print(tagArray)
                print(compareArray)
                sender.setImage(KartenArray[sender.tag].cardImage, for: .normal)
                buttonArray[tagArray[0]].removeTarget(self, action: #selector(btnDown), for: .touchUpInside)
                }
          case 0://zweiter Klick
          do {
                tagArray.insert(sender.tag, at: 1)
                compareArray.insert(imgArray[sender.tag], at: 1)
                print(tagArray)
                print(compareArray)
                sender.setImage(KartenArray[sender.tag].cardImage, for: .normal)
                buttonArray[tagArray[1]].removeTarget(self, action: #selector(btnDown), for: .touchUpInside)
                
                //nach dem zweiten Spielzug werden alle Buttons ersteinmal deaktiviert
                 deactivateBtns()
                 if (compareArray[0] == compareArray[1]) { //falls zwei korrekte Karten angeklickt wurden
                    //es ertönt ein Glöckchen
                    MusicHelper.sharedHelper.playBellSound()
                    
                    solvedBtns[tagArray[0]] = true
                    solvedBtns[tagArray[1]] = true
                    aktiviereRestlicheBtns()

                    //zählt die korrekt aufgedeckten Kartenpaare
                    discoveredCards += 1
                    //sind genügend Kartenpaare aufgedeckt --> GameOver
                    gameOver(zahl: discoveredCards)
                    tagArray.removeAll()
                    compareArray.removeAll()
                   
              } else if (compareArray[0] != compareArray[1]){ //falls zwei falsche Karten angeklickt wurden
                    //alle Buttons für die solvedBtns[i] == false gilt, müssen nach zwei Sekunden wieder aktiviert werden
                   _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(aktiviereRestlicheBtns), userInfo: nil, repeats: false)
                    //nach zwei Sekunden werden Karten wieder verdeckt
                   _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(coverCards), userInfo: nil, repeats: false)
                   }
             }
         default:
            break
          }//Ende switch
        }//Ende playmove()
    
 
    @objc private func aktiviereRestlicheBtns(){
        for i in 0 ..< solvedBtns.count {
            if solvedBtns[i] == false {
                buttonArray[i].addTarget(self, action: #selector(btnDown), for: .touchUpInside)
            }
        }
    }
    
   @objc private func btnDown(sender:UIButton){
    playmove(sender: sender)
   }
    
   @objc private func deactivateBtns(){
        for i in 0 ..< imgArray.count {
            buttonArray[i].removeTarget(self, action: #selector(btnDown), for: .touchUpInside)
        }
   }
    
    ///Wenn alle Karten aufgedeckt sind, wird zum EndVC navigiert
    private func gameOver(zahl:Int){
        if zahl == (imgArray.count/2){
          interval.invalidate()
          let sb:UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
          let vc:UIViewController = sb.instantiateViewController(withIdentifier: "eVC")
          self.navigationController?.pushViewController(vc, animated: true)
          self.show(vc, sender: vc)
        }
     }
    
}// Ende GameVC
