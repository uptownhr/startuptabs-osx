//
//  PHShareAction.swift
//  ProductHunt
//
//  Created by Vlado on 4/5/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import Kingfisher
import ReSwift

class PHShareAction: NSObject, NSSharingServiceDelegate {

    static let sharedInstance = PHShareAction()

    func performTwitter(_ post: PHPost?) {
        guard let post = post else {
            return
        }

        store.dispatch( PHTrackPostShare(post: post, medium: "twitter") )

        KingfisherManager.shared.retrieveImage(with: post.thumbnailUrl, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
            self.perform(NSSharingServiceNamePostOnTwitter, title: PHShareMessage.message(fromPost: post), url: post.discussionUrl, image: image)
        })
    }

    func performFacebook(_ post: PHPost?) {
        guard let post = post else {
            return
        }

        store.dispatch( PHTrackPostShare(post: post, medium: "facebook") )

        KingfisherManager.shared.retrieveImage(with: post.thumbnailUrl, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
            self.perform(NSSharingServiceNamePostOnFacebook, title: PHShareMessage.message(fromPost: post), url: post.discussionUrl, image: image)
        })
    }

    fileprivate func perform(_ service: String, title: String, url: URL, image: NSImage?) {
        if let service =  NSSharingService(named: service) {
            service.delegate = self

            var items = [AnyObject]()

            items.append(title as AnyObject)

            if let image = image {
                items.append(image)
            }

            service.perform(withItems: items)
        }
    }
}
