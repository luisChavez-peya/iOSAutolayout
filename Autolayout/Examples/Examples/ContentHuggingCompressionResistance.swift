//
//  ContentHuggingCompressionResistance.swift
//  Autolayout
//
//  Created by Luis Chavez on 7/03/22.
//

import Foundation
import UIKit

class ContentHuggingCompressionResistance: UIView {
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Squad Name Name Name Name Name Name Name: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Home 🏡 "
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

private extension ContentHuggingCompressionResistance {
    func setupUI() {
        setupFirstLabel()
        setupSecondLabel()
    }

    func setupFirstLabel() {
        addSubview(firstLabel)
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            firstLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        firstLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func setupSecondLabel() {
        addSubview(secondLabel)
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor),
            secondLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            secondLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        secondLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

// Setup SwiftUI
import SwiftUI
struct ContentHuggingCompressionResistance_Previews: PreviewProvider {
    static var previews: some View {
        ViewRepresentable<ContentHuggingCompressionResistance>(view: ContentHuggingCompressionResistance())
    }
}
