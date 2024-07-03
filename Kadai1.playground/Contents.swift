import UIKit

let urlStr: String = "https://picsum.photos/200/300"

let url = URL(string: urlStr)!

let session = URLSession.shared
let task = session.dataTask(with: url) { data, response, error in
    // errorがnilじゃないならifがtrueになる
    if let error {
        print(error)
        return
    }
    
    guard let data, let image = UIImage(data: data) else {
        print("dataは画像じゃないよ")
        return
    }
    
    //　本当はここでUI側に渡して画面に表示したりする
    image
}

task.resume()
