import UIKit

class BookmarkEmptyView: UIView {
    
    //MARK: - Properties
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "empty_bookmarks_label".localized()
        label.font = UIFont.interFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.AppColor.blackPrimary.value
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame.size = CGSize(width: 72, height: 72)
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        image.backgroundColor = UIColor.AppColor.purpleLighter.value
        return image
    }()
    
    let bookImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "text.book.closed")
        image.tintColor = UIColor.AppColor.purpleBright.value
        return image
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    //MARK: - Setup UI 
    private func setupUI() {
        addSubview(logoImageView)
        addSubview(messageLabel)
        logoImageView.addSubview(bookImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 72),
            logoImageView.heightAnchor.constraint(equalToConstant: 72),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bookImageView.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            bookImageView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 24),
            bookImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func updateEmptyText() {
        messageLabel.text = "empty_bookmarks_label".localized()
    }
}
