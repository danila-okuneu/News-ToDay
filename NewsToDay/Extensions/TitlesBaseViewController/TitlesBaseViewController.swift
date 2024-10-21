import UIKit

class TitlesBaseViewController: UIViewController {
    
    //MARK: - Properties
    private let customNavBar = TitlesBarView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavBar()
    }
    
    //MARK: - SetupUI
    private func setupCustomNavBar() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customNavBar)
        
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: - Methods
    func setTitlesNavBar(title: String, description: String) {
        customNavBar.setTitles(title: title, description: description)
    }
}

