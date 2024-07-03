import UIKit

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

#Preview {
    ImageViewController()
}
