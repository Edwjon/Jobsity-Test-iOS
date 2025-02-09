//
//  AuthenticationView.swift
//  Jobsity Test
//
//  Created by Edward Pizzurro on 2/8/25.
//

import Foundation
import UIKit

// MARK: - PinSetupViewProtocol
protocol PinSetupViewProtocol: AnyObject {
    func showError(_ message: String)
    func showSuccess()
}

class PinSetupView: UIViewController {
    private var presenter: PinSetupPresenterProtocol!
    private let titleLabel = UILabel()
    private let pinTextField = UITextField()
    private let confirmPinTextField = UITextField()
    private let savePinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        let interactor = PinSetupInteractor()
        let router = PinSetupRouter()
        self.presenter = PinSetupPresenter(view: self, interactor: interactor, router: router)
    }
    
    private func setupUI() {
        titleLabel.text = "Set Up Your PIN"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pinTextField.placeholder = "Enter PIN"
        pinTextField.textAlignment = .center
        pinTextField.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        pinTextField.borderStyle = .none
        pinTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        pinTextField.layer.cornerRadius = 10
        pinTextField.isSecureTextEntry = true
        pinTextField.keyboardType = .numberPad
        pinTextField.translatesAutoresizingMaskIntoConstraints = false
        
        confirmPinTextField.placeholder = "Confirm PIN"
        confirmPinTextField.textAlignment = .center
        confirmPinTextField.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        confirmPinTextField.borderStyle = .none
        confirmPinTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        confirmPinTextField.layer.cornerRadius = 10
        confirmPinTextField.isSecureTextEntry = true
        confirmPinTextField.keyboardType = .numberPad
        confirmPinTextField.translatesAutoresizingMaskIntoConstraints = false
        
        savePinButton.setTitle("Save PIN", for: .normal)
        savePinButton.backgroundColor = .systemGreen
        savePinButton.setTitleColor(.white, for: .normal)
        savePinButton.layer.cornerRadius = 10
        savePinButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        savePinButton.translatesAutoresizingMaskIntoConstraints = false
        savePinButton.addTarget(self, action: #selector(savePinTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, pinTextField, confirmPinTextField, savePinButton])
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
            confirmPinTextField.heightAnchor.constraint(equalToConstant: 50),
            savePinButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func savePinTapped() {
        guard let pin = pinTextField.text, let confirmPin = confirmPinTextField.text else { return }
        presenter.savePIN(pin, confirmPin: confirmPin)
    }
}

extension PinSetupView: PinSetupViewProtocol {
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showSuccess() {
        navigationController?.setViewControllers([AuthenticationView()], animated: true)
    }
}
