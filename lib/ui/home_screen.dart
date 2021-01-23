import 'package:chirag_patel_23_jan_2021/bloc/image/image_bloc.dart';
import 'package:chirag_patel_23_jan_2021/bloc/image/image_event.dart';
import 'package:chirag_patel_23_jan_2021/bloc/image/image_state.dart';
import 'package:chirag_patel_23_jan_2021/data/model/image_list_response.dart';
import 'package:chirag_patel_23_jan_2021/resourse/app_colors.dart';
import 'package:chirag_patel_23_jan_2021/resourse/app_text_style.dart';
import 'package:chirag_patel_23_jan_2021/resourse/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  BuildContext _buildContext;
  ImageBloc imageBloc;
  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    imageBloc = BlocProvider.of<ImageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return SafeArea(
      child: new Container(
            decoration: new BoxDecoration(color: AppColors.colorWhite),
            child: new Scaffold(
              backgroundColor: AppColors.default_background,
              appBar: getAppBar(),
              body: Builder(builder: (context) {
                _buildContext = context;
                return getBody();
              }),
            )),
    );
  }

  Widget getBody() {
    var button = new MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      elevation: 2.0,
      minWidth: 70.0,
      height: 35,
      color: AppColors.textColorBlue,
      child: new Text('Get',
          style: new TextStyle(fontSize: 16.0, color: Colors.white)),
      onPressed: () {
        if (isValid())
          setState(() {
            FocusManager.instance.primaryFocus.unfocus();
            imageBloc
                .add(FetchImagesEvent(int.parse(controller.text.toString())));
          });
      },
    );
    var inputField = TextField(
          keyboardType: TextInputType.number,
          style: AppTextStyle.textStyleBlackSize16,
          controller: controller,
          textAlign: TextAlign.center,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2),
              hintText: '',
              labelStyle: AppTextStyle.textStyleBlackSize16),
        );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: inputField,
              ),
              Expanded(
                flex: 0,
                child: button,
              )
            ],
          ),
        ),
        Expanded(
            child: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is ImageErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              if (state is ImageInitialState) {
                return buildLoading("Loading data");
              } else if (state is ImageLoadingState) {
                return buildLoading("Loading data");
              } else if (state is ImageLoadedState) {
                if (state.images != null && state.images.length > 0) {
                  return getCateGoryListWidget(state.images);
                }
              } else if (state is ImageErrorState) {
                return buildErrorUi(state.message);
              } else {
                return buildLoading("Please enter value to get the data");
              }
            },
          ),
        ))
      ],
    );
  }

  Widget getAppBar() {
    var ivMenu = GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 40,
        height: 40,
        child: Padding(
            padding: EdgeInsets.all(4),
            child: new Icon(Icons.list, color: AppColors.colorWhite)),
      ),
    );

    return CustomAppBar(
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Stack(
            children: [
              Row(
                children: [
                  ivMenu,
                ],
              ),
              Align(
                child: Text(
                  "Home",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textStyleWhiteSize16,
                ),
                alignment: Alignment.center,
              )
            ],
          )),
    );
  }

  var selectedMainCategory = 0;

  Widget getCateGoryListWidget(List<ImageModel> images) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 6,
        itemCount: images.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            getListItem(images, index),
        staggeredTileBuilder: (int index) => StaggeredTile.count(
            ((index + 1) % 5 == 0 || ((index + 2) % 5 == 0)) ? 3 : 2,
            ((index + 1) % 5 == 0 || ((index + 2) % 5 == 0)) ? 3 : 2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget buildLoading(String message) {
    return Text(
      message,
      style: AppTextStyle.textStyleBlackSize16,
    );
  }

  Widget buildErrorUi(String message) {
    return Text("Error : " + message);
  }

  Widget getListItem(List<ImageModel> images, int index) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: FadeInImage.assetNetwork(
        image: images[index].imageUrl,
        placeholder: "assets/icons/place_holder_image.jpg",
        // your assets image path
        fit: BoxFit.cover,
      ),
    );
   }

  bool isValid() {
    if (controller.text.toString().trim().isEmpty) {
      Scaffold.of(_buildContext).showSnackBar(
        SnackBar(
          content: Text("Please enter value"),
        ),
      );
      return false;
    }
    if (int.parse(controller.text.toString().trim()) <= 0) {
      Scaffold.of(_buildContext).showSnackBar(
        SnackBar(
          content: Text("Please enter valid input value"),
        ),
      );
      return false;
    }
    return true;
  }
}
