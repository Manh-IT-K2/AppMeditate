import 'package:flutter/material.dart';
import 'package:meditation_app/Widgets/choose_topic_page_widget/body_topicgrid_widget.dart';
import 'package:meditation_app/Widgets/choose_topic_page_widget/header_topic_widget.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/Repository/topic_storage.dart';

final topicStorage = AssetTopicStorage();

class ChooseTopicPage extends StatelessWidget {
  const ChooseTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReponsiveBuilder(
        portrait: Column(
          children: const [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: HeaderChooseTopicWidget(),
            ),
            Flexible(
              flex: 3,
              child: BodyTopicGridWidget(),
            ),
          ],
        ),
        landscape: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: const [
                  Expanded(child: HeaderChooseTopicWidget()),
                  Spacer(),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: const BodyTopicGridWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
