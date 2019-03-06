//
//  ImageRecogniserVC.swift
//  SwiftBootcamp
//
//  Created by Syon on 06/03/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ImageRecogniserVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // Properties
    let imagePicker = UIImagePickerController()
    
    // MARK: Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    // MARK: Instance Methods

    
    // MARK: Actions
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

// MARK: *********** Extensions  ***********

// MARK: Image Picket delegates
extension ImageRecogniserVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: Navigation Controller delegates
extension ImageRecogniserVC: UINavigationControllerDelegate {
    
}
