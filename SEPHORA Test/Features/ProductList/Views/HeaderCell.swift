//
//  HeaderCell.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit


class HeaderCell: UICollectionViewCell {
    
    static var reuseIdentifier: String { String(describing: HeaderCell.self) }

    
    let title : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 28, weight: .heavy)
        v.textColor = .label
        v.numberOfLines = 2
        v.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        v.textAlignment = .left
        return v
    }()
    
    let subtitle : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 14, weight: .light)
        v.textColor = .orange
        v.sizeToFit()
        return v
    }()
    
    let separator: UIView = {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray
        return separator
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
        let stackView = UIStackView(arrangedSubviews: [separator, title, subtitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            title.heightAnchor.constraint(equalToConstant: 29),
            subtitle.heightAnchor.constraint(equalToConstant: 20),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
 
        ])
    }

    func configure(with title: (String,String)) {
        self.title.text = title.0
        self.subtitle.text = title.1
    }
    
}
