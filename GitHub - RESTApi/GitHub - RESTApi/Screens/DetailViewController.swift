//
//  DetailViewController.swift
//  GitHub - RESTApi
//
//  Created by Hitarth on 08/05/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLable: UILabel!
    
    @IBOutlet weak var userIdLable: UILabel!
    
    
    var items: Users = Users(id: 0, login: "", avatar_url: "", followers_url: "", following_url: "", gists_url: "")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        userImageView.sd_setImage(with: URL(string: items.avatar_url)!, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: nil)
            
            userNameLable.text = items.login
            userIdLable.text = "\(items.id)"
    }
    
    
    

    //End Of Class
}
