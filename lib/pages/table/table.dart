import 'package:erp_pos/constant/images.dart';
import 'package:erp_pos/pages/table/components/floatingActionButton.dart';
import 'package:erp_pos/pages/table/components/table_body.dart';
import 'package:flutter/material.dart';

class POSTable extends StatefulWidget {
  const POSTable({Key? key}) : super(key: key);

  @override
  State<POSTable> createState() => _POSTableState();
}

class _POSTableState extends State<POSTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableBody(),
      floatingActionButton: BuildFloatingActionButton(),
    );
  }
}
