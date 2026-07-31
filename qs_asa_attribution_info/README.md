# qs_asa_attribution_info

获取 Apple Search Ads 归因 Token 和归因信息的 Flutter 插件。

插件内部通过 iOS `AdServices` 获取 attribution token，并使用该 token 请求 Apple AdServices Attribution API。

## 支持平台

| 平台 | 支持情况 |
| --- | --- |
| iOS | 支持，要求 iOS 14.3+ |
| Android | 不支持，调用后返回 `null` |

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_asa_attribution_info: ^1.0.0
```

然后执行：

```bash
flutter pub get
```

## iOS 原生配置

### 1. iOS 版本要求

Apple `AdServices` 的 `AAAttribution.attributionToken()` 需要 iOS 14.3 或更高版本。

如果你的 App 最低支持版本低于 iOS 14.3，也可以继续集成本插件；低版本设备调用时会返回 `null`。

### 2. Pod 配置

插件的 podspec 已经声明以下 iOS framework：

```ruby
s.weak_frameworks = 'AdServices', 'AdSupport', 'iAd'
```

对应 Xcode 中 `Frameworks, Libraries, and Embedded Content` 的配置为：

| Framework | Embed |
| --- | --- |
| `AdServices.framework` | Do Not Embed |
| `AdSupport.framework` | Do Not Embed |
| `iAd.framework` | Do Not Embed |

正常情况下业务 App 不需要手动再添加这三个 framework，CocoaPods 会通过插件 podspec 自动链接。

集成后进入 iOS 工程目录执行：

```bash
cd ios
pod install
```

如果你的项目使用 Flutter 默认 CocoaPods 集成方式，一般只需要正常运行：

```bash
flutter pub get
flutter run
```

### 3. 网络访问

`getAttributionInfo()` 会请求 Apple 官方接口：

```text
https://api-adservices.apple.com/api/v1/
```

请求方式为 `POST`，请求体为 attribution token，`Content-Type` 为 `text/plain`。

如果你的项目配置了代理、网络拦截、ATS 白名单或企业网络策略，请确保可以访问该域名。默认 iOS ATS 配置通常不需要额外添加白名单，因为该接口使用 HTTPS。

### 4. ATT 权限

本插件不主动请求 ATT 权限，也不读取 IDFA。

如果你的业务还有其他广告追踪或跨 App 跟踪行为，请根据你自己的业务合规要求单独处理 ATT 和隐私声明。

## 使用方法

插件方法是静态方法，不需要创建对象。

### 获取 Attribution Token

```dart
import 'package:qs_asa_attribution_info/qs_asa_attribution_info.dart';

final token = await QsAsaAttributionInfo.getAttributionToken();

if (token == null || token.isEmpty) {
  // 获取失败、系统不支持或当前平台不支持
  return;
}

print(token);
```

### 获取归因信息

```dart
import 'package:qs_asa_attribution_info/qs_asa_attribution_info.dart';

final attributionInfo = await QsAsaAttributionInfo.getAttributionInfo();

if (attributionInfo == null || attributionInfo.isEmpty) {
  // 没有归因数据、请求失败、系统不支持或当前平台不支持
  return;
}

print(attributionInfo);
```

### 推荐用法

```dart
import 'package:qs_asa_attribution_info/qs_asa_attribution_info.dart';

Future<void> uploadAsaAttribution() async {
  final attributionInfo = await QsAsaAttributionInfo.getAttributionInfo();

  if (attributionInfo == null || attributionInfo.isEmpty) {
    return;
  }

  // TODO: 上传 attributionInfo 到你的服务端
}
```

## 异常处理

插件已在 Dart 公开方法中做异常兜底：

| 方法 | 失败时返回 |
| --- | --- |
| `getAttributionToken()` | `null` |
| `getAttributionInfo()` | `null` |

业务侧通常不需要再包一层 `try/catch`。建议按 `null` 或空 Map 做降级处理，不要让 ASA 归因失败阻塞注册、登录、订阅等主流程。

可能返回 `null` 的情况包括：

- 当前平台不是 iOS
- iOS 版本低于 14.3
- attribution token 获取失败或为空
- 请求 Apple AdServices Attribution API 失败
- Apple 返回数据为空或解析失败

## 返回数据

`getAttributionInfo()` 返回 Apple AdServices Attribution API 的原始 Map 数据。

不同广告系列、系统版本和 Apple 返回策略下，字段可能不同。建议业务侧按可选字段读取，不要强依赖所有字段都存在。

## 参考

- [Apple Developer Documentation: AdServices](https://developer.apple.com/documentation/adservices)
- [Apple Developer Documentation: AAAttribution.attributionToken()](https://developer.apple.com/documentation/adservices/aaattribution/attributiontoken%28%29)
- [Apple Ads Help: Measuring ad performance on the App Store](https://ads.apple.com/app-store/help/attribution/0028-measuring-ad-performance)
