/// 资源链接
const LOCAL_SERVER = 'http://192.168.124.5/server'; // 本地服务器
const picDemo =
    'https://cdn.pixabay.com/photo/2020/03/03/20/31/laguna-4899802_1280.jpg';

/// 服务声明
// 海外
const private1 = 'https://bit.ly/3adde';
const guide1 = 'https://bit.ly/7dwoe';
const agreement1 = 'https://bit.ly/32rkc';

// 大陆
const page = 'https://mr-cai.gitee.io/dev/html';
const private = '$page/private';
const guide = '$page/private_guide';
const agreement = '$page/agreement';

/// 请求头
/// { 'User-Agent': POST_MAN }
/// 请求参数
/// {
///   'deviceModel': 'GM1910',  设备型号
///   'date': 1565226000000,  时间戳(往期视频查询)
///   'num': 10  总页数
/// }
const POST_MAN = 'PostmanRuntime/7.16.1';

const CHROME =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Mobile Safari/537.36';

/// 开眼视频(API)
const EYE_BASE = 'https://baobab.kaiyanapp.com/api';

/// 日报版块
const EYE_DAILY = '/v5/index/tab/feed';

/// 推荐版块
const EYE_RELATED = '/v4/video/related';

/// 和风天气 🌞
const HE_WEATHER_BASE = 'https://free-api.heweather.net/s6/weather';
const weatherKey = '604c3a417ef24a61ac201b467a7ce55c'; // 和风天气密钥
const now = '$HE_WEATHER_BASE/now'; // 今日天气
const hourly = '$HE_WEATHER_BASE/hourly'; // 实时天气
const forecast = '$HE_WEATHER_BASE/forecast'; // 未来天气
const lifestyle = '$HE_WEATHER_BASE/lifestyle'; // 生活建议

/// 扩展小程序
const EXT_BASE = 'https://www.mocky.io/v2';
const typeList = '5e78fd0c2d0000ab7b18ba1a';

/// 谷歌广告密钥
// Android 正式
const bannerUnit = 'ca-app-pub-9275143816186195/7092152699';
const intersUnit = 'ca-app-pub-9275143816186195/1089851125';
const rewardUnit = 'ca-app-pub-9275143816186195/3111888542';
// Android 测试
const bannerTest = 'ca-app-pub-3940256099942544/6300978111';
const intersTest = 'ca-app-pub-3940256099942544/6300978111';
const rewardTest = 'ca-app-pub-3940256099942544/5224354917';

/// 腾讯广告
// Android 正式
const appID = 1109716769;
const bannerID = 9040882216019714;
const nativeID = 4060287287437033;
const intersID = 7080080247106780;
const splashID = 7020785136977336;
const bgPic = 'intelligent.fun_refresh:mipmap/splash_img';
// Android 测试
const appIDTest = 0;
const bannerIDTest = 0;
const nativeIDTest = 0;
const intersIDTest = 0;
const splashIDTest = 0;

const tencentID = '1109685869';
