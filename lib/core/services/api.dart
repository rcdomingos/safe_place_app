import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:safe_place_app/core/models/comment.dart';
import 'package:safe_place_app/core/models/place.dart';
import 'package:safe_place_app/core/models/reviews_score.dart';
import 'package:safe_place_app/core/models/user.dart';

const String SERVER_URL = 'http://192.168.1.250:8080/api';

class Api {
  Dio dio = new Dio();

  Future<User> getUserApi(String email, String password) async {
    try {
      var url = '$SERVER_URL/Usuario/login?email=$email&password=$password';

      User user = new User();
      Response response = await dio.get(url);

      var dataJson = jsonDecode(response.data);

      user = User.fromJson(dataJson);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> sendUserRegister(User user) async {
    try {
      var url = '$SERVER_URL/Usuario';
      String responseData;

      var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      var formData = jsonEncode(<String, dynamic>{
        'Name': user.name,
        'Email': user.email,
        'Password': user.password,
      });

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 201) {
        responseData = "ok";
      } else if (response.statusCode == 200) {
        responseData = response.data;
      } else {
        responseData = "Erro interno, tente mais tarde!";
      }
      return responseData;
    } catch (e) {
      return "Erro: " + e.toString();
    }
  }

  ///buscar todos os lugares cadastrados na base
  Future<List<Place>> getAllPlaces() async {
    try {
      var url = '$SERVER_URL/Place/';
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var places = new List<Place>();

      final Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.data);
        for (var place in dataJson) {
          places.add(Place.fromJson(place));
        }
        return places;
      } else {
        return List.empty();
      }
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  ///buscar todos os lugares cadastrados na base
  Future<Place> getPlaceById(int placeId) async {
    try {
      var url = '$SERVER_URL/Place/$placeId';
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.data);

        Place place = new Place.fromJson(dataJson);
        return place;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// buscar todos lugares de uma categoria enviada como parametro
  Future<List<Place>> getPlacesCategoty(int category) async {
    try {
      var url = '$SERVER_URL/Place?category=$category';
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var places = new List<Place>();

      final Response response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.data);
        for (var place in dataJson) {
          places.add(Place.fromJson(place));
        }
        return places;
      } else {
        return List.empty();
      }
    } catch (e) {
      // print(e.toString());
      return List.empty();
    }
  }

  ///Buscar os comentarios de um lugar enviando o id como parametro
  Future<List<Comment>> getCommentPlace(int placeId) async {
    try {
      var url = '$SERVER_URL/Place/$placeId/Comment';

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var comments = new List<Comment>();

      final Response response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var dataJson = jsonDecode(response.data);

        for (var comment in dataJson) {
          comments.add(Comment.fromJson(comment));
        }
        return comments;
      } else {
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }

  ///Adicionar um comentario enviando o nome,email,titulo e o comentario como parametro
  Future<bool> addPlaceComment({
    int placeId,
    int userId,
    String title,
    String comment,
  }) async {
    try {
      var url = '$SERVER_URL/Place/$placeId/Comment';

      var headers = {'Content-Type': 'application/json; charset=UTF-8'};
      var formData = jsonEncode(<String, dynamic>{
        "UserId": userId,
        "Title": title,
        "CommentText": comment
      });

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );
      return (response.statusCode == 201) ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///Deletar um comentario da base enviando o id do comentario como parametro
  Future<bool> deleteCommentPlace(commentId) async {
    try {
      var url = '$SERVER_URL/Place/Comment/$commentId';

      Response response = await dio.delete(url);
      return (response.statusCode == 204) ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///Adicionar a avaliação de um lugar enviando o id e as notas como parametro
  Future<bool> addPlaceScore({int placeId, ReviewsScore score}) async {
    try {
      var url = '$SERVER_URL/Place/$placeId/Score';

      var headers = {'Content-Type': 'application/json; charset=UTF-8'};

      var formData = jsonEncode(<String, dynamic>{
        "UserId": score.userId,
        "CleanScore": score.cleanScore,
        "DistanceScore": score.distanceScore,
        "MaskScore": score.maskScore
      });

      final Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: headers,
        ),
      );

      return (response.statusCode == 201) ? true : false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  ///FAKE API para testes
  Future<bool> _fakeApiTest(int timer) {
    return Future.delayed(Duration(seconds: timer)).then((onValue) => false);
  }
}
