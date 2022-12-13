//
//  MainView.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import UIKit

class MainView: UIView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let tableView = UITableView()
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MusicCell.self, forCellReuseIdentifier: "MusicCell")

    }
    
}


extension MainView: UITableViewDelegate {
    
}


extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
