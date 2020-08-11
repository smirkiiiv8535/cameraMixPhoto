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
    
    var preparePhotoEffect: UIImage!
    var passedWidth: CGFloat!
    var passedHeight: CGFloat!
    var passedAngle: CGFloat!
    
    var buttonNumber = 0
    
    let filterMap = ["","CIColorInvert","CISepiaTone","CIFalseColor","CIColorPosterize","CIPhotoEffectProcess","CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectTransfer","CIPhotoEffectChrome"]
    
   override func viewDidLoad() {
        super.viewDidLoad()
 
       renderSizePhoto.image = preparePhotoEffect
       renderSizePhoto.frame = CGRect(x: 52, y: 120, width: passedWidth, height: passedHeight)
       renderSizePhoto.transform = CGAffineTransform(rotationAngle: passedAngle)
    
    }
    
    
    
    @IBAction func changeBrightness(_ sender: UISlider) {
           let ciImage = CIImage(image: preparePhotoEffect)
            let brightness = CIFilter(name: "CIColorControls")
            brightness?.setValue(ciImage, forKey: kCIInputImageKey)
            brightness?.setValue(brightNessSlider.value, forKey: kCIInputBrightnessKey)
            
        if let transBrightImage = brightness?.outputImage,let resizeOutputImage = CIContext().createCGImage(transBrightImage, from: transBrightImage.extent){
            let finalBrightnessImage = UIImage(cgImage: resizeOutputImage)
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
            renderSizePhoto.image = preparePhotoEffect
        }else{
            buttonNumber = sender.tag
            startChangePic()
        }
    }
    
    
    
    func startChangePic(){
        if renderSizePhoto.image != nil{
            let turnToCiImage = CIImage(image: renderSizePhoto.image!)
            
            if let photoFilter = CIFilter(name:self.filterMap[buttonNumber]){
                photoFilter.setValue(turnToCiImage, forKey: kCIInputImageKey)
                
                if let outputFilterImage = photoFilter.outputImage {
                    let orientCIImage = outputFilterImage.oriented(CGImagePropertyOrientation(preparePhotoEffect.imageOrientation))
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

