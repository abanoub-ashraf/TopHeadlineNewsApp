import UIKit
import SafariServices

class ViewController: UIViewController {
    
    // MARK: - Variables -
    
    var viewModel = NewsListViewModel()
    
    // MARK: - UI -
    
    private lazy var headerView: HeaderView = {
        let header = HeaderView(fontSize: 32)
        header.backgroundColor = .systemBackground
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.register(NewsCell.self, forCellReuseIdentifier: viewModel.tableViewCellIdentifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    // MARK: - LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        fetchNews()
    }
    
    // MARK: - Helper Functions -
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        // this function will get data from the api and fill the NewsListViewModel's newsVM property with it
        viewModel.getNewsFromAPI { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate -

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        
        guard let url = URL(string: news.url) else { return }
        
        let config = SFSafariViewController.Configuration()
        let safariController = SFSafariViewController(url: url, configuration: config)
        safariController.modalPresentationStyle = .formSheet
        
        present(safariController, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource -

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: viewModel.tableViewCellIdentifier,
            for: indexPath
        ) as? NewsCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
}
