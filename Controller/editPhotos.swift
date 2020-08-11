//
//  editPhotos.swift
//  cameraMixPhoto
//
//  Created by 林祐辰 on 2020/8/8.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit

class editPhotos: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var passFirstEdit :UIImageView!
    var pickerView : UIPickerView!
    
    var width :CGFloat = 310
    var height :CGFloat = 310
    var initAngle = 360
    var fixedAngle :CGFloat = 0
    var ratioMap = ["","1:1","4:5","16:9","5:7","14:11","3:4",""]
    
    
    @IBOutlet weak var versionSecondPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        versionSecondPhoto.image = passFirstEdit.image
        setForPick()
    }
    
    func setForPick(){
         pickerView = UIPickerView()
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.frame = CGRect(x: 36, y: 680, width: 342, height: 182)
         view.addSubview(pickerView)
     }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratioMap.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ratioMap[row]
       }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
        case 0:
            fallthrough
        case 1:
            height = width * 1
        case 2:
            height = width * 5/4
        case 3:
            height = width * 9/16
        case 4:
            height = width * 7/5
        case 5:
            height = width * 11/14
        case 6:
            height = width * 4/3
        default :
            height = width * 1
        }
       versionSecondPhoto.frame = CGRect(x: 52, y: 120, width: width, height: height)
    }
    
    @IBAction func turnLeft(_ sender: UIButton) {
        switch initAngle {
         case 360 :
            initAngle = 270
            versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi*3/2)
            fixedAngle = CGFloat.pi*3/2
         case 270 :
            initAngle = 180
            versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            fixedAngle = CGFloat.pi
         case 180 :
            initAngle = 90
            versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            fixedAngle = CGFloat.pi/2
        default:
            initAngle = 360
            versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
            fixedAngle = CGFloat.pi*2
            break
        }
   }
    
    @IBAction func turnRight(_ sender: UIButton) {
        switch initAngle {
         case 360 :
            initAngle = 90
          versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            fixedAngle = CGFloat.pi/2
         case 90 :
            initAngle = 180
              versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            fixedAngle = CGFloat.pi
         case 180 :
            initAngle = 270
               versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi*3/2)
            fixedAngle = CGFloat.pi*3/2
        default:
            initAngle = 360
             versionSecondPhoto.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
            fixedAngle = CGFloat.pi*2
            break
        }
    }
    
    @IBSegueAction func readyRender(_ coder: NSCoder) -> finalRender? {
        let renderHelper = finalRender(coder: coder)
        renderHelper?.passedImage = versionSecondPhoto.image
        renderHelper?.passedWidth = self.width
        renderHelper?.passedHeight = self.height
        renderHelper?.passedAngle = self.fixedAngle
        return renderHelper
    }
    

    @IBAction func unwindToSize (segue:UIStoryboardSegue){}
}
