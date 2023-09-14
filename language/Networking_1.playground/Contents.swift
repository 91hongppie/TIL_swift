import UIKit


// MARK: - Welcome
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// MARK: - Result
struct Music: Codable {
    let songName: String?
    let artistName:String?
    let albumName: String?
    let previewURL: String?
    let imageUrl: String?
    private let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewURL
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
}




func getMethod() {
    
    
    // URL구조체 만들기
    guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=jazz") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        
        do {
            let decoder = JSONDecoder()
            let musicArray = try decoder.decode(MusicData.self, from: safeData)
            dump(musicArray)
        } catch {
            print(error)
        }
        
        
    }.resume()     // 시작
    print("우하하하하")
}


getMethod()




