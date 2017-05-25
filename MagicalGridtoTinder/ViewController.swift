//
//  ViewController.swift
//  MagicalGridtoTinder
//
//  Created by 陳囿豪 on 2017/4/21.
//  Copyright © 2017年 yasuoyuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numViewPerRow = 14
    var cells = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...30 {
            
            for i in 0...numViewPerRow {
                
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width + 20, width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor

                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
    }
    
    var selectedCell : UIView? = nil
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: view)
//        print(location)
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        let key = "\(i)|\(j)"
//        cellView?.backgroundColor = .black
        
//        print(i , j)
//        for subview in view.subviews {
//            if subview.frame.contains(location) {
//                subview.backgroundColor = .black
//            }
//        }

        guard let cellView = cells[key] else { return }
        cellView.isHidden = false
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        
        view.bringSubview(toFront: cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            
        }, completion: { (_) in
        })
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
            })
        }
        
        
    }
    
    fileprivate func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

