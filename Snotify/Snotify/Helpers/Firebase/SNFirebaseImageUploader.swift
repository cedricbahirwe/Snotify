//
//  SNFirebaseImageUploader.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 20/07/2022.
//

import Firebase
import FirebaseStorage

final class SNFirebaseImageUploader {
    static let shared = SNFirebaseImageUploader()
    private init() { }
    var imageUrl: URL?

    func upload(data: Data,
                format: String,
                path: String,
                completionHandler: @escaping (_ status: String) -> ()) {

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageId = UUID()

        let meta = StorageMetadata()
        meta.contentType = "\(format == "pdf" ? "application" : "image")/\(format)";
        let riversRef = storageRef.child("\(path)/\(imageId).\(format)")
        let uploadTask = riversRef.putData(data, metadata: meta) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("Error occured: \(String(describing: error))")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            print("Meta data size", size)
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    print("Error Downloading \(String(describing: error))")
                    return
                }
                self.imageUrl = downloadURL
                print("Downloaded URL: \(downloadURL)")
            }
        }
        let observer = uploadTask.observe(.progress) { snapshot in
            print("Progress at upload: \(snapshot)")
        }

        print("observe", observer)
        _  = uploadTask.observe(.success) { snapshot in
            snapshot.reference.downloadURL(completion: {d, error in
//                print("Succest at \(snapshot) with \(imageUrl?.absoluteString)")
                completionHandler(d?.absoluteString ?? "")
            })
        }

        _ = uploadTask.observe(.failure) { snapshot in
            print("Failure at snapshot \(snapshot)")
        }
    }

//    func uploadPicture(data: Data, format: String, path: String, completionHandler: @escaping (_ status: String) -> ()) {
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let imageId = UUID()
//
//        let meta = StorageMetadata()
//        meta.contentType = "\(format == "pdf" ? "application" : "image")/\(format)";
//        let riversRef = storageRef.child("\(path)/\(imageId).\(format)")
//        let uploadTask = riversRef.putData(data, metadata: meta) { (metadata, error) in
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                print("Error with metadata \(String(describing: error))")
//                return
//            }
//            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
//            print("Meta size: ", size)
//
//            // You can also access to download URL after upload.
//            riversRef.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                    // Uh-oh, an error occurred!
//                    print("Error: \(String(describing: error))")
//                    return
//                }
//                self.imageUrl = downloadURL
//                print("Download URL: \(downloadURL)")
//            }
//        }
//        let _ = uploadTask.observe(.progress) { snapshot in
//            print("Progress value: \(snapshot)")
//        }
//
//        let _ = uploadTask.observe(.success) { snapshot in
//            snapshot.reference.downloadURL(completion: {d, error in
////                print("SUC \(snapshot) \(self.imageUrl?.absoluteString)")
//                completionHandler(d?.absoluteString ?? "")
//            })
//        }
//
//        let _ = uploadTask.observe(.failure) { snapshot in
//            print("Failure: \(snapshot)")
//        }
//
//    }
}

