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

//设置偏移量
- (void)setOffset {
  self.taBarItem.redDotOffset = CGPointMake(5, 10);
}

//设置小红点半径
- (void)setRadius {
  self.taBarItem.redDotRadius = 10;
}

//设置小红点颜色
- (void)setColor {
self.taBarItem.redDotColor = [UIColor redColor];
}

//使用自定义view显示在小红点位置
- (void)setCustomView {
  self.taBarItem.customView = ....;
}
```
