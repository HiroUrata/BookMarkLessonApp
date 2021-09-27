//
//  ViewController.swift
//  BookMarkLessonApp
//
//  Created by UrataHiroki on 2021/09/25.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }

    override func viewWillLayoutSubviews() {
        
        searchBar.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY + self.view.safeAreaInsets.top, width: self.view.frame.size.width, height: 44)
        searchBar.showsBookmarkButton = true
        searchBar.showsCancelButton = true
        view.addSubview(searchBar)
        
        
    }
    

}

