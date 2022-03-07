//
//  LeftVsLeadingContraintExampleView.swift
//  Autolayout
//
//  Created by Luis Chavez on 5/03/22.
//

import UIKit

class LeftVsLeadingContraintExampleView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello 🙋🏻‍♂️"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewStyle()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewStyle() {
        backgroundColor = .orange
    }
}

//MARK: - Add Subviews and setup Constraints
private extension LeftVsLeadingContraintExampleView {
    func setupUI() {
        setupLabel()
    }

    func setupLabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor,
                                       constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,
                                        constant: 10),
            
        ])
    }
}

//MARK: - Swift UI Setup examples
import SwiftUI
struct LeftVsLeadingContraint_Previews: PreviewProvider {

    static var previews: some View {
        ViewRepresentable<LeftVsLeadingContraintExampleView>(view: LeftVsLeadingContraintExampleView())
            .environment(\.layoutDirection, .leftToRight)
            .previewDisplayName("Left to Right")
    
        ViewRepresentable<LeftVsLeadingContraintExampleView>(view: LeftVsLeadingContraintExampleView())
            .environment(\.layoutDirection, .rightToLeft)
            .previewDisplayName("Right to Left")
    }
}

