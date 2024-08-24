import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/data/dto/user_dto.dart';
import 'package:fudo_challenge/data/source/network/user_api.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';
import 'package:fudo_challenge/domain/usecase/search_posts.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for PostRepository
class MockPostRepository extends Mock implements PostRepository {}
class MockUserApi extends Mock implements UserApi {}

void main() {
  late SearchPostsUseCase searchPostsUseCase;
  late MockPostRepository mockPostRepository;
  late MockUserApi mockUserApi;

  setUp(() {
    mockPostRepository = MockPostRepository();
    mockUserApi = MockUserApi();
    searchPostsUseCase = SearchPostsUseCase(mockPostRepository, mockUserApi);
  });

  test('should search posts from the repository by userId given User Name', () async {
    // Arrange
    const user = UserDto(id: 1, name: "Leanne Graham", username: "Lenny", email: "email@email.com");
    final posts = [const Post(id: 1, title: 'Test Post', body: 'Test Body')];

    when(() => mockUserApi.getUser(name: "Leanne Graham")).thenAnswer((_) async => user);
    when(() => mockPostRepository.searchPosts(userId: user.id)).thenAnswer((_) async => posts);

    // Act
    final result = await searchPostsUseCase(name: "Leanne Graham");

    // Assert
    expect(result, posts);
    verify(() => mockUserApi.getUser(name: "Leanne Graham"));
    verify(() => mockPostRepository.searchPosts(userId: 1));
    verifyNoMoreInteractions(mockPostRepository);
  });
}