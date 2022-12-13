//
//  MusicCell.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import UIKit

class MusicCell: UITableViewCell {
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
    
    lazy var trackName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var collectionName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [trackName,artistName,collectionName,releaseDate])
        st.spacing = 5
        st.axis = .vertical
//        st.distribution = .fillEqually
//        st.alignment = .fill
        return st
    }()
    
    
    
    
    
    override func prepareForReuse() {
         super.prepareForReuse()
         self.albumImageView.image = nil
     }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setConst()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConst() {
        addSubview(albumImageView)
        addSubview(stackView)
        
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: CellSize.cellHeight),
            albumImageView.heightAnchor.constraint(equalToConstant: CellSize.cellHeight),
            
            
            stackView.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
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
