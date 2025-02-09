//
//  AuthenticationRouter.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

protocol EpisodeDetailRouterProtocol {
    func navigateToEpisodeDetail(episode: Episode)
}

class EpisodeDetailRouter: EpisodeDetailRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToEpisodeDetail(episode: Episode) {
        let episodeDetailView = EpisodeDetailView(episode: episode)
        viewController?.navigationController?.pushViewController(episodeDetailView, animated: true)
    }
}
