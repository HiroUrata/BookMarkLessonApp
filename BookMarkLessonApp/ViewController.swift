//
//  ViewController.swift
//  BookMarkLessonApp
//
//  Created by UrataHiroki on 2021/09/25.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
    }

    override func viewWillLayoutSubviews() {
        
        searchBar.frame = CGRect(x: view.frame.minX, y: view.frame.minY + view.safeAreaInsets.top, width: view.frame.size.width, height: 44)
        
        tableView.frame = CGRect(x: view.frame.minX, y: searchBar.frame.origin.y + searchBar.frame.size.height, width: view.frame.width, height: view.frame.size.height - (searchBar.frame.origin.y + searchBar.frame.size.height))
        
    }
    

}

extension ViewController:UISearchBarDelegate{
    
    
}


extension ViewController:UITableViewDelegate{
    
    
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
