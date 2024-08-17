import 'dart:async';
import 'package:bethany_app/data/api/video_api.dart';
import 'package:bethany_app/models/channel_model.dart';
import 'package:bethany_app/models/video_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imagesPaths = [
  'assets/banner1.jpg',
  'assets/banner2.jpg',
  'assets/banner3.jpg'
];

late List<Widget> _pages;

int _activePage = 0;

final PageController _pageController = PageController(initialPage: 0);

Timer? _timer;

class _HomePageState extends State<HomePage> {
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      // Check if _pageController has a position and is attached to a PageView
      if (_pageController.hasClients &&
          _pageController.page == imagesPaths.length - 1) {
        // check if current page is last
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else if (_pageController.hasClients) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  Channel? _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
        imagesPaths.length,
        (index) => ImagePlaceholder(
              imagePath: imagesPaths[index],
            ));
    startTimer();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCY-9GTNAiyWEZcyYPgRCmZQ');
    setState(() {
      _channel = channel;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  _buildProfileInfo() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
          child: PageView.builder(
              controller: _pageController,
              itemCount: imagesPaths.length,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              }),
        ),
        //page indicator
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _pages.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            _pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 3000),
                                curve: Curves.easeIn);
                          },
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: _activePage == index
                                ? Colors.yellow
                                : Colors.grey,
                          ),
                        ),
                      )),
            ),
          ),
        )
      ],
    );
  }

  _buildVideo(Video video) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: Image(
                  image: NetworkImage(
                    video.thumbnailUrl,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0,left: 20,right: 30),
              child: Text(
                video.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.clip),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel!.uploadPlaylistId);
    List<Video> allVideos = _channel!.videos..addAll(moreVideos);
    setState(() {
      _channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel!.videos.length !=
                        int.parse(_channel!.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel!.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }

                  Video video = _channel!.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
