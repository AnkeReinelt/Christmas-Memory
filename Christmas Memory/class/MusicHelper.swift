//
//  MusicHelper.swift
//  Christmas Memory
//
//  Created by Student on 16.12.20.
//



import AVFoundation

class MusicHelper {

    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?

    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "jinglebells", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        }
        catch {
            print("Cannot play the file")
        }
    }
    
    
    func playBellSound() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bellsound", ofType: "mp3")!)
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer2!.numberOfLoops = 1
            audioPlayer2!.prepareToPlay()
            audioPlayer2!.play()
        }
        catch {
            print("Cannot play the file")
        }
    }
    
}
