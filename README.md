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
媒体时间的使用，就是用于媒体的，例如，动画上的使用；
属性动画类，是通过属性来改变的动画
基础动画是继承属性动画
关键帧动画继承属性动画
