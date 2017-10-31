//
//  ViewController.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 31/10/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
 UINavigationControllerDelegate {

    @IBOutlet weak var customLbl: UILabel!
    @IBOutlet weak var mealNameTxtView: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mealNameTxtView.delegate = self
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        customLbl.text = textField.text
    }
    
    @IBAction func setDefaultBtnTapped(_ sender: Any) {
        mealNameTxtView.text = "Default Text"
    }
    
    
    //IB Action for ImageView Gesture Recognizier
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard
        mealNameTxtView.resignFirstResponder()
        
        // UIIImagePickerController is a view controller that let user pick photo
        // from phone photo library
        let imagePickerController = UIImagePickerController()
        
        // only Allow photo to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController notified when the user pickes an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
       // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
} //End of ViewController Class
