import UIKit

class BookmarksCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "BookmarksCell"
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.AppColor.greyPrimary.value
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.AppColor.blackPrimary.value
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(bookmark: Bookmark) {
        articleImageView.image = UIImage(named: bookmark.articleImage)
        categoriesLabel.text = bookmark.categories
        descriptionLabel.text = bookmark.description
    }
    
    //MARK: - Setup UI
    private func configureUI() {
        addSubview(articleImageView)
        addSubview(categoriesLabel)
        addSubview(descriptionLabel)
                
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 96),
            articleImageView.widthAnchor.constraint(equalToConstant: 96),
            
            categoriesLabel.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: 5),
            categoriesLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: categoriesLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}


