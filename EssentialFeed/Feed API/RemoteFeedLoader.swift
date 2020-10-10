//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Rafael Lellys on 2020-10-09.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient){
        self.url = url
        self.client = client
    }
    
    public func load() {
        //move test logic to httpclient
        client.get(from: url)
    }
}
