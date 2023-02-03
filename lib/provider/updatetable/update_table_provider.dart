import 'package:erp_pos/model/updatestatus/updatestatus_models.dart';
import 'package:erp_pos/model/updatetable/update_table_models.dart';
import 'package:erp_pos/pages/homepage/homepage.dart';
import 'package:erp_pos/services/updatestatus/updatestatus_service.dart';
import 'package:erp_pos/services/updatetable/update_table_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateTableProvider extends ChangeNotifier {
  UpdateStatusModels? _tableUpdateModels;
  UpdateStatusModels? get tableupdateModels => _tableUpdateModels;
  int? _status;
  int? get status => _status;

  Future<void> updateTableProvider(BuildContext context, String? tableid,
      String? tablename, String? idarea, String? areaname) async {
    _tableUpdateModels =
        await updateTableService(context, tableid, tablename, idarea, areaname);
    notifyListeners();
  }

  Future<void> updatetableStatus(BuildContext context, String idarea,
      String areaname, String idtable, String tablename) async {
    _tableUpdateModels =
        await updateStatus(context, idarea, areaname, idtable, tablename);

    notifyListeners();
  }
}
