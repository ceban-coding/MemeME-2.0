//
//  TableViewController.swift
//  MemeME 1.0
//
//  Created by Ion Ceban on 4/16/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableView", for: indexPath) as! TableViewCell
        let memeForRow = memes[indexPath.row]
        cell.imageView?.image = memeForRow.memedImage
        cell.textLabel?.text = memeForRow.topText + "..." + memeForRow.bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

            //Populate view controller with data from the selected item
            detailController.meme = memes[(indexPath as NSIndexPath).row]

            // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}

