//
//  ProductDetailsPageViewController.swift
//  BlibliProject
//
//  Created by Srijan Kumar  on 23/07/22.
//

import UIKit

class ProductDetailsPageViewController: UIViewController {
    
    @IBOutlet weak var detailedImage: UIImageView!
    @IBOutlet weak var productPriceDisplay: UILabel!
    @IBOutlet weak var productNameDisplay: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var productName: String?
    var productPrice: String?
    var imageToDisplay: UIImage?
    
    @IBAction func addToCartButton(_ sender: Any) {
        addToCartButton.setTitle("Added to Cart", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productNameDisplay.text = productName
        self.productPriceDisplay.text = productPrice
        self.detailedImage.image = imageToDisplay
        
        addToCartButton.setTitle("Add To Cart", for: .normal)
    }
}
