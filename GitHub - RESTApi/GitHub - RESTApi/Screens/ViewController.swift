//
//  ViewController.swift
//  GitHub - RESTApi
//
//  Created by Hitarth on 08/05/21.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var UserData: [Users] = []
    
    let userModel = UsersViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        userModel.fetchData(offset: self.UserData.count) { [weak self] (result) in
            switch result {
                case .success(let data):
                    self?.UserData.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    
                case .failure(let err):
                    print(err)
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard !userModel.isPaginating else {
                return
            }
            
            userModel.fetchData(pagination: true, offset: self.UserData.count) { [weak self] (result) in
                switch result {
                    case .success(let data):
                        self?.UserData.append(contentsOf: data)
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }

                    case .failure(let err):
                        print(err)
                }
            }
            
        }
        
        
    }
    
    //End Of Class
}






extension ViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let userData = UserData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController
        
        vc?.items = userData
        
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}


extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return UserData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as! UserCollectionViewCell
        
        
        cell.configure(withImage: UserData[indexPath.row].avatar_url, withName: UserData[indexPath.row].login)
        
        return cell
    }
    
    
}



extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
    
}
