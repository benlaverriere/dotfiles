#include QMK_KEYBOARD_H
#include "version.h"
#include "keymap_german.h"
#include "keymap_nordic.h"
#include "keymap_french.h"
#include "keymap_spanish.h"
#include "keymap_hungarian.h"
#include "keymap_swedish.h"
#include "keymap_br_abnt2.h"
#include "keymap_canadian_multilingual.h"
#include "keymap_german_ch.h"
#include "keymap_jp.h"
#include "keymap_bepo.h"
#include "keymap_italian.h"
#include "keymap_slovenian.h"
#include "keymap_danish.h"
#include "keymap_norwegian.h"
#include "keymap_portuguese.h"
#include "keymap_contributions.h"

#include "keymap_steno.h"

#define KC_MAC_UNDO LGUI(KC_Z)
#define KC_MAC_CUT LGUI(KC_X)
#define KC_MAC_COPY LGUI(KC_C)
#define KC_MAC_PASTE LGUI(KC_V)
#define KC_PC_UNDO LCTL(KC_Z)
#define KC_PC_CUT LCTL(KC_X)
#define KC_PC_COPY LCTL(KC_C)
#define KC_PC_PASTE LCTL(KC_V)
#define ES_LESS_MAC KC_GRAVE
#define ES_GRTR_MAC LSFT(KC_GRAVE)
#define ES_BSLS_MAC ALGR(KC_6)
#define NO_PIPE_ALT KC_GRAVE
#define NO_BSLS_ALT KC_EQUAL
#define LSA_T(kc) MT(MOD_LSFT | MOD_LALT, kc)
#define BP_NDSH_MAC ALGR(KC_8)

#define ___ KC_TRANSPARENT
#define _x_ KC_NO
#define KC_ALFRED LALT(KC_SPACE)

#define LAYER_BASE   0
#define LAYER_SYMBOL 1
#define LAYER_MEDIA  2
#define LAYER_STENO  3

