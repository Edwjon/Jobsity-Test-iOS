import UIKit

protocol PeopleSearchViewProtocol: AnyObject {
    func showPeople(_ people: [Person])
    func showError(_ message: String)
}

class PeopleSearchView: UIViewController, PeopleSearchViewProtocol {
    var presenter: PeopleSearchPresenterProtocol!
    private var people: [Person] = []
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let interactor = PeopleSearchInteractor(apiClient: APIClient())
        let router = PeopleSearchRouter(viewController: self)
        presenter = PeopleSearchPresenter(view: self, interactor: interactor, router: router)
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "People Search"

        searchBar.placeholder = "Search people..."
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 20, height: 200)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PeopleCell.self, forCellWithReuseIdentifier: "PeopleCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showPeople(_ people: [Person]) {
        self.people = people
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension PeopleSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as? PeopleCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: people[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPerson = people[indexPath.row]
        presenter.showPersonDetail(person: selectedPerson)
    }
}

extension PeopleSearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.people = []
            self.collectionView.reloadData()
            return
        }
        presenter.searchPeople(query: searchText)
    }
}
