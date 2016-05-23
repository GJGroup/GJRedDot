#GJRedDot
这是一个小红点的解决方案，你可以方便的使用它去管理你的小红点
（目前是Beta版，我们会不断完善，包括小红点UI接口等等）

##Start
将GJRedDot文件夹拷贝到工程中，在使用的地方导入头文件
```bash
#import "GJRedDot.h"
```

##Regist
首先，需要在app launch中，以小红点对应的key，通过NSArray及NSDictionary关联起来，并进行注册（见Demo)
```objective-c
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[GJRedDot registWithProfile:[GJRedDotRegister registProfiles]];
return YES;
}
```
```objective-c
NSString *const GJTabBar2 = @"GJTabBar2";
NSString *const GJGroupKey = @"GJAllGays";
NSString *const GJSunnyxxKey = @"GJSunnyxxIsGay";
NSString *const GJUncleBirdKey = @"GJUncleBird";
NSString *const GJSardKey = @"GJSarkIsGay";

@implementation GJRedDotRegister
+ (NSArray *)registProfiles {
return @[
@{GJTabBar2:@{GJGroupKey:@[
GJSunnyxxKey,
GJUncleBirdKey,
GJSardKey
]
}
}
];
}
```

##Use
在需要使用小红点的地方调用如下方法
```objective-c
//将小红点管理绑定到持有小红点的对象上(handler)，当它release的时候，也自动release小红点的管理
//block是小红点刷新的动作，当有其他与当前key相关联的小红点状态发生变化或自身发生变化时，并影响到当前小红点状态，则进行刷新动作
//这里要使用weakSelf避免循环引用
__weak typeof(self) weakSelf = self;
[self setRedDotKey:GJGroupKey refreshBlock:^(BOOL show) {
weakSelf.gjGroupButton.showRedDot = show;
} handler:self];
```

在需要改变小红点状态的地方调用此方法：
```objective-c
//改变小红点状态，他会自动在上一个方法中刷新小红点，以及刷新想关联的小红点状态
[self resetRedDotState:NO forKey:GJGroupKey];
```

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
<img src="https://github.com/GJGroup/UITabBarItem-GJRedDot/blob/master/demo.gif" width="375">
