#include <WiFi.h>
#include <WebSocketsServer.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ST7789.h>
#include <ESP32Ping.h>


// Define GPIO pins for hardware SPI
//#define PIN_NUM_MISO 19 //G19 DEFAULT VSPI
//#define PIN_NUM_MOSI 23 //G23 DEFAULT VSPI
//#define PIN_NUM_CLK  18 //D18 DEFAULT VSPI
#define TFT_CS 5    // G5
#define TFT_DC 16   // G16
#define TFT_RST 17  // G17

// Dimensions of the TFT display
#define TFT_WIDTH 135
#define TFT_HEIGHT 240


//const char* ssid = "DESKTOP-RCRV73B 3238";
//const char* password = "X70t684*";
const char* ssid = "iPhone von Steven";
const char* password = "hallo12345";
IPAddress local_IP(192, 168, 31, 115);
IPAddress gateway(192, 168, 31, 1);
IPAddress subnet(255, 255, 0, 0);
IPAddress primaryDNS(8, 8, 8, 8); //optional
IPAddress secondaryDNS(8, 8, 4, 4); //optional

WebSocketsServer webSocket = WebSocketsServer(8080);
Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);

const size_t RGB_BITMAP_SIZE = TFT_WIDTH * TFT_HEIGHT * sizeof(uint16_t);
uint16_t rgbBitmap[TFT_WIDTH * TFT_HEIGHT];

// Define the required variables
bool receivingImage = true;
uint8_t* imageBuffer = nullptr;
size_t totalImageSize = TFT_WIDTH * TFT_HEIGHT * 2;
size_t receivedImageSize = 0;

void setup() {
  Serial.begin(115200);
  //while (!Serial);

  if (!WiFi.config(local_IP, gateway, subnet, primaryDNS, secondaryDNS)) {
    Serial.println("STA Failed to configure");
  }

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("");
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("ESP Mac Address: ");
  Serial.println(WiFi.macAddress());
  Serial.print("Gateway IP: ");
  Serial.println(WiFi.gatewayIP());
  Serial.print("DNS: ");
  Serial.println(WiFi.dnsIP());

  IPAddress ip (192, 168, 137, 1); // The remote ip to ping
  bool ret = Ping.ping(ip);
  Serial.println(ret);

  // Initialize TFT display
  tft.init(TFT_WIDTH, TFT_HEIGHT);
  tft.setRotation(2);
  tft.fillScreen(65535);

  // Start WebSocket server
  webSocket.begin();
  webSocket.onEvent(onWebSocketEvent);
}

void loop() {
  webSocket.loop();
}

void onWebSocketEvent(uint8_t num, WStype_t type, uint8_t* payload, size_t length){
 Serial.println("webanfrage");
  Serial.println(type);

  switch (type) {
    case WStype_BIN: {
      // Calculate the remaining image size to be received
      size_t remainingSize = totalImageSize - receivedImageSize;

      // Calculate the size of the chunk to be copied
      size_t chunkSize = (length > remainingSize) ? remainingSize : length;

      // Check if the payload contains the image chunk
      if (receivingImage) {
        // Check if the received image size matches the expected total image size
        if (receivedImageSize + chunkSize > totalImageSize) {
          Serial.println("Invalid image size");
          return;
        }

        // Allocate memory for the image buffer on the first chunk
        if (imageBuffer == nullptr) {
          imageBuffer = new uint8_t[totalImageSize];
        }

        // Copy the chunk to the image buffer
        memcpy(imageBuffer + receivedImageSize, payload, chunkSize);

        // Update the received image size
        receivedImageSize += chunkSize;

        // Check if the complete image has been received
        if (receivedImageSize == totalImageSize) {
          // Display the RGB565 bitmap on the TFT display
          tft.drawRGBBitmap(0, 0, (uint16_t*)imageBuffer, TFT_WIDTH, TFT_HEIGHT);

          // Clean up the allocated memory
          delete[] imageBuffer;
          imageBuffer = nullptr;

          // Reset the receivingImage flag for the next image
          receivingImage = true;
          receivedImageSize = 0;
        }
      }
      
      break;
    }
    default:
      Serial.println("in default: ");
      // Print each byte as a two-digit hexadecimal value
      for (size_t i = 0; i < length; i++) {
        if (payload[i] < 16) {
          Serial.print("0"); // Print leading zero for single-digit values
        }
        Serial.print(payload[i], HEX); // Print the byte as a hexadecimal value
        Serial.print(" ");
      }
      Serial.println();
      break;
  }
}
