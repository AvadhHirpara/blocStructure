import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screens/home/cubit/home_request.dart';
import '../../base/base_stateful_state.dart';
import '../../common_widgets/common_button.dart';
import '../../common_widgets/text_widget.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  @override
  Widget buildBody(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessState) {
          // Success MSG
          push(context, enterPage: HomeScreen()); // screen redirect
        }
        if (state is HomeErrorState) {
          // Error MSG
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            TextWidget(text: 'Name'),
            CommonButton(
              showLoading: state is HomeLoadingState,
              text: 'Click',
              onTap: () {
                // Api call //
                HomeCubit.get(context).callHome(homeRequest: HomeRequest(name: 'name'));
              },
            )
          ],
        );
      },
    );
  }
}
