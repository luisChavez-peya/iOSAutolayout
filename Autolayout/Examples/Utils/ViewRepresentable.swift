//
//  ViewRepresentable.swift
//  Autolayout
//
//  Created by Luis Chavez on 7/03/22.
//

import SwiftUI

struct ViewRepresentable<T: UIView>: UIViewRepresentable {
    typealias UIViewType = T
    var view: T
    
    init(view: T) {
        self.view = view
    }

    func makeUIView(context: Context) -> T {
        return view
    }

    func updateUIView(_ uiView: T, context: Context) {
    }
}
