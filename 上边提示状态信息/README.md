# LSLStatusBarHUD
一个非常实用的状态信息提示框架！

### 使用时非常的简单，只需导入头文件即可
```objc
#import "LSLStatusBarHUD.h"
```
### 成功信息提示方式
```objc
  // 方式一
  [LSLStatusBarHUD showImage:[UIImage imageNamed:@"xxx"] text:@"加载成功！"];
  
  // 方式二
  [LSLStatusBarHUD showImageName:@"xxx" text:@"加载成功！"];
  
  // 方式三
  [LSLStatusBarHUD showSuccess:@"加载成功！"];
```

### 失败信息提示方式
```objc
  [LSLStatusBarHUD showError:@"加载失败！"];
```

### 加载中信息提示方式
```objc
  [LSLStatusBarHUD showLoadding:@"正在加载中"];
```
### 隐藏信息提示框

```objc
  [LSLStatusBarHUD hide];
```

### 文字信息提示方式
```objc
  [LSLStatusBarHUD showText:@"明天会更好！"];
```

![](https://github.com/SilongLi/LSLStatusBarHUD/raw/master/LSLStatusBarHUDDemo/Logo/LSLStatusBarHUD.gif)  


