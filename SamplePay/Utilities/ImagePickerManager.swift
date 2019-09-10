//
//  ImagePickerManager.swift
//  SamplePay
//
//  Created by sapphre on 09/09/19.
//  Copyright © 2019 abhilash. All rights reserved.
//

import UIKit

//MARK:- ImagePickerManager
final class ImagePickerManager: NSObject, UINavigationControllerDelegate {
    
    static let shared: ImagePickerManager = ImagePickerManager.init()
    private override init() {
        super.init()
    }
    
    var onImageChosenCallBack: ((UIImage?) -> ())?
    var onImagePickerDismissCallBack: (() -> ())?
    
    fileprivate var chosenImage: UIImage? = nil
    
    func presentChooseImagePickerInViewController(vc: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController.init()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            vc.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func presentCameraImagePickerInViewController(vc: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController.init()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            vc.present(pickerController, animated: true, completion: nil)
        }
    }
}
//MARK:- ImagePickerManager: UIImagePickerControllerDelegate
extension ImagePickerManager: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        if let block = onImageChosenCallBack {
            block(image)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let block = onImagePickerDismissCallBack {
            block()
        }
    }
}
