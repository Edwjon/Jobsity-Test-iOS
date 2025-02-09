import UIKit

protocol PeopleSearchRouterProtocol {
    func navigateToPersonDetail(person: Person)
}

class PeopleSearchRouter: PeopleSearchRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToPersonDetail(person: Person) {
        let detailVC = PersonDetailView(person: person)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
