import 'package:aplikasi_arisan/page/blocs/poster/poster_bloc.dart';
import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:aplikasi_arisan/page/ui/poster/buat_poster.dart';
import 'package:aplikasi_arisan/page/ui/poster/ubah_poster.dart';
import 'package:aplikasi_arisan/resources/poster_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PosterListUI extends StatefulWidget {
  @override
  _PosterListUIState createState() => _PosterListUIState();
}

class _PosterListUIState extends State<PosterListUI> {
  final PosterBloc _newsBloc = PosterBloc();
  final posterApiProvider = PosterApiProvider();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPosterList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetPosterList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FlatButton(
        height: 25,
        minWidth: 90,
        shape: StadiumBorder(),
        color: Colors.deepPurple[800],
        child: Text(
          'Buat Poster',
          style: Theme.of(context).textTheme.headline5,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: UploadPoster()),
            ),
          ).then((value) => refreshList());
        },
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 243, 250, 1),
            ),
            child: _buildListCovid()),
      ),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PosterBloc, PosterState>(
          listener: (context, state) {
            if (state is PosterError) {}
          },
          child: BlocBuilder<PosterBloc, PosterState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PosterInitial) {
                return _buildLoading();
              } else if (state is PosterLoading) {
                return _buildLoading();
              } else if (state is PosterLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PosterError) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_cellular_no_sim_outlined,
                        size: 45,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, PosterModel model) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(7.0),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: model.poster.length,
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            child: ListTile(
              subtitle: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(175, 45, 45, 1),
                  gradient: LinearGradient(
                    colors: [Colors.blue[800], Colors.lightBlue[900]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: new Container(
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.centerLeft,
                            image: new NetworkImage(
                                'https://api.moneykingdom.org/public/foto/' +
                                    model.poster[index].foto,
                                scale: 1),
                          ),
                        ),
                      ),
                    ),
                    Text(model.poster[index].nama,
                        style: Theme.of(context).textTheme.headline5),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(3),
                        scrollDirection: Axis.vertical,
                        child: Text(model.poster[index].deskripsi,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
              onTap: () {
                final _transformationController = TransformationController();
                TapDownDetails _doubleTapDetails;
                LongPressEndDetails _tripleTapDetails;
                void _handleDoubleTapDown(TapDownDetails details) {
                  _doubleTapDetails = details;
                }

                void _handleTripleTapDown(LongPressEndDetails details) {
                  _tripleTapDetails = details;
                }

                void _handleDoubleTap() {
                  if (_transformationController.value != Matrix4.identity()) {
                    _transformationController.value = Matrix4.identity();
                  } else {
                    final position = _doubleTapDetails.localPosition;
                    // For a 3x zoom
                    _transformationController.value = Matrix4.identity()
                      ..translate(-position.dx * 2, -position.dy * 2)
                      ..scale(3.0);
                    // Fox a 2x zoom
                    // ..translate(-position.dx, -position.dy)
                    // ..scale(2.0);

                  }
                }

                void _handleTripleTap() {
                  if (_transformationController.value != Matrix4.identity()) {
                    _transformationController.value = Matrix4.identity();
                  } else {
                    final position = _tripleTapDetails.localPosition;
                    // For a 3x zoom
                    _transformationController.value = Matrix4.identity()
                      ..translate(-position.dx * 3, -position.dy * 3)
                      ..scale(5.0);
                    // Fox a 2x zoom
                    // ..translate(-position.dx, -position.dy)
                    // ..scale(2.0);

                  }
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: GestureDetector(
                            onDoubleTapDown: _handleDoubleTapDown,
                            onDoubleTap: _handleDoubleTap,
                            onLongPress: _handleTripleTap,
                            onLongPressEnd: _handleTripleTapDown,
                            child: InteractiveViewer(
                              transformationController:
                                  _transformationController,
                              child: Image(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    'https://api.moneykingdom.org/public/foto/' +
                                        model.poster[index].foto,
                                    scale: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.poster[index].nama,
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Deskripsi",
                                style: Theme.of(context).textTheme.headline6),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              child: Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.all(5),
                                  scrollDirection: Axis.vertical,
                                  child: Text(model.poster[index].deskripsi,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                iconSize: 16,
                                icon: Icon(
                                  Icons.create_sharp,
                                  color: Colors.blue[900],
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: UbahPoster(model.poster[index]),
                                    ),
                                  ).then((value) => refreshList());
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            IconButton(
                                iconSize: 16,
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[900],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.pink[300],
                                      title: Center(
                                        child: Text(
                                          "Apakah Anda Yakin Ingin Menghapus Poster ini ?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      content: Row(
                                        children: [
                                          FlatButton(
                                            shape: StadiumBorder(),
                                            color: Colors.red[900],
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Tidak",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          FlatButton(
                                            shape: StadiumBorder(),
                                            color: Colors.lightBlue[900],
                                            onPressed: () async {
                                              final adApiProvider =
                                                  PosterApiProvider();

                                              var id = model.poster[index].id
                                                  .toString();

                                              Map<String, dynamic> jwt =
                                                  await adApiProvider
                                                      .attemptHapusPoster(id);
                                              if (jwt['status_code'] == 200) {
                                                Navigator.pop(context);
                                                refreshList();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Colors.lightGreen[800],
                                                    title: Center(
                                                      child: Text(
                                                        'Poster Sudah Dihapus',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Colors.red[800],
                                                    title: Center(
                                                      child: Text(
                                                        'Gagal Hapus Poster',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      jwt.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Text(
                                              "Ya",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
