//
//  CompositionLayoutView.swift
//  Autolayout
//
//  Created by Luis Chavez on 15/06/22.
//

import Foundation
import SwiftUI
import UIKit

enum LayoutType: Int, CaseIterable {
    case fullWidth
    case banner
    case grid
    case bottomGrid
    case horizontalListWithBackground
    case horizontalList
}

struct ComponentWithLayout: Hashable {
    var id = UUID()
    var layout: LayoutType
    var component: [Component]
}

struct Component: Hashable {
    var id = UUID()
    static func build(number: Int) -> [Component] {
        return Array(0..<number).map { _ in Component() }
    }
}

class CompositionLayoutView: UIView {
    typealias ComponentDataSource = UICollectionViewDiffableDataSource<ComponentWithLayout, Component>
    typealias SnapshotDataSource = NSDiffableDataSourceSnapshot<ComponentWithLayout, Component>

    private var components: [ComponentWithLayout] = [.init(layout: .fullWidth, component: Component.build(number: 1)),
                                                     .init(layout: .grid, component: Component.build(number: 5)),
                                                     .init(layout: .bottomGrid, component: Component.build(number: 4)),
                                                     .init(layout: .banner, component: Component.build(number: 10)),
                                                     .init(layout: .horizontalListWithBackground, component: Component.build(number: 5)),
                                                     .init(layout: .horizontalList, component: Component.build(number: 3)),
                                                     .init(layout: .horizontalList, component: Component.build(number: 4)),
                                                     .init(layout: .horizontalList, component: Component.build(number: 5)),
                                                     .init(layout: .horizontalList, component: Component.build(number: 3))]

    private lazy var dataSource: ComponentDataSource = {
        let dataSource = ComponentDataSource(collectionView: collectionView) {
            (collectionView, indexPath, component) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ComponentCellView.identifier,
                for: indexPath) as? ComponentCellView else { fatalError("Cannot create new cell") }
            let color = indexPath.row % 2 == 0 ? UIColor.random : UIColor.random
            cell.configure(color: color)
            return cell
        }
        return dataSource
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background")
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ComponentCellView.self,
                    forCellWithReuseIdentifier: ComponentCellView.identifier)
        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        applySnapshot(animatingDifferences: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = SnapshotDataSource()
        snapshot.appendSections(components)
        components.forEach { snapshot.appendItems($0.component, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - Make Sections
private extension CompositionLayoutView {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env in
            switch  self.components[sectionNumber].layout {
            case .fullWidth:
                let section = self.makeFullWidth()
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 20
                section.contentInsets.trailing = 20
                return section
            case .banner:
                let section = self.makeBanner()
                section.contentInsets.bottom = 66
                section.contentInsets.leading = 20
                section.contentInsets.trailing = 20
                return section
            case .grid:
                let section = self.makeGrid(with: sectionNumber)
                section.contentInsets.leading = 20
                section.contentInsets.trailing = 20
                return section
            case .bottomGrid:
                let section = self.makeBottomGrid()
                section.contentInsets.bottom = 10
                section.contentInsets.leading = 20
                section.contentInsets.trailing = 20
                return section
            case .horizontalListWithBackground:
                let section = self.makeHorizontalListWithBackground()
                section.contentInsets.bottom = 10
                section.contentInsets.leading = 36
                section.contentInsets.trailing = 20
                return section
            case .horizontalList:
                let section = self.makeHorizontalList()
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 20
                section.contentInsets.trailing = 20
                return section
            }
        }
    }
    
    func makeFullWidth() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(56))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    func makeBanner() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 16, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .estimated(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 16, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func makeGrid(with section: Int) -> NSCollectionLayoutSection {
        //Sizes
        let fullWidthAndHeightSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1))

        let leadingItemSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                               heightDimension: .fractionalHeight(1))
        
        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                          heightDimension: .fractionalHeight(1))

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(0.4))
        
        //Items
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6)
        

        let trailingItem = NSCollectionLayoutItem( layoutSize: fullWidthAndHeightSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6)
        
        
        //Groups
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: fullWidthAndHeightSize,
            subitem: trailingItem, count: 2)

        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: trailingGroupSize,
            subitem: horizontalGroup, count: 2)
    
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [leadingItem, trailingGroup])
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 12, trailing: 0)

        return NSCollectionLayoutSection(group: group)
    }
    
    func makeBottomGrid() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 16, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                               heightDimension: .estimated(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func makeHorizontalListWithBackground() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 16, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .fractionalWidth(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: -60, leading: 24, bottom: 10, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.decorationItems = [backgroundItem]
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func makeHorizontalList() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1.5/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 16, trailing: 6)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .estimated(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}

//MARK: - Setup UI
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

extension UIColor {
    static var random: UIColor {
        return UIColor(
            hue: .random(in: 0...1),
            saturation: 0.4,
            brightness: 0.9,
            alpha: 1
        )
    }
}
