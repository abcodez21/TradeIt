import Foundation
struct TradeData: Codable{
    var result: Double
    var info: Info
}

struct Info: Codable{
    var rate: Double
}
