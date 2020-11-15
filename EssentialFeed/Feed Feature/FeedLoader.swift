//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Rafael Lellys on 2020-10-04.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

//boundary between API and UI
public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
