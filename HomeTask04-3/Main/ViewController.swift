import UIKit
import SnapKit

class ViewController: UIViewController {
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .blue
        view.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return view
    }()
    
    private let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        return cv
    }()
    
    private var product: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        setUpSubviews()
        fetchProducts()
    }
    
    private func showError(with messeage: Error) {
        let alert = UIAlertController(title: "error", message: messeage.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "okay", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func editingChanged() {
        print(searchTextField.text!)
    }
    
    func setUpSubviews() {
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        view.addSubview(myCollectionView)
        myCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(12)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func fetchProducts() {
        NetworkLayer.shared.fetchProducts { result in
            switch result {
            case.success(let model):
                self.product = model
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            case .failure(let error):
                self.showError(with: error)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.initCell(data: product[indexPath.row])
        return  cell
    }
}



extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 20, height: 380)
    }
}

