//
//  TZWErrorWarningView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/7.
//

import UIKit

class TZWErrorWarningView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }

    func setUI() {
        self.alpha = 0
        
        self.addSubview(imageView)
        self.addSubview(messageLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.centerY.equalTo(self)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(2)
            make.centerY.equalTo(self)
        }
    }
    
    // MARK: public
    
    func showWithMessage(message: String) {
        if  message != "" {
            messageLabel.text = message
            show()
            layoutIfNeeded()
        }
    }
    
    // MARK: private
    
    private func show() {
        self.alpha = 1.0
        addAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss()
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.35) {
            self.alpha = 0
        }
    }
    
    private func addAnimation() {
        UIImpactFeedbackGenerator().impactOccurred()

        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        rotationAnimation.duration = 0.1
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 10.0
        rotationAnimation.repeatCount = 2
        rotationAnimation.autoreverses = true
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

    // MARK: 懒加载
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error_tip")
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hexString: "#999999")
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()

}
