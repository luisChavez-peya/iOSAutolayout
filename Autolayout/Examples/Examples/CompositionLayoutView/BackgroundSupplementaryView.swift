//
//  BackgroundSupplementaryView.swift
//  Autolayout
//
//  Created by Maria Ledesma on 7/26/22.
//

import Foundation
import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    let title = UILabel()
    let subtitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        backgroundColor = .purple
        setupTitle()
        setupSubtitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 15)
        title.text = "Viernes con amigos"
    }
    
    func setupSubtitle() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.adjustsFontSizeToFitWidth = true
        addSubview(subtitle)
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        subtitle.textColor = .white
        subtitle.font = UIFont.systemFont(ofSize: 11)
        subtitle.text = "Restaurantes"
    }
    
}
