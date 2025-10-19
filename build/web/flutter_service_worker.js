'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a74b9c16864186e4cf01abb275719cc2",
"assets/AssetManifest.bin.json": "e645796a02a460c4e7d50463d2a32342",
"assets/AssetManifest.json": "7eba5a9cb41dfed30621f9026f517f38",
"assets/assets/books/atomic_habits.png": "95242e9e7f894344ff60a6f15c4f135e",
"assets/assets/books/Ayat-Ayat_Cinta.png": "87635731307abb1fb9358ed18626c334",
"assets/assets/books/bumi_manusia.png": "a0dab1c65cfdea04fe08bb6b546ff857",
"assets/assets/books/Dilan_1990.png": "996741ad5f2d0e51449c3f8bcdd48185",
"assets/assets/books/filosofi_kopi.png": "8cb2d15c4b05bfdcf4b53990c385e852",
"assets/assets/books/laskar_pelangi.png": "0952026d2d1b4f3d26e1a44e7f32ade7",
"assets/assets/books/Negeri_5_Menara.png": "848fc96ce8dd9fb3451aac07ad20dc40",
"assets/assets/books/norwegian_wood.png": "e35bf395b39528ba27471a216d57a174",
"assets/assets/books/Perahu_Kertas.png": "3c0f7e8325b32a3f35bace06cd5b871a",
"assets/assets/books/Sang_Pemimpi.png": "4732dea74fd84fa340f9fcb2faffe20e",
"assets/assets/cats/anaknya_kucing_kampus.jpg": "55003c67f64184cd68a4e887c2793272",
"assets/assets/cats/bobby.jpg": "75fe0998b020ce9f2c3876e3a011edef",
"assets/assets/cats/Cat.jpg": "2d640bdbe13994e51466e29ccdf9d3d8",
"assets/assets/cats/elus_kucing_wirellees.jpg": "81d3095ff0e73fbb8cb88b9759ecdbe8",
"assets/assets/cats/gosong.jpg": "bf7034a760a7f2b6515522bcf3648e9d",
"assets/assets/cats/Kucing_kampus_bersama_anaknya.jpg": "a79e3cf82873e9316539ce14722abab9",
"assets/assets/cats/Kucing_kampus_bersama_anaknya2.jpg": "858df0f3e75f98eb6355a0c5d90bc58c",
"assets/assets/cats/kucing_let_me_think.jpg": "88099c34fc033ac52239dc31119fe3d9",
"assets/assets/cats/kucing_putih_kampus1.jpg": "e91bc159da1b827bf33d6179d274ca29",
"assets/assets/cats/mam.jpg": "e6a747d27ec6398b246283f3cf59879d",
"assets/assets/cats/meng.jpg": "0cbf1d74dfb7e9e528e61bc995873d72",
"assets/assets/cats/pustakapaw.jpg": "055793b355925e7e41e3bdb0d6b88c38",
"assets/assets/cats/shepy.jpg": "5ba95729e0af8d267b787c0bfc5262c7",
"assets/assets/cats/sicuki.jpg": "7213f586f87ed0bc7068e9bc6654060a",
"assets/assets/cats/sioon_merem.jpg": "3949710d3cf11ea611e035104f133a86",
"assets/assets/cats/Sipino_turu.jpg": "1487490f8bfa187538f5609bc0384ab0",
"assets/assets/cats/sitoldon.jpg": "9fbdb91691b295e2ca7ef270b8ade894",
"assets/assets/cats/wlee.jpg": "f6264b03652c765ba0b8e585bd8d8b65",
"assets/assets/Logo.png": "29b6176e57c76661a612c90955e062ae",
"assets/assets/menu/drink/Cappucino.png": "98fa3a8d3253ce3ca567ac7f611d0feb",
"assets/assets/menu/drink/jus_alpukat.png": "b64a08e28a61bf2f6e327aefadb9d1a8",
"assets/assets/menu/drink/teh_hijau.png": "dc7981b8b46ca96da5103985088f4921",
"assets/assets/menu/food/Croissants_cokelat.png": "d4f4060b2b4e1cbf566387672604855a",
"assets/assets/menu/food/donat.jpg": "acc4c49724ef1b759263592790cbc629",
"assets/assets/menu/food/es_krim_cokelat.png": "7c07dcc59806f9d63d4c274ee7a725d1",
"assets/assets/menu/food/es_krim_vanilla.png": "bd51d3b2e073e822c2e44ce0ecbeeeb5",
"assets/assets/menu/food/mie_ayam.jpg": "5c1fcd8a0d15463370dad7cc0a93c163",
"assets/assets/menu/food/mie_instan.jpg": "369bb665bfca125af294bbdea8fc862d",
"assets/assets/menu/food/nasi_goreng_paw.png": "9d1f417ff0ad2973826de3f5be331b86",
"assets/assets/menu/food/roti_bakar_keju.png": "1015b311285fc7fb9b969dc44bb812a1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "55c00386d5fdde8b8bcf363f3c242719",
"assets/NOTICES": "0ed54002ede9e3c11eb5bd043fb83285",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "463303dbef69925b21583a2b3600cd40",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "af644d5fe45719fa17fcaa12ba186145",
"/": "af644d5fe45719fa17fcaa12ba186145",
"main.dart.js": "8b0d5e3a8e8d8613e49fba9d7c73cb94",
"manifest.json": "2161231d4fe84231f5157e92c5a59495",
"version.json": "b9d3cd0527d9a70c9a372bccfbce9e1d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
