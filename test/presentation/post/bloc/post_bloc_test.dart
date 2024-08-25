import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fudo_challenge/domain/entity/post.dart';
import 'package:fudo_challenge/domain/exceptions/internet_exception.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:fudo_challenge/domain/usecase/search_posts.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_bloc.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_event.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

class MockSearchPostsUseCase extends Mock implements SearchPostsUseCase {}

void main() {
  late PostBloc postBloc;
  late MockGetPostsUseCase mockGetPostsUseCase;
  late MockSearchPostsUseCase mockSearchPostsUseCase;

  setUp(() {
    mockGetPostsUseCase = MockGetPostsUseCase();
    mockSearchPostsUseCase = MockSearchPostsUseCase();
    postBloc = PostBloc(
      getPostsUseCase: mockGetPostsUseCase,
      searchPostsUseCase: mockSearchPostsUseCase,
    );
  });

  tearDown(() {
    postBloc.close();
  });

  group('PostBloc', () {
    const posts = [
      Post(id: 1, title: "title1", body: "body1"),
      Post(id: 2, title: "title2", body: "body2"),
      Post(id: 3, title: "title3", body: "body3")
    ];

    const postsByUser = [
      Post(id: 1, title: "Leanne Graham", body: "Leanne Graham"),
      Post(id: 2, title: "Leanne Graham", body: "Leanne Graham"),
    ];

    test('initial state should be correct', () {
      expect(postBloc.state.status, PostStatus.initial);
      expect(postBloc.state.posts, []);
    });

    blocTest<PostBloc, PostState>(
      'should fetch posts and update state when FetchPosts event is added',
      build: () {
        when(() => mockGetPostsUseCase()).thenAnswer((_) async => posts);
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        const PostState(status: PostStatus.success, posts: posts),
      ],
      verify: (bloc) {
        verify(() => mockGetPostsUseCase()).called(1);
      },
    );

    blocTest<PostBloc, PostState>(
      'should handle InternetException and update state when FetchPosts event is added with no cached data',
      build: () {
        when(() => mockGetPostsUseCase()).thenThrow(InternetException());
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        const PostState(status: PostStatus.failure, posts: []),
      ],
      verify: (bloc) {
        verify(() => mockGetPostsUseCase()).called(1);
      },
    );

    blocTest<PostBloc, PostState>(
      'should handle InternetException and update state when FetchPosts event is added and return cached data if available',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenThrow(InternetException(cachedData: posts));
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        const PostState(status: PostStatus.failure, posts: posts),
      ],
      verify: (bloc) {
        verify(() => mockGetPostsUseCase()).called(1);
      },
    );

    blocTest<PostBloc, PostState>(
      'should search posts and update state when SearchPosts event is added with a non-empty query',
      build: () {
        when(() => mockSearchPostsUseCase(name: 'query'))
            .thenAnswer((_) async => postsByUser);
        return postBloc;
      },
      act: (bloc) => bloc.add(SearchPosts(query: 'query')),
      expect: () => [
        const PostState(status: PostStatus.initial, posts: []),
        const PostState(status: PostStatus.success, posts: postsByUser),
      ],
      verify: (bloc) {
        verifyNever(() => mockGetPostsUseCase());
        verify(() => mockSearchPostsUseCase(name: 'query')).called(1);
      },
    );

    blocTest<PostBloc, PostState>(
      'should fetch posts and update state when SearchPosts event is added with an empty query',
      build: () {
        when(() => mockGetPostsUseCase()).thenAnswer((_) async => posts);
        return postBloc;
      },
      act: (bloc) => bloc.add(SearchPosts(query: '')),
      expect: () => [
        const PostState(status: PostStatus.initial, posts: []),
        const PostState(status: PostStatus.success, posts: posts),
      ],
      verify: (bloc) {
        verify(() => mockGetPostsUseCase()).called(1);
        verifyNever(() => mockSearchPostsUseCase(name: ''));
      },
    );

    blocTest<PostBloc, PostState>(
      'should handle exceptions and update state when SearchPosts event is added and fails',
      build: () {
        when(() => mockSearchPostsUseCase(name: 'query'))
            .thenThrow(Exception());
        return postBloc;
      },
      act: (bloc) => bloc.add(SearchPosts(query: 'query')),
      expect: () => [
        const PostState(status: PostStatus.initial, posts: []),
        const PostState(status: PostStatus.failure, posts: []),
      ],
      verify: (bloc) {
        verifyNever(() => mockGetPostsUseCase());
        verify(() => mockSearchPostsUseCase(name: 'query')).called(1);
      },
    );
  });
}
