//
//  ViewController.swift
//  testlaunchscreen
//
//  Created by Mohammad Alabed on 01/04/2024.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("fonts1 \(Environment.valueForColor(.fontName1))")
//        print("fonts2 \(Environment.valueForColor(.fontName2))")
        // Do any additional setup after loading the view.
//        print("API Key: \(ConfigValues.shared.APP_BUNDLE_IDENTIFIER)")
        
        // Create a stack view
        let stackView = UIStackView()
        stackView.axis = .vertical // or .vertical based on your layout preference
        stackView.alignment = .center
        stackView.spacing = 8 // Set the spacing between views
        
        // Create an image view
        let imageView = UIImageView(image: UIImage(named: "image"))
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true // Set image view width
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true // Set image view height
        
        // Create a label
        let label = UILabel()
        label.text = "Bundle ID \(ConfigValues.shared.APP_BUNDLE_IDENTIFIER)"
        label.font = UIFont.systemFont(ofSize: 16)
        
        // Add the image view and label to the stack view
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        let label2 = UILabel()
        label2.text = "App Name \(ConfigValues.shared.APP_NAME)"
        label2.font = UIFont(name: ConfigValues.shared.fontName1, size: 33)
        stackView.addArrangedSubview(label2)
        let label3 = UILabel()
        label3.text = "Test font2"
        label3.font = UIFont(name: ConfigValues.shared.fontName2, size: 33)
        label3.textColor = UIColor.init(hex: ConfigValues.shared.text1Color)
        stackView.addArrangedSubview(label3)
        
        
//        let label4 = UILabel()
//        label4.text = "Test font3"
//        label4.font = UIFont(name: "KasperLullabyRegular", size: 33)
//        stackView.addArrangedSubview(label4)
//        
//        
        // Add the stack view to your view hierarchy
        view.addSubview(stackView)
        
        // Set constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        addLottie()
    }
    
    
    private var animationView: LottieAnimationView?

    func addLottie() {
        
            // Set animation view properties (e.g., loop mode, playback speed)
            animationView = .init(name: "Animation - 1713817130713")
              
              animationView!.frame = view.bounds
              
              // 3. Set animation content mode
              
              animationView!.contentMode = .scaleAspectFit
              
              // 4. Set animation loop mode
              
              animationView!.loopMode = .loop
              
              // 5. Adjust animation speed
              
              animationView!.animationSpeed = 1.5
              
              view.addSubview(animationView!)
              
              // 6. Play animation
              
              animationView!.play()
        guard let animationView = animationView else { return }
            // Add animation view to your view hierarchy
            view.addSubview(animationView)

            // Set constraints or frame for the animation view
            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                animationView.widthAnchor.constraint(equalToConstant: 200),
                animationView.heightAnchor.constraint(equalToConstant: 200)
            ])

            // Play the animation
        
    }
    
}

extension ViewController {
    func encrypedTest() {
        // Encrypt data
//        let key = "your_encryption_key"
//        let iv = "your_initialization_vector"
//        let apiKey = "your_api_key_here"
//        let encryptedApiKey = try? AES(key: key, iv: iv).encrypt(Array(apiKey.utf8))
//
//        // Decrypt data
//        let decryptedApiKey = try? AES(key: key, iv: iv).decrypt(encryptedApiKey)
//        let apiKeyString = String(data: Data(decryptedApiKey ?? []), encoding: .utf8)

    }
}
