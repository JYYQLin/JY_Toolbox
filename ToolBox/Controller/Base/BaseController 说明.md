
//  JY_Enum_BaseController_Status
    - 预设的控制器状态:
        1. yq_default: 默认状态
        2. yq_loading: 首次加载请求状态, 显示加载动画
        3. yq_data_loaded: 控制器已经加载了数据, 跟yq_default其实差不多
        4. yq_show_status: 控制器显示状态


//  JY_Base_Controller: 说明
封装了几个控件, 方便开发
1. yq_content_view: 控制器显示的内容控件, 将控制器加载后需要显示的内容都放进这里, 方便统一控制.
    a.只有在控制器的JY_Enum_BaseController_Status 为 yq_default || yq_data_loaded 才会显示, 默认大小与控制器View系统

2. yq_background_content_view: 层级在之下, 用于显示控制器的背景图/背景色, 控件任何状态下都会显示
    a. 可以通过在Assets资源中添加 yq_baseController_bgColor 颜色统一设置控制器的背景色
    b. 如果有背景相关的控件, 都放在 yq_background_content_view 中 方便统一管理

3. yq_request_loading_view: 控制器加载时, 显示的loadingview动画, 只有在控制器状态为 yq_first_request 才会显示, 与yq_content_view 显示互斥
    a. 将加载动画的view放到yq_request_loading_view中

4. yq_status_view: 详见 JY_Status_View 描述, 与yq_content_view 显示互斥

5. yq_left_tap_view: 层级最高, 控制器左侧的一个高度与控制器View系统,宽度5的控件
    a. 用于阻止yq_content_view的手势事件, 只要为了防止有scrollView, collectionView存在左滑情况下, 导航控制器的滑动返回失效.
    b. 放弃控制器左侧5像素的任何点击事件, 正常人不会非要点击那么点范围 手指那么粗, 放弃了没什么影响, 还能保证滑动返回不容易出现冲突

6. yq_retry_request_click():
a. 请求数据的方法通过重写这个方法来统一控制, 调用这个方法时, yq_controller_status = .yq_first_request 显示加载动画, 数据加载完成后, 记得手动设置 yq_controller_status = .yq_data_loaded, 显示yq_content_view

7. yq_setInterface() / yq_setNavigationBar():
    a. 当控制器的viewDidLoad()方法调用时, 会先调用 yq_setInterface()方法 在调用yq_setNavigationBar()
    b. 重写yq_setInterface()方法 , 在里面将内容控件添加到 yq_content_view中
    c. 重写yq_setNavigationBar()方法 , 对导航条进行设置, 所有层级需要高于 yq_content_view 的控件, 都在yq_setNavigationBar() 中添加 到控制器的view里, 例如自定义的导航条
    d. 当控制器调用viewWillLayoutSubviews()方法时, 会调用yq_setSubviewsFrame(), 重写yq_setSubviewsFrame() , 将自定义的所有子控件都在这里设置frame, 保证设备横竖屏切换 / 平板分屏操作时, 控件都能相应变化frame,

