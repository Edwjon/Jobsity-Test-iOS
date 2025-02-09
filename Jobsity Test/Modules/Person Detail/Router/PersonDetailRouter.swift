import Foundation
import UIKit

protocol PersonDetailRouterProtocol {
    func navigateToPersonDetail(person: Person)
}

class PersonDetailRouter: PersonDetailRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToPersonDetail(person: Person) {
        let personDetailView = PersonDetailView(person: person)
        viewController?.navigationController?.pushViewController(personDetailView, animated: true)
    }
}
