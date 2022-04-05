//
//  takePhoto.swift
//  eventLocation
//
//  Created by meh  on 3/30/22.
//

import Foundation

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // this is wrapping a UIKit view
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let img = info[.originalImage] as? UIImage {
                parent.image = img
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // @Binding two way connect to that state object
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        print("makeUIViewController")
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available")
            picker.sourceType = .camera
            picker.showsCameraControls = true
            picker.allowsEditing = true
            
            
        }
        else {
            print("No camera.")
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
    
    
}

