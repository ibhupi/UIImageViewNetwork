//
//  CollectionViewController.swift
//  UIImageViewNetwork
//
//  Created by Bhupendra Singh on 7/10/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import UIImageViewNetwork

private let reuseIdentifier = "Cell"
let ImageCollectionViewCellReuseableID : NSString = "ImageCollectionViewCellReuseableID"


class CollectionViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
	let MinimumLineSpacing : CGFloat = 3.0
	let MinimumInterItemSpacing : CGFloat = 3.0
	let EdgeInset : UIEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
    var imagesArray: [String] = []
	var lastIchibaLoadedPage : NSInteger = 1
	var alertControllersQueue : NSMutableArray? = NSMutableArray()
	
	let kMaximumRankingPageIndex : NSInteger = 34
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "UIImageViewNetwork Example"
		
		//	view.imageView.errorImage = UIImage(named: "ErrorImage")
		//	view.imageView.setImageFromUrl("https://www.google.co.jp/images/srpr/logo11w.png");
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.loadInstagramImages()
	}
	
	//	MARK: - UICollectionViewDataSource

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.imagesArray.count;
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCellReuseableID as String, for: indexPath)
		
		let imageCollectionViewCell  = cell as! CollectionViewCell
		imageCollectionViewCell.imageView.errorImage = UIImage(named: "ErrorImage")
		imageCollectionViewCell.imageView.setImageFromUrl(self.imagesArray[(indexPath as NSIndexPath).row] as NSString );
		
		imageCollectionViewCell.imageView.layer.borderColor = UIColor(colorLiteralRed: 0.99, green: 0.30, blue: 0.20, alpha: 1).cgColor
		imageCollectionViewCell.imageView.layer.borderWidth = 0.5
		
		return cell
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemInARow : NSInteger = 4
		var width : CGFloat = collectionView.frame.width - (CGFloat)((itemInARow - 1) * Int(MinimumInterItemSpacing)) - 4
		width = width/CGFloat(itemInARow)
		return CGSize(width: width, height: width)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return MinimumLineSpacing
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return MinimumInterItemSpacing
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return EdgeInset
	}
	
	//	MARK: - Helper Functions
	
	func loadInstagramImages() {
		let path = Bundle.main.path(forResource: "PopularImages", ofType: "txt")
		let data: Data = try! Data(contentsOf: URL(fileURLWithPath: path!))
		let string : NSString? = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let tokens = string!.components(separatedBy: ",")
        self.imagesArray = tokens
	}
}
