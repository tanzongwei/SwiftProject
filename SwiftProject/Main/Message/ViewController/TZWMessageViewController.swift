//
//  TZWMessageViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWMessageViewController: TZWBaseViewController,HideNavigationBarProtocol {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard TZWUser.isLogin() else {
            TZWLoginPage.share.showLogin()
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        setUI()
        
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(pageTopView)
        view.addSubview(pageCollectionView)
        pageCollectionView.moveToIndex(index: 0, animation: false)
    }
    
    // MARK: 通知处理
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didPressLoginBack), name: Notification.Name(rawValue: TZWClickLoginBackName), object: nil)
    }
    
    @objc func didPressLoginBack() {
        if let array = navigationController?.viewControllers {
            for viewController in array {
                if viewController.isKind(of: TZWMessageViewController.self) {
                    self.tabBarController?.selectedIndex = 1
                }
            }
        }

    }
    
    // MARK: 懒加载
    
    lazy var pageTopView: TZWMessageTopPageView = {
        let pageView = TZWMessageTopPageView(frame: CGRectMake(0, SL_SAFE_AREA_INSETS_TOP, SL_SCREEN_WIDTH, 44))
        pageView.delegate = self
        return pageView
    }()
    
    lazy var pageCollectionView: TZWCollectionPageView = {
        let collectionView = TZWCollectionPageView(frame: CGRectMake(0, pageTopView.bottom, SL_SCREEN_WIDTH, SL_SCREEN_HEIGHT - pageTopView.bottom))
        collectionView.dataSource = self
        return collectionView
    }()

}

extension TZWMessageViewController: TZWCollectionPageViewDataSource, TZWMessageTopPageViewDelegate {
    
    func numberOfSection(pageView: TZWCollectionPageView) -> Int {
        return 3
    }
    
    func pageView(pageView: TZWCollectionPageView, index: Int) -> UIView? {
        if index >= 3 {
            return nil
        }
        
        let contentView = TZWMessageContentView(frame: self.pageCollectionView.bounds)
        if ((index % 2) != 0) {
            contentView.backgroundColor = UIColor.blue
        } else {
            contentView.backgroundColor = UIColor.green
        }
        return contentView
        
    }
    
    
    func clickTopPage(itemModel: TZWMessageTopItemModel) {
        self.pageCollectionView.moveToIndex(index: itemModel.index!, animation: false)
    }
}
