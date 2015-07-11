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
	var imagesArray : NSArray = []
	var lastIchibaLoadedPage : NSInteger = 1
	var alertControllersQueue : NSMutableArray? = NSMutableArray()
	
	let kMaximumRankingPageIndex : NSInteger = 34
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "UIImageViewNetwork Example"
		
		//	view.imageView.errorImage = UIImage(named: "ErrorImage")
		//	view.imageView.setImageFromUrl("https://www.google.co.jp/images/srpr/logo11w.png");
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.loadInstagramImages()
	}
	
	//	MARK: - UICollectionViewDataSource

	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.imagesArray.count;
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell : UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCellReuseableID as String, forIndexPath: indexPath)
		
		let imageCollectionViewCell  = cell as! CollectionViewCell
		imageCollectionViewCell.imageView.errorImage = UIImage(named: "ErrorImage")
		imageCollectionViewCell.imageView.setImageFromUrl(self.imagesArray.objectAtIndex(indexPath.row) as! NSString );
		
		imageCollectionViewCell.imageView.layer.borderColor = UIColor(colorLiteralRed: 0.99, green: 0.30, blue: 0.20, alpha: 1).CGColor
		imageCollectionViewCell.imageView.layer.borderWidth = 0.5
		
		return cell
	}
	
	// MARK: UICollectionViewDelegateFlowLayout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		let itemInARow : NSInteger = 4
		var width : CGFloat = CGRectGetWidth(collectionView.frame) - (CGFloat)((itemInARow - 1) * Int(MinimumInterItemSpacing)) - 4
		width = width/CGFloat(itemInARow)
		return CGSize(width: width, height: width)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return MinimumLineSpacing
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return MinimumInterItemSpacing
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return EdgeInset
	}
	
	//	MARK: - Helper Functions
	
	func loadInstagramImages() {
		let path = NSBundle.mainBundle().pathForResource("PopularImages", ofType: "txt")
		let data: NSData = NSData(contentsOfFile: path!)!
		let string : NSString? = NSString(data: data, encoding: NSUTF8StringEncoding)
		self.imagesArray = string!.componentsSeparatedByString(",")
	}
}