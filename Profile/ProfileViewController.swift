import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        imageView.layer.cornerRadius = 35
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var button: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "logoutButton")!,
            target: self,
            action: nil
        )
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var nLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = .boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lNLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(nLabel)
        view.addSubview(lNLabel)
        view.addSubview(dLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),

            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

            nLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            lNLabel.trailingAnchor.constraint(equalTo: nLabel.trailingAnchor),
            lNLabel.leadingAnchor.constraint(equalTo: nLabel.leadingAnchor),
            lNLabel.topAnchor.constraint(equalTo: nLabel.bottomAnchor, constant: 8),

            dLabel.trailingAnchor.constraint(equalTo: nLabel.trailingAnchor),
            dLabel.leadingAnchor.constraint(equalTo: nLabel.leadingAnchor),
            dLabel.topAnchor.constraint(equalTo: lNLabel.bottomAnchor, constant: 8)
        ])
    }
}
