
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var search = NSMutableArray()
    let refresher = UIRefreshControl()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.alwaysBounceVertical = true
        refresher.tintColor = UIColor.orange
        refresher.addTarget(self, action: #selector(callApi), for: .valueChanged)
        collectionView!.addSubview(refresher)
        callApi()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func callApi()
    {
        if Helper.sharedHelper.isNetworkAvailable()
        {
            self.startAnimating()
            WebServicesClass.sharedInstance.callWebAPIWith(apiName:apiUrl) { (result,error) in
                
                DispatchQueue.main.async {
                  self.stopAnimating()
                  self.refresher.endRefreshing()
                    
                    if result != nil
                    {
                        let modal = ModalClass(data:result as! NSMutableArray)
                        SharedController.sharedInstance.setModels(modal)
                        self.search = modal.infoListArr
                        self.collectionView.reloadData()
                    }
                    else
                    {
                        Helper.sharedHelper.showGlobalAlertwithMessage("Something went wrong!")
                    }
                }
            }
        }
        else
        {
            DispatchQueue.main.async {
                self.stopAnimating()
                self.refresher.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    func stopAnimating()
    {
        self.activityIndicator.stopAnimating()
    }
    
    func startAnimating()
    {
       self.activityIndicator.startAnimating()
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
       
        if !Helper.sharedHelper.isNetworkAvailable(){return 1}
        else
        {
            return search.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !Helper.sharedHelper.isNetworkAvailable()
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offlineCell",
                                                          for: indexPath) as! CustomCell
            let lblMessage = cell.viewWithTag(1) as! UILabel
            lblMessage.text = "No internate available \n Pull down to try again"
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! CustomCell
            
            let dic = search[indexPath.row] as! NSDictionary
            let modal = DataModalClass.init(data: dic)
            
            cell.imgView.setImgWithUrl(url: NSURL.init(string: modal.imgUrl as String)! , placeholderImg : UIImage.init(named: "placeholder")! ,animate : true)
            cell.imgView.addShadow()
            cell.lblName.text = modal.name as String?
            return cell
        }
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if !Helper.sharedHelper.isNetworkAvailable()
        {
            return CGSize(width:self.view.frame.width , height:230)
        }
        else{return CGSize(width:self.view.frame.width/2 , height:self.view.frame.width/2+48)}
        
    }
    
}
