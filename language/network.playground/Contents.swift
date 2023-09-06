import UIKit


// 0. URL 주소 - 문자열로
let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20210101&key=6f31dc3f47b1a9cd3b8d6866037ae0bd"

// 1. URL 구조체 만들기
let structUrl = URL(string: movieURL)!

// 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할
let session = URLSession.shared // 또는 let session = URLSession(configuration: .default)

// 3. 세션에 (일시정지 상태로) 작업 부여
let task = session.dataTask(with: structUrl) { data, response, error in
    if error != nil {
        print(error!)
        return
    }
    
    guard let response = response as? HTTPURLResponse, (200..<299) ~= response.statusCode else {
        print("Error: HTTP request failed")
        return
    }
    
    guard let safeData = data else { return }
    
    // 데이터를 우리가 사용하려는 형태(구조체/클래스)로 변형해서 사용
    
    
    // 데이터를 그냥 한번 출력해보기
    // print(String(decoding: safeData, as: UTF8.self))
 
    let movieArray = parseJSON1(safeData)
    
    dump(movieArray!)
}

// 일시정지된 상태로 작업이 시작하기 때문에 resume이 필요함
// 4. 작업시작
task.resume()


// 비동기적으로 동작함


// 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ========================================================

// 현재의 형태
// 스위프트5
// 자동으로 원하는 클래스/구조체 형태로 분석
// JSONDecoder
func parseJSON1(_ movieData: Data) -> [DailyBoxOfficeList]? {
    do {
        let decoder = JSONDecoder()
        
        let decodedData = try decoder.decode(MovieData.self, from: movieData)
        
        return decodedData.boxOfficeResult.dailyBoxOfficeList
        
    } catch {
        return nil
    }
}

// 스위프트4 버전까지
// 딕셔너리 형태로 분석
// JSONSerialization
func parseJSON2(_ movieData: Data) -> [DailyBoxOfficeList]? {
    do {
        
        var movieLists = [DailyBoxOfficeList]()
        

        if let json = try JSONSerialization.jsonObject(with: movieData) as? [String: Any] {
            if let boxOfficeResult = json["boxOfficeResult"] as? [String: Any] {
                if let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"] as? [[String: Any]] {
                    for item in dailyBoxOfficeList {
                        let rank = item["rank"] as! String
                        let movieNm = item["movieNm"] as! String
                        let audiCnt = item["audiCnt"] as! String
                        let audiAcc = item["audiAcc"] as! String
                        let openDt = item["openDt"] as! String
                        
                        // 하나씩 인스턴스 만들어서 배열에 append
                        let movie = DailyBoxOfficeList(rank: rank, movieNm: movieNm, audiCnt: audiCnt, audiAcc: audiAcc, openDt: openDt)

                        movieLists.append(movie)
                    }
                    return movieLists
                }
            }
        }
        return nil
    } catch {
        return nil
    }
}

// 서버에서 주는 데이터의 형태 ========================================================

// MARK: - Welcome
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}

struct Movie {
    let name: String
    let openDate: String
    
}
