//
//  SearchViewController.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 15.02.2024.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var articles = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBar.delegate = self
        searchTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let  searchString = searchBar.text ,!searchString.isEmpty else {return}
        APICaller.shared.getNews(keyword: searchString) { result in
            switch result {
            case.success(let articles):
                print("serchString: \(searchString)")
                self.articles = articles
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            case.failure(let error):
                print("error")
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ) else  {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    
    
}
