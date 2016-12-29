第三方# iOSMultiplexing 主要是存放一下在项目用用到过的一些组件以及所涉及到的第三方库（使用记录）

AES ： 主要是关于iOS上的AES加密的使用，（AES单秘钥对称加密）

protobuf：主要是使用google的第三方库protobuf来进行传递数据；[教程]（http://www.jianshu.com/p/4741a75997c9 ）

NSMutableData+Helper ： 主要是关于在开发IM的时候，使用二进制进行传输，这个过程需要将本地编码转化为网络上的编码（涉及到字节序的（大端、小端））

CALayer/CAShapeLayer ： 关于ShapeLayer 的一个mask view的使用，用于掩界面的实现。运行的结果如下：
![CAShapeLayer实现mask view结果](https://github.com/helinyu/iOSMultiplexing/blob/master/CALayer/CAShapeLayer/CAShapeLayer/Snip20161227_1.png)

AnimationLayerView：这个类是关于基础动画的内容平移、拉伸（有待实现）等基础动画
translatonAnimationChanged(method)【这个是因为代理方法stop在隐式动画执行之后】这方法就是用来处理平移之后动画回到起点的到终点的问题（不过好像有问题）怎么处理？涉及到CATransaction
[一种替代的方法：就是移动结束（经过时间）就删除这个layer，然后在代理方法stop中重新添加这个layer]这里涉及到layer（主要）、一点动画、CATransaction（隐式和显示动画）

BasicAnimationView 这里面主要是关于BasicAnimation的动画

媒体时间的使用，就是用于媒体的，例如，动画上的使用;

属性动画类，是通过属性来改变属性的动画

CAPropertyAnimation： 属性动画（基础动画和关键动画都是继承属性动画）

CABasicAnimation： 基础动画只是增加了起点、经过点、终点

CFTimeInterval ： 媒体时间的使用

CAValueFunction : 应该是一个值行为（也就是值的属性决定的行为）
![动画之间的关系](https://github.com/helinyu/iOSMultiplexing/blob/master/CALayer/CAShapeLayer/CAShapeLayer/Snip20161229_2.png)

SpringAimationView : 这个类是关于弹簧动画的类；

testUIViewAnimaiton：笔记还记录了关于UIView上的一些动画，就是UIView上的一些简单初步的动画是可以在View上直接就实现了的。

GroupAnimationView : 关于组动画，就是讲基础动画或者关键动画添加到animations里面，就形成了组动画。

TransitionView: 转场动画，可以用于实现轮播图片转场的时候的结果。
PS: 上面的方法其实可以分为两类：将组合动画规划到属性动画中。
FrameByFrameAnimationView： 这个类是关于逐帧动画的内容；CADisplayink ，这个动画是实现了和主队列上懂不，消耗的资源比较多。在视频处理方面需要垂直同步的时候可以使用这种方式（尽量不用这个类）
