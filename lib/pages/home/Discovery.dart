import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/pages/home/DetailsArticle.dart';
import 'package:hello_world/utils/Request.dart';

// 详情页路由
import './DiscoveryItem.dart';

class DiscoveryPage extends StatefulWidget {
  DiscoveryPage({Key key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<DiscoveryDataItem> discoverItems = [];
  @override
  void initState() {
    super.initState();
    getData() async {
      Map<String, dynamic> requ = await PxzRequest()
          .get("/index/index", data: {"page": 1, "limit": 20});
      List<dynamic> reqs = requ["data"]["items"];
      setState(() {
        discoverItems = reqs.map((e) => DiscoveryDataItem.fromJson(e)).toList();
      });
    }

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 190.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(background: NekoSwiper()),
        ),
        SliverPadding(
          padding: EdgeInsets.all(5),
          sliver: SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: discoverItems?.length,
            itemBuilder: (BuildContext context, int index) => ProgramItem(
              discoveryDataItem: discoverItems[index],
            ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
        )
      ],
    );
  }
}

///
/// 轮播图
///
class NekoSwiper extends StatelessWidget {
  static List<Widget> swiperItem = [
    CachedNetworkImage(
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
      imageUrl: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2364654808,1367649755&fm=26&gp=0.jpg",
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    CachedNetworkImage(
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
      imageUrl: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=e65c12f32f0969f9337c309db95209cb&imgtype=0&src=http%3A%2F%2Fwww.chabeichong.com%2Fimages%2F2016%2F10%2F21-06155760.jpg",
      errorWidget: (context, url, error) => Icon(Icons.error),
    )
  ];
  const NekoSwiper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(5, 12, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              child: Swiper(
                itemBuilder: (BuildContext context,int index) {
                  return swiperItem[index];
                },
                itemCount: 2,
                pagination: SwiperPagination(),
              ),
            )),
        Positioned(
          width: 45.0,
          height: 45.0,
          top: -5.0,
          left: 20,
          child: Image.asset("assets/home/swiper_decorate_left.png"),
        ),
        Positioned(
          width: 45.0,
          height: 45.0,
          top: -5.0,
          right: 20,
          child: Image.asset("assets/home/swiper_decorate_right.png"),
        )
      ],
    )
    );
  }
}

///
/// 页面展示小卡片
///
class ProgramItem extends StatelessWidget {
  const ProgramItem({Key key, this.discoveryDataItem}) : super(key: key);
  final DiscoveryDataItem discoveryDataItem;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 0.3,
              offset: Offset(0, 0.5),
            )
          ]),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (discoveryDataItem.resources[0].type == "video") {
                Navigator.push(context, MaterialPageRoute(builder:(context) => DiscoveryItemPage(itemId: discoveryDataItem.id)));
              } else {
                Navigator.push(context, MaterialPageRoute(builder:(context) => DetailsArticlePage(id: discoveryDataItem.id,)));              
              }
            },
            child: Stack(
              children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                child: discoveryDataItem.resources.length > 0
                    ? CachedNetworkImage (
                      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
                      imageUrl: discoveryDataItem.mainDefaultId,
                    ) 
                    : Image.asset("assets/home/loading.png")),
                discoveryDataItem.resources[0].type == "video" ?  
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Icon(Icons.play_circle_outline, color: Colors.white, size: 25,),
                  ) 
                ) : 
                SizedBox.shrink() 
              ],
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 10, 5),
            child: Text(
              discoveryDataItem.title,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
            height: 35.0,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage:
                        NetworkImage(discoveryDataItem.memberDetail.avatar),
                  ),
                ),
                Text(
                  discoveryDataItem.memberDetail.nickname,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Expanded(child: Text("")),
                SizedBox(
                  width: 28,
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      onPressed: null),
                ),
                Text(
                  discoveryDataItem.likeNum,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

/// item data class
///
class DiscoveryDataItem {
  String id;
  String title;
  String likeNum;
  String mainDefaultId;
  MemberDetail memberDetail;
  List<Resource> resources;
  DiscoveryDataItem(
      {this.id, this.title, this.likeNum, this.mainDefaultId, this.memberDetail, this.resources});

  factory DiscoveryDataItem.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> resources = parsedJson["resources"] as List;
    return DiscoveryDataItem(
        id: parsedJson["id"],
        title: parsedJson["title"],
        likeNum: parsedJson["like_num"],
        mainDefaultId: parsedJson["main_default_id"],
        memberDetail: MemberDetail.fromJson(parsedJson["member_detail"]),
        resources: resources.map((e) => Resource.fromJson(e)).toList());
  }
}

class MemberDetail {
  String id;
  String avatar;
  String nickname;

  MemberDetail({this.id, this.avatar, this.nickname});

  factory MemberDetail.fromJson(Map<String, dynamic> parsedJson) {
    return MemberDetail(
        id: parsedJson["id"],
        avatar: parsedJson["avatar"],
        nickname: parsedJson["nickname"]);
  }
}

class Resource {
  String url;
  String type;

  Resource({this.url, this.type});

  factory Resource.fromJson(Map<String, dynamic> parsedJson) {
    return Resource(url: parsedJson["url"], type: parsedJson["type"]);
  }
}