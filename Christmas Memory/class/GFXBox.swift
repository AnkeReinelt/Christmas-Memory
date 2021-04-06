//
//  GFXBox.swift
//  Christmas App
//
//  Created by student on 15.12.20.
//


import UIKit

class GFXBox: UIView {
    
    private var img:UIImageView!
    
    init(str:String,frame: CGRect) {
              super.init( frame:frame)
           createImg(str: str)
    }
 
    
    required init?(coder: NSCoder) {     super.init(coder:coder)    }

    
    public func setImg(str: String) {
        if(str.contains(".gif")){
            print()
            img.image = UIImage.gifImageWithName(str.components(separatedBy: ".")[0])
        }else{
            img.image = UIImage(named: str)
        }
    }
    
    
    private func createImg(str:String){
         img = UIImageView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height) )
         setImg(str: str)
         self.addSubview(img)
    }
    
}

