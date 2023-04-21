import 'package:equatable/equatable.dart';

class Species extends Equatable {
  final String name;
  final String url;
  const Species({
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [name, url];
}
