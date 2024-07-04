import UIKit

let urlStr = "https://picsum.photos/200/300"

let url = URL(string: urlStr)!

Task {
    do {
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "dataは画像じゃないよ", code: 100)
        }
        
        //　本当はここでUI側に渡して画面に表示したりする
        image
        print(image.size)
    } catch let error {
        print(error)
    }
}

