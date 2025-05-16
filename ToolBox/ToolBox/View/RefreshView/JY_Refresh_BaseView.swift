//
//  JY_Refresh_BaseView.swift
//  JY_Refresh_CollectionView
//
//  Created by JYYQLin on 2024/8/21.
//

import UIKit

open class JY_Base_TableViewCell: UITableViewCell {
    
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
        if yq_scale != scale {
            yq_scale = scale
            layoutSubviews()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.isHidden = frame.height < 0.25
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        yq_add_subviews()
    }
    
    @objc dynamic open func yq_add_subviews() { }
    
    public class func yq_ID() -> String {
        let name = ("\(self)" + "\(#function)")
        return name.yq_md5()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

open class JY_Base_CollectionViewCell: UICollectionViewCell {
    
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        yq_add_subviews()
    }
    
    @objc dynamic open func yq_add_subviews() { }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.isHidden = frame.height < 0.25
    }
    
    public class func yq_ID() -> String {
        let name = ("\(self)" + "\(#function)")
        return name.yq_md5()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


open class JY_Base_CollectionReusableView: UICollectionReusableView {

    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        yq_add_subviews()
    }
    
    @objc dynamic open func yq_add_subviews() { }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.isHidden = frame.height < 0.25
    }
    
    public class func yq_ID() -> String {
        let name = ("\(self)" + "\(#function)")
        return name.yq_md5()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

open class JY_Base_TableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public private(set) lazy var yq_scale: CGFloat = 1
    open func yq_set(scale: CGFloat) {
         if yq_scale != scale {
             yq_scale = scale
             layoutSubviews()
         }
     }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        yq_add_subviews()
    }
    
    @objc dynamic open func yq_add_subviews() { }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.isHidden = frame.height < 0.25
    }
    
    public class func yq_ID() -> String {
        let name = ("\(self)" + "\(#function)")
        return name.yq_md5()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
