//
//  CompositionLayoutView.swift
//  Autolayout
//
//  Created by Luis Chavez on 15/06/22.
//

import Foundation
import SwiftUI
import UIKit

class CompositionLayoutView: UIView {
    private lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ComponentCellView.self,
                    forCellWithReuseIdentifier: ComponentCellView.identifier)
        cv.dataSource = self
        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CompositionLayoutView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComponentCellView.identifier, for: indexPath) as? ComponentCellView else {
            return UICollectionViewCell()
        }
        let color = indexPath.row % 2 == 0 ? UIColor.blue : .orange
        cell.configure(color: color)
        return cell
    }
}

private extension CompositionLayoutView {
    func setupUI() {
        setupStyle()
        setupCollectionView()
    }
    
    func setupStyle() {
        backgroundColor = .red
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

//MARK: - Swift UI Setup examples
import SwiftUI
struct CompositionLayoutView_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewRepresentable<CompositionLayoutView>(view: CompositionLayoutView())
            .ignoresSafeArea()
            .previewDisplayName("CompositionLayoutView")
    }
}


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
