

import Foundation
import UIKit

var cache = NSCache<AnyObject, AnyObject>()
var task: URLSessionDataTask!
var session: URLSession!

extension UIImageView
{
    func setImgWithUrl(url : NSURL , placeholderImg : UIImage , animate : Bool)
    {
        if (cache.object(forKey: url) != nil){
            
            self.image = cache.object(forKey: url) as?  UIImage
            
        }else{
            
            self.image = placeholderImg

            let request = NSMutableURLRequest(url: url as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                if let data = try? Data(contentsOf: url as URL){
                    
                    DispatchQueue.main.async(execute: { () -> Void in

                        let img:UIImage! = UIImage(data: data)
                        self.image = img
                        
                        if animate
                        {
                            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                                self.transform = CGAffineTransform.identity
                            }, completion: { (finished) in
                            })
                        }

                        if img != nil{
                            cache.setObject(img, forKey: url)
                        }
                        
                    })
                }
            })
            dataTask.resume()
         }
    }

}
