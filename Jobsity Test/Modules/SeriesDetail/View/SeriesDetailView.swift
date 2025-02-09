import UIKit

protocol SeriesDetailViewProtocol: AnyObject {
    func showEpisodes(_ episodes: [Episode])
    func showError(_ message: String)
}

class SeriesDetailView: UIViewController, SeriesDetailViewProtocol {
    private let series: Series
    private var presenter: SeriesDetailPresenterProtocol!
    private var episodesBySeason: [Int: [Episode]] = [:]
    private let contentView = UIView()
    private var episodesCollectionView: UICollectionView!
    private let summaryLabel = UILabel()
    private var router: SeriesDetailRouterProtocol!
    
    weak var favoritesDelegate: FavoritesListViewDelegate?
    
    init(series: Series) {
        self.series = series
        super.init(nibName: nil, bundle: nil)
        let interactor = SeriesDetailInteractor(apiClient: APIClient())
        self.presenter = SeriesDetailPresenter(view: self, interactor: interactor, series: series)
        self.router = SeriesDetailRouter(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = series.name
        setupHeader()
        presenter.loadEpisodes()
        
        let isFavorite = FavoritesManager.shared.isFavorite(seriesId: series.id)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorite ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
    }
    
    private func setupHeader() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrl = series.image?.medium, let url = URL(string: imageUrl) {
            imageView.loadImage(from: url)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = series.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let genresLabel = UILabel()
        genresLabel.text = "Genres: " + series.genres.joined(separator: ", ")
        genresLabel.font = UIFont.systemFont(ofSize: 16)
        genresLabel.numberOfLines = 0
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let scheduleLabel = UILabel()
        scheduleLabel.text = "Airs on: " + series.schedule.days.joined(separator: ", ") + " at " + series.schedule.time
        scheduleLabel.font = UIFont.systemFont(ofSize: 16)
        scheduleLabel.numberOfLines = 0
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        summaryLabel.text = series.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No summary available."
        summaryLabel.numberOfLines = 0
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: view.frame.size.width, height: 280)
        
        episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        episodesCollectionView.register(EpisodesCarouselCell.self, forCellWithReuseIdentifier: "EpisodesCarouselCell")
        episodesCollectionView.backgroundColor = .white
        episodesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(genresLabel)
        view.addSubview(scheduleLabel)
        view.addSubview(summaryLabel)
        view.addSubview(episodesCollectionView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            genresLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            genresLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            scheduleLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            scheduleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            episodesCollectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
    func showEpisodes(_ episodes: [Episode]) {
        episodesBySeason = Dictionary(grouping: episodes, by: { $0.season })
        episodesCollectionView.reloadData()
    }
    
    func showError(_ message: String) {
        print("Error loading episodes: \(message)")
    }
    
    @objc private func toggleFavorite() {
        if FavoritesManager.shared.isFavorite(seriesId: series.id) {
            FavoritesManager.shared.removeFavorite(seriesId: series.id)
        } else {
            FavoritesManager.shared.addFavorite(series: series)
        }
        
        favoritesDelegate?.didUpdateFavorites()
        
        let isFavorite = FavoritesManager.shared.isFavorite(seriesId: series.id)
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
    }
}


extension SeriesDetailView: UICollectionViewDelegate, UICollectionViewDataSource, EpisodesCarouselCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.episodesBySeason.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCarouselCell", for: indexPath) as? EpisodesCarouselCell else {
            return UICollectionViewCell()
        }
        
        let season = Array(episodesBySeason.keys.sorted())[indexPath.item]

        if let episodes = episodesBySeason[season] {
            cell.configure(episodes: episodes)
        }
        
        cell.episodesCarouselCellDelegate = self
        cell.configureSeasonLabel(text: "Season: \(season)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let season = Array(episodesBySeason.keys.sorted())[indexPath.item]
        if let episodes = episodesBySeason[season] {
            let selectedEpisode = episodes[indexPath.row]
            let episodeDetailView = EpisodeDetailView(episode: selectedEpisode)
            navigationController?.pushViewController(episodeDetailView, animated: true)
        }
    }
    
    func openEpisodeDetails(episode: Episode) {
        router.navigateToEpisodeDetail(episode: episode)
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
