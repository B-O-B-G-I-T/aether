import 'package:equatable/equatable.dart';

class Params {}

class NoParams extends Equatable implements Params {
  @override
  List<Object?> get props => [];
}

class TemplateParams {}
