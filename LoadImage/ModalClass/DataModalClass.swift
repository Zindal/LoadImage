

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

open class DataModalClass {
    
    var name:NSString!
    var imgUrl:NSString!

    init(data:NSDictionary) {
        let json = data["user"] as! NSDictionary
        
        if json.object(forKey: "name") != nil
        {
           name = json.object(forKey: "name") as! NSString!
        }
        
        if json.object(forKey: "profile_image") != nil
        {
            let imgDic = json.object(forKey: "profile_image") as! NSDictionary
            imgUrl = imgDic.object(forKey: "large") as! NSString!
        }

    }
}
