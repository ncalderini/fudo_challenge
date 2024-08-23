import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_challenge/data/source/network/post_api.dart';
import 'package:fudo_challenge/domain/repository/post_repository.dart';
import 'package:fudo_challenge/domain/usecase/get_posts.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_bloc.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_event.dart';
import 'package:fudo_challenge/presentation/posts/bloc/post_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Posts")),
        body: BlocProvider<PostBloc>(
            create: (context) => PostBloc(
                getPostsUseCase:
                    GetPostsUseCase(PostRepositoryImpl(api: PostApi())))
              ..add(FetchPosts()),
            child: const PostsList()));
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
            ..showSnackBar(const SnackBar(content: Text("Failed to fetch posts")));
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {              
            case PostStatus.success:
              return PostListView(state: state);
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class PostListView extends StatelessWidget {
  const PostListView({super.key, required this.state});

  final PostState state;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: Text(state.posts[index].title,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(state.posts[index].body),
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: state.posts.length);
  }
}
