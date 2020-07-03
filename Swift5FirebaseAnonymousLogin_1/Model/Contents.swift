//
//  Contents.swift
//  Swift5FirebaseAnonymousLogin_1
//
//  Created by 須藤英隼 on 2020/07/03.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import Foundation

class Contents {
    
    var userNameString: String = ""
    var profileImageString:String = ""
    var contentImageString:String = ""
    var commentString:String = ""
    var postDateString:String = ""
    
    init(userNameString:String,profileImageString:String,contentImageString:String,commnetString:String,postDateString:String){
        
        self.userNameString = userNameString
        self.profileImageString = profileImageString
        self.contentImageString = contentImageString
        self.commentString = commnetString
        self.postDateString = postDateString
    }
    
    
}
