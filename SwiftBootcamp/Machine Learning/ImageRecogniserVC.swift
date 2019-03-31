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
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    // MARK: Actions
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Custom methods
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "HotDog!"
                } else {
                    self.navigationItem.title = "Not Hotdog!"
                }
            }
        }
        
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch  {
            print(error)
        }
    }
    
}

// MARK: *********** Extensions  ***********

// MARK: Image Picket delegates
extension ImageRecogniserVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage.")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: Navigation Controller delegates
extension ImageRecogniserVC: UINavigationControllerDelegate {
    
}
