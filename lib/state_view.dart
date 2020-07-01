library flutter_state_view;

import 'package:flutter/material.dart';


typedef RetryCallback = void Function(bool isError);
typedef ErrorViewBuilder = Widget Function();
typedef EmptyViewBuilder = Widget Function();
typedef LoadingViewBuilder = Widget Function();
//四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

///根据不同状态来展示不同的视图
class StateView extends StatefulWidget {

  final LoadState state; //页面状态
  final Widget child;//成功视图
  final RetryCallback onRetry; //重试
  final String errorLabel; //失败的自定义提示
  final String emptyLabel; //空数据的自定义提示
  final String loadingLabel;//加载中的自定义提示

  final String errorImage; //失败的自定义图片提示
  final String emptyImage; //空数据的自定义图片提示

  final LoadingViewBuilder loadingViewBuilder; //自定义加载中
  final EmptyViewBuilder emptyViewBuilder; //自定义空界面
  final ErrorViewBuilder errorViewBuilder; //自定义错误页面


  StateView(
      {Key key,
        this.state = LoadState.State_Success,//默认为成功状态
        this.child,
        this.onRetry,
        this.errorLabel,
        this.emptyLabel,
        this.loadingLabel,
        this.errorImage,
        this.emptyImage,
        this.loadingViewBuilder,
        this.emptyViewBuilder,
        this.errorViewBuilder,
      })
      :
        assert(child != null),
        super(key: key);

  @override
  StateViewState createState() => StateViewState();
}

class StateViewState extends State<StateView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadState.State_Success:
        return widget.child;
        break;
      case LoadState.State_Error:
        return _errorView;
        break;
      case LoadState.State_Loading:
        return _loadingView;
        break;
      case LoadState.State_Empty:
        return _noDataView;
        break;
      default:
        return null;
    }
  }

  _onRetry(isError) {
    if(widget.onRetry == null) {
      return;
    }
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      widget.onRetry(isError);
    });

  }

  _onEmptyRetry() {
    this._onRetry(false);
  }

  _onErrorRetry() {
    this._onRetry(true);
  }

  Widget get _noDataView {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child:
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _onEmptyRetry,
          child: getNoDataView()
      ),
    );
  }

  Widget getNoDataView() {
    if(widget.emptyViewBuilder != null) {
      return widget.emptyViewBuilder();
    }
    var label = '暂无相关数据,轻触重试~';
    var assetImage = 'imgs/empty.png';
    if(widget.emptyLabel != null) {
      label = widget.emptyLabel;
    }
    if(widget.emptyImage != null) {
      assetImage = widget.emptyImage;
    }
    return  Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Image.asset(assetImage),
          ),
          Text(label,style: TextStyle(color: Color(0xFF1E1E1E),fontSize: 18),),
        ],
      ),
    );
  }

  ///加载中视图
  Widget get _loadingView {
    var label = '拼命加载中...';
    if(widget.loadingLabel != null) {
      label = widget.loadingLabel;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: getLoadingView(),
    );
  }

  Widget getLoadingView() {
    if(widget.loadingViewBuilder != null) {
      return widget.loadingViewBuilder();
    }
    var label = '拼命加载中...';
    if(widget.loadingLabel != null) {
      label = widget.loadingLabel;
    }
    return  Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
          Text(label,style: TextStyle(color: Color(0xFF1E1E1E),fontSize: 18),)],
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child:
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _onErrorRetry,
          child: getErrorView(),
        ),
    );
  }


  Widget getErrorView() {
    if(widget.errorViewBuilder != null) {
      return widget.errorViewBuilder();
    }

    var label = "加载失败，请轻触重试!";
    var assetImage = 'imgs/error.png';
    if(widget.errorLabel != null) {
      label = widget.errorLabel;
    }
    if(widget.errorImage != null) {
      assetImage = widget.errorImage;
    }

    return Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Image.asset(assetImage),
          ),
          Text(label,style: TextStyle(color: Color(0xFF1E1E1E),fontSize: 18),),
        ],
      ),
    );

  }
 }