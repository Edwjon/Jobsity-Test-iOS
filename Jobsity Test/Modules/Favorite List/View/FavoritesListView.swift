import Foundation
import UIKit

protocol FavoritesListViewDelegate: AnyObject {
    func didUpdateFavorites()
}

protocol FavoritesListViewProtocol: AnyObject {
    func showFavorites(_ series: [Series])
    func showError(_ message: String)
}

class FavoritesListView: UIViewController, FavoritesListViewProtocol {
    var presenter: FavoritesListPresenterProtocol!
    private var series: [Series] = []
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        let interactor = FavoritesListInteractor()
        let router = FavoritesListRouter(viewController: self)
        presenter = FavoritesListPresenter(view: self, interactor: interactor, router: router)
        
        presenter.loadFavoriteSeries()
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
    
    func showFavorites(_ series: [Series]) {
        self.series = series.sorted { $0.name < $1.name }
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension FavoritesListView: UICollectionViewDelegate, UICollectionViewDataSource, FavoritesListViewDelegate {
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
        presenter.showSeriesDetails(series[indexPath.row], delegate: self)
    }
    
    func didUpdateFavorites() {
        presenter.loadFavoriteSeries()
    }
}
