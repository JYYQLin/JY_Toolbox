
// 作用: 简单的屏幕比例适配, 设备的一些基础信息

//  JY_Device: 获取设备的一些基础信息
    1. 通过单例yq_current_device调用
    2. 可以快速获取设备的宽高, 导航条Frame 以及 TabBar的frame
        例如:
                yq_current_device.yq_tabBar_height(): Tabbar高度
                yq_current_device.yq_tabBar_height(): 小白条预留高度, 非全面屏设备会返回0
                yq_current_device.yq_navigationBar_height(): 导航条高度
                yq_current_device.yq_statusBar_height(): 状态栏高度
                yq_current_device.yq_navigationBar_maxY(): 导航条总高
        
                
                
//  JY_Extension_UIDevice: JY_Device的补充
    主要关注, yq_supported_device_list()设备列表即可
        当苹果有新设备发布, 根据之前的格式, 添加进新设备的屏幕信息
        
        
//  JY_Extension_UIScreen: 用于屏幕适配
    1. 给UIScreen添加扩展, 快速获取设备当前宽高等基础信息
    2. 屏幕适配:
        适配思路: 
            1. 设计图一般只以一个机型出原型图, 使用yq_scale_to_width方法 传入设计图设备的宽度, 算出当前设备与设计图的缩放比例. 
            2. 由于平板宽度比例过大, 所以通过全局常量yq_max_scale限制了最大缩放比例,防止在平板设备上,界面扩的太大
                            yq_max_scale的取值思路:
                                
                                    /**
                                        最大比例缩放
                                            手机系列最大宽度为
                                                15 pro max的 430
                                            最小宽度为
                                                    375
                                            所以最大缩放比例就是 430 / 375 = 1.14
 
                                            平板最小宽度为
                                                mini 6 的 744
 
                                            所以最小缩放比例就是 768 / 375 = 1.98
 
                                            最后取平均值 = 1.56
 
                                            */
                                            
            3. 给UIView/CGRect/CGFloat都添加了扩展, 方便快速获取缩放比例
                a.可以通过空间 UIView().yq_scale_to_width(originalWidth: 375),
                b.可以通过空间 UIView().frame.yq_scale_to_width(originalWidth: 375),
                c.可以通过空间 UIView().frame.width.yq_scale_to_width(originalWidth: 375)
                
                a/b方法会自动获取控件宽度计算bilibili
