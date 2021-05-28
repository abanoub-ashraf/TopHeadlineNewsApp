import Foundation

struct NewsViewModel {
    
    // MARK: - Variables -
    
    let news: NewsModel
    
    var author: String {
        return news.author ?? Constants.unknow
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? Constants.stringIamge
    }
    
}