enum custom_keycodes {
  RGB_SLD = EZ_SAFE_RANGE,
  KC_MAGENTA,
  KC_GREEN,
  KC_YELLOW,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [LAYER_BASE] = LAYOUT_ergodox_pretty(
    KC_EQUAL,       KC_1,           KC_2,           KC_3,           KC_4,           KC_5,           TG(1),                                          TG(2),          KC_6,           KC_7,           KC_8,           KC_9,           KC_0,           KC_MINUS,
    KC_DELETE,      KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,           KC_LBRACKET,                                    KC_RBRACKET,    KC_Y,           KC_U,           KC_I,           KC_O,           KC_P,           LT(1,KC_BSLASH),
    KC_BSPACE,      KC_A,           KC_S,           KC_D,           KC_F,           KC_G,                                                                           KC_H,           KC_J,           KC_K,           KC_L,           LT(2,KC_SCOLON),LGUI_T(KC_QUOTE),
    KC_LSHIFT,      LCTL_T(KC_Z),   KC_X,           KC_C,           KC_V,           KC_B,           KC_LPRN,                                        KC_RPRN,        KC_N,           KC_M,           KC_COMMA,       KC_DOT,         RCTL_T(KC_SLASH),KC_RSHIFT,
    LT(1,KC_GRAVE), TG(3),          LALT(KC_LSHIFT),KC_LEFT,        KC_RIGHT,                                                                                                       KC_UP,          KC_DOWN,        KC_LBRACKET,    KC_RBRACKET,    KC_ALFRED,
                                                                                                    KC_LALT,        KC_LGUI,        KC_LALT,        LCTL_T(KC_ESCAPE),
                                                                                                                    KC_HOME,        KC_PGUP,
                                                                                    KC_SPACE,       KC_BSPACE,      KC_END,         KC_PGDOWN,      KC_TAB,         KC_ENTER
  ),
  [LAYER_SYMBOL] = LAYOUT_ergodox_pretty(
    KC_ESCAPE,      KC_F1,          KC_F2,          KC_F3,          KC_F4,          KC_F5,          ___,                                            ___,            KC_F6,          KC_F7,          KC_F8,          KC_F9,          KC_F10,         KC_F11,
    ___,            KC_EXLM,        KC_AT,          KC_LCBR,        KC_RCBR,        KC_PIPE,        ___,                                            ___,            KC_UP,          KC_7,           KC_8,           KC_9,           KC_ASTR,        ___,           
    ___,            KC_HASH,        KC_DLR,         KC_LPRN,        KC_RPRN,        KC_GRAVE,                                                                       KC_DOWN,        KC_4,           KC_5,           KC_6,           KC_PLUS,        ___,           
    ___,            KC_PERC,        KC_CIRC,        KC_LBRACKET,    KC_RBRACKET,    KC_TILD,        RGB_HUD,                                        RGB_HUI,        KC_AMPR,        KC_1,           KC_2,           KC_3,           KC_BSLASH,      ___,           
    ___,            ___,            ___,            ___,            ___,                                                                                                            ___,            KC_DOT,         KC_0,           KC_EQUAL,       ___,           
                                                                                                    RGB_MOD,        KC_MAGENTA,RGB_TOG,        RGB_SLD,
                                                                                                                    KC_GREEN, LED_LEVEL,
                                                                                    ___,            ___,            KC_YELLOW, ___,            ___,            KC_TRANSPARENT
  ),
  [LAYER_MEDIA] = LAYOUT_ergodox_pretty(
    ___,            ___,            ___,            ___,            ___,            ___,            ___,                                            ___,            ___,            ___,            ___,            ___,            ___,            ___,           
    ___,            ___,            ___,            ___,            ___,            ___,            ___,                                            ___,            ___,            ___,            ___,            ___,            ___,            ___,           
    ___,            ___,            ___,            ___,            ___,            ___,                                                                            ___,            ___,            ___,            ___,            ___,            KC_MEDIA_PLAY_PAUSE,
    ___,            ___,            ___,            ___,            ___,            ___,            ___,                                            ___,            ___,            ___,            KC_MEDIA_PREV_TRACK,KC_MEDIA_NEXT_TRACK,___,            ___,           
    ___,            ___,            ___,            ___,            ___,                                                                                                     KC_AUDIO_VOL_UP,KC_AUDIO_VOL_DOWN,KC_AUDIO_MUTE,  ___,            ___,           
                                                                                                    ___,            ___,            ___,            ___,           
                                                                                                                    ___,            ___,           
                                                                                    ___,            ___,            ___,            ___,            ___,            KC_WWW_BACK
  ),
  [LAYER_STENO] = LAYOUT_ergodox_pretty(
    _x_,            _x_,            _x_,            _x_,            _x_,            _x_,            _x_,                                            _x_,            _x_,            _x_,            _x_,            _x_,            _x_,            _x_,
    _x_,            _x_,            STN_N1,         STN_N2,         STN_N3,         STN_N4,         STN_N5,                                         STN_N6,         STN_N7,         STN_N8,         STN_N9,         STN_NA,         STN_NB,         _x_,
    _x_,            _x_,            STN_S1,         STN_TL,         STN_PL,         STN_HL,                                                                         STN_FR,         STN_PR,         STN_LR,         STN_TR,         STN_DR,         _x_,
    _x_,            _x_,            STN_S2,         STN_KL,         STN_WL,         STN_RL,         STN_ST2,                                        STN_ST4,        STN_RR,         STN_BR,         STN_GR,         STN_SR,         STN_ZR,         _x_,  
    _x_,            ___,            _x_,            _x_,            _x_,                                                                                                            _x_,            _x_,            _x_,            _x_,            ___,           
                                                                                                    _x_,            _x_,            _x_,            _x_,  
                                                                                                                    _x_,            _x_,  
                                                                                    STN_A,          STN_O,          _x_,            _x_,            STN_E,          STN_U
  ),
};


