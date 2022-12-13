//
//  NetworkManager.swift
//  MusicSearch
//
//  Created by Soo Jang on 2022/12/01.
//

import UIKit

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        
        performRequest(with: urlString) { result in
            completion(result)
        }
        
    }
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            // 메서드 실행해서, 결과를 받음
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(musics))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ musicData: Data) -> [Music]? {
        //print(#function)
    
        // 성공
        do {
            // 우리가 만들어 놓은 구조체(클래스 등)로 변환하는 객체와 메서드
            // (JSON 데이터 ====> MusicData 구조체)
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
