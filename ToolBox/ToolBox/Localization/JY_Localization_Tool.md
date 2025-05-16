
    
//  调用方法:
    已经给String添加分类, 字符串直接调用yq_localized方法
    参数说明:
        tableName: 本地化表名
        languageType: 预设的语言, 
        languageRawValue: 如果预设语言没包括所需要的语言, 这自己传入language表的真是名. 优先级大于languageType
    


// JY_Localization_Tool: 
    - 单例获取: yq_localized_manager
    
    作用: 
    1. 通过单例设置当前软件语言
    2. 类方法: yq_language_string根据预设的语言, 返回语言对应的名称
    
    

//  JY_Enum_Language 枚举:
    预设一些语言, 枚举真实值就是语言的值
    

