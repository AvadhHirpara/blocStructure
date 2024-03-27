import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screens/home/cubit/home_request.dart';
import 'package:untitled/screens/home/cubit/home_response.dart';
import '../../../repo_api/dio_helper.dart';
import '../../../repo_api/rest_constants.dart';
import '../../../utils/app_utils.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeResponse? homeResponse;

  void callHome({required HomeRequest homeRequest}) {
    emit(HomeLoadingState());
    DioHelper.postData(
      url: RestConstants.homeUrl,
      data: homeRequest.toJson(),
      isHeader: true, // for pass auth token
      isLanguage: true, // for pass language
    ).then((value) {
      homeResponse = HomeResponse.fromJson(value.data);
      emit(HomeSuccessState(homeResponse!));
    }).catchError((error) {
      emit(HomeSuccessState(HomeResponse(message: AppUtils.instance.getErrorMessage(error))));
    });
  }
}
