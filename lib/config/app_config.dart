import 'package:flutter/material.dart';

import 'app_env.dart' show appEnv;
import '../routes/route_name.dart';

enum CacheKey {
  FILTER_MODE_KEY,
  WHITE_LIST_KEY,
  BLACK_LIST_KEY,
}

class AppConfig {
  static Map<CacheKey, String> cacheKey = {
    CacheKey.FILTER_MODE_KEY: 'filter_mode_key',
    CacheKey.WHITE_LIST_KEY: 'white_list_key',
    CacheKey.BLACK_LIST_KEY: 'black_list_key'
  };

  /// 设计稿尺寸 宽750 高1334
  static Size screenSize = const Size(750, 1334);
  /// 背景色
  static Color backgroundColor = const Color(0xFFF5F5F5);
  /// 主色调
  static Color mainColor = const Color(0xFF5E93F5);
  /// 是否开启dio接口详细信息输出，以及其它相关插件调试信息
  static const DEBUG = true;

  /// 是否开启LogUtil类打印方法
  static const printFlag = true;

  /// 是否直接跳过闪屏页面，
  static const notSplash = true;

  /// 是否跳过引导页面
  static const isShowWelcome = true;

  /// 闪屏后跳转的页面（方便调试），需notSplash参数为true才有效果
  static String directPageName = RouteName.appMain;

  /// 是否显示jh_debug浮动按钮
  static const showJhDebugBtn = true;

  /// 是否开启更新app
  static const isUpdateApp = true;

  /// dio请求前缀
  static String host = appEnv.baseUrl;

  /// 是否启用代理，启用代理后，反向代理IP及端口才能生效
  static const usingProxy = false;

  /// 反向代理的IP/域名地址
  static const proxyAddress = '192.168.2.201:9003';
}
