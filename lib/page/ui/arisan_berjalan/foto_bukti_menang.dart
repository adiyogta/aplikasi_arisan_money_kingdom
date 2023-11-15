import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:flutter/material.dart';

class FotoMenang extends StatefulWidget {
  final Peserta peserta;
  FotoMenang(this.peserta);

  @override
  _FotoMenangState createState() => _FotoMenangState();
}

class _FotoMenangState extends State<FotoMenang> {
  @override
  Widget build(BuildContext context) {
    return (widget.peserta.buktiTransferMenang != null)
        ? GestureDetector(
            onTap: () async {
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
                  title: Center(
                    child: Text(
                        "Bukti Menang Slot " +
                            widget.peserta.slotNomor.toString(),
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: GestureDetector(
                      onDoubleTapDown: _handleDoubleTapDown,
                      onDoubleTap: _handleDoubleTap,
                      onLongPress: _handleTripleTap,
                      onLongPressEnd: _handleTripleTapDown,
                      child: InteractiveViewer(
                        transformationController: _transformationController,
                        child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                              'https://api.moneykingdom.org/public/bukti-transfer-menang/' +
                                  widget.peserta.buktiTransferMenang,
                              scale: 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: FlatButton(
              shape: StadiumBorder(),
              color: Colors.pink[600],
              child: Text(
                'Lihat Foto Bukti',
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () async {
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
                    title: Center(
                      child: Text(
                          "Bukti Menang Slot " +
                              widget.peserta.slotNomor.toString(),
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: GestureDetector(
                        onDoubleTapDown: _handleDoubleTapDown,
                        onDoubleTap: _handleDoubleTap,
                        onLongPress: _handleTripleTap,
                        onLongPressEnd: _handleTripleTapDown,
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          child: Image(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                'https://api.moneykingdom.org/public/bukti-transfer-menang/' +
                                    widget.peserta.buktiTransferMenang,
                                scale: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.09,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white,
              ),
            ),
          );
  }
}
