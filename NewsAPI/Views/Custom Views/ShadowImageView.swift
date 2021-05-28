import UIKit

/// we gonna use this inside the NewsCell file as an image for each news
class ShadowImageView: UIView {
    
    /// wherever this property is set when this calss is used, set the lazy iamge view down there
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = Constants.placeholderImageAsset
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    // the shadow is gonna be to the base view and the image view is gonna be inside that base view
    // can't do the shadow to the image view because of the clips to bounds is set to true
    private lazy var baseView: UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = .clear
        bv.layer.shadowColor = UIColor.black.cgColor
        bv.layer.shadowOffset = CGSize(width: 5, height: 5)
        bv.layer.shadowOpacity = 0.7
        bv.layer.shadowRadius = 10.0
        return bv
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // draw the shadow for the base view in this functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        [baseView, imageView].forEach { (view) in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                view.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
    }
    
}
