import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    var title: String
    var description: String
    var price: Int
    var thumbnail:String
}
