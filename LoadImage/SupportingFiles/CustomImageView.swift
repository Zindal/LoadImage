
import Foundation
import UIKit

extension UIImageView
{
    func addShadow()
    {
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.6;
    }
}
