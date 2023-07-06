//
//  TZWMineViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWMineViewController: TZWBaseViewController,HideNavigationBarProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.showLogin(isLogin: true)
        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(contentView)
        contentView.addSubview(scrollView)
        contentView.addSubview(bgImageView)
        contentView.addSubview(topView)
        contentView.addSubview(infoView)

    }

    // MARK:懒加载
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: SL_SCREEN_BOUNDS)
        return contentView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: SL_SCREEN_BOUNDS)
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: SL_SCREEN_BOUNDS)
        imageView.backgroundColor = UIColor.init(hexString: "#000000", alpha: 0.3)
        return imageView
    }()
    
    lazy var topView: TZWMineTopView = {
        let topView = TZWMineTopView(frame: CGRectMake(0, 0, SL_SCREEN_WIDTH, 44 + SL_SAFE_AREA_INSETS_TOP))
        return topView
    }()
    
    lazy var infoView: TZWMineInfoView = {
        let infoView = TZWMineInfoView(frame: CGRectMake(0, SL_SAFE_AREA_INSETS_TOP, SL_SCREEN_WIDTH, 320))
        return infoView
    }()

}
