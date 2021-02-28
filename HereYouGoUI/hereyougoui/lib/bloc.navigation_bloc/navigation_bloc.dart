import 'package:bloc/bloc.dart';
import 'package:hereyougoui/pages/mytripspage.dart';
import '../pages/MyBlogPage.dart';
import '../pages/myexpensepage.dart';

import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyBlogPageClickedEvent,
  MyExpenseClickedEvent,
  MyTripClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyBlogPageClickedEvent:
        yield MyBlogPage();
        break;
      case NavigationEvents.MyTripClickedEvent:
        yield MyTripsPage();
        break;
      case NavigationEvents.MyExpenseClickedEvent:
        yield MyExpensePage();
        break;
    }
  }
}
