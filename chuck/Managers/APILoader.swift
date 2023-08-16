import Foundation
import RealmSwift

struct JokeCategory: Codable {
    var category: String
}


struct Joke: Codable {
    var categories: [String]
    var value: String
    var downloadDate = Date()
    
    enum CodingKeys: String, CodingKey {
            case categories, value
        }
}


final class APILoader {
    
    static let shared = APILoader()
    private init() { }
    
    // To test categories
    //let apiURL = URL(string: "https://api.chucknorris.io/jokes/random?category=political")!
    
    // Random API url
    let apiURL = URL(string: "https://api.chucknorris.io/jokes/random")!
    
    
    func getQuote(completion: @escaping (Result<Joke, APIError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            
        if let _ = error {
            completion(.failure(.otherError))
        }
            
        if let response = (response as? HTTPURLResponse), response.statusCode == 200 {
            
            guard let data = data else {
                return completion(.failure(.dataError))
            }
            
                do {
                    let data = try JSONDecoder().decode(Joke.self, from: data)
                    completion(.success(data))
                }
                
                catch {
                    completion(.failure(.dataError))
                }
                
        } else {
            completion(.failure(.httpError))
        }
            
        }
        
        task.resume()
    }
    
    
}
