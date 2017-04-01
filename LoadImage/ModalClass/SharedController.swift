

import UIKit

class SharedController {

    private static var __once: () = {

        }()

    var modal:ModalClass?

    static let singleton = SharedController()
    
    class var sharedInstance: SharedController {
        
        return singleton
    }
        
    func setModels(_ modal:AnyObject) -> Void {
        
        if modal.isKind(of: ModalClass.self)
        {
            let MainModal = modal as! ModalClass
            self.modal = MainModal
        }

    }

}







