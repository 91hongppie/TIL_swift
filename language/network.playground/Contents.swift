import UIKit

let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20190101&key=6f31dc3f47b1a9cd3b8d6866037ae0bd"



let structUrl = URL(string: movieURL)!


let session = URLSession.shared // 또는 let session = URLSession(configuration: .default)

// 멈춤 상태에서 시작
let task = session.dataTask(with: structUrl) { data, response, error in
    if error != nil {
        print(error?.localizedDescription)
        return
    }
    
    if let safeData = data {
        
        print(String(decoding: safeData, as: UTF8.self))
    }
}

// 그래서 resume이 필요함
task.resume()


