//
//  PostImageViewController.swift
//  Yelpy
//
//  Created by Hieu Ngan Nguyen on 4/27/22.
//  Copyright © 2022 memo. All rights reserved.
//

import UIKit

protocol PostImageViewControllerDelegate: class {
    
    func imageSelected(controller: PostImageViewController, image: UIImage)
    
}

class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    // Add delegate for the protocol created
    weak var delegate: PostImageViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createImagePicker()
        navigationController?.navigationBar.isHidden = true
    }
    
    // Unwind back to Restaurant Detail after uploading image
    @IBAction func onFinishPosting(_ sender: Any) {
        // performSegue(withIdentifier: "unwindToDetail", sender: self)
        delegate.imageSelected(controller: self, image: self.selectedImageView.image!)
    }
    
    
    // MARK: LAB 6 TODO: ImagePicker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage

        self.selectedImageView.image = originalImage
        
        dismiss(animated: true, completion: nil)
    }

    
    //  Create Image Picker
    func createImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imagePicker.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
}
