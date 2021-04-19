//
//  memeCollectionViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 4/16/21.
//

import UIKit

// private let reuseIdentifier = "Cell"

class memeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    //MARK: Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heighDimension = (view.frame.size.height - (2 * space)) / 5.0
        
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heighDimension)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
   
           super.viewWillAppear(animated)
           collectionView.reloadData()
        tabBarController?.tabBar.isHidden = false
   
       }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! memeCollectionViewCell
        let memeForCell = memes[indexPath.row]
        cell.imageViewCollection.image = memeForCell.memedImage
    
        return cell
    }

    
     override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

            //Populate view controller with data from the selected item
            detailController.meme = memes[(indexPath as NSIndexPath).row]

            // Present the view controller using navigation
            navigationController!.pushViewController(detailController, animated: true)
    }
    
   
    
    
    @IBAction func imagePicker(_ sender: Any) {
        performSegue(withIdentifier: "picker", sender: nil)
    }
    
}
