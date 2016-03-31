# UITabBarItem-GJRedDot
通过系统原生UITabBarItem添加小红点功能
```objective-c
//VC中的方法
- (void)methodVC {
  //self就是VC
  self.tabBarItem.isShowRedDot = YES;
}

//通过tabBar的items获取item来设置
- (void)methodTabBar {
  self.tabBarController.tabBar.items[1].isShowRedDot = YES;
}
```
