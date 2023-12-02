//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Tyler Milner on 9/30/23.
//

import UIKit

// Must inherit from NSObject to avoid Obj-C related error - `Unrecognized selector -[Instafilter.ImageSaver methodSignatureForSelector:]`
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
