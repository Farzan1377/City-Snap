/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Yari D'areglia @bitwaker
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
import UIKit


@objc public protocol BWWalkthroughViewControllerDelegate{
    
    @objc optional func walkthroughCloseButtonPressed()              // If the skipRequest(sender:) action is connected to a button, this function is called when that button is pressed.
    @objc optional func walkthroughNextButtonPressed()               // Called when the "next page" button is pressed
    @objc optional func walkthroughPrevButtonPressed()               // Called when the "previous page" button is pressed
    @objc optional func walkthroughPageDidChange(_ pageNumber:Int)   // Called when current page changes
}


@objc public protocol BWWalkthroughPage{
    @objc func walkthroughDidScroll(to:CGFloat, offset:CGFloat)   // Called when the main Scrollview...scrolls
}


@objc open class BWWalkthroughViewController: UIViewController, UIScrollViewDelegate{
    
    
    weak open var delegate:BWWalkthroughViewControllerDelegate?
    
    @IBOutlet open var pageControl:UIPageControl?
    @IBOutlet open var nextButton:UIButton?
    @IBOutlet open var prevButton:UIButton?
    @IBOutlet open var closeButton:UIButton?
    
    open var currentPage: Int {    // The index of the current page (readonly)
        get{
            let page = Int((scrollview.contentOffset.x / view.bounds.size.width))
            return page
        }
    }
    
    open var currentViewController:UIViewController{ //the controller for the currently visible page
        get{
            let currentPage = self.currentPage;
            return controllers[currentPage];
        }
    }
    
    open var numberOfPages:Int{ //the total number of pages in the walkthrough
        get {
            return self.controllers.count
        }
    }
    
    
    // MARK: - Private properties -
    
    open let scrollview = UIScrollView()
    private var controllers = [UIViewController]()
    private var lastViewConstraint: [NSLayoutConstraint]?
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        // Setup the scrollview
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.isPagingEnabled = true
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    var image: UIImage?

    override open func viewDidLoad() {
        super.viewDidLoad()
       
        //imageView.image = image
       
        // Initialize UI Elements
        
        pageControl?.addTarget(self, action: #selector(BWWalkthroughViewController.pageControlDidTouch), for: UIControlEvents.touchUpInside)
        
        // Scrollview
        
        scrollview.delegate = self
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(scrollview, at: 0) //scrollview is inserted as first view of the hierarchy
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollview]-0-|", options:[], metrics: nil, views: ["scrollview":scrollview] as [String: UIView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollview]-0-|", options:[], metrics: nil, views: ["scrollview":scrollview] as [String: UIView]))
        
    }
    
    
    
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        updateUI()
        
        pageControl?.numberOfPages = controllers.count
        pageControl?.currentPage = 0
    }
    
    
    
    @IBAction open func nextPage(){
        if (currentPage + 1) < controllers.count {

            delegate?.walkthroughNextButtonPressed?()
            gotoPage(currentPage + 1)
        }
    }

    @IBAction open func prevPage(){
        if currentPage > 0 {

            delegate?.walkthroughPrevButtonPressed?()
            gotoPage(currentPage - 1)
        }
    }
    
    @IBAction open func close(_ sender: AnyObject) {
        delegate?.walkthroughCloseButtonPressed?()
    }
    
    @objc func pageControlDidTouch(){
        if let pc = pageControl{
            gotoPage(pc.currentPage)
        }
    }
    
    fileprivate func gotoPage(_ page:Int){
        
        if page < controllers.count{
            var frame = scrollview.frame
            frame.origin.x = CGFloat(page) * frame.size.width
            scrollview.scrollRectToVisible(frame, animated: true)
        }
    }
    
    open func add(viewController:UIViewController)->Void{
        
        controllers.append(viewController)
        
        
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
        

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollview.addSubview(viewController.view)
        
        
        let metricDict = ["w":viewController.view.bounds.size.width,"h":viewController.view.bounds.size.height]
        
        let viewsDict: [String: UIView] = ["view":viewController.view, "container": scrollview]
        
        scrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view(==container)]", options:[], metrics: metricDict, views: viewsDict))
        scrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==container)]", options:[], metrics: metricDict, views: viewsDict))
        scrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]|", options:[], metrics: nil, views: viewsDict))
        
        if controllers.count == 1{
            scrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]", options:[], metrics: nil, views: ["view":viewController.view]))
        
        } else {
            
            let previousVC = controllers[controllers.count-2]
            if let previousView = previousVC.view {
                scrollview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[previousView]-0-[view]", options:[], metrics: nil, views: ["previousView":previousView,"view":viewController.view]))
            }
            
            if let cst = lastViewConstraint {
                scrollview.removeConstraints(cst)
            }
            lastViewConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-0-|", options:[], metrics: nil, views: ["view":viewController.view])
            scrollview.addConstraints(lastViewConstraint!)
        }
    }

    fileprivate func updateUI(){
        
        pageControl?.currentPage = currentPage
        delegate?.walkthroughPageDidChange?(currentPage)
        
        if currentPage == controllers.count - 1{
            nextButton?.isHidden = true
        }else{
            nextButton?.isHidden = false
        }
        
        if currentPage == 0{
            prevButton?.isHidden = true
        }else{
            prevButton?.isHidden = false
        }
    }
    
    
    open func scrollViewDidScroll(_ sv: UIScrollView) {
        
        for i in 0 ..< controllers.count {
            
            if let vc = controllers[i] as? BWWalkthroughPage{
            
                let mx = ((scrollview.contentOffset.x + view.bounds.size.width) - (view.bounds.size.width * CGFloat(i))) / view.bounds.size.width
                
                if(mx < 2 && mx > -2.0){
                    vc.walkthroughDidScroll(to:scrollview.contentOffset.x, offset: mx)
                }
            }
        }
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateUI()
    }
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateUI()
    }
    
    fileprivate func adjustOffsetForTransition() {
        
        let currentPage = self.currentPage
        
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * 0.1 )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            [weak self] in
            self?.gotoPage(currentPage)
        }
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        adjustOffsetForTransition()
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        adjustOffsetForTransition()
    }
    
}


