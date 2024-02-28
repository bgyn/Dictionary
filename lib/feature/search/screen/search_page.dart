import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary/feature/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  final String query;
  SearchPage({super.key, required this.query});

  Future<void> playAudioFromUrl(String url) async {
    final player = AudioPlayer();
    await player.play(UrlSource(url));
  }

  final indexProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
                            fontWeight: FontWeight.bold,
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
                            if (data.phonetics![0].audio == "") {
                              playAudioFromUrl(
                                data.phonetics![1].audio.toString(),
                              );
                            } else {
                              playAudioFromUrl(
                                data.phonetics![0].audio.toString(),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.speaker_rounded,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final currentIndex = ref.watch(indexProvider);
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                data.meanings!.asMap().entries.map((entry) {
                              int index = entry.key;
                              var meaning = entry.value;
                              return InkWell(
                                onTap: () {
                                  ref
                                      .watch(indexProvider.notifier)
                                      .update((state) => index);
                                },
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? Colors.blue
                                        : null,
                                    border: Border.all(
                                        width: 1, color: Colors.blue),
                                  ),
                                  child: Center(
                                    child: Text(
                                      meaning.partOfSpeech.toString(),
                                      style: currentIndex == index
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white)
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final index = ref.watch(indexProvider);
                        return RichText(
                          text: TextSpan(
                            text: "DEFINITIONS ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: data.meanings![index].definitions!.length
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final index = ref.watch(indexProvider);
                        return Text(
                          data.meanings![index].definitions![0].definition
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final index = ref.watch(indexProvider);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "SYNONYMS ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: data
                                          .meanings![index].synonyms!.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data.meanings![index].synonyms!
                                    .take(4)
                                    .map((e) => Text(
                                          e,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.blue,
                                              ),
                                        ))
                                    .toList(),
                              )
                            ],
                          );
                        }),
                        Consumer(builder: (context, ref, child) {
                          final index = ref.watch(indexProvider);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "ANTONYMS ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: data
                                          .meanings![index].antonyms!.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data.meanings![index].antonyms!
                                    .take(4)
                                    .map((e) => Text(
                                          e,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.blue,
                                              ),
                                        ))
                                    .toList(),
                              )
                            ],
                          );
                        }),
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
