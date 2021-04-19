//
//  MemeDetailViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 4/16/21.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme : Meme?
    
    //MARK: Outlets
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        updateView()
    }
    
    
    func updateView(){
        
        guard let meme = meme else {return}
        imageView.image = meme.memedImage
        
    }

    
}
