import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

protocol EpisodesCarouselCellDelegate {
    func openEpisodeDetails(episode: Episode)
}

class SeriesCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let skeletonView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 6
        contentView.layer.masksToBounds = false

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.isHidden = true
        
        skeletonView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        skeletonView.layer.cornerRadius = 12
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        skeletonView.isHidden = false
        
        contentView.addSubview(skeletonView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            skeletonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with series: Series) {
        titleLabel.text = series.name
        loadImage(from: series.image?.medium)
    }
    
    func configure(with episode: Episode) {
        titleLabel.text = "S\(episode.season)E\(episode.number)\n\(episode.name)"
        loadImage(from: episode.image?.medium)
    }
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = UIImage(named: "placeholder")
            skeletonView.isHidden = true
            titleLabel.isHidden = false
            return
        }
        
        if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            imageView.image = cachedImage
            skeletonView.isHidden = true
            titleLabel.isHidden = false
            return
        }
        
        skeletonView.isHidden = false
        titleLabel.isHidden = true
        imageView.image = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            
            ImageCache.shared.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.imageView.image = image
                self.skeletonView.isHidden = true
                self.titleLabel.isHidden = false
            }
        }.resume()
    }
}
