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
    
    var m_image:UIImage = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        imageView.image = m_image
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
}
