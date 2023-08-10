import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/logger.dart';
import 'package:flutter_ducafecat_news_getx/pages/paint/love.dart';
import 'package:get/get.dart';

import 'logic.dart';

class BookPage extends GetView<BookLogic> {
  @override
  Widget build(BuildContext context) {
    Get.put(BookLogic());
    return
        // Scaffold(
        // //下拉刷新
        // body: RefreshIndicator(
        //   //可滚动组件在滚动时会发送ScrollNotification类型的通知
        //   notificationPredicate: (ScrollNotification notification) {
        //     //该属性包含当前ViewPort及滚动位置等信息
        //     ScrollMetrics scrollMetrics = notification.metrics;
        //     if (scrollMetrics.minScrollExtent == 0) {
        //       return true;
        //     } else {
        //       return false;
        //     }
        //   },
        //   //下拉刷新回调方法
        //   onRefresh: () async {
        //     //模拟网络刷新 等待2秒
        //     await Future.delayed(const Duration(milliseconds: 2000));
        //     //返回值以结束刷新
        //     return Future.value(true);
        //   },
        //   child:
        buildNestedScrollView();
    // ),
    // );
  }

  //NestedScrollView 的基本使用
  Widget buildNestedScrollView() {
    //滑动视图
    return NestedScrollView(
      //配置可折叠的头布局
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [buildSliverAppBar()];
      },
      //页面的主体内容
      body: buidChildWidget(),
    );
  }

  //flexibleSpace可折叠的内容区域
  buildSliverAppBar() {
    return SliverAppBar(
      title: buildHeader(),
      //标题居中
      centerTitle: true,
      backgroundColor: AppColor.pinkColor,
      //当此值为true时 SliverAppBar 会固定在页面顶部
      //当此值为fase时 SliverAppBar 会随着滑动向上滑动
      pinned: true,
      //当值为true时 SliverAppBar设置的title会随着上滑动隐藏
      //然后配置的bottom会显示在原AppBar的位置
      //当值为false时 SliverAppBar设置的title会不会隐藏
      //然后配置的bottom会显示在原AppBar设置的title下面
      floating: false,
      //当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
      //反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
      snap: false,
      elevation: 0.0,
      //展开的高度
      expandedHeight: 380,
      //AppBar下的内容区域
      flexibleSpace: FlexibleSpaceBar(
        //背景
        //配置的是一个widget也就是说在这里可以使用任意的
        //Widget组合 在这里直接使用的是一个图片
        background: buildFlexibleSpaceWidget(),
      ),
      bottom: buildFlexibleTooBarWidget(),
    );
  }

  //通常在用到 PageView + BottomNavigationBar 或者 TabBarView + TabBar 的时候
  //大家会发现当切换到另一页面的时候, 前一个页面就会被销毁, 再返回前一页时, 页面会被重建,
  //随之数据会重新加载, 控件会重新渲染 带来了极不好的用户体验.
  //由于TabBarView内部也是用的是PageView, 因此两者的解决方式相同
  //页面的主体内容
  Widget buidChildWidget() {
    return TabBarView(
      controller: controller.tabController,
      children: <Widget>[
        Center(
          child: Text("1"),
        ),
        Center(
          child: Text("2"),
        ),
        Center(
          child: Text("3"),
        ),
      ],
    );
  }

  //构建SliverAppBar的标题title
  buildHeader() {
    //透明组件
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.abc, color: Colors.white),
          onPressed: () {
            Get.to(LovePage());
          },
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "搜索",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_alert_rounded),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  buildFlexibleSpaceWidget() {
    return RefreshIndicator(
      //可滚动组件在滚动时会发送ScrollNotification类型的通知
      notificationPredicate: (ScrollNotification notification) {
        //该属性包含当前ViewPort及滚动位置等信息
        ScrollMetrics scrollMetrics = notification.metrics;
        if (scrollMetrics.minScrollExtent == 0) {
          return true;
        } else {
          return false;
        }
      },
      //下拉刷新回调方法
      onRefresh: () async {
        //模拟网络刷新 等待2秒
        await Future.delayed(const Duration(milliseconds: 2000));
        //返回值以结束刷新
        return Future.value(true);
      },
      child: Column(
        children: [
          Container(
              height: 240,
              child: CarouselSlider(
                options: CarouselOptions().copyWith(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  autoPlay: true,
                ),
                items: controller.imgList.map((item) {
                  return Container(
                    child: Image.network(item, fit: BoxFit.fill),
                  );
                }).toList(),
              )),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    color: Colors.blueGrey,
                    child: Container(
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //[SliverAppBar]的bottom属性配制
  PreferredSizeWidget buildFlexibleTooBarWidget() {
    //[PreferredSize]用于配置在AppBar或者是SliverAppBar
    //的bottom中 实现 PreferredSizeWidget
    return PreferredSize(
      //定义大小
      preferredSize: Size.fromHeight(44),
      //配置任意的子Widget
      child: Container(
        alignment: Alignment.center,
        child: Container(
          color: Colors.grey[200],
          //随着向上滑动，TabBar的宽度逐渐增大
          //父布局Container约束为 center对齐
          //所以程现出来的是中间x轴放大的效果
          // width: MediaQuery.of(context).size.width,
          child: TabBar(
            controller: controller.tabController,
            tabs: <Widget>[
              Tab(
                text: "标签一",
              ),
              Tab(
                text: "标签二",
              ),
              Tab(
                text: "标签三",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDraggableScrollableSheet() {
  return DraggableScrollableSheet(
    //注意 maxChildSize >= initialChildSize >= minChildSize
    //初始化占用父容器高度
    initialChildSize: 0.1,
    //占用父组件的最小高度
    minChildSize: 0.1,
    //占用父组件的最大高度
    maxChildSize: 0.8,
    //是否应扩展以填充其父级中的可用空间默认true 父组件是Center时设置为false,才会实现center布局，但滚动效果是向两边展开
    expand: true,
    //true：触发滚动则滚动到maxChildSize或者minChildSize，不在跟随手势滚动距离 false:滚动跟随手势滚动距离
    snap: false,
    // 当snapSizes接收的是一个数组[],数组内的数字必须是升序，而且取值范围必须在 minChildSize,maxChildSize之间
    //作用是可以控制每次滚动部件占父容器的高度，此时expand: true,
    // snapSizes: [ 0.3, 0.4, 0.8],
    builder: (BuildContext context, ScrollController scrollController) {
      return InterestView(scrollController);
    },
  );
}

class InterestView extends StatefulWidget {
  final ScrollController scrollController;

  const InterestView(this.scrollController, {Key? key}) : super(key: key);

  @override
  State<InterestView> createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {

      Log().d(widget.scrollController.offset.toString(), tag: "offset");
      Log().d(widget.scrollController.position.toString(), tag: "position");

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)],
          ),
          child: ListView(
            padding: const EdgeInsets.only(top: 30),
            controller: widget.scrollController,
            children: [
              Container(
                height: 400,
              ),
              Container(
                height: 400,
              ),
            ],
          ),
        ),
        IgnorePointer(
          child: SizedBox(
            height: 30,
            child: Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
