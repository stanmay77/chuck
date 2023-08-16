import RealmSwift
import Foundation


class JokeRealm: Object {
    @Persisted var joke: String
    @Persisted var category: String
    @Persisted var dateDownloaded: Date
    
    convenience init(joke: String, category: String) {
        self.init()
        self.joke = joke
        self.category = category
    }
}


final class RealmManager {
    
    private var realm: Realm {
            do {
                return try Realm()
            } catch {
                fatalError()
            }
        }
    
    
    var jokes: [JokeRealm] {
        let jokes = realm.objects(JokeRealm.self)
        return Array(jokes)
    }
    
    func fetchData() {
        
    }
    
    func saveData(joke: Joke) {
        
        let jokeCategory =  (joke.categories.count > 0) ? joke.categories[0] : "Без категории"
        let jokeForRealm = JokeRealm(joke: joke.value, category: jokeCategory)
        
        let jokeExists = jokes.filter({$0.joke==joke.value})
        
        if jokeExists.isEmpty {
            
            do {
                try realm.write {
                    realm.add(jokeForRealm)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func purgeRealm() {
        let realm = try! Realm()
                
                try! realm.write {
                    realm.delete(self.jokes)
                    print("Realm DB cleared")
                }
    }
}