extern bool g_suspend_state;
extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) {
  rgb_matrix_enable();
}

// HSL colors, but the SL values are 0-255 rather than percentages
#define STENO_COLOR  {146,224,255}
#define ACCENT_COLOR {100,224,255}
#define NO_COLOR     {0,0,0}
#define TEST_COLOR   {0,255,127}
// see also process_record_user / KC_MAGENTA
#define BASE_COLOR   {238,255,255}

const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL][3] = {
  [LAYER_STENO] = {
    // right hand
    NO_COLOR,      NO_COLOR,      NO_COLOR,      NO_COLOR,      NO_COLOR,
    ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,
    STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,
    STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,
    /*empty*/      NO_COLOR,      NO_COLOR,      NO_COLOR,      NO_COLOR,

    // left hand, horizontally mirrored from physical layout
    NO_COLOR,      NO_COLOR,      NO_COLOR,      NO_COLOR,      NO_COLOR,
    ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,  ACCENT_COLOR,
    STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,
    STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,   STENO_COLOR,
    /*empty*/      NO_COLOR,      NO_COLOR,      NO_COLOR,      BASE_COLOR
  },
};

void set_layer_color(int layer) {
  for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
    HSV hsv = {
      .h = pgm_read_byte(&ledmap[layer][i][0]),
      .s = pgm_read_byte(&ledmap[layer][i][1]),
      .v = pgm_read_byte(&ledmap[layer][i][2]),
    };
    if (!hsv.h && !hsv.s && !hsv.v) {
        rgb_matrix_set_color( i, 0, 0, 0 );
    } else {
        RGB rgb = hsv_to_rgb( hsv );
        float f = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
        rgb_matrix_set_color( i, f * rgb.r, f * rgb.g, f * rgb.b );
    }
  }
}

void rgb_matrix_indicators_user(void) {
  if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
  switch (biton32(layer_state)) {
    case 3:
      set_layer_color(3);
      break;
   default:
    if (rgb_matrix_get_flags() == LED_FLAG_NONE)
      rgb_matrix_set_color_all(0, 0, 0);
    break;
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case RGB_SLD:
      if (record->event.pressed) {
        rgblight_mode(1);
      }
      return false;
    case KC_MAGENTA:
      if (record->event.pressed) {
        rgblight_mode(1);
        rgblight_sethsv(238,255,255);
      }
      return false;
    case KC_GREEN:
      if (record->event.pressed) {
        rgblight_mode(1);
        rgblight_sethsv(86,255,128);
      }
      return false;
    case KC_YELLOW:
      if (record->event.pressed) {
        rgblight_mode(1);
        rgblight_sethsv(27,255,255);
      }
      return false;
  }
  return true;
}

uint32_t layer_state_set_user(uint32_t state) {

  uint8_t layer = biton32(state);

  ergodox_board_led_off();
  ergodox_right_led_1_off();
  ergodox_right_led_2_off();
  ergodox_right_led_3_off();
  switch (layer) {
    case 1:
      ergodox_right_led_1_on();
      break;
    case 2:
      ergodox_right_led_2_on();
      break;
    case 3:
      ergodox_right_led_3_on();
      break;
    case 4:
      ergodox_right_led_1_on();
      ergodox_right_led_2_on();
      break;
    case 5:
      ergodox_right_led_1_on();
      ergodox_right_led_3_on();
      break;
    case 6:
      ergodox_right_led_2_on();
      ergodox_right_led_3_on();
      break;
    case 7:
      ergodox_right_led_1_on();
      ergodox_right_led_2_on();
      ergodox_right_led_3_on();
      break;
    default:
      break;
  }
  return state;
};

// Runs just one time when the keyboard initializes.
void matrix_init_user(void) {
    steno_set_mode(STENO_MODE_GEMINI);
};
