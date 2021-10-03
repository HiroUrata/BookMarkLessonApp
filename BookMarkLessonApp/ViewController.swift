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
    
    var tableViewContentsArray = [Int](0...100)
    var bookMarkContentsArray:[String] = []
    var textDidChangeResultArray:[Int] = []
    
    var searchBool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        searchBar.keyboardType = .numberPad
        view.addSubview(searchBar)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tag = 1
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        bookMarkListView.delegate = self
        bookMarkListView.dataSource = self
        bookMarkListView.backgroundColor = .systemGray
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            textDidChangeResultArray = []
            textDidChangeResultArray = tableViewContentsArray.filter{ content in
                
                if String(content).contains(searchBar.text!) == true{
                    
                    return true
                }else{
                    
                    return false
                }
            }
            
            print(textDidChangeResultArray)
            searchBool = true
            tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        textDidChangeResultArray = []
        searchBool = false
        tableView.reloadData()
        
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        if bookMarkListView.frame.origin.x == view.frame.minX - (view.frame.size.width / 2){
            
        UITableView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {self.bookMarkListView.frame.origin.x = self.view.frame.minX}, completion: nil)
            
        }else if bookMarkListView.frame.origin.x == view.frame.minX{
            
            UITableView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {self.bookMarkListView.frame.origin.x = self.view.frame.minX - (self.view.frame.size.width / 2)}, completion: nil)
        }
    }
}


extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch tableView.tag{
        
        case 1: return
            
        case 2:
            let selectCell = tableView.cellForRow(at: indexPath)
            searchBar.text = selectCell?.textLabel?.text
            textDidChangeResultArray = []
            textDidChangeResultArray = tableViewContentsArray.filter{ content in
                
                if String(content).contains(searchBar.text!) == true{
                    
                    return true
                }else{
                    
                    return false
                }
            }
            
            print(textDidChangeResultArray)
            searchBool = true
            self.tableView.reloadData()
            
        default: break
        }
    }
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.size.height / 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnInt = Int()
        
        switch tableView.tag{
        
        case 1:
            returnInt = {() -> Int in
                
            if textDidChangeResultArray.count > 0{
                
                return textDidChangeResultArray.count
            }else{
                
                return tableViewContentsArray.count
            }
        }()
            
        case 2:
            returnInt = bookMarkContentsArray.count
            
        default:
            returnInt = 0
        }
        
        return returnInt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return {() -> UITableViewCell in
            
            var retunCell = UITableViewCell()
            
            switch tableView.tag {
            
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                
                cell.textLabel?.text = {() -> String in
                    
                    if textDidChangeResultArray.count > 0{
                        
                        return String(textDidChangeResultArray[indexPath.row])
                    }else{
                        
                        return String(tableViewContentsArray[indexPath.row])
                    }
                }()
                cell.accessoryView = {() -> UISwitch in
                    
                    let uiSwitch = UISwitch()
                    uiSwitch.frame.origin = CGPoint(x: cell.frame.maxX - (uiSwitch.frame.width + 5), y: cell.frame.midY - (uiSwitch.frame.size.height / 2))
                    uiSwitch.addTarget(self, action: #selector(bookMarkRegistration), for: .valueChanged)
                    uiSwitch.tag = indexPath.row
                    uiSwitch.isOn = {() -> Bool in
                        
                        switch searchBool{
                        
                        case true:
                            if bookMarkContentsArray.contains(String(textDidChangeResultArray[indexPath.row])){

                                return true
                            }else{

                                return false
                            }
                            
                        case false:
                            if bookMarkContentsArray.contains(String(tableViewContentsArray[indexPath.row])){

                                return true
                            }else{

                                return false
                            }
                        }

                    }()
                    
                    return uiSwitch
                }()
                retunCell = cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkCell", for: indexPath)
                
                if bookMarkContentsArray.count >= 1{
                        
                    cell.textLabel?.text = bookMarkContentsArray[indexPath.row]
                }
                //cell.textLabel?.text = bookMarkContentsArray[indexPath.row]
                cell.textLabel?.textColor = .white
                cell.backgroundColor = .systemGray
                retunCell = cell
                
            default:
                break
            }
            return retunCell
        }()
        
    }
    
    @objc func bookMarkRegistration(sender:UISwitch){
        
        switch sender.isOn{
        
        case true:
            if searchBool == true{
                
                bookMarkContentsArray.append(String(textDidChangeResultArray[sender.tag]))
                self.bookMarkListView.reloadData()
            }else if searchBool == false{
                
                bookMarkContentsArray.append(String(tableViewContentsArray[sender.tag]))
                self.bookMarkListView.reloadData()
            }
           
        case false:
            if searchBool == true{
                
                bookMarkContentsArray.removeAll(where: {$0 == String(textDidChangeResultArray[sender.tag])})
                bookMarkListView.reloadData()
            }else if searchBool == false{
                
                bookMarkContentsArray.removeAll(where: {$0 == String(tableViewContentsArray[sender.tag])})
                bookMarkListView.reloadData()
            }
//            bookMarkContentsArray.removeAll(where: {$0 == String(sender.tag)})
//            bookMarkListView.reloadData()
        }
    }
    
}
