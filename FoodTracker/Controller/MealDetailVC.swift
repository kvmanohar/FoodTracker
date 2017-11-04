//
//  ViewController.swift
//  FoodTracker
//
//  Created by Manohar Kurapati on 31/10/2017.
//  Copyright © 2017 Manosoft. All rights reserved.
//

import UIKit
import os.log

class MealDetailVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
 UINavigationControllerDelegate {


    @IBOutlet weak var mealNameTxtView: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControlSV!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*This value is either passed by MealTableVC or constructed as part of meal add*/
    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mealNameTxtView.delegate = self
        
        //Set up view if editing the existing view
        if meal != nil {
            navigationItem.title = meal!.name
            mealNameTxtView.text = meal!.name
            photoImageView.image = meal!.photo
            ratingControl.rating = meal!.rating
        }
        updateSaveButtonState()
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    private func updateSaveButtonState(){
        //Disable the save button if the text field is empty
        let text = mealNameTxtView.text ?? ""
        saveButton.isEnabled = !text.isEmpty
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
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //This method lets you to configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling.", log: OSLog.default, type: .debug)
            return
        }
        let name = mealNameTxtView.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    
    
} //End of ViewController Class
