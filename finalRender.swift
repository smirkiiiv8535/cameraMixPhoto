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
 
        // Do any additional setup after loading the view.
       renderSizePhoto.image = preparePhotoEffect
       renderSizePhoto.frame = CGRect(x: 52, y: 120, width: passedWidth, height: passedHeight)
       renderSizePhoto.transform = CGAffineTransform(rotationAngle: passedAngle)
    }
    
    
    
    @IBAction func changeBrightness(_ sender: UISlider) {
           let ciImage = CIImage(image: preparePhotoEffect)
        
            let brightness = CIFilter(name: "CIColorControls")
            brightness?.setValue(ciImage, forKey: kCIInputImageKey)
            brightness?.setValue(brightNessSlider.value, forKey: kCIInputBrightnessKey)
            
            let transBrightImage = brightness?.outputImage
            renderSizePhoto.image = UIImage(ciImage: transBrightImage!)
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
                
                if let outputFilterImage = photoFilter.outputImage, let resizeOutputImage = CIContext().createCGImage(outputFilterImage, from: outputFilterImage.extent) {
                    let finalimage = UIImage(cgImage: resizeOutputImage)
                    renderSizePhoto.image = finalimage
                }
            }
        }
    }
    
    
    
}


