//
//  MagicImageView.swift
//  swift2
//
//  Created by Singh, Bhupendra | Bhupi | NEWSD on 7/9/15.
//  Copyright © 2015 Bhupendra Singh. All rights reserved.
//

import UIKit

private var kImageUrlAssociationKey: UInt8 = 0
private var kErrorImageAssociationKey: UInt8 = 0
private let kCachedImageLimitCount: NSInteger = 100

/**
Image cache, so need to download it again once it downloaded.
*/
struct ImageCache {
    static var cacheDictionary:NSMutableDictionary?
    
    /// TODO: Better cache purging with memory warning from APP
    static var cacheArrayForPurging:NSMutableArray?
}

extension UIImageView {
    /**
    Error Image, this image will be used when there is any error in downloading image from network.
    */
    public var errorImage: UIImage? {    
        get {
            return objc_getAssociatedObject(self, &kErrorImageAssociationKey) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &kErrorImageAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    /**
    Set Image from imgage URL, This will asynchronoulsy fetch
    image from network. And set it after loading. Images will
    be set with fadeIn animation.
    
    If image url was changed during loading, then it will
    gracefully ignore previously fetched image.
    
    - parameter imageUrlString: image url string to download image
    
    */
    public func setImageFromUrl(imageUrlString : NSString) {
        self.setImageFromUrl(imageUrlString, animated: true)
    }
    
    /**
    Set Image from imgage URL, This will asynchronoulsy fetch
    image from network. And set it after loading.
    
    If image url was changed during loading then it will
    gracefully ignore previously fetched image.
    
    - parameter imageUrlString:  image url string
    - parameter animated: boolean value(true) to show image with animation
    
    */
    public func setImageFromUrl(imageUrlString : NSString, animated : Bool) {
        if (self.imageUrlString != nil && self.imageUrlString.length > 0 && self.imageUrlString.isEqualToString(imageUrlString as String)) {
            return;
        }
        
        self.imageUrlString = imageUrlString
        if (imageUrlString.length < 1) {
            return;
        }
        
        if(ImageCache.cacheDictionary == nil) {
            ImageCache.cacheDictionary = NSMutableDictionary()
            ImageCache.cacheArrayForPurging = NSMutableArray()
        }
        self.image = nil
        let imagesDict = ImageCache.cacheDictionary
        if let imageCached = imagesDict?.objectForKey(imageUrlString) as? UIImage {
            self.setImage(imageCached, animated: false)
            return
        }

        downloadImage(imageUrlString) { (urlString, image) -> Void in
            // Cache Image for downloaded URL
            ImageCache.cacheDictionary?.setValue(image, forKey: urlString as String)
            ImageCache.cacheArrayForPurging?.addObject(urlString)
            if(ImageCache.cacheDictionary?.count > kCachedImageLimitCount) {
                let firstImageInCache : NSString = (ImageCache.cacheArrayForPurging?.firstObject) as! NSString
                ImageCache.cacheDictionary?.removeObjectForKey(firstImageInCache)
                ImageCache.cacheArrayForPurging?.removeObject(firstImageInCache)
            }
            if (urlString != self.imageUrlString) {
                return;
            }
            var imageToShow : UIImage? = image
            if(image == nil) {
                imageToShow = self.errorImage
            }
            self.setImage(imageToShow, animated: animated)
        }
    }
    
    /**
    Set already Image with or without animaiton
    
    - parameter image:  UIImage? An optional UIImage
    - parameter animated: boolean value(true) to show image with animation
    
    */
    public func setImage(image : UIImage?, animated : Bool) {
        if (animated == true) {
            UIView.transitionWithView(self, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.image = image
                }, completion: { (stop) -> Void in
            })
        } else {
            self.image = image
        }
    }
    
    /**
    Function to download image from network. Downloaded image will
    be cached. Cached image will be used for same url
    
    
    - parameter urlString: Image url string to download image from
    - parameter completion: Completion block will be called in main
    thread after image is dowloaded or found in cache
    
    */
    func downloadImage(urlString : NSString, completion:(urlString : NSString, image : UIImage?) -> Void) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { () -> Void in
            
            let url = NSURL(string: urlString as String)
            if (url == nil) {
                self.imageDownloaded(urlString, image: nil, completion: completion)
                return
            }
            let data = NSData(contentsOfURL: url!)
            if (data?.length > 0), let image = UIImage(data: data!) {
                self.imageDownloaded(urlString, image: image, completion: completion)
            }
            else {
                self.imageDownloaded(urlString, image: nil, completion: completion)
            }
        }
    }
    
    /**
    Helper function to call completion block in main thread
    (Reduing just few lines of code in downloadImage())
    */
    func imageDownloaded(urlString : NSString, image : UIImage?, completion:(urlString : NSString, image : UIImage?) -> Void) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            completion(urlString: urlString, image: image)
        }
    }
    
    /**
    Custom image url property, to check when download asynchronous
    image is same as latest set image url.
    If different then downloaded image will not be set in image view.
    Because image might has been removed or new image is being downloaded from different url
    */
    var imageUrlString: NSString! {
        get {
            return objc_getAssociatedObject(self, &kImageUrlAssociationKey) as? NSString
        }
        set {
            objc_setAssociatedObject(self, &kImageUrlAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}