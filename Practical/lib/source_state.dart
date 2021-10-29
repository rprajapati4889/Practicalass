part of 'source_cubit.dart';


@immutable
abstract class SourceState {}

class SourceInitial extends SourceState {}

class SourceLoading extends SourceState{}

class SourceLoaded extends SourceState{

  final List<Sources> sources;


  SourceLoaded(this.sources);
}

class SourceError extends SourceState{
  final AlertDialog alertDialog;

  SourceError(this.alertDialog);
}


