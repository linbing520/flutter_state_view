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
        
快捷使用方法：<br/>
//初始化
        
    StateView page;
    
    page = Column(
      mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'You have pushed the button this many times11:',
      ),
      Text(
        '$_counter',
        style: Theme.of(context).textTheme.headline4,
      ),
    ],
    ).center().pageState();

//改变状态：
  
    page.pageStateLoading("加载中...");
    Future.delayed(Duration(seconds: 3)).then((value) {
      page.configErrorImage('imgs/empty.png');
      page.pageStateErrorWithRetry("出错了！",(iserror)=>{
        this._incrementCounter()
      });
    }); 
    


    
        
效果图如下：<br/>
![image](https://img-blog.csdnimg.cn/20200701170651627.jpg)
![image](https://img-blog.csdnimg.cn/20200701170651704.jpg)
![image](https://img-blog.csdnimg.cn/20200701170651697.jpg)
## Getting Started
