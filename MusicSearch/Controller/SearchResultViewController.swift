//
//  SearchResultViewController.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/06.
//

import UIKit

class SearchResultViewController: UIViewController {
    

    let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.scrollDirection = .vertical

        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)) / CVCell.cellColumns

        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh

        // 컬렉션뷰의 속성에 할당

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        cv.backgroundColor = .white
        
        cv.collectionViewLayout = flowLayout
        
        cv.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: Cell.musicCollectionViewCellIdentifier)
        
        return cv
    }()
    
    
    
    let networkManager = NetworkManager.shared
    
    var musicArray: [Music] = []
    
    var searchTerm: String? {
        didSet {
            guard let term = searchTerm else { return }
            searchTerm = term.components(separatedBy: [" "]).joined()

            getData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        setConst()

    }
    
    func getData(){
        guard let term = searchTerm else { return }
        musicArray = []
        networkManager.fetchMusic(searchTerm: term) {
            result in
            
            switch result {
            case .success(let musicData):
                self.musicArray = musicData
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func setConst() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.imageUrl = musicArray[indexPath.item].artworkUrl100

        return cell
    }

}
