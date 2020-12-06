//
//  Firestorage.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import Foundation
import SwiftUI
import FirebaseStorage
 

let storage = Storage.storage()

class FileStorage {
    
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?) -> Void) {
        
        let storageRef = storage.reference(forURL: kFILEREFERENCE).child(directory)
        
        let imageData = image.jpegData(compressionQuality: 0.6)
        
        var task: StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { (metaData, error) in
            
            task.removeAllObservers()
            //ProgressHUD.dismiss()
            
            if error != nil {
                print("error uploading image", error!.localizedDescription)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                print("we have uploaded image to ", downloadUrl.absoluteString)
                completion(downloadUrl.absoluteString)
            }
        })
        
        
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            
            _ = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            //ProgressHUD.showProgress(CGFloat(progress))
        }
        
        
    }
    
    
    
    class func downloadImage(imageUrl: String, completion: @escaping (_ image: UIImage?) -> Void) {
                
        let imageFileName = ((imageUrl.components(separatedBy: "_").last!).components(separatedBy: "?").first)!.components(separatedBy: ".").first!

        if fileExistsAt(path: imageFileName) {
            
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: imageFileName)) {
                completion(contentsOfFile)
            } else {
                print("couldnt generate image from local image")
                completion(nil)
            }
            
        } else {

            if imageUrl != "" {
                
                let documentURL = URL(string: imageUrl)
                
                let downloadQueue = DispatchQueue(label: "downloadQueue")

                downloadQueue.async {
                    
                    let data = NSData(contentsOf: documentURL!)
                    
                    if data != nil {
                        
                        let imageToReturn = UIImage(data: data! as Data)
                        
                        FileStorage.saveImageLocally(imageData: data!, fileName: imageFileName)
                        
                        completion(imageToReturn)
                        
                    } else {
                        print("no image in database")
                        completion(nil)
                    }
                }

            } else {
                completion(nil)
            }
        }
    }
    
    
    
    
    class func saveImageLocally(imageData: NSData, fileName: String) {
        
        var docURL = getDocumentsURL()
        
        docURL = docURL.appendingPathComponent(fileName, isDirectory: false)
        imageData.write(to: docURL, atomically: true)
    }
    
    class func removeFileFromFirestore(fileURL:String){
            let storage = Storage.storage()
            let storageRef = storage.reference(forURL: fileURL)
            storageRef.delete { error in
                if let error = error {
                    print(error)
                } else {
                    print(">> File deleted successfully!")
                }
            }
        
    }
    
}


func getDocumentsURL() -> URL {
    
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    
    return documentURL!
}


func fileInDocumentsDirectory(filename: String) -> String {
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    
    return fileURL.path
}




func fileExistsAt(path: String) -> Bool {
    
    return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(filename: path))
}


