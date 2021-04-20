//
//  ViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 3/18/21.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var memeImage: UIImage!
    


    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        tabBarController?.tabBar.isHidden = true
    }

    
    
    // MARK: - IBACTIONS
    
    
    // pickAnImageFromLibrary Button
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickAnImage(sourceType: .photoLibrary)
    }
    
    // pickAnImageFromCamera Button
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(sourceType: .camera)
    }
    
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error -> () in
            if (completed) {
                self.save()
                activityViewController.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    

    
    
    @IBAction func cancel(_ sender: Any) {
        
        shareButton.isEnabled = false
        imagePickerView.image = nil
        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    

    
    // MARK: - image delegate functions
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        
        guard let image = info[.originalImage] as? UIImage else {return}
        
          //  if let image = info[.originalImage] as? UIImage{
                imagePickerView.image = image
        
                shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
         }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
           }
    
    // MARK: - FUNCTION TO PICK IMAGES FROM ALBUM OR CAMERA
    
    func pickAnImage(sourceType: UIImagePickerController.SourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            present(imagePickerController, animated: true, completion: nil)
        }

    
    // MARK: - Setting Textfields
    
    
    func setTextField(_ textField: UITextField) {
        let memeTextAttributes : [NSAttributedString.Key : Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .strikethroughColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBold", size: 40)!,
            .strokeWidth: -3.0
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.allowsEditingTextAttributes = true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    func generateImage() -> UIImage {
        
        
        // Hide ToolBar and NavBar
        navigationBar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show ToolBar and Navbar
        navigationBar.isHidden = false
        bottomToolbar.isHidden = false
        return memedImage
    }
    
    // MARK: - PREPARE VIEW FUNCTION
    
    func prepareView() {
        
        //Prepare text fields within image view
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        self.setTextField(self.topTextField)
        self.setTextField(self.bottomTextField)
    }
    
    
    
    // MARK: - Keyboard and Notifications
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: - Functions related to keyboard presentation
    
    // Function called when keyboard must be shown and the screen must be moved up
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isEditing) { // It must be moved only for bottom text
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
        
    // Function called when screen must be moved down
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    //Get keyboard size for move the screen

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    
    // MARK: - Subscribe and unsubscribe from keyboard notifications
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // Initializing a Meme object
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!,
                bottomText: bottomTextField.text!,
                originalImage:imagePickerView.image!,
                memedImage: generateImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
    }

    

// Reset view controls tp initial state

    func setViewControlsToInitialState() {
        imagePickerView.image = nil
        shareButton.isEnabled = false
        topTextField.text = Constants.TopStartText
        bottomTextField.text = Constants.BottomStartText
    }
    
}

