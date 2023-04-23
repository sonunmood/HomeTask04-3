

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    private var title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private var infoDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 4
        return view
    }()
    
    private var price: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        view.textColor = .blue
        return view
    }()
    
    private var thumbnail: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCell(data: Product) {
        title.text = data.title
        infoDescription.text = data.description
        thumbnail.getImage(from: data.thumbnail)
        price.text = "\(data.price)"
    }
    
    func setupSubviews() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.right.equalToSuperview().inset(12)
        }
        
        addSubview(infoDescription)
        infoDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(12)
        }
        
        addSubview(price)
        price.snp.makeConstraints { make in
            make.top.equalTo(infoDescription.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(12)
        }
        
        addSubview(thumbnail)
        thumbnail.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(200)
        }
    }
}


