//
//  UploadFirebase.swift
//  ChatKeepcoding
//
//  Created by CRISTIAN ESPES on 11/12/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadFirebase: UploadManager {
    func save(name: String, image: UIImage, onSuccess: @escaping (String) -> Void, onError: ErrorClosure?) {
        
        // Storage.storage().reference() -> La raíz
        let uploadRef = Storage.storage().reference().child(name)
        
        // Reducimos un poco el tamaño de la imagen
        if let imageData = UIImageJPEGRepresentation(image, 0.3) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            uploadRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let err = error, let retError = onError {
                    retError(err)
                }
                
                uploadRef.downloadURL{ (url, error) in
                    if let err = error, let retError = onError {
                        retError(err)
                    }
                    
                    onSuccess(url?.absoluteString ?? "")
                }
            }
        }
        
        
        
        
        
    }
}
