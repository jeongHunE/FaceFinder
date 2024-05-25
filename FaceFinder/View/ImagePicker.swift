//
//  ImagePicker.swift
//  FaceFinder
//
//  Created by 이정훈 on 5/25/24.
//

import SwiftUI
import Foundation

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

extension ImagePicker {
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        private var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        //MARK: - Delegate method executed after Image Selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = CVWrapper.drawRectangle(to: image)
            }
            
            parent.presentationMode.wrappedValue.dismiss()   //사진 선택 후 View 닫음
        }
    }
}

#Preview {
    ImagePicker(image: .constant(nil))
}
