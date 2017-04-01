

import UIKit
import SystemConfiguration


class Helper: NSObject {

    static let sharedHelper = Helper()
    
    func showGlobalAlertwithMessage(_ str : NSString)
    {
        let window:UIWindow = UIApplication.shared.windows.last!
        let alertView = UIAlertController(title: "LoadImage", message: str as String, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        window.rootViewController!.present(alertView, animated: true, completion: nil)
    }
    
    func checkNullString(str:NSString) -> NSString
    {
        if str .isKind(of:NSNull.self) || str == "<null>" || str == "0" || str == "(null)" || str == "" || str == "null"
        {
            return ""
        }
        else
        {
            return str
        }
    }
    
    func isNetworkAvailable() -> Bool
    {
        let rechability = Reachability()
        
        if (rechability?.isReachable)!
        {
            return true
        }
        else
        {
            return false
        }

    }
}
