//
//  ProductListCollectionViewCell.swift
//  BlibliProject
//
//  Created by Srijan Kumar  on 22/07/22.
//

import UIKit


class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var strikedPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var starRatings: UILabel!
    @IBOutlet weak var ratingsDisplay: UILabel!
    
    var addToCartHandler: (() -> Void)?
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        addToCartHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Your String here")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        strikedPrice.attributedText = attributeString
        imageDisplay.layer.cornerRadius = 10.0
        imageDisplay.clipsToBounds = true
        productName.font = .boldSystemFont(ofSize: 15.0)
        offerPrice.font = .boldSystemFont(ofSize: 15.0)
        offerPrice.textColor = .red
        starRatings.font = .boldSystemFont(ofSize: 22)
        ratingsDisplay.font = .boldSystemFont(ofSize: 15)
        discount.textColor = .black
        discount.font = .boldSystemFont(ofSize: 14)
        addToCartButton.backgroundColor = .white
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        addToCartButton.layer.cornerRadius = 10.0
        addToCartButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
}
