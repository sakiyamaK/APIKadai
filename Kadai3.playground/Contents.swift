import UIKit

let urlStr = "https://api.github.com/search/repositories?q=swift"

let url = URL(string: urlStr)!

Task {
    do {
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        guard let string = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "dataは文字列じゃないよ", code: 100)
        }
        //　本当はここでUI側に渡して画面に表示したりする
        print(string)
    } catch let error {
        print(error)
    }
}

