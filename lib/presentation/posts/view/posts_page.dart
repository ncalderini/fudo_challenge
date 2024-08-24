import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/data/source/local/post_storage.dart';
import 'package:fudo_challenge/data/source/network/post_api.dart';
import 'package:fudo_challenge/data/source/network/user_api.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:fudo_challenge/domain/usecase/search_posts.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_bloc.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_event.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getPostsUseCase = GetPostsUseCase(
        PostRepositoryImpl(api: PostApi(), storage: PostStorage()));

    final searchPostsUseCase = SearchPostsUseCase(
        PostRepositoryImpl(api: PostApi(), storage: PostStorage()), UserApi());

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocProvider<PostBloc>(
          create: (context) => PostBloc(
              getPostsUseCase: getPostsUseCase,
              searchPostsUseCase: searchPostsUseCase)
            ..add(FetchPosts()),
          child: const PostsList()),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //Create post here
          }),
    );
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text("Failed to fetch posts")));
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.success:
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: PostsSearchBar(),
                  ),
                  Expanded(child: PostListView(state: state)),
                ],
              );
            case PostStatus.failure:
              return state.posts.isNotEmpty
                  ? PostListView(state: state)
                  : const Center(child: Text("No data"));
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PostsSearchBar extends StatelessWidget {
  const PostsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      leading: const Icon(Icons.search),
      hintText: "Search posts by author",
      hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
      onSubmitted: (query) =>
          context.read<PostBloc>().add(SearchPosts(query: query)),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({super.key, required this.state});

  final PostState state;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(state.posts[index].title,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(state.posts[index].body),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: state.posts.length);
  }
}
