import UIKit

final class AlertPresenter {
    
    weak var delegat: UIViewController?
    
    func showAlert(title: String, message: String, handler: @escaping() -> Void ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: "OK",
            style: .default
        ){ _ in handler() }
        
        alert.addAction(alertAction)
        delegat?.present(alert, animated: true)
    }
}


