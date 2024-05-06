//
//  Google.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/6/24.
//

import Foundation


struct Snippet: Codable {
    let customUrl: String
    let description: String
    let localized: Localized
    let publishedAt: String
    let thumbnails: Thumbnails
    let title: String
}

struct Localized: Codable {
    let description: String
    let title: String
}

struct Thumbnails: Codable {
    let `default`: Thumbnail
    let high: Thumbnail
    let medium: Thumbnail
}

struct Thumbnail: Codable {
    let height: Int
    let url: String
    let width: Int
}

struct Statistics: Codable {
    var hiddenSubscriberCount: Bool
    let subscriberCount: String
    let videoCount: String
    let viewCount: String
}

struct ChannelItem: Codable {
    let etag: String
    let id: String
    let kind: String
    let snippet: Snippet
    let statistics: Statistics
}

struct ChannelListResponse: Codable {
    let etag: String
    let items: [ChannelItem]
    let kind: String
    let pageInfo: PageInfo
}

struct PageInfo: Codable {
    let resultsPerPage: Int
    let totalResults: Int
}
