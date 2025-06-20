import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_must_eat_place_app/model/address.dart';
import 'package:riverpod_must_eat_place_app/vm/database_handler.dart';


class VMHandler extends StateNotifier<List<Address>>{
  final DatabaseHandler _dbHandler = DatabaseHandler();

  VMHandler() : super([]){
    loadAddress(); // 시작할때 데이터 불러와야 한다.
  }
  
  Future<void> loadAddress()async{
    final result = await _dbHandler.queryAddress();
    state = result;
  }


  Future<void> insertAddress(Address address)async{
    await _dbHandler.insertAddress(address);
    await loadAddress();
  }


  Future<void> updateAddress(Address address)async{
    await _dbHandler.updateAddress(address);
    await loadAddress();
  }


  Future<void> updateAddressAll(Address address)async{
    await _dbHandler.updateAddressAll(address);
    await loadAddress();
  }


  Future<void> deleteAddress(int id)async{
    await _dbHandler.deleteAddress(id);
    await loadAddress();
  }
}

final vmHandlerProvider = StateNotifierProvider<VMHandler, List<Address>>(
  (ref) => VMHandler(),
);