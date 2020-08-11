//
//  finalRender.swift
//  cameraMixPhoto
//
//  Created by 林祐辰 on 2020/8/10.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit

class finalRender: UIViewController {


    @IBOutlet weak var renderSizePhoto: UIImageView!
    @IBOutlet weak var brightNessSlider: UISlider!
    
  
    var passedWidth: CGFloat!
    var passedHeight: CGFloat!
    var passedAngle: CGFloat!
    var buttonNumber:Int = 0
    var parameter = addImage()
    
   override func viewDidLoad() {
        super.viewDidLoad()
 
       renderSizePhoto.image = parameter.addPic
       renderSizePhoto.frame = CGRect(x: 52, y: 120, width: passedWidth, height: passedHeight)
       renderSizePhoto.transform = CGAffineTransform(rotationAngle: passedAngle)
    }
    

    
    @IBAction func changeBrightness(_ sender: UISlider) {
           let ciImage = CIImage(image: parameter.addPic!)
           let brightness = CIFilter(name: "CIColorControls")
            brightness?.setValue(ciImage, forKey: kCIInputImageKey)
            brightness?.setValue(brightNessSlider.value, forKey: kCIInputBrightnessKey)
            
        if let transBrightImage = brightness?.outputImage,let resizeOutputImage_ = CIContext().createCGImage(transBrightImage, from: transBrightImage.extent){
            let cgOutputImage = transBrightImage.oriented(CGImagePropertyOrientation(parameter.addPic!.imageOrientation))
            let finalBrightnessImage = UIImage(ciImage: cgOutputImage)
            renderSizePhoto.image = finalBrightnessImage
          }
        
        }
 
    @IBAction func sharePictures(_ sender: UIButton) {
        
        if let sharedImage = renderSizePhoto.image{
            let activities = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
              self.present(activities, animated: true, completion: nil)
        }
        
    }
    
   
    @IBAction func renderFilter(_ sender: UIButton) {
        if sender.tag == 0{
             renderSizePhoto.image = parameter.addPic
         }else{
             buttonNumber = sender.tag
             startChangePic()
         }
    }
    
    
    func startChangePic(){
     let filter=["","CIColorInvert","CISepiaTone","CIFalseColor","CIColorPosterize","CIPhotoEffectProcess","CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectTransfer","CIPhotoEffectChrome"]
        
        if parameter.addPic != nil{
            let turnToCiImage = CIImage(image: renderSizePhoto.image!)
            
            if let photoFilter = CIFilter(name:filter[buttonNumber]){
                photoFilter.setValue(turnToCiImage, forKey: kCIInputImageKey)
                
                if let outputFilterImage = photoFilter.outputImage {
                    let orientCIImage = outputFilterImage.oriented(CGImagePropertyOrientation(parameter.addPic!.imageOrientation))
                    let finalImage = UIImage(ciImage: orientCIImage)
                    renderSizePhoto.image = finalImage
                }
            }
        }
    }
}



extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        @unknown default:
            self = .up
        }
    }
}

