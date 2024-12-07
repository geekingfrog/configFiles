
# To use the keymap
```
qmk flash --keyboard xbows/nature --keymap bepo_keymap.json
```

To create or modify this keymap, go to [https://config.qmk.fm/](https://config.qmk.fm/)

# To compile

* Upload the relevant json file to [qmk configurator](https://config.qmk.fm/#/xbows/knight/LAYOUT)
* Modify, and then download the new json
* Go change `config.h` to add `#define TAPPING_TERM 200` under `qmk cd/keyboards/xbows/knight/config.h`
* Then `qmk compile knight_hrm.json`
* `qmk flash (qmk cd)/knight_hrm.hex`

