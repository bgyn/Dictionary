import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/feature/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  Future<void> playAudioFromUrl(String url) async {
    final player = AudioPlayer();
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title: Text(
          "Search",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 20, color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ref.watch(getResponseProvider(query)).when(
              data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.word.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 40,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${data.phonetics![0].text}, ${data.phonetics![0].text}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                        ),
                        IconButton(
                          onPressed: () {
                            playAudioFromUrl(
                              data.phonetics![0].audio.toString(),
                            );
                          },
                          icon: const Icon(
                            Icons.speaker_rounded,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
              error: (error, errorStack) {
                return Text(error.toString());
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
