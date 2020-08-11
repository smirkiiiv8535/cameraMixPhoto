//
//  decidePhotoScreen.swift
//  cameraMixPhoto
//
//  Created by 林祐辰 on 2020/8/8.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class decidePhotoScreen: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
           
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

            dismiss(animated: true, completion: nil)
        }
    }
       
    @objc func image(_ image: UIImage,
        didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERROR \(error)")
        }
    }
    
    @IBAction func takePhotos(_ sender: Any) {
        let takeImageControler = UIImagePickerController()
        takeImageControler.sourceType = .camera
        takeImageControler.delegate = self
       present(takeImageControler,animated: true,completion: nil)
    }
    
    @IBAction func unwindTakePictures(segue:UIStoryboardSegue){
    }
    @IBAction func unwindChoosePictures(segue:UIStoryboardSegue){
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
