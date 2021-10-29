import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practical/Models/source.dart';
import 'package:practical/Repository/articlerepo.dart';

part 'source_state.dart';

class SourceCubit extends Cubit<SourceState> {
  final ArticleRepository repository;

  SourceCubit(this.repository) : super(SourceInitial()){
    _getDataFromRepo();
}

 Future<void> _getDataFromRepo() async {
    try {
      emit(SourceLoading());

      final sourceResponse = await repository.dataGetRequest.getSources();
      List<Sources> sourceList = sourceResponse.sources;
      emit(SourceLoaded(sourceList));
    }catch(e){
      print(e);
    }
 }
}
