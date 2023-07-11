//
//  TZWCollectionPageView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/11.
//

import UIKit
import ObjectiveC

private var UIViewReuseIdentifier: UInt8 = 0
private var UIViewIsInScreen: UInt8 = 0

class TZWCollectionPageView: UIView {
    public var delegate: TZWCollectionPageViewDelegate?
    public var dataSource: TZWCollectionPageViewDataSource? {
        didSet {
            totalCount = self.dataSource?.numberOfSection(pageView: self)

        }
    }

    var totalCount: Int? {
        didSet {
            mainScrollView.contentSize = CGSizeMake(CGFloat(totalCount ?? 0) * self.frame.size.width, 0)
        }
    }
    var lastContentOffset: CGFloat = 0.0
    var currentView: UIView?
    var currentIndex: Int?
    var reUseViewArray: Array<Any>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    deinit {
        mainScrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    func setUI() {
        self.addSubview(mainScrollView)
        
        mainScrollView.addObserver(self, forKeyPath: "contentOffset",options: .new, context: nil)
    }
    
    
    // MARK: public
    
    func moveToIndex(index: Int, animation: Bool) {
        if animation {
            
        } else {
            lastContentOffset = CGFloat(index) * CGFloat(self.frame.size.width)
        }
        
        if lastContentOffset == mainScrollView.contentOffset.x {
            let firstView = checkDataSourceView(index: index)
            if !checkIsExistInCache(view: firstView) {
                currentView = firstView
                mainScrollView.addSubview(firstView)
                reUseViewArray?.append(firstView)
            }
            endChangeIndex()

        } else {
            mainScrollView.contentOffset = CGPointMake(CGFloat(index)*self.frame.size.width, 0)
        }
        let nextIndex = index + 1
        if nextIndex < totalCount ?? 0 {
            let nextCurrentView: UIView = checkDataSourceView(index: nextIndex)
            if !checkIsExistInCache(view: nextCurrentView) {
                reUseViewArray?.append(nextCurrentView)
                mainScrollView.addSubview(nextCurrentView)
            } else {
                if nextCurrentView.isInScreen == "0" {
                    mainScrollView.addSubview(nextCurrentView)
                }
            }
        }
    }
    
    func dequeueReuserView(identifier: String) -> UIView? {
        if let list = reUseViewArray {
            for view in list {
                let reView = view as? UIView
                guard reView?.reuserIdentifier != identifier else {
                    return reView
                }
            }
        }
        return nil
    }
    
    // MARK: private
    
   private func checkDataSourceView(index: Int) -> UIView {
        let view: UIView = self.dataSource?.pageView(pageView: self, index: index) ?? UIView()
        view.frame = CGRectMake(CGFloat(index) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)
        return view
    }
    
    private func checkIsExistInCache(view: UIView) -> Bool {
        var isExits = false
        
        if let list = reUseViewArray {
            for reUseView in list {
                let cacheView = reUseView as? UIView
                if cacheView?.reuserIdentifier == view.reuserIdentifier {
                    isExits = true
                }
            }
        }
        return isExits
    }
    
    private func endChangeIndex() {
        removeOutSideView()
    }
    
    private func removeOutSideView() {
        if let list = reUseViewArray {
            for listView in list {
                let view = listView as? UIView
                if viewIsInScreen(frame: view!.frame) {
                    view?.isInScreen = "1"
                } else {
                    view?.isInScreen = "0"
                    view?.removeFromSuperview()
                }
            }
        }
    }
    
    private func viewIsInScreen(frame: CGRect) -> Bool {
        let x = frame.origin.x
        let screenWidth = mainScrollView.frame.size.width
        
        let contentOffsetX = mainScrollView.contentOffset.x
        if CGRectGetMaxX(frame) > contentOffsetX && (x - contentOffsetX) < screenWidth {
            return true
        } else {
            return false
        }
    }
    
    // MARK: 懒加载
    
    lazy var mainScrollView: TZWScrollView = {
        let scrollView = TZWScrollView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
}

protocol TZWCollectionPageViewDataSource {
    func numberOfSection(pageView: TZWCollectionPageView) -> Int
    func pageView(pageView: TZWCollectionPageView, index: Int) -> UIView?
}

protocol TZWCollectionPageViewDelegate {
    func pageView(pageView: TZWCollectionPageView, direction: String)
}

extension TZWCollectionPageView: UIScrollViewDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
          if keyPath == "contentOffset" {
//              // 处理 contentOffset 的变化
//
//              var index = mainScrollView.contentOffset.x / self.frame.size.width
//
//              if lastContentOffset < mainScrollView.contentOffset.x {
//                  if index * self.frame.size.width != mainScrollView.contentOffset.x {
//                      index = index + 1
//                  }
//              }
//
//              guard CGFloat((totalCount ?? 0)) > index else {
//                  return
//              }
//
//             let view = checkDataSourceView(index: Int(index))
//              currentView = view
//
//              guard currentView?.reuserIdentifier != nil else {
//                  return
//              }
//
//              if checkIsExistInCache(view: view) {
//                  if currentView?.isInScreen == "0" {
//                      mainScrollView.addSubview(view)
//                  }
//              } else {
//                  reUseViewArray?.append(view)
//                  mainScrollView.addSubview(view)
//              }
//
//              let nextIndex = index + 1
//              if nextIndex < CGFloat(totalCount!) {
//                  let nextView = checkDataSourceView(index: Int(nextIndex))
//                  guard nextView.reuserIdentifier != nil else {
//                      return
//                  }
//
//                  if checkIsExistInCache(view: nextView) {
//                      if nextView.isInScreen == "0" {
//                          mainScrollView.addSubview(nextView)
//                      }
//                  } else {
//                      reUseViewArray?.append(nextView)
//                      mainScrollView.addSubview(nextView);
//                  }
//              }
          }
      }
    // MARK: scrollView 协议
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var direction = "向左"
        if lastContentOffset > scrollView.contentOffset.x {
            direction = "向右"
        }
        delegate?.pageView(pageView: self, direction: direction)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x/self.frame.size.width)
        currentView = checkDataSourceView(index: currentIndex!)
    }

}

extension UIView {
    var reuserIdentifier: String? {
        set {
            objc_setAssociatedObject(self, &UIViewReuseIdentifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &UIViewReuseIdentifier) as? String
        }
    }
    
    var isInScreen: String? {
        set {
            objc_setAssociatedObject(self, &UIViewIsInScreen, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &UIViewIsInScreen) as? String
        }
    }
}
