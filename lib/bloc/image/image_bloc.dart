import 'package:bloc/bloc.dart';
import 'package:chirag_patel_23_jan_2021/bloc/image/image_event.dart';
import 'package:chirag_patel_23_jan_2021/bloc/image/image_state.dart';
import 'package:chirag_patel_23_jan_2021/data/model/image_list_response.dart';
import 'package:chirag_patel_23_jan_2021/data/repository/image_repository.dart';
import 'package:meta/meta.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {

  ImageRepository repository;

  ImageBloc({@required this.repository}) : assert(repository != null), super(null);

  @override
  ImageState get initialState => ImageInitialState();

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is FetchImagesEvent) {
      yield ImageLoadingState();
      try {
        List<ImageModel> images = await repository.getImages(event.size);
        yield ImageLoadedState(images: images);
      } catch (e) {
        yield ImageErrorState(message: e.toString());
      }
    }
  }

}