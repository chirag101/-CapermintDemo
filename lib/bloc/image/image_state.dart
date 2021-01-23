import 'package:chirag_patel_23_jan_2021/data/model/image_list_response.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ImageState extends Equatable {}

class ImageInitialState extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoadingState extends ImageState {
  @override
  List<Object> get props => [];
}

class ImageLoadedState extends ImageState {

  List<ImageModel> images;

  ImageLoadedState({@required this.images});

  @override
  List<Object> get props => [images];
}

class ImageErrorState extends ImageState {

  String message;

  ImageErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

