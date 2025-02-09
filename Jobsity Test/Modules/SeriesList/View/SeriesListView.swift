//
//  SeriesListView.swift.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/6/25.
//

import UIKit

protocol SeriesListViewProtocol: AnyObject {
    func showSeries(_ series: [Series])
    func showError(_ message: String)
}

class SeriesListView: UIViewController, SeriesListViewProtocol, UISearchBarDelegate {
    var presenter: SeriesListPresenterProtocol!
    private var series: [Series] = []
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        
        let interactor = SeriesListInteractor(apiClient: APIClient())
        let router = SeriesListRouter(viewController: self)
        presenter = SeriesListPresenter(view: self, interactor: interactor, router: router)
        
        presenter.loadMoreSeries()
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search series..."
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 20, height: 250)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SeriesCell.self, forCellWithReuseIdentifier: "SeriesCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func showSeries(_ series: [Series]) {
        self.series = series
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            presenter.loadMoreSeries()
        } else {
            isSearching = true
            presenter.searchSeries(query: searchText)
        }
    }
}

extension SeriesListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCell", for: indexPath) as? SeriesCell else {
            return UICollectionViewCell()
        }
        let seriesItem = series[indexPath.row]
        cell.configure(with: seriesItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showSeriesDetails(series[indexPath.row])
    }
}
