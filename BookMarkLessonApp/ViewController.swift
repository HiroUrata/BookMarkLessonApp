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
    let bookMarkListView = UITableView()
    
    var bookMarkContentsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 1
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        bookMarkListView.delegate = self
        bookMarkListView.dataSource = self
        bookMarkListView.tag = 2
        bookMarkListView.register(UITableViewCell.self, forCellReuseIdentifier: "BookMarkCell")
        view.addSubview(bookMarkListView)
        
    }

    override func viewWillLayoutSubviews() {
        
        searchBar.frame = CGRect(x: view.frame.minX, y: view.frame.minY + view.safeAreaInsets.top, width: view.frame.size.width, height: 44)
        
        tableView.frame = CGRect(x: view.frame.minX, y: searchBar.frame.origin.y + searchBar.frame.size.height, width: view.frame.width, height: view.frame.size.height - (searchBar.frame.origin.y + searchBar.frame.size.height))
        
        bookMarkListView.frame = CGRect(x: view.frame.minX - (view.frame.size.width / 2), y: tableView.frame.origin.y, width: tableView.frame.size.width / 2, height: tableView.frame.height)
    }
    

}

extension ViewController:UISearchBarDelegate{
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
//
//    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
}


extension ViewController:UITableViewDelegate{
    
    
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.size.height / 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView.tag {
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            cell.textLabel?.text = String(indexPath.row)
            cell.accessoryView = {() -> UISwitch in
                
                let uiSwitch = UISwitch()
                uiSwitch.frame.origin = CGPoint(x: cell.frame.maxX - (uiSwitch.frame.width + 5), y: cell.frame.midY - (uiSwitch.frame.size.height / 2))
                uiSwitch.addTarget(self, action: #selector(bookMarkRegistration), for: .valueChanged)
                uiSwitch.tag = indexPath.row
                return uiSwitch
            }()
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath)
            
            cell.textLabel?.text = bookMarkContentsArray[indexPath.row]
            
            return cell
        default:
            break
        }
        
        
    }
    
    @objc func bookMarkRegistration(sender:UISwitch){
        
        switch sender.isOn{
        
        case true:
            bookMarkContentsArray.append(String(sender.tag))
            
        case false:
            bookMarkContentsArray.removeAll(where: {$0 == String(sender.tag)})
            bookMarkListView.reloadData()
        }
    }
    
}
