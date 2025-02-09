import Foundation
import UIKit

protocol SeriesDetailRouterProtocol {
    func navigateToEpisodeDetail(episode: Episode)
}

class SeriesDetailRouter: SeriesDetailRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToEpisodeDetail(episode: Episode) {
        let episodeDetailRouter = EpisodeDetailRouter(viewController: viewController!)
        episodeDetailRouter.navigateToEpisodeDetail(episode: episode)
    }
}
