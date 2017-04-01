
import UIKit

class WebServicesClass: NSObject {
    
    static let sharedInstance = WebServicesClass()
    let helperClass = Helper()
    
    func callWebAPIWith(apiName: String,completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void)
    {
        
            let headers = [
                "accept": "application/json",
                ]
            
            let url = NSString(format:"%@",apiName)
            
            let request = NSMutableURLRequest(url: NSURL(string:url as String) as! URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    
                    completion(nil, error as NSError?)
                    
                } else {
                    var json: NSArray!
                    
                    do {
                        json = try JSONSerialization.jsonObject(with: NSData(data:data!) as Data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSArray
                        print("Response : \n %@",json)
                        
                        completion(json, nil)
                        
                    } catch {
                        completion(nil,nil)
                    }
                }
            })
            
            dataTask.resume()
    }

}
