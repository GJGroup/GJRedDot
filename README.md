# GJRedDot

这是一个小红点的解决方案，你可以方便的使用它去管理你的小红点提示。如有bug或者建议，请提 issue 或 PR，感谢支持。

## 使用场景

我们的项目中，有很多小红点联动的需求，例如上一级页面的小红点受下一级页面小红点的影响，比如微信的“发现——朋友圈”，当朋友圈有新消息时，发现 tab 页面朋友圈 cell 中的 icon 上会有一个小红点，这时发现 tab 的 icon 上也有一个小红点，但是当我们点击“发现 tab“的时候，小红点并不消失，而是点击朋友圈 cell 后，cell 上和“发现 tab”上的小红点同时消失，类似的需求很多 APP 中都可以发现。

最开始我们使用消息中心来实现，后来发现，当小红点级别变多后，代码量几何增长且分散各处，十分混乱，为了解决这个问题，我们将它进行封装。首先用 key 将小红点的进行关联并注册，然后只需在显示小红点的页面设置刷新 block，并在任何需要刷新他的地方调用改变显示状态的方法，只需这三步即可完成。

## 开始

支持 Pod，或手动导入文件夹 GJRedDot：

```bash
pod 'GJRedDot'
```

```objective-c
#import "GJRedDot.h"
```

## 注册

首先，需要在 app launch 中，以小红点对应的 key，通过 NSArray 及 NSDictionary 关联起来，并进行注册（见 Demo)：

```objective-c
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GJRedDot registWithProfile:[GJRedDotRegister registProfiles] defaultShow:YES];//defaultShow为默认状态是展示还是隐藏
    return YES;
}
```

这个例子在 Demo 中：GJTabBar2 是第二个 tabbar 的小红点 Key，它与这个 tab 的 rootVC 中的 icon（GJGroupKey）进行关联，GJGroupKey 又与下一级页面的3个按钮（GJSunnyxxKey，GJUncleBirdKey，GJSardKey）进行关联。最后所实现的功能就是，GJSunnyxxKey，GJUncleBirdKey，GJSardKey 三个按钮中有一个按钮有小红点，则 GJGroupKey，GJTabBar2 上也会显示小红点，如果三个按钮中小红点都消失，则 GJGroupKey，GJTabBar2 上的小红点才会消失。

看着不太明白是吧？下面用伪代码解释一下：

```objective-c
- (BOOL)isShowGJTabBar2 {
    if (GJGroupKey.isShow) return YES;
    return NO
}

- (BOOL)isShowGJGroupKey {
    if(!GJSunnyxxKey.isShow && !GJUncleBirdKey.isShow && !GJSardKey.isShow) return NO;
    return YES;
}
```

是不是清晰点了？

注意：默认注册方法下，是使用 GJRedDotModelUserDefault，将使用Key缓存到 NSUserDefault 中，所以请保证小红点的 Key 与程序中其他地方的 Key 区分开，以防出现问题。

Demo注册代码：

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
                                   //GJSardKey 这里注释掉是为了后面的单独注册的方法，与在这里注册等效
                                   ]
                           }
               }
             ];
}
```

你也可以在需要的时候单独动态注册 Key，在 demo 中也有示例：

```objective-c
[GJRedDot registNodeWithKey:GJSarkKey parentKey:GJGroupKey];
```

## 使用

在需要使用小红点的地方调用如下方法：

```objective-c
//将小红点刷新的callback block绑定到持有小红点的对象上(handler)，当它release的时候，也自动release小红点的刷新block
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

你可以通过 2 个方法把小红点全部置为隐藏或显示状态：

```objective-c
[GJRedDot resetAllNodesBecomeShown];
[GJRedDot resetAllNodesBecomeHidden];
```

你可以在程序开始时统一设置默认的小红点大小和颜色：

```objective-c
[GJRedDot setDefaultRadius:4];
[GJRedDot setDefaultColor:[UIColor orangeColor]];
```

## 通过系统原生 UITabBarItem 添加小红点功能

```objective-c
//VC中的方法
- (void)methodVC {
//self就是VC
    self.tabBarItem.showRedDot = YES;
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

<img src="https://github.com/GJGroup/GJRedDot/blob/master/screenshots/demo.gif" width="375">

## 给以 UIView 为基类的 View 添加小红点及 badge

当设置 badgeValue 后，优先显示 badgeValue，当 badgeValue 为 nil 后，才会根据 showRedDot 来显示小红点：

```objective-c
- (void)setRedDotWithView:(UIView *)view{
    view.showRedDot = YES;
    
    view.redDotRadius = 4.0;
    
    view.redDotOffset = CGPointMake(10, 5);
    
    view.redDotColor = [UIColor BlueColor];
    
    view.redDotBorderWitdh = 1.0;
    
    view.redDotBorderColor = [UIColor yellowColor];
    
    view.badgeValue = @"12345";
    
    view.badgeOffset = CGPointMake(10, 5);
}
```

<img src=https://github.com/GJGroup/GJRedDot/blob/master/screenshots/reddot.png width="375">
