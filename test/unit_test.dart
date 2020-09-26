import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/services/auth.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([_mockUser]);
  }
}

Future<void> main() async {
  final MockFirebaseAuth mockAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockAuth);
  setUp(() {});

  tearDown(() {});

  test("emit occures", () async {
    expectLater((auth.user), emitsInOrder([_mockUser]));
  });

  test("create account", () async {
    when(MockFirebaseAuth().createUserWithEmailAndPassword(
            email: "test@gmail.com", password: "123456"))
        .thenAnswer((realInvocation) => null);

    expect(
        await auth.createAccount(email: "test@gmail.com", password: "123456"),
        "Success");
  });

  // test("create account exception", () async {
  //   when(MockFirebaseAuth().createUserWithEmailAndPassword(
  //           email: "test@gmail.com", password: "123456"))
  //       .thenAnswer((realInvocation) =>
  //           throw FirebaseAuthException(message: "failed auth"));
  //
  //   expect(
  //       await auth.createAccount(email: "test@gmail.com", password: "123456"),
  //       "failed auth");
  // });
}
