//
//  ViewController.swift
//  BlibliProject
//
//  Created by Srijan Kumar  on 22/07/22.
//

import UIKit

class ProductSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UISearchBar!
    
    let interItemSpacing: CGFloat = 16.0
    let lineSpacing: CGFloat = 16.0
    let numberOfCells = 1
    var currentStatus = "See Product Details"
    var urlCaller: ProjectListManager?
    var productDataSet: DataMain?
    let kCellIdentifier = "ProductListCollectionViewCell"
    var startingPoint = 0
    var productInCart: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomeViewCell()
        searchButton.delegate = self
        urlCaller = ProjectListManager()
        urlCaller?.dataPassingThroughClosure = { (data) in
            self.productDataSet = data
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDataSet?.data?.products?.count ?? 0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        urlCaller?.fetchProductList(searchItem: searchBar.text ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? ProductListCollectionViewCell else{
            print("custom cell not being created")
            return UICollectionViewCell()
        }
        cell.addToCartHandler = { [weak self] in
            if let giveDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductDetails") as? ProductDetailsPageViewController{
                if let productDataSend = self?.productDataSet?.data?.products?[indexPath.row] {
                    giveDetails.productName = productDataSend.name
                    giveDetails.productPrice = productDataSend.price?.priceDisplay
                    giveDetails.imageToDisplay = cell.imageDisplay.image
                }
                self?.navigationController?.pushViewController(giveDetails, animated: true)
            }
        }
        
        if let productData = productDataSet?.data?.products?[indexPath.row] {
            
            if let priceToDisplay = productData.price{
                cell.offerPrice.text = priceToDisplay.offerPriceDisplay
            }
            if let discountDisplay = productData.price, let discountPrice = discountDisplay.discount{
                cell.discount.text = "\(discountPrice)% off"
            }
            
            if let strikedDisplay = productData.price, let strikedPrice = strikedDisplay.strikeThroughPriceDisplay{
                cell.strikedPrice.text = "\(strikedPrice)"
            }
            cell.productName.text = productData.name
            if let productRating = productData.review, let rating = productRating.rating{
                cell.ratingsDisplay.text = "[\(rating)]"
                cell.starRatings.text = getStars(ratings: rating)
            }
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 20.0
            self.loadImage(urlString: productData.images?.first, imageView: cell.imageDisplay)
        }
        return cell
    }
    
    func getStars(ratings: Int) -> (String){
        if ratings == 0
        {
            return "✩✩✩✩✩"
        }
        else if ratings == 1
        {
            return "★✩✩✩✩"
        }
        else if ratings == 2
        {
            return "★★✩✩✩"
        }
        else if ratings == 3
        {
            return "★★★✩✩"
        }
        else if ratings == 4
        {
            return "★★★★✩"
        }
        return "★★★★★"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: 350, height: 230)
        return cellSize
    }
    
    func registerCustomeViewCell(){
        let nib = UINib(nibName: kCellIdentifier, bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: kCellIdentifier)
    }
    
    func loadImage(urlString: String?, imageView: UIImageView)  {
        if let unwrappedString = urlString,
           let url = URL(string: unwrappedString) {
            print(unwrappedString)
            
            DispatchQueue.global(qos: .background).async {
                do {
                    let imageData = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        let loadedImage = UIImage(data: imageData)
                        imageView.image = loadedImage
                        imageView.contentMode = .scaleAspectFit
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
