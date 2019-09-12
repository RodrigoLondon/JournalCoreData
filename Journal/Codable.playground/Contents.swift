import UIKit



struct Movie: Codable {
    
    var name: String
    var sales: Int
    var rating: String
    var reviewScore: Double
    var productionCompany: String
    var releaseDate: Int
    
}


let deadpoolJson = """
{

"name" : "Deadpool",
"sales" : 36000000,
"rating" : "R",
"reviewScore" : 4.5

}
"""


let jd = JSONDecoder()

if let deadpoolJsonData = deadpoolJson.data(using: .utf8) {
    
    do {
        let deadpool = try jd.decode(Movie.self, from: deadpoolJsonData)
        deadpool.name
        deadpool.sales
        deadpool.rating
        deadpool.reviewScore
        
    } catch let e {
        print("Error decoding object \(e)")
    }
}



let spiderman = Movie(name: "Spiderman", sales: 319000000, rating: "PG-13", reviewScore: 4.5, productionCompany: "WB", releaseDate: 2018)

let je = JSONEncoder()

do {
    let data = try je.encode(spiderman)
    let dataString = String(bytes: data, encoding: .utf8)
    print(dataString ?? 0)
} catch let e {
    print("Error encoding object \(e)")
}
