import Foundation

struct NewsEnvelope: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsModel]
}

struct NewsModel: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
}
