//
//  IntrinsicContentSize.swift
//  Autolayout
//
//  Created by Luis Chavez on 7/03/22.
//

import Foundation
import UIKit

class IntrinsicContentSizeView: UIView {
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupStyle()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        backgroundColor = .blue
    }
}

private extension IntrinsicContentSizeView {
    func setupUI() {
        setupFirstLabel()
    }

    func setupFirstLabel() {
        addSubview(firstLabel)
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            firstLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

// Setup SwiftUI
import SwiftUI
struct IntrinsicContentSizeView_Previews: PreviewProvider {
    static var previews: some View {
        ViewRepresentable<IntrinsicContentSizeView>(view: IntrinsicContentSizeView())
    }
}
