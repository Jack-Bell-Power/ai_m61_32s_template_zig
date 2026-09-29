# ai_m61_32s_template

## AI m61 32s support
You don't need to type the long paramator of chip and board when you want to build
the ai m61 32s which is defalut supported.

If you type make at line it will works
first build the zig file
then link the static.a file
then finish the make and you get the firmware
which you can use on BL616/BL618 by default.

If you type make flash COMX=xxx # xxx is your com name
you can flash the firmware to the board which is using by defalut.


## Support CHIP

| CHIP              | Remark |
|:-----------------:|:------:|
| BL602/BL604       |        |
| BL702/BL704/BL706 |        |
| BL702L/BL704L     |        |
| BL616/BL618       |        |
| BL618DG           |        |


## Compile

- BL602/BL604

```
make CHIP=bl602 BOARD=bl602dk
```

- BL702/BL704/BL706

```
make CHIP=bl702 BOARD=bl702dk
```

- BL702L/BL704L

```
make CHIP=bl702l BOARD=bl702ldk
```

- BL616/BL618

```
make CHIP=bl616 BOARD=bl616dk
```

- BL618DG

```
make CHIP=bl618dg BOARD=bl618dgdk CPU_ID=ap
make CHIP=bl618dg BOARD=bl618dgdk CPU_ID=np
```

## Flash

```
make flash CHIP=chip_name COMX=xxx # xxx is your com name
```
