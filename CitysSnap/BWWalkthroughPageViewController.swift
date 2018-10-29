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
var showAllCat=false
public enum WalkthroughAnimationType:String{
    case Linear = "Linear"
    case Curve = "Curve"
    case Zoom = "Zoom"
    case InOut = "InOut"
    
    init(_ name:String){
        
        if let tempSelf = WalkthroughAnimationType(rawValue: name){
            self = tempSelf
        }else{
            self = .Linear
        }
    }
}

open class BWWalkthroughPageViewController: UIViewController, BWWalkthroughPage {
    private var animation:WalkthroughAnimationType = .Linear
    private var subviewsSpeed:[CGPoint] = Array()
    private var notAnimatableViews:[Int] = [] // Array of views' tags that should not be animated during the scroll/transition
    
 
    @IBInspectable var speed:CGPoint = CGPoint(x: 0.0, y: 0.0);            // Note if you set this value via Attribute inspector it can only be an Integer (change it manually via User defined runtime attribute if you need a Float)
    @IBInspectable var speedVariance:CGPoint = CGPoint(x: 0.0, y: 0.0)     // Note if you set this value via Attribute inspector it can only be an Integer (change it manually via User defined runtime attribute if you need a Float)
    @IBInspectable var animationType:String {
        set(value){
            self.animation = WalkthroughAnimationType(rawValue: value)!
        }
        get{
            return self.animation.rawValue
        }
    }
    @IBInspectable var animateAlpha:Bool = false
    @IBInspectable var staticTags:String {                                
        set(value){
            self.notAnimatableViews = value.components(separatedBy: ",").map{Int($0)!}
        }
        get{
            return notAnimatableViews.map{String($0)}.joined(separator: ",")
        }
    }
    
    // MARK: BWWalkthroughPage Implementation
    @IBOutlet var button1Outlet: UIButton!
    @IBOutlet var button2Outlet: UIButton!
    @IBOutlet var button3Outlet: UIButton!
    @IBOutlet var button4Outlet: UIButton!
    @IBOutlet var button5Outlet: UIButton!
    @IBOutlet var button6Outlet: UIButton!
    @IBOutlet var button7Outlet: UIButton!
    @IBOutlet weak var imageBackground: UIImageView!
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.masksToBounds = true
        subviewsSpeed = Array()
        let blurrEffect=UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurrView = UIVisualEffectView(effect: blurrEffect)
        
        blurrView.frame.size = CGSize(width: 800, height: 800)
        blurrView.center = view.center
        view.addSubview(blurrView)
        view.sendSubview(toBack: blurrView)
//        imageBackground.image=image
        //self.containerView.bringSubview(toFront:yellowView)
       
//        view.superview?.bringSubview(toFront: button1Outlet)
//        view.superview?.bringSubview(toFront: button2Outlet)
//        view.superview?.bringSubview(toFront: button3Outlet)
//        view.superview?.bringSubview(toFront: button4Outlet)
//        view.superview?.bringSubview(toFront: button5Outlet)
//        view.superview?.bringSubview(toFront: button6Outlet)
//        view.superview?.bringSubview(toFront: button7Outlet)
 
        
        for v in view.subviews{
            speed.x += speedVariance.x
            speed.y += speedVariance.y
            if !notAnimatableViews.contains(v.tag) {
                subviewsSpeed.append(speed)
            }
        }
    }
   
    
    @IBAction func button1(_ sender: Any) {
        
//        button2Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button6Outlet.isHidden = true
//        button7Outlet.isHidden = true
//        
        print("button 1 is clicked")
    }
    @IBAction func button2(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button6Outlet.isHidden = true
//        button7Outlet.isHidden = true
        performSegue(withIdentifier: "showLitter", sender: self)
        print("xzzzzxzxzxzxzxzxzxz")
    }
    @IBAction func button3(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button2Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button6Outlet.isHidden = true
//        button7Outlet.isHidden = true
    }
    @IBAction func button4(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button2Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button6Outlet.isHidden = true
//        button7Outlet.isHidden = true
    }
    @IBAction func button5(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button2Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button6Outlet.isHidden = true
//        button7Outlet.isHidden = true
    }
    @IBAction func button6(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button2Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button7Outlet.isHidden = true
    }
    @IBAction func button7(_ sender: Any) {
//        button1Outlet.isHidden = true
//        button2Outlet.isHidden = true
//        button3Outlet.isHidden = true
//        button4Outlet.isHidden = true
//        button5Outlet.isHidden = true
//        button6Outlet.isHidden = true
    }
    
    open func walkthroughDidScroll(to: CGFloat, offset: CGFloat) {
        
        for i in 0 ..< subviewsSpeed.count{
            
            // Perform animations
            switch animation{
                
            case .Linear:
                animationLinear(i, offset)
                
            case .Zoom:
                animationZoom(i, offset)
                
            case .Curve:
                animationCurve(i, offset)
                
            case .InOut:
                animationInOut(i, offset)
            }
            
            // Animate alpha
            if(animateAlpha){
                animationAlpha(i, offset)
            }
        }
    }


    // MARK: Animations
    
    private func animationAlpha(_ index:Int, _ offset:CGFloat) {
        let cView = view.subviews[index]
        var mutableOffset = offset
        if(mutableOffset > 1.0){
            mutableOffset = 1.0 + (1.0 - mutableOffset)
        }
        cView.alpha = (mutableOffset)
    }
    
    private func animationCurve(_ index:Int, _ offset:CGFloat) {
        var transform = CATransform3DIdentity
        let x:CGFloat = (1.0 - offset) * 10
        transform = CATransform3DTranslate(transform, (pow(x,3) - (x * 25)) * subviewsSpeed[index].x, (pow(x,3) - (x * 20)) * subviewsSpeed[index].y, 0 )
        applyTransform(index, transform: transform)
    }
    
    private func animationZoom(_ index:Int, _ offset:CGFloat){
        var transform = CATransform3DIdentity

        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        let scale:CGFloat = (1.0 - tmpOffset)
        transform = CATransform3DScale(transform, 1 - scale , 1 - scale, 1.0)
        applyTransform(index, transform: transform)
    }
    
    private func animationLinear(_ index:Int, _ offset:CGFloat) {
        var transform = CATransform3DIdentity
        let mx:CGFloat = (1.0 - offset) * 100
        transform = CATransform3DTranslate(transform, mx * subviewsSpeed[index].x, mx * subviewsSpeed[index].y, 0 )
        applyTransform(index, transform: transform)
    }
    
    private func animationInOut(_ index:Int, _ offset:CGFloat) {
        var transform = CATransform3DIdentity
        
        var tmpOffset = offset
        if(tmpOffset > 1.0){
            tmpOffset = 1.0 + (1.0 - tmpOffset)
        }
        transform = CATransform3DTranslate(transform, (1.0 - tmpOffset) * subviewsSpeed[index].x * 100, (1.0 - tmpOffset) * subviewsSpeed[index].y * 100, 0)
        applyTransform(index, transform: transform)
    }
    
    private func applyTransform(_ index:Int, transform:CATransform3D){
        let subview = view.subviews[index]
        if !notAnimatableViews.contains(subview.tag){
            view.subviews[index].layer.transform = transform
        }
    }
}
