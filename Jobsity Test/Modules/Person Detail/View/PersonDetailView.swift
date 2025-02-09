import Foundation
import UIKit

protocol PersonDetailViewProtocol: AnyObject {
    func showPersonDetails(_ person: Person)
}

class PersonDetailView: UIViewController, PersonDetailViewProtocol {
    private let person: Person
    private var presenter: PersonDetailPresenterProtocol!
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
        let interactor = PersonDetailInteractor(apiClient: APIClient(), person: person)
        self.presenter = PersonDetailPresenter(view: self, interactor: interactor, person: person)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = person.name
        setupHeader()
        presenter.loadPersonDetails()
    }
    
    private func setupHeader() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        
        if let imageUrl = person.image?.medium, let url = URL(string: imageUrl) {
            imageView.loadImage(from: url)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = person.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func showPersonDetails(_ person: Person) {
        title = person.name
    }
}
