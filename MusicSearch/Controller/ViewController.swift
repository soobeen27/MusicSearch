//
//  ViewController.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import UIKit

class ViewController: UIViewController {
    
    let searchResultVC = SearchResultViewController()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: searchResultVC)
        sc.searchResultsUpdater = self
        sc.searchBar.autocapitalizationType = .none
        return sc
    }()
    
    private var tableView: UITableView = {
       let tv = UITableView()
        tv.rowHeight = CellSize.cellHeight
        tv.register(MusicCell.self, forCellReuseIdentifier: Cell.musicCellIdentifier)
        return tv
    }()

    let networkManager = NetworkManager.shared
    
    var musicArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music Search"
        firstView()
        setConst()
        tableView.dataSource = self
        setNav()
    }

    
    func firstView() {
        networkManager.fetchMusic(searchTerm: "lesserafim") {
            result in
            switch result {
            case .success(let musicData):
                self.musicArray = musicData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func setConst() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50)
        ])
    }

    func setNav() {
        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let vc = searchController.searchResultsController as! SearchResultViewController
        vc.searchTerm = searchController.searchBar.text ?? ""
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        
        cell.imageUrl = musicArray[indexPath.row].artworkUrl100
        cell.artistName.text = musicArray[indexPath.row].artistName
        cell.trackName.text = musicArray[indexPath.row].trackName
        cell.collectionName.text = musicArray[indexPath.row].collectionName
        cell.releaseDate.text = musicArray[indexPath.row].releaseDateString
        cell.selectionStyle = .none
        
        return cell
    }
}

