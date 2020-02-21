/// 资源链接
const LOCAL_SERVER = 'http://192.168.124.5/server'; // 本地服务器
const imgs_base = 'https://s2.ax1x.com/';

/// 开眼视频(日报版块)
/// 请求头
/// { 'User-Agent': POST_MAN }
/// 请求参数
/// {
///   'deviceModel': 'GM1910',  设备型号
///   'date': 1565226000000,  时间戳(往期视频查询)
///   'num': 10  总页数
/// }
const POST_MAN = 'PostmanRuntime/7.16.1';
const EYE_DAILY = 'https://baobab.kaiyanapp.com/api/v5/index/tab/feed';

/// 和风天气 🌞
const HE_WEATHER_BASE = 'https://free-api.heweather.net/s6/weather';
const weatherKey = '985cb464f7ae4866a1fc35fd63e17e42'; // 和风天气密钥
const now = '$HE_WEATHER_BASE/now'; // 今日天气
const hourly = '$HE_WEATHER_BASE/hourly'; // 实时天气
const forecast = '$HE_WEATHER_BASE/forecast'; // 未来天气
const lifestyle = '$HE_WEATHER_BASE/lifestyle'; // 生活建议

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
