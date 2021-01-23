import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable{}

class FetchImagesEvent extends ImageEvent {
  final int size;

  FetchImagesEvent(this.size);

  @override
  List<Object> get props => null;
}