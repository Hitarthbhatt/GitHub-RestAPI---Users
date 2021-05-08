//
//  UsersViewModel.swift
//  GitHub - RESTApi
//
//  Created by Hitarth on 08/05/21.
//

import Foundation


class UsersViewModel {
    
    var isPaginating: Bool = false
    
    func fetchData( pagination: Bool = false, offset: Int ,completion: @escaping (Result<[Users], Error>) -> Void) {
        
        if pagination {
           isPaginating = true
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + ( pagination ? 3 : 2)) {
            
            let url = "https://api.github.com/users?since=\(offset)&per_page=20"
            
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: URL(string: url)!) { (data, _, err) in
              
                if let error = err {
                    print(error.localizedDescription)
                    completion(.failure("Network Issue" as! Error))
                    return
                }
                
                guard let userData = data else {
                    print("No Data Found")
                    return
                }
                
                
                do {
                    
                    //TODO:- Tried to check what is the data.
                    //let dataX = try JSONSerialization.jsonObject(with: userData, options: .allowFragments)
                     //print(dataX)
                    
                    let data = try JSONDecoder().decode([Users].self, from: userData)
                    completion(.success(data))
                    
                    
                }catch {
                    print("Error is:- ",error.localizedDescription)
//                    completion(.failure("Error in decoding the data" as! Error))
                }
                
                
            }.resume()
            
            if pagination {
                self.isPaginating = false
            }
            
            //Threading
        }
        //End Of Function
    }
    
    
}
