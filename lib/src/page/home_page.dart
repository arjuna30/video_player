import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/src/bloc/home_bloc.dart';
import 'package:video_player_app/src/bloc/video_cubit.dart';

class HomePage extends StatefulWidget {
  static final route = ChildRoute(Modular.initialRoute,
      child: (context, args) => const HomePage());

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        BlocProvider(create: HomeBloc.create),
        BlocProvider(create: VideoCubit.create),
      ],
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const Scaffold(body: _BodyHomePage())),
    );
  }
}

class _BodyHomePage extends StatefulWidget {
  const _BodyHomePage({Key? key}) : super(key: key);

  @override
  State<_BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<_BodyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  final _refreshController = RefreshController();

  bool isPlaying = false;
  bool _onTouch = true;
  Timer? _timer;
  int _limit = 5;
  late VideoPlayerController _playerController;

  String duration(int millisecond) {
    late double x;
    late int seconds;
    late int minutes;
    x = millisecond / 1000;
    seconds = (x % 60).ceil();
    x /= 60;
    minutes = (x % 60).ceil();

    final String stringSecond =
        seconds.toString().length < 2 ? '0$seconds' : seconds.toString();
    final String stringMinutes =
        minutes.toString().length < 2 ? '0$minutes' : minutes.toString();

    return '$stringMinutes:$stringSecond';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      onFieldSubmitted: (_) => _search(),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(right: 15),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _search(),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isPlaying)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BlocBuilder<VideoCubit, VideoState>(
                builder: (context, state) {
                  if (state is LoadingVideoState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SuccessFetchVideoState) {
                    _playerController = state.playerController;
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          child: VideoPlayer(_playerController),
                          onTap: () {
                            _timer?.cancel();
                            setState(() {
                              _onTouch = !_onTouch;
                            });
                          },
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: Visibility(
                            visible: _onTouch,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _timer?.cancel();
                                      setState(() {
                                        _playerController.seekTo(
                                            _playerController.value.position -
                                                const Duration(seconds: 10));
                                      });
                                      if (_playerController.value.isPlaying) {
                                        _timer = Timer.periodic(
                                            const Duration(milliseconds: 1000),
                                            (_) {
                                          setState(() {
                                            _onTouch = false;
                                          });
                                        });
                                      }
                                    },
                                    child: const Icon(Icons.replay_10,
                                        color: Colors.white, size: 30),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _timer?.cancel();
                                      setState(() {
                                        _playerController.value.isPlaying
                                            ? _playerController.pause()
                                            : _playerController.play();
                                      });
                                      if (_playerController.value.isPlaying) {
                                        _timer = Timer.periodic(
                                            const Duration(milliseconds: 1000),
                                            (_) {
                                          setState(() {
                                            _onTouch = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Icon(
                                        _playerController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _timer?.cancel();
                                      setState(() {
                                        _playerController.seekTo(
                                            _playerController.value.position +
                                                const Duration(seconds: 10));
                                      });
                                      if (_playerController.value.isPlaying) {
                                        _timer = Timer.periodic(
                                            const Duration(milliseconds: 1000),
                                            (_) {
                                          setState(() {
                                            _onTouch = false;
                                          });
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.forward_10,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        VideoProgressIndicator(_playerController,
                            allowScrubbing: true)
                      ],
                    );
                  }
                  if (state is ErrorFetchVideoState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.error_outline,
                              size: 45, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('Error Fetch Video.',
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is LoadingHomeState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SuccessSearchHomeState) {
                  _refreshController.loadComplete();
                  final videos = state.videos;
                  return videos.isEmpty
                      ? const Center(child: Text('No result found.'))
                      : SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          onLoading: _onLoading,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            itemCount: videos.length,
                            itemBuilder: (context, i) {
                              final video = videos[i];
                              final date = DateFormat.yMMMMd('en_US')
                                  .format(video.releaseDate);

                              return SizedBox(
                                height: 75,
                                child: Row(
                                  children: [
                                    InkWell(
                                      customBorder: const CircleBorder(),
                                      onTap: () {
                                        if (isPlaying) {
                                          _playerController.pause();
                                        }
                                        setState(() {
                                          isPlaying = true;
                                        });
                                        ReadContext(context)
                                            .read<VideoCubit>()
                                            .fetchVideo(video.previewUrl);
                                      },
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        color: Theme.of(context).primaryColor,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            video.trackName,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                height: 2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            date,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(duration(video.trackTimeMillis)),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                }
                if (state is ErrorHomeState) {
                  return const Center(child: Text('Something went wrong ..'));
                }
                return const Center(
                    child: Text('Search video you want to watch'));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _search() {
    if (_searchController.text.isNotEmpty) {
      if (isPlaying) _playerController.pause();
      setState(() {
        isPlaying = false;
      });
      _limit = 5;
      ReadContext(context)
          .read<HomeBloc>()
          .add(SearchVideoEvent(_searchController.text, _limit));
    }
  }

  void _onLoading() {
    _limit += 5;
    ReadContext(context)
        .read<HomeBloc>()
        .add(SearchVideoEvent(_searchController.text, _limit));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _refreshController.dispose();
    if (isPlaying) _playerController.pause();
    super.dispose();
  }
}
