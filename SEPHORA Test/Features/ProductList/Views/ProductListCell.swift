//
//  ProductListCell.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit


class ProductListCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { String(describing: ProductListCell.self) }

    let imageView : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = .darkGray
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 8
        return v
    }()
    
    let tagLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        v.textColor = .systemPink
        v.textAlignment = .left
        return v
    }()
    
    let name : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.preferredFont(forTextStyle: .headline)
        v.textColor = .label
        v.numberOfLines = 2
        v.textAlignment = .left
        return v
    }()
    
    let descriptionLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.preferredFont(forTextStyle: .caption2)
        v.textColor = .label
        v.numberOfLines = 2
        return v
    }()
    
    let price : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.preferredFont(forTextStyle: .headline)
        v.textColor = .label
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        let stackView = UIStackView(arrangedSubviews: [tagLabel, imageView, name, descriptionLabel, price])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 260),
            imageView.heightAnchor.constraint(equalToConstant: 160),

            tagLabel.heightAnchor.constraint(equalToConstant: 20),
            name.heightAnchor.constraint(equalToConstant: 20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            price.heightAnchor.constraint(equalToConstant: 30),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            
        ])
    }

    func configure(with product: Product) {
        name.text = product.name
        tagLabel.text = "\(product.brand.name)"
        descriptionLabel.text = product.description
        price.text = "Price: \(product.price)$"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
