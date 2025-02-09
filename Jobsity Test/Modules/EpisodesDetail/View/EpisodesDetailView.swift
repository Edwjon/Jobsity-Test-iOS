//
//  AuthenticationView.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

protocol EpisodeDetailViewProtocol: AnyObject {
    func showEpisodeDetails(_ episode: Episode)
}

// MARK: - EpisodeDetailView
class EpisodeDetailView: UIViewController, EpisodeDetailViewProtocol {
    private let episode: Episode
    private var presenter: EpisodeDetailPresenterProtocol!
    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        let interactor = EpisodeDetailInteractor(apiClient: APIClient(), episode: episode)
        self.presenter = EpisodeDetailPresenter(view: self, interactor: interactor, episode: episode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = episode.name
        setupHeader()
        presenter.loadEpisodeDetails()
    }
    
    private func setupHeader() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let imageUrl = episode.image?.medium, let url = URL(string: imageUrl) {
            imageView.loadImage(from: url)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = episode.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let seasonLabel = UILabel()
        seasonLabel.text = "Season \(episode.season), Episode \(episode.number)"
        seasonLabel.font = UIFont.systemFont(ofSize: 16)
        seasonLabel.numberOfLines = 0
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let summaryLabel = UILabel()
        summaryLabel.text = episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No summary available."
        summaryLabel.numberOfLines = 0
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(seasonLabel)
        view.addSubview(summaryLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            seasonLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            seasonLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func showEpisodeDetails(_ episode: Episode) {
        title = episode.name
    }
}
