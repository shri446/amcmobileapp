
const clientId = "mobile-app";
const clientSecret = "mobile-secret";
const baseUrl = "http://172.25.65.60:8080";
// const baseUrl = "http://172.25.65.240:8081";

String getWebsocketUrl(){
  return baseUrl.startsWith("http") ? baseUrl.replaceAll("http", "ws") : baseUrl.replaceAll("https", "wss");
}