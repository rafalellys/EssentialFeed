//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Rafael Lellys on 2020-10-04.
//

import XCTest
import EssentialFeed


class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string:"https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let url = URL(string:"https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError(){
        
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0)}
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string:"https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        //client is created inside this function so it doesnt need to be passed as a parameter in every test
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    //spy for test only
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (Error) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map{$0.url}
        }

        func get(from url: URL, completion: @escaping (Error) -> Void) {
            messages.append((url,completion))
        }
        
        func complete(with error: Error, at index: Int = 0){
            messages[index].completion(error)
        }
    }
}
