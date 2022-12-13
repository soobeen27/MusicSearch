//
//  SearchResultCollectionViewCell.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/06.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(albumImageView)
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConst() {
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            guard urlString == url.absoluteString else { return }
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: data)
            }
        }
    }
}
