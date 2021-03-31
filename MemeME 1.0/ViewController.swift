//
//  ViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 3/18/21.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    

   

    // pickAnImageFromLibrary Button
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
        
    
       
    
    // pickAnImageFromCamera Button
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = .camera
        present(cameraController, animated: true, completion: nil)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage{
                imagePickerView.image = image
            }
            dismiss(animated: true, completion: nil)
         }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
           }
    
    //Textfields
    func setTextField(_ textField: UITextField) {
        let textAttributes : [NSAttributedString.Key : Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .strikethroughColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 40)!,
            .strokeWidth: -3.0
        ]
        textField.defaultTextAttributes = textAttributes
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.allowsEditingTextAttributes = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        self.setTextField(self.topTextField)
        self.setTextField(self.bottomTextField)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    
    }
    
