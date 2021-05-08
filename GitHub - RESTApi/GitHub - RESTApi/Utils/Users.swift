//
//  Users.swift
//  GitHub - RESTApi
//
//  Created by Hitarth on 08/05/21.
//

import Foundation

struct Users: Codable {
    
    var id: Int
    var login: String
    var avatar_url: String
    var followers_url: String
    var following_url: String
    var gists_url: String
    
}
