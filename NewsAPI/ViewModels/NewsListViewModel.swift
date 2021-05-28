import Foundation

class NewsListViewModel {
    
    // MARK: - Variables -
    
    var newsVM = [NewsViewModel]()
    
    let tableViewCellIdentifier = Constants.tableViewCellIdentifier
    
    // MARK: - Helper Functions -
    
    /// this view model will call the api, get the data and assign them to its newsVM property
    func getNewsFromAPI(completion: @escaping ([NewsViewModel]) -> Void) {
        NetworkManager.shared.getNews { (news) in
            guard let news = news else { return }

            /// the api returns a model object so we will convert it into viewmodel one
            let newsViewModels = news.map { (singleNews) in
                NewsViewModel(news: singleNews)
            }
            
            DispatchQueue.main.async {
                self.newsVM = newsViewModels
                completion(self.newsVM)
            }
            
        }
    }
}
