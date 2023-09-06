import UIKit


// 0. URL 주소 - 문자열로
let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20190101&key=6f31dc3f47b1a9cd3b8d6866037ae0bd"

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
    
}

// 일시정지된 상태로 작업이 시작하기 때문에 resume이 필요함
// 4. 작업시작
task.resume()


// 비동기적으로 동작함


// 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ========================================================

//func parseJSON(_ movieData: Data)
