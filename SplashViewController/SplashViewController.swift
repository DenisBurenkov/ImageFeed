import UIKit

final class SplashViewController: UIViewController {
    
    private let oauth2Service = OAuth2Service()
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let alertPresenter = AlertPresenter()
    private var wasChecked: Bool = false
    
    private let showLoginFlowSegueIdentifier = "ShowLoginFlow "
    
    private var screnlogo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "LanchScreenLogo")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ypBlack
        alertPresenter.delegat = self
        setupViewsVC()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthTocen()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func setupViewsVC() {
        view.addSubview(screnlogo)
        NSLayoutConstraint.activate([
            screnlogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screnlogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            screnlogo.widthAnchor.constraint(equalToConstant: 75),
            screnlogo.heightAnchor.constraint(equalToConstant: 78),
        ])
    }
    
    private func checkAuthTocen() {
        guard !wasChecked else { return }
        wasChecked = true
        if oauth2Service.isAuthenticated {
            UIBlockingProgressHUD.show()
            fetchProfile { [weak self] in
                self?.switchToTabBarController()
                UIBlockingProgressHUD.dismiss()
            }
        } else {
            showAuthVC()
        }
    }
    
    private func showAuthVC() {
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "AuthViewController")
        guard let authViewController = viewController as? AuthViewController else { return }
        authViewController.delegate = self
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated:  true)
    }

    func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
             self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        
        oauth2Service.fetchOAuthToken(code) { [weak self] autRresult in
            switch autRresult {
            case .success(_):
                self?.fetchProfile(complition: {
                    UIBlockingProgressHUD.dismiss()
                })
            case .failure(let error):
                self?.showLoginAlert(error: error)
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    private func fetchProfile(complition: @escaping () -> Void) {
        profileService.fetchProfile { [weak self] profilResult in
            switch profilResult {
            case .success(_):
                self?.switchToTabBarController()
            case .failure(let error):
                self?.showLoginAlert(error: error)
            }
            complition()
        }
    }
    
    private func showLoginAlert(error: Error) {
        alertPresenter.showAlert(
            title: "Что-то пошло не так",
            message: "Не удолось войти в систему \(error.localizedDescription)") {
                self.performSegue(withIdentifier: self.showLoginFlowSegueIdentifier, sender: nil)
            }
    }
    
    private func presentAuth() {
        let viweController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AuthViewController")
        guard let authViewController = viweController as? AuthViewController else { return }
        authViewController.delegate = self
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
        
    }
}
