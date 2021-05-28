import Foundation

class NetworkManager {
    
    // MARK: - Variables -
    
    static let shared = NetworkManager()
    
    let imageCache = NSCache<NSString, NSData>()
    
    // MARK: - Init -
    
    private init() {}
    
    // MARK: - API Calls -
    
    func getNews(completion: @escaping ([NewsModel]?) -> Void) {
        let urlString = "\(Constants.baseURL)\(Constants.USToHeadline)&apikey=\(Config.apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }

                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
    
}
