//
//  PHMarkAsSeenOperation.swift
//  Product Hunt
//
//  Created by Vlado on 5/3/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Foundation
import ReSwift

class PHMarkAsSeenOperation {

    class func perform(_ post: PHPost) {
        perform(store, posts: [post])
    }

    class func perform(_ posts: [PHPost]) {
        perform(store, posts: posts)
    }

    class func perform(_ store: Store<PHAppState>, posts: [PHPost]) {
        let filters: [PHPostFilter] = [.seen(false), .votes(store.state.settings.filterCount)]
        store.dispatch( PHMarkPostsAsSeenAction(posts: PHPostSorter.filter(store, posts: posts, by: filters) ) )
    }
}
