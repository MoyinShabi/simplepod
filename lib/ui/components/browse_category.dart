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
              final items = snapshot.data?.items;
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              if (item != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PodcastDetailsScreen(
                                      selectedPodcast: item),
                                ));
                              }
                            },
                            child: Image.network(
                              item?.artworkUrl600 ?? '',
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
              enabled: true,
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
                          child: Image.network(
                            'https://via.placeholder.com/600x600',
                            fit: BoxFit.fill,
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
