//
//  ViewContraint.swift
//  Autolayout
//
//  Created by Luis Chavez on 7/03/22.
//

import Foundation
import UIKit

class ViewConstraint: UIView {
    private var view: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
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

private extension ViewConstraint {
    func setupUI() {
//        setupView()
        setupViewWithPriorities()
    }

    func setupView() {
        addSubview(view)
        let topAnchorConstraint = view.topAnchor.constraint(equalTo: topAnchor,
                                      constant: 10)
        let leadingAnchorConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: 10)
        
        let bottomAnchorConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    
        let trailingAnchorConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    
        NSLayoutConstraint.activate([
            topAnchorConstraint,
            leadingAnchorConstraint,
            trailingAnchorConstraint,
            bottomAnchorConstraint
        ])
    }
    
    func setupViewWithPriorities() {
        addSubview(view)
        let topAnchorConstraint = view.topAnchor.constraint(equalTo: topAnchor,
                                      constant: 10)
        let leadingAnchorConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: 10)

    
        let heightAnchorConstraint = view.heightAnchor.constraint(equalToConstant: 100)
        
        let widthAnchorConstraint = view.widthAnchor.constraint(equalToConstant: 100)
    
        widthAnchorConstraint.priority = .defaultLow
    
        let trailingAnchorlessThanOrEqualToConstraint = view.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
    
        trailingAnchorlessThanOrEqualToConstraint.priority = .defaultHigh
        
        
        let bottomAnchorConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            topAnchorConstraint,
            leadingAnchorConstraint,
            bottomAnchorConstraint,
            trailingAnchorlessThanOrEqualToConstraint,
            widthAnchorConstraint,
            heightAnchorConstraint,
        ])
    }
}


// Setup SwiftUI
import SwiftUI
struct ViewConstraint_Previews: PreviewProvider {
    static var previews: some View {
        ViewRepresentable<ViewConstraint>(view: ViewConstraint())
    }
}



