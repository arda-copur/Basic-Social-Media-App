import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_paddings.dart';
import 'package:user_app/service/status_service.dart';
import 'package:user_app/widgets/custom_loading.dart';

class StatusList extends StatefulWidget {
  const StatusList({super.key});

  @override
  State<StatusList> createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  final StatusService _statusService = StatusService();

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  StreamBuilder _body() {
    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const CustomLoading()
            : snapshot.data == null
                ? const CustomLoading()
                : _mainBody(snapshot);
      },
    );
  }

  ListView _mainBody(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot myPost = snapshot.data!.docs[index];
        return Padding(
          padding: const ProjectPaddings.highPadding(),
          child: _statusContainer(myPost),
        );
      },
    );
  }

  Container _statusContainer(DocumentSnapshot myPost) {
    return Container(
      decoration: BoxDecoration(
          color: ProjectColors.white, borderRadius: BorderRadius.circular(20)),
      child: _statusColumn(myPost),
    );
  }

  Column _statusColumn(DocumentSnapshot myPost) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "@${myPost['anlikKullanici']}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: ProjectColors.primaryColor,
                fontSize: 14),
          ),
        ),
        Padding(
          padding: const ProjectPaddings.normalPadding(),
          child: Text(
            myPost['status'],
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Image.network(
          myPost['image'],
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
      ],
    );
  }
}
