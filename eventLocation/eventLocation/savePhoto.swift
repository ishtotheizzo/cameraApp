import UIKit
import SwiftUI


class PhotoLibrarySaver: NSObject {


    func writeToPhotosAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savePhoto), nil)
    }
    
    @objc func savePhoto(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        }
        else {
            print("The image was saved in the Photo Library.")
        }
    }
}


func saveImageToFile(image: UIImage, filename: String) {
    if let data = image.jpegData(compressionQuality: 0.9) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathname = path.appendingPathComponent(filename)
        do {
            try data.write(to: pathname)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    else {
        print("Warning, unable to create jpeg data.")
    }
}

// code taken from https://handyopinion.com/save-load-image-from-documents-directory-in-swift/

 func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
    
        
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        return nil
    }

