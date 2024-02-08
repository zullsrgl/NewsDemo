//
//  Model.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 6.02.2024.
//

import Foundation
// MARK: - Welcome
struct Welcome: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

