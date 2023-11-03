import 'package:get/get.dart';

class EventListState{

  final _eventState = 0.obs;
  set eventState(value) => this._eventState.value = value;
  get eventState => this._eventState.value;


  final _examineState = 0.obs;
  set examineState(value) => this._examineState.value = value;
  get examineState => this._examineState.value;

}