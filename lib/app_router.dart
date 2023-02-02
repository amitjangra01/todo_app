import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/screen/homepage.dart';
import 'app/screen/searchPage.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/searchPage',
        builder: (context, state) => const SearchPage(),
      ),
    ],
  ),
);
