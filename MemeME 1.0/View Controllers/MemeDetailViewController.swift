//
//  MemeDetailViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 4/16/21.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
  
    //MARK: Outlets
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme : Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
}
