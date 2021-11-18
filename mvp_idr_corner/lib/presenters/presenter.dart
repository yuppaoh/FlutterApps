import 'package:mvp_idr_corner/models/model.dart';
import 'package:mvp_idr_corner/views/view.dart';

class AppPresenter {
  set view(AppView appView){}
  void btnClick(){}

}

class BasicAppPresenter implements AppPresenter {
  AppModel? _model;
  AppView? _view;

  BasicAppPresenter(){
    this._model = AppModel();
  }

  @override
  void set view(AppView appView) {
    this._view = appView;
    this._view!.refreshData(this._model!);
  }

  @override
  void btnClick() {
    int v1 = int.parse(this._model!.textController1.text);
    int v2 = int.parse(this._model!.textController2.text);
    this._model!.result = v1 + v2;
    this._view!.refreshData(this._model!);
  }
}