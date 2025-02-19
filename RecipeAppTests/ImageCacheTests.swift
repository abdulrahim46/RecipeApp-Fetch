//
//  ImageCacheTests.swift
//  RecipeApp
//
//  Created by Abdul Choudhary on 2/19/25.
//


import XCTest
@testable import RecipeApp

final class ImageCacheTests: XCTestCase {
    var imageCache: ImageCache!
    let testImageURL = URL(string:  "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
    
    override func setUp() {
        super.setUp()
        imageCache = ImageCache.shared
    }

    override func tearDown() {
        imageCache = nil
        super.tearDown()
    }

    func testLoadImageFromNetwork() async throws {
        let testImage = UIImage(systemName: "star")!
        let imageData = testImage.pngData()!
        
        // Mock URLSession
        URLProtocolMock.testURLs = [testImageURL: imageData]
        let loadedImage = try await imageCache.loadImage(from: testImageURL)
        
        XCTAssertNotNil(loadedImage)
    }

//    func testSaveAndLoadImageFromDisk() async throws {
//        let testImage = UIImage(systemName: "star")!
//        try await imageCache.loadImage(from: testImageURL) // Saves to disk
//        
//        let loadedImage = imageCache.loadFromDisk(path: testImageURL)
//        XCTAssertNotNil(loadedImage)
//    }
}

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        return testURLs[request.url!] != nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let data = URLProtocolMock.testURLs[request.url!] {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
