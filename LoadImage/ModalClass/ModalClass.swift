

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

open class ModalClass {
    
    var infoListArr:NSMutableArray!

    init(data:NSMutableArray) {
        let json = data 
        
          self.infoListArr = json
          print(self.infoListArr)

    }
}
