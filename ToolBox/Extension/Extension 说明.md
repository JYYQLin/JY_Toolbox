

//  JY_Extension_Int:
    将Int格式化成字符串: 千转为小数点两位k, 万转为小数点两位w


//  JY_Extension_CommonCrypto: 通用加密
    扩展String类: 提供base64加密 和 md5加密


//  JY_Extension_UIApplication: 

    类方法:
        - yq_bundle_identifier(): 获取当前BundleID
            
        - yq_appVersion(): 获取当前版本号
        
        - yq_push_application_setting(): 跳转应用设置
        
        - yq_request_photo_authorization: 检测相册授权情况


//  JY_Extension_UIColor:

    提供方法: 
        1. 快速红绿蓝透明度 转颜色
        2. 随机色
        3. 16位颜色转rgb
    

//  JY_Extension_UIFont: 
    1. 提供一些常用第三方字体调用方法, 如果没有导入对应字体包, 则返回系统默认字体


//  JY_Extension_UIImage: 
    1. 提供生成纯色图片的方法: yq_generate_image(color: ) 
        图片生成后, 会保存到cache文件夹
        
    2. 提供生成渐变色图片方法: yq_generate_image(colorArray: )
        图片生成后, 会保存到cache文件夹
        
    3. 基础的图片压缩方法: yq_compress_original_image(size: )


//  JY_Extension_UIWindow: 
    1. 提供快速获取当前window方法
