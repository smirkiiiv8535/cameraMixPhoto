//
//  selectHistoryPic.swift
//  cameraMixPhoto
//
//  Created by 林祐辰 on 2020/8/8.
//  Copyright © 2020 smirkiiiv. All rights reserved.
//

import UIKit

class selectHistoryPic: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var pickedPhotos: UIImageView!
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let renderImage = info[.originalImage] as? UIImage
        pickedPhotos.image=renderImage
        dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pickPictures(_ sender: Any) {
        let pickPhotoHelper = UIImagePickerController()
        pickPhotoHelper.sourceType = .photoLibrary
        pickPhotoHelper.delegate = self
        present(pickPhotoHelper,animated:true,completion: nil)
        
  }
    
    
    
    @IBSegueAction func readyToRenderPhoto(_ coder: NSCoder) -> editPhotos? {
       
        let renderController = editPhotos(coder: coder)
        renderController?.passFirstEdit = pickedPhotos
        return renderController
    }
    
    
    @IBAction func unwindFromEditPhoto(segue:UIStoryboardSegue){
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
