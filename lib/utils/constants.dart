
const clientId = "mobile-app";
const clientSecret = "mobile-secret";
// const baseUrl = "http://192.168.1.7:8080";
const baseUrl = "http://172.25.65.240:80";

String getWebsocketUrl(){
  return baseUrl.startsWith("http") ? baseUrl.replaceAll("http", "ws") : baseUrl.replaceAll("https", "wss");
}