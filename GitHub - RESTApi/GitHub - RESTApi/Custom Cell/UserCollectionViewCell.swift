//
//  CollectionViewCell.swift
//  GitHub - RESTApi
//
//  Created by Hitarth on 08/05/21.
//

import UIKit
import SDWebImage

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTitleLable: UILabel!
    
    
    static let identifier: String = "UserCollectionViewCell"
    
    
    public func configure(withImage image: String, withName name: String) {
        
        userImageView.sd_setImage(with: URL(string: image)!, placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: nil)
        
        userTitleLable.text = name
        
    }
    
    
}
