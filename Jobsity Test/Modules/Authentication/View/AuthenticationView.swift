import Foundation
import UIKit

protocol AuthenticationViewProtocol: AnyObject {
    func showError(_ message: String)
}

class AuthenticationView: UIViewController {
    var presenter: AuthenticationPresenterProtocol!
    private let titleLabel = UILabel()
    private let pinTextField = UITextField()
    private let authenticateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        let interactor = AuthenticationInteractor()
        let router = AuthenticationRouter()
        self.presenter = AuthenticationPresenter(view: self, interactor: interactor, router: router)
    }
    
    private func setupUI() {
        titleLabel.text = "Enter Your PIN"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pinTextField.placeholder = "••••"
        pinTextField.textAlignment = .center
        pinTextField.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        pinTextField.borderStyle = .none
        pinTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        pinTextField.layer.cornerRadius = 10
        pinTextField.isSecureTextEntry = true
        pinTextField.keyboardType = .numberPad
        pinTextField.translatesAutoresizingMaskIntoConstraints = false
        
        authenticateButton.setTitle("Unlock", for: .normal)
        authenticateButton.backgroundColor = .systemBlue
        authenticateButton.setTitleColor(.white, for: .normal)
        authenticateButton.layer.cornerRadius = 10
        authenticateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        authenticateButton.translatesAutoresizingMaskIntoConstraints = false
        authenticateButton.addTarget(self, action: #selector(authenticateTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, pinTextField, authenticateButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 280),
            
            pinTextField.heightAnchor.constraint(equalToConstant: 50),
            authenticateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func authenticateTapped() {
        guard let pin = pinTextField.text else { return }
        presenter.authenticateUser(with: pin)
    }
}

extension AuthenticationView: AuthenticationViewProtocol {
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
