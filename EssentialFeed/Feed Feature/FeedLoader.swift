//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Rafael Lellys on 2020-10-04.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

//boundary between API and UI
protocol FeedLoader {
    associatedtype Error: Swift.Error
    
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
