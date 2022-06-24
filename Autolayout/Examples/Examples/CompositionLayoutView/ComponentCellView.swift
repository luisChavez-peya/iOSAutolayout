//
//  ComponentCellView.swift
//  Autolayout
//
//  Created by Luis Chavez on 24/06/22.
//

import UIKit

class ComponentCellView: UICollectionViewCell {
    static var identifier = "ComponentCellView"
    
    var heightAnchorContraint: NSLayoutConstraint?

    private var component: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    func configure(color: UIColor) {
        component.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
      //  addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTapGesture() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDidTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleDidTap() {
        heightAnchorContraint?.constant = 300
        UIView.animate(withDuration: 1.0, delay: 0.0,
          usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0,
          options: .curveEaseIn,
          animations: {
            self.layoutIfNeeded()
          },
          completion: nil
        )
    }
}

private extension ComponentCellView {
    func setupUI() {
        setupComponent()
    }
    
    func setupComponent() {
        contentView.addSubview(component)
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: contentView.topAnchor),
            component.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            component.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            component.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            component.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        heightAnchorContraint = component.heightAnchor.constraint(equalToConstant: 80)
        heightAnchorContraint?.isActive = true
    }
}
