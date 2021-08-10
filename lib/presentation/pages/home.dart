import 'package:moyori/utils/device_info.dart';
import 'package:flutter/material.dart';
import 'package:moyori/presentation/pages/place_list.dart';
import 'package:moyori/presentation/arguments/place_list.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:moyori/presentation/model/home.dart';
import 'package:moyori/utils/color.dart';
import 'package:moyori/utils/ad_state.dart';
import 'package:moyori/utils/keyboard.dart';
import 'package:moyori/utils/loading.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final FocusNode _textNode = FocusNode();

  static Widget provide() => ChangeNotifierProvider<HomePageModel>(
    create: (BuildContext context) => HomePageModel()..initialize(),
    child: HomePage()
  );

  @override
  Widget build(BuildContext context) {
    final HomePageModel model = Provider.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('最寄り検索'),
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
              icon: Icon(Icons.refresh),
                onPressed: () async {
                  showLoading(context: context);
                  final permission = await model.updateLocation();
                  Navigator.of(context).pop();
                  if (permission == PermissionStatus.deniedForever) {
                    _showDialog(context, "位置情報の利用不可", "設定アプリで位置情報の利用を許諾してください");
                  }
                },
              ),
            )
          ],
        ),
        body: Column(
          children: [
            adMobBanner(context),
            model.myLocationData == null ? Container() : _textSearchViewSection,
            Expanded(
              child: model.myLocationData == null ? _errorSection : _homeContentSection
            ),
          ],
        )
      ),
    );
  }

  Widget get _textSearchViewSection => Consumer<HomePageModel>(builder: (context, model, _) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
      decoration: BoxDecoration(
        border: const Border(
          bottom: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      height: 80,
      child: Row(
        children: [
          Flexible(
            child: Container(
              child: KeyboardActions(
                disableScroll: true,
                config: keyboardActionConfig(_textNode),
                child: TextField(
                  focusNode: _textNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "フリー検索",
                    // icon: Icon(Icons.search),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onChanged: (inputText) { 
                    model.setSearchInputWord(inputText);
                  },
                  onSubmitted: (String searchWord) async {
                    if (searchWord.isNotEmpty) {
                       _transitionPlaceList(context: context, model: model, searchWord: searchWord);
                    }
                  }
                ),
              )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.black,
                  onPressed: model.searchInputWord.isEmpty ? null: () {
                    _transitionPlaceList(context: context, model: model, searchWord: model.searchInputWord);
                  },
                ),
              )
            ]
          ),
        ],
      ),
    );
  });

  Widget get _errorSection => Consumer<HomePageModel>(builder: (context, model, _) {
    final networkStatus = Provider.of<NetworkStatus>(context);
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
        child: Text(
          (networkStatus.isConnected ? 
            "現在地情報が取得できません" : 
            "ネットワーク接続が確認できませんでした"
          ) + "\n電波の良い場所で「↻」ボタンを押して下さい",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      )
    );
  });

  Widget get _homeContentSection => Consumer<HomePageModel>(builder: (context, model, _) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(height: 20),
          _gridViewSection,
          Container(height: 20)
        ]
      ),
    );
  });

  Widget get _gridViewSection => Consumer<HomePageModel>(builder: (context, model, _) {
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    return Flexible(
      child: Container(
        child: GridView.builder(
          itemCount: model.searchPlaceList.length,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          // childAspectRatio: (itemWidth / itemHeight),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                final lat = model.myLocationData?.latitude;
                final lon = model.myLocationData?.longitude;
                if (lat == null || lon == null) {
                  return;
                }
                await Navigator.pushNamed<void>(
                  context,
                  PlaceListPage.routeName,
                  arguments: PlaceListPageArguments(
                    lat: lat, 
                    lon: lon, 
                    searchWord: model.searchPlaceList[index].searchWord, 
                    placeType: model.searchPlaceList[index].placeType
                  )
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.searchPlaceList[index].searchWord,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      model.searchPlaceList[index].iconData,
                      color: Colors.white,
                      size: 100.0,
                    )
                  ]
                ),
                decoration: BoxDecoration(
                  color: AppColor.customSwatch.shade500,
                  border: Border.all(color: AppColor.customSwatch.shade800),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        ),
      ),
    );
  });

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Center(child: Text(title)),
            content: Text(message),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () { Navigator.of(context).pop(); },
              ),
            ],
          );
        }
    );
  }

  void _transitionPlaceList({
    required BuildContext context, 
    required HomePageModel model, 
    required String searchWord, 
    String? placeType
  }) async {
    final lat = model.myLocationData?.latitude;
    final lon = model.myLocationData?.longitude;
    if (lat == null || lon == null) {
      return;
    }
    await Navigator.pushNamed<void>(
      context,
      PlaceListPage.routeName,
      arguments: PlaceListPageArguments(
        lat: lat, 
        lon: lon, 
        searchWord: searchWord,
        placeType: placeType
      )
    );
  }
}