import 'package:ca_storage/main.dart';
import 'package:ca_storage/providers/categories.provider.dart';
import 'package:ca_storage/providers/entries.provider.dart';
import 'package:ca_storage/providers/tags.provider.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';

class UnAutorizedInterceptor extends DioException {
  UnAutorizedInterceptor({required super.requestOptions});
}

class ApiService {
  final cookieJar = PersistCookieJar();
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:3000",
      receiveDataWhenStatusError: true,
      followRedirects: true,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ),
  );
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    final cookieJar = PersistCookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.options.validateStatus = (status) {
      if (status == 401) {
        cookieJar.deleteAll();
        return false;
      }
      return true;
    };
  }

  verify() => dio.get("/auth/verify");

  login(String username, String password) => dio.post(
        "/auth/login",
        data: {
          "username": username,
          "password": password,
        },
      );

  Future logout() => dio.post("/auth/logout");

  Future<List<CategoryModel>?> getCategories() async {
    final response = await dio.get("/categories");
    return (response.data as List)
        .map((e) => CategoryModel.fromMap(e))
        .toList();
  }

  Future<List<TagModel>?> getTags() async {
    final response = await dio.get("/tags");
    return (response.data as List).map((e) => TagModel.fromMap(e)).toList();
  }

  Future<List<EntryModel>?> getEntries() async {
    final response = await dio.get("/files");
    return (response.data as List).map((e) => EntryModel.fromMap(e)).toList();
  }

  Future<EntryModel> createEntry(EntryModel entry) async {
    final response = await dio.post("/files", data: entry.toMap());
    return EntryModel.fromMap(response.data);
  }

  Future<EntryModel> updateEntry(EntryModel entry) async {
    final response = await dio.put("/files", data: entry.toMap());
    return EntryModel.fromMap(response.data);
  }

  deleteEntry(String id) => dio.delete("/files/$id");
  pauseEntry(String id) => dio.patch("/files/$id/pause");
  dropEntry(String id) => dio.patch("/files/$id/drop");
  planningEntry(String id) => dio.patch("/files/$id/future");
}
