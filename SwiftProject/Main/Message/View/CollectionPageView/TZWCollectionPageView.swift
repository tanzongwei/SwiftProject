//
//  TZWCollectionPageView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/11.
//

import UIKit

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
            let fistView = checkDataSourceView(nextIndex: index)
            currentView = fistView
            mainScrollView.addSubview(fistView)
        } else {
            mainScrollView.contentOffset = CGPointMake(CGFloat(index)*self.frame.size.width, 0)
        }
        let nextIndex = index + 1
        if nextIndex < totalCount ?? 0 {
            let nextCurrentView: UIView = checkDataSourceView(nextIndex: nextIndex)
            mainScrollView.addSubview(nextCurrentView)
        }
    }
    
    // MARK: private
    
    func checkDataSourceView(nextIndex: Int) -> UIView {
        let view: UIView = self.dataSource?.pageView(pageView: self, index: nextIndex) ?? UIView()
        view.frame = CGRectMake(CGFloat(nextIndex) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)
        return view
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
              // 处理 contentOffset 的变化
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
        currentView = checkDataSourceView(nextIndex: currentIndex!)
    }

}
