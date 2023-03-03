//
//  ErrorView.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

public class ErrorView: UIView {
    
    let icon: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(systemName: "exclamationmark.circle")
        v.clipsToBounds = true
        v.tintColor = .red
        return v
    }()
    
    let title: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 26)
        v.textAlignment = .center
        v.text = "ERROR"
        return v
    }()
    
    let message: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.font = .italicSystemFont(ofSize: 18)
        v.text = "Network error. \n There must be a problem with the server. \n please check your internet connection."
        v.textAlignment = .center
        v.numberOfLines = 3
        return v
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        let stackView = UIStackView(arrangedSubviews: [icon, title, message])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 80),
            icon.widthAnchor.constraint(equalToConstant: 80),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
        ])
        stackView.setCustomSpacing(8, after: icon)
    }
}
