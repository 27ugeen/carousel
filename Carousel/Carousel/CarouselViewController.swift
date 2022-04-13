//
//  ViewController.swift
//  Carousel
//
//  Created by GiN Eugene on 13/4/2022.
//

import UIKit

struct CarouselData {
    let image: UIImage?
    let text: String
}

class CarouselViewController: UIViewController {
    //MARK: - Properties
    
    private var carouselData = [CarouselData]()
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    //MARK: - Subviews
    
    private lazy var carouselCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 300, height: 400)
        carouselLayout.sectionInset = .zero
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        
        collection.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellId)
        
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    //MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupData()
    }
}
//MARK: - setup Views

extension CarouselViewController {
    func setupViews() {
        view.addSubview(carouselCollectionView)
        view.addSubview(pageControl)
        
        let constraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            carouselCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            carouselCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            carouselCollectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
//MARK: - setup Data

extension CarouselViewController {
    func setupData() {
        carouselData.append(.init(image: UIImage(named: "beach"), text: "beach"))
        carouselData.append(.init(image: UIImage(named: "ferrari-458-spider"), text: "ferrari-458-spider"))
        carouselData.append(.init(image: UIImage(named: "ladybug"), text: "ladybug"))
        carouselData.append(.init(image: UIImage(named: "dog-"), text: "dog-"))
        
        carouselCollectionView.reloadData()
    }
}
// MARK: - Helpers
private extension CarouselViewController {
    func getCurrentPage() -> Int {
        
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}
//MARK: - UICollectionViewDataSource

extension CarouselViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = carouselData.count
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.cellId, for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        
        let image = carouselData[indexPath.row].image
        let text = carouselData[indexPath.row].text
        
        cell.configure(image: image, text: text)
        
        return cell
    }
}
//MARK: - UICollectionViewDelegate

extension CarouselViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension CarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellPadding = (collectionView.frame.width - 300) / 2
        return UIEdgeInsets(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width - 300
    }
}
