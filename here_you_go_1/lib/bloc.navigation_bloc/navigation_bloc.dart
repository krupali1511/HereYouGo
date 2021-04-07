import 'package:bloc/bloc.dart';
import 'package:here_you_go_1/Screens/TripDetails.dart';
import 'package:here_you_go_1/pages/MyBlogPage.dart';
import 'package:here_you_go_1/pages/ProfilePage.dart';
import 'package:here_you_go_1/pages/currencyConverter.dart';
import 'package:here_you_go_1/pages/mainTrip.dart';
import 'package:here_you_go_1/pages/myexpensepage.dart';
import 'package:here_you_go_1/pages/subtripspage.dart';

import '../pages/homepage.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyBlogPageClickedEvent,
  MyExpenseClickedEvent,
  MyTripClickedEvent,
  MyProfileClickedEvent,
  MyCurrencyConverterEvent,
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
        yield ViewBlog();
        break;
      case NavigationEvents.MyTripClickedEvent:
        yield Usertrip();
        break;
      case NavigationEvents.MyExpenseClickedEvent:
        yield Expense();
        break;
      case NavigationEvents.MyProfileClickedEvent:
        yield ProfilePage();
        break;
      case NavigationEvents.MyCurrencyConverterEvent:
        yield CurrencyPage();
        break;
    }
  }
}
