import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_tdd_clean_architecture/core/network/network_info.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should foward the call to DataConnectionChecker has Connection',
        () async {
      //arrange
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      //act
      final result = await networkInfo.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
