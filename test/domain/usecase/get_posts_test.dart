import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for PostRepository
class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late GetPostsUseCase getPostsUseCase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getPostsUseCase = GetPostsUseCase(mockPostRepository);
  });

  test('should get posts from the repository', () async {
    // Arrange
    final posts = [const Post(id: 1, title: 'Test Post', body: 'Test Body')];
    when(() => mockPostRepository.getPosts()).thenAnswer((_) async => posts);

    // Act
    final result = await getPostsUseCase();

    // Assert
    expect(result, posts);
    verify(() => mockPostRepository.getPosts());
    verifyNoMoreInteractions(mockPostRepository);
  });
}