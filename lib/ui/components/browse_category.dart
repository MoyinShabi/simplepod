import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/services/podcast_service.dart';
import '../screens/podcast_details_screen.dart';

class BrowseCategory extends StatefulWidget {
  final String title;
  final String genre;

  const BrowseCategory({
    super.key,
    required this.title,
    this.genre = '',
  });

  @override
  State<BrowseCategory> createState() => _BrowseCategoryState();
}

class _BrowseCategoryState extends State<BrowseCategory> {
  late Future<SearchResult> topPodcasts;

  @override
  void initState() {
    super.initState();
    topPodcasts = PodcastService().fetchTopPodcasts(genre: widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        FutureBuilder<SearchResult>(
          future: topPodcasts,
          builder:
              (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
            if (snapshot.hasData) {
              final List<Item>? items = snapshot.data?.items;
              return SizedBox(
                height: 230,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.resultCount ?? 0,
                  itemBuilder: (context, index) {
                    final item = items?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (item != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PodcastDetailsScreen(
                                      selectedPodcast: item),
                                ),
                              );
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              placeholder: (context, value) => Skeletonizer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
                                  ),
                                ),
                              ),
                              imageUrl: item?.artworkUrl600 ?? '',
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text((index + 1).toString()),
                        SizedBox(
                          width: 150,
                          child: Text(
                            item?.trackName ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            item?.artistName ?? '',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    'Oops! Something went wrong. Please check your internet connection.'),
              );
            }
            return Skeletonizer(
              // ignorePointers: false,
              // enabled: true,
              child: SizedBox(
                height: 230,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text((index + 1).toString()),
                        const SizedBox(
                          width: 150,
                          child: Text(
                            'Lorem ipsum dolor sit amet consechhj',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Text(
                            'Lorem ipsum dolor',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
