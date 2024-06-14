import 'dart:io';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class SpentPage extends StatefulWidget {
  const SpentPage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _SpentPageState();
}

class _SpentPageState extends State<SpentPage> {
  final _dfPeriod = DateFormat('MM/yyyy');
  final _dfDay = DateFormat('dd/MM/yyyy');

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _periodController = TextEditingController();
  final _payedDateController = TextEditingController();

  File? _billFile;
  FilePickerResult? _billFileResult;

  File? _voucherFile;
  FilePickerResult? _voucherFileResult;

  @override
  Widget build(BuildContext context) {
    _periodController.text = _dfPeriod.format(DateTime.now());
    _payedDateController.text = _dfDay.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            //ListView(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // padding: const EdgeInsets.all(12.0),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    icon: Icon(
                      Icons.description,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, preencha a descrição';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _periodController,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    labelText: 'Período',
                    icon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showMonthPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024, 1),
                      lastDate: DateTime.now(),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          _periodController.text = _dfPeriod.format(date);
                        });
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _payedDateController,
                  textInputAction: TextInputAction.none,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    labelText: 'Dia de pagamento',
                    icon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024, 1),
                      lastDate: DateTime.now(),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          _payedDateController.text = _dfDay.format(date);
                        });
                      }
                    });
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.any);

                      setState(() {
                        _billFileResult = result;
                      });

                      if (_billFileResult != null) {
                        _billFile = File(_billFileResult!.files.first.path!);
                      }
                    },
                    child: const Text('Anexar Fatura'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_billFileResult?.files.first.name ??
                        'Nenhum arquivo carregado'),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.any);

                      setState(() {
                        _voucherFileResult = result;
                      });

                      if (_voucherFileResult != null) {
                        _voucherFile =
                            File(_voucherFileResult!.files.first.path!);
                      }
                    },
                    child: const Text('Anexar Comprovante'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_voucherFileResult?.files.first.name ??
                        'Nenhum arquivo carregado'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enviando dados...'),
                          showCloseIcon: true,
                          duration: Durations.extralong4,
                        ),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
