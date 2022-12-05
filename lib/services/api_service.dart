import 'dart:convert';

import 'package:gymbro/hasura/hasura.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/models/move_model.dart';
import 'package:http/http.dart';

ApiService get api => ApiService.instance;

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final Uri url = Uri.parse('http://localhost:8080/');

  setUser(String name, String email, String uuid) async {
    final query = Hasura.insert(
        table: 'users',
        object: {'user_name': name, 'user_email': email, 'uuid': uuid},
        returning: {'id'});

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(query.body),
    );

    final data = jsonDecode(response.body);
    print(response.body);

    return data;
  }

  Future<List<GymModel>> getGyms() async {
    final query = Hasura.queryList(
      table: 'gym_records',
      returning: {
        'id',
        'gym_name',
        'gym_image',
        'gym_address',
        'gym_tool_count',
        'gym_member_count'
      },
    );

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(query.body),
    );

    final data = jsonDecode(response.body)['data']['gym_records'];

    return List.from(data).map((e) => GymModel.fromJson(e)).toList();
  }

  Future<List<MoveModel>> getMoves(String moveArea) async {
    final query = Hasura.queryList(table: 'gym_moves', returning: {
      'id',
      'move_name',
      'move_area',
    }, where: {
      'move_area': {'_eq': moveArea}
    });

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(query.body),
    );

    final data = jsonDecode(response.body)['data']['gym_moves'];
    print(data);
    print(query.body);

    return List.from(data).map((e) => MoveModel.fromJson(e)).toList();
  }

  Future fetchMoves(String area, String moves) async {
    final queryx = Hasura.insert(
      table: "gym_moves",
      object: {"move_area": area, "move_name": moves},
      returning: {"id"},
    );

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(queryx.body),
    );

    print(response.body);
  }
}
