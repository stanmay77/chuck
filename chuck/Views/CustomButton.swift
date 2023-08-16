import UIKit


final class CustomButton: UIButton {
    
    typealias Action = (()->Void)
    let action: Action
    let buttonTitle: String
    let titleColor: UIColor
    
    
    init(frame: CGRect, buttonTitle: String, titleColor: UIColor, action: @escaping Action) {
        self.action = action
        self.buttonTitle = buttonTitle
        self.titleColor = titleColor
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        self.setTitle(buttonTitle, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        
        self.layer.borderColor = UIColor.link.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        self.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        self.setBackgroundImage(UIImage(named: "blue_pixel")!.image(alpha: 0.8), for: .selected)
        self.setBackgroundImage(UIImage(named: "blue_pixel")!.image(alpha: 0.8), for: .highlighted)
        self.setBackgroundImage(UIImage(named: "blue_pixel")!.image(alpha: 0.8), for: .disabled)
        self.clipsToBounds = true
    }
    
    @objc func clickAction() {
        action()
    }
    
    
}
