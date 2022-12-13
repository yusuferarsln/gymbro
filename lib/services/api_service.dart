import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbro/hasura/hasura.dart';
import 'package:gymbro/models/basic_user_model.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/models/image_model.dart';
import 'package:gymbro/models/move_model.dart';
import 'package:http/http.dart';

import '../models/workout_model.dart';

ApiService get api => ApiService.instance;

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  final Uri url = Uri.parse('http://141.147.30.156:5050/');

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

  Future<Map<String, dynamic>?> get currentUserClaims async {
    final user = FirebaseAuth.instance.currentUser;

    // If refresh is set to true, a refresh of the id token is forced.
    final idTokenResult = await user?.getIdTokenResult(true);

    return idTokenResult!.claims;
  }

  Future<List<BasicUserModel>> getUserDetail() async {
    var result = await api.currentUserClaims;
    var uuid = result!['sub'];

    final queryx = Hasura.queryList(table: 'users', returning: {
      'id',
      'user_email'
    }, where: {
      'uuid': {'_eq': uuid}
    });
    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(queryx.body),
    );

    print(response.body);
    final data = jsonDecode(response.body)['data']['users'];

    return List.from(data).map((e) => BasicUserModel.fromJson(e)).toList();
  }

  Future<bool> sendRequest(int gymId, int userId) async {
    print(gymId);
    print(userId);
    final queryx = Hasura.insert(
      table: "user_gyms",
      object: {
        "user_id": userId,
        "gym_id": gymId,
        'status': 0,
        'is_active': false
      },
      returning: {"status"},
    );

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(queryx.body),
    );
    final data = jsonDecode(response.body)['data'];

    print(response.body);
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getUserID() async {
    var result = await api.currentUserClaims;
    var uuid = result!['sub'];

    final queryx = Hasura.queryList(table: 'users', returning: {
      'id',
    }, where: {
      'uuid': {'_eq': uuid}
    });
    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(queryx.body),
    );

    print(response.body);
    final data = jsonDecode(response.body)['data']['users'][0]['id'];

    return data;
  }

  Future<int> getGymID(int userID) async {
    final queryx = Hasura.queryList(table: 'user_gyms', returning: {
      'gym_id',
    }, where: {
      'user_id': {'_eq': userID}
    });
    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode(queryx.body),
    );

    print(response.body);
    final data = jsonDecode(response.body)['data']['user_gyms'][0]['gym_id'];

    return data;
  }

  Future<List<ImageModel>> getMoveImg() async {
    print('starting');
    var query = ''' 
 query MyQuery {
  gym_moves(order_by: {id: asc}) {
    move_img
  }
}

''';

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode({'query': query}),
    );

    final data = jsonDecode(response.body)['data']['gym_moves'];
    print(data);

    return List.from(data).map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<List<WorkoutModel>> getWorkouts(int gymID, int userID) async {
    print('starting');
    var query = ''' 
  query MyQuery {
  user_gyms(where: {_and: {gym_id: {_eq: "$gymID"}}, user_id: {_eq: "$userID"}}) {
    user_workouts_relations {
      chest
      id
    }
  }
}



''';

    final response = await post(
      Uri.parse('${url}dbRelay'),
      body: jsonEncode({'query': query}),
    );

    final data = jsonDecode(response.body)['data']['user_gyms'][0]
        ['user_workouts_relations'];
    print(data);

    return List.from(data).map((e) => WorkoutModel.fromJson(e)).toList();
  }
}
