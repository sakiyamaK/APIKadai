import UIKit
import PlaygroundSupport

extension UIView {
    func applyConstraintSuperViewSafeArea() {
        // self.superviewがnilならクラッシュ
        guard let superview else {
            fatalError()
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

final class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        stackView.addArrangedSubview(label)
        
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)

        self.view.addSubview(stackView)
        stackView.applyConstraintSuperViewSafeArea()

        let urlStr = "https://picsum.photos/200/300"
        
        label.text = urlStr
        
        Task {
            do {
                let (data, urlResponse) = try await URLSession.shared.data(from: URL(string: urlStr)!)
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "dataは画像じゃないよ", code: 100)
                }
                
                imageView.image = image
                
            } catch let error {
                print(error)
            }
        }
    }
}

let vc = ImageViewController()
vc.view.frame = .init(origin: .zero, size: .init(width: 300, height: 500))
PlaygroundPage.current.liveView = vc


//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//
//        view.backgroundColor = .white
//
//        let stackView = UIStackView()
//        
//        let label = UILabel()
//        label.text = "Hello"
//        label.textAlignment = .center
//
//        // so we can see the frame
//        label.backgroundColor = .green
//        
//        stackView.addArrangedSubview(label)
//
//        let label2 = UILabel()
//        label2.text = "Hello"
//        label2.textAlignment = .center
//        stackView.addArrangedSubview(label2)
//
//        label.text = "World"
//
//        view.addSubview(stackView)
//        
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            stackView.widthAnchor.constraint(equalToConstant: 100.0),
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
//        ])
//        
//        self.view = view
//    }
//}
//
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()
