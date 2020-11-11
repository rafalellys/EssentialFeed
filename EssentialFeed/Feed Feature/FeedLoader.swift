//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Rafael Lellys on 2020-10-04.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

//boundary between API and UI
protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
