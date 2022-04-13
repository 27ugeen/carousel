//
//  CarouselCollectionViewCell.swift
//  Carousel
//
//  Created by GiN Eugene on 13/4/2022.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let cellId = "CarouselCollectionViewCell"
    // MARK: - SubViews
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.textColor = .white
        return textLabel
    }()
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setups

private extension CarouselCollectionViewCell {
    func setupUI() {
        backgroundColor = .clear
        
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
// MARK: - Public

extension CarouselCollectionViewCell {
    public func configure(image: UIImage?, text: String) {
        imageView.image = image
        textLabel.text = text
    }
}
