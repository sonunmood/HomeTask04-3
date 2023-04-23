import Foundation

final class NetworkLayer {
    static let shared = NetworkLayer()
    
    private init() { }
    
    private var baseUrl = URL(string: "https://dummyjson.com/products")!
    func fetchProducts(completion: @escaping(Result<[Product], Error>)-> Void) {
        let request = URLRequest(url: baseUrl)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                let model: Products = self.decode(with: data)
                completion(.success(model.products))
            }
        }
        .resume()
    }
    
    func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
}


