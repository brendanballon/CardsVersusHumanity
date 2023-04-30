//
//  ProductAuthenticity.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import Foundation

func authenticate(code: String, completion: @escaping (Bool) -> Void) {
    let parameters = "{\"code\":\"\(code)\"}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://www.cah.io/verify")!,timeoutInterval: Double.infinity)
    request.addValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    request.addValue("en-US,en;q=0.9", forHTTPHeaderField: "Accept-Language")
    request.addValue("keep-alive", forHTTPHeaderField: "Connection")
    request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.addValue("https://www.cah.io", forHTTPHeaderField: "Origin")
    request.addValue("https://www.cah.io/verify", forHTTPHeaderField: "Referer")
//    request.addValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
//    request.addValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
//    request.addValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
//    request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
//    request.addValue("\"Chromium\";v=\"112\", \"Google Chrome\";v=\"112\", \"Not:A-Brand\";v=\"99\"", forHTTPHeaderField: "sec-ch-ua")
//    request.addValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
//    request.addValue("\"macOS\"", forHTTPHeaderField: "sec-ch-ua-platform")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(false)
            return
        }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let status = json["status"] as? String {
                completion(status == "success")
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
            completion(false)
        }
    }

    task.resume()
}
