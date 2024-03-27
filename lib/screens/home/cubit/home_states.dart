import 'package:untitled/screens/home/cubit/home_response.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final HomeResponse homeResponse;

  HomeSuccessState(this.homeResponse);
}

class HomeErrorState extends HomeStates {
  final HomeResponse homeResponse;

  HomeErrorState(this.homeResponse);
}
