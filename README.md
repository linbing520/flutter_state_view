# flutter_state_view
flutter state view with loading，empty，error show 
<br/>

使用方法：<br/>

        
        StateView(
          state: state,
          loadingLabel:'加载中...',
          emptyLabel: '空空如也',
          errorLabel: '我错了',
          onRetry: this.onRetry,
          child: Text('成功页面！'),
        ),
        
效果图如下：<br/>
![image](https://img-blog.csdnimg.cn/20200701170651627.jpg)
![image](https://img-blog.csdnimg.cn/20200701170651704.jpg)
![image](https://img-blog.csdnimg.cn/20200701170651697.jpg)
## Getting Started
