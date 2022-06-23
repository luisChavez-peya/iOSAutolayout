//
//  GrillaViewController.swift
//  Autolayout
//
//  Created by Luis Chavez on 31/03/22.
//

import UIKit

class GrillaViewController: UIView {
    @UsesAutoLayout
    private var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        addChilds()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChilds() {
        let firstEntryPoint = EntryPoint(height: 120,
                                         color: .blue)
        horizontalStack.addArrangedSubview(firstEntryPoint)
        firstEntryPoint.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        let secondEntryPoint = EntryPoint(height: 120,
                                         color: .orange)
        horizontalStack.addArrangedSubview(secondEntryPoint)
        secondEntryPoint.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

private extension GrillaViewController {
    func setupUI() {
        backgroundColor = .red
        setupHorizontalStack()
    }

    func setupHorizontalStack() {
        addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            horizontalStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
}

// Setup SwiftUI
import SwiftUI
struct GrillaViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewRepresentable<GrillaViewController>(view: GrillaViewController())
    }
}



//

class EntryPoint: UIView {
    let height: CGFloat
    let color: UIColor
    
    init(height: CGFloat, color: UIColor) {
        self.height = height
        self.color = color
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
