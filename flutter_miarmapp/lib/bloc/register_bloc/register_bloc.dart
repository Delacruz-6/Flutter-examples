import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/auth/register_dto.dart';
import 'package:flutter_miarmapp/models/auth/register_response.dart';
import 'package:image_picker/image_picker.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(ImagePickBlocInitial()) {
    on<SelectImageEvent>(_onSelectImage);
  }

  void _onSelectImage(
      SelectImageEvent event, Emitter<RegisterState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.source,
      );
      if (pickedFile != null) {
        //emit(RegisterSuccess(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image selection'));
    }
  }
}
