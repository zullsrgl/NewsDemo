//
//  ViewController.swift
//  NewsDemo
//
//  Created by Zülal Sarıoğlu on 6.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var newsTableViewCell: UITableView!
    var articles = [Article]()
    
    let newsCategory = ["Nasional" , "Inter Nasional", "Ekonomi","Teknologi"]
    let userDef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
        collectionViewCategory.register(UINib(nibName: "Categorycollections", bundle: nil), forCellWithReuseIdentifier: "cellCategory")
        newsTableViewCell.delegate = self
        newsTableViewCell.dataSource = self
        newsTableViewCell.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cellCategory")
        userDef.set(0, forKey: "CategoryIndex")
        apiCaller()
      
    }
    
    func apiCaller() {
        let  baseUrl : String  = "https://raw.githubusercontent.com/enesarabaci/NewsApp/master/testJson"

        APICaller.shared.getData(from: baseUrl) { result in
            switch result {
            case .success(let fetchedArticles) :
                self.articles = fetchedArticles
                DispatchQueue.main.async {
                    self.newsTableViewCell.reloadData()
                }
            case .failure(_):
                print("Hata oluştu")
                
            }
        }
    }
}

//MARK: Table View
extension ViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategory", for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item: \(indexPath.row)")
        
    }
}


//MARK: Collection View
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCategory.dequeueReusableCell(withReuseIdentifier: "cellCategory", for: indexPath) as! Categorycollections
        if userDef.integer(forKey: "CategoryIndex") == indexPath.row {
            cell.labelCategory.textColor = .black
            cell.border.backgroundColor = .black
          
        }
        else {
            cell.labelCategory.textColor = .lightGray
            cell.border.backgroundColor = .lightGray
        }
        
        cell.labelCategory.text = newsCategory[indexPath.row ]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userDef.set(indexPath.row, forKey: "CategoryIndex")
        collectionView.reloadData()
        print(indexPath.row)
        if indexPath.row > 0 {
            newsTableViewCell.isHidden = true
        }
        
    }
    
}

