//
//  NewsListViewController.swift
//  NewsList
//
//  Created by Yerem Sargsyan on 23.01.21.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var dataMeneger = DataMeneger()
    var loadingView = LoadingView()
    var newsData: [MetaCoreData] = []
    
     // MARK: overload methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.show()
        self.newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        dataMeneger.delegate = self
        dataMeneger.loadNewsData()
        self.navigationItem.title = "News List"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        newsTableView.reloadData()
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UINavigationBar.appearance().prefersLargeTitles = false
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let repeatNetwork = {(action : UIAlertAction!) -> Void in
            self.dataMeneger.loadNewsData()
        }
        alert.addAction(UIAlertAction(title: "repeat", style: .default, handler: repeatNetwork))
        self.present(alert, animated: true, completion: nil)
    }
    
}
// MARK: table view
extension NewsListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.defaultData(shortNews: ShortNews(metaData: news))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height / 3
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            nextVC.newsData = self.newsData[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
// MARK: data manager delegate
extension NewsListViewController : DataMenegerDelegate {
    //get error
    func internetConnectionError(error: Error) {
        guard newsData.isEmpty else { return }
        self.showError(error.localizedDescription)
    }
    //get data
    func newsData(isChange: Bool, newsData: [MetaCoreData]) {
        if !newsData.isEmpty {
            self.loadingView.dismiss()
        }
            self.newsData = newsData
            newsTableView.reloadData()
       
    }
}
