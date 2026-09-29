const Device = opaque {};

extern fn board_init() void;

extern fn bflb_device_get_by_name(name: [*:0]const u8) *Device;

extern fn bflb_gpio_init(
    gpio: *Device,
    pin: u8,
    cfgset: u32,
) void;

extern fn bflb_gpio_set(
    gpio: *Device,
    pin: u8,
) void;

extern fn bflb_gpio_reset(
    gpio: *Device,
    pin: u8,
) void;

extern fn bflb_mtimer_delay_ms(ms: u32) void;

// GPIO pins
const GPIO_PIN_12: u8 = 12;
const GPIO_PIN_14: u8 = 14;
const GPIO_PIN_15: u8 = 15;

// GPIO configuration
const GPIO_OUTPUT: u32 = 1 << 6;
const GPIO_PULLUP: u32 = 1 << 9;
const GPIO_SMT_EN: u32 = 1 << 11;
const GPIO_DRV_0: u32 = 0 << 12;

pub export fn run() void {
    board_init();

    const gpio = bflb_device_get_by_name("gpio");

    const gpio_config =
        GPIO_OUTPUT |
        GPIO_PULLUP |
        GPIO_SMT_EN |
        GPIO_DRV_0;

    bflb_gpio_init(gpio, GPIO_PIN_12, gpio_config);
    bflb_gpio_init(gpio, GPIO_PIN_14, gpio_config);
    bflb_gpio_init(gpio, GPIO_PIN_15, gpio_config);

    while (true) {
        bflb_gpio_set(gpio, GPIO_PIN_12);
        bflb_mtimer_delay_ms(500);

        bflb_gpio_reset(gpio, GPIO_PIN_12);
        bflb_mtimer_delay_ms(500);

        bflb_gpio_set(gpio, GPIO_PIN_14);
        bflb_mtimer_delay_ms(500);

        bflb_gpio_reset(gpio, GPIO_PIN_14);
        bflb_mtimer_delay_ms(500);

        bflb_gpio_set(gpio, GPIO_PIN_15);
        bflb_mtimer_delay_ms(500);

        bflb_gpio_reset(gpio, GPIO_PIN_15);
        bflb_mtimer_delay_ms(500);
    }
}
