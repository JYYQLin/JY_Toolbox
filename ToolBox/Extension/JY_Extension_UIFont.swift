//
//  JY_Extension_UIFont.swift
//  JY_ToolBox
//
//  Created by JYYQLin on 2024/10/13.
//

import UIKit

extension UIFont {
    public static func yq_system_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    public static func yq_medium_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    public static func yq_semibold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_Alimama_ShuHeiTi_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Alimama ShuHeiTi", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    public static func yq_source_KeynoteartHans_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Source-KeynoteartHans", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_din_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "DIN Alternate", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_xi_mai_ti_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "ZiZhiQuXiMaiTi", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_gotham_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Gotham", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_zi_hun_xing_shi_ti_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "zihunxingshiti", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_harmonyOS_Sans_SC_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "HarmonyOS Sans SC", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_arial_rounded_MT_bold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Arial Rounded MT Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_xian_er_ti_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "XianErTi", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_chillax_bold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Chillax-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_chillax_medium_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Chillax-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_chillax_Semibold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Chillax-Semibold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_Roboto_Medium_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Roboto-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    public static func yq_Roboto_Regular_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "Roboto-Regular", size: fontSize) ?? UIFont.init(name: "Roboto", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIFont {
    public static func yq_D_DIN_PRO_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "D-DIN-PRO", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    public static func yq_D_DIN_PRO_Semibold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "D-DIN-PRO-Semibold", size: fontSize) ?? UIFont.yq_D_DIN_PRO_font(fontSize)
    }
    
    public static func yq_D_DIN_PRO_Medium_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "D-DIN-PRO-Medium", size: fontSize) ?? UIFont.yq_D_DIN_PRO_font(fontSize)
    }
        
    public static func yq_D_DIN_PRO_Bold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "D-DIN-PRO-Bold", size: fontSize) ?? UIFont.yq_D_DIN_PRO_font(fontSize)
    }
        
    public static func yq_D_DIN_PRO_ExtraBold_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "D-DIN-PRO-ExtraBold", size: fontSize) ?? UIFont.yq_D_DIN_PRO_font(fontSize)
    }
    
    public static func yq_DIN_Condensed_font(_ fontSize: CGFloat) -> UIFont {
        return UIFont.init(name: "DIN Condensed", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
