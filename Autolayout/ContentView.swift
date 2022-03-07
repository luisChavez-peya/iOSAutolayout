//
//  ContentView.swift
//  Autolayout
//
//  Created by Luis Chavez on 2/03/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ExampleViewControllerRepresentable<ExampleViewController>(controller: ExampleViewController())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class ExampleViewController: UIViewController {
    let customView = IntrinsicContentSizeView()

    init() {
        super.init(nibName: nil, bundle: nil)
        setupCustomView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
        ])
    }
}

struct ExampleViewControllerRepresentable<T: UIViewController>: UIViewControllerRepresentable {
    typealias UIViewControllerType = T
    private let controller: T
    
    init(controller: T) {
        self.controller = controller
    }

    func makeUIViewController(context: Context) -> T {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) {
    }
}
