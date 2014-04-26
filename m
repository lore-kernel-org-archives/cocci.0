From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 26 Apr 2014 16:06:18 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <535B6EB3.9070705@users.sourceforge.net>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
 <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
 <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
 <535B6EB3.9070705@users.sourceforge.net>
Message-ID: <CABxcv=nOLP3mR1jWf_k=ahdQ=5Y-O=CimmKUWACVuAmzGpOsHQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Markus

On Sat, Apr 26, 2014 at 10:30 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Besides moving the function pointers assigned to the structure
>> gpio_chip fields to the new struct gpio_chip_ops, a pointer to the new
>> struct gpio_chip_ops has to be assigned to the struct gpio_chip .ops field.
>
> Will any macros become relevant for such a source code reorganisation?
>

Not really, I was not thinking in adding any macros although there are
drivers using macros to initialize the data structure if that is what
you mean, I'll add more detail about this point below.

>
>> So where to put the new structure is constrained by where struct
>> gpio_chip fields are set. If is easier we can define to be just before
>> the function where the assignments were made but I don't know if it
>> can be generalized.
>
> I am curious how a generalisation should be described here.
>
>

me too :-)

Right now I identified 3 different patters:

1) When there is already a global gpio_chip structure declared and
initialized using the C99 tagged approach, i.e:

static struct gpio_chip ixp4xx_gpio_chip = {
-       .label                  = "IXP4XX_GPIO_CHIP",
+static const struct gpio_chip_ops ixp4xx_gpio_ops = {
        .direction_input        = ixp4xx_gpio_direction_input,
        .direction_output       = ixp4xx_gpio_direction_output,
        .get                    = ixp4xx_gpio_get_value,
        .set                    = ixp4xx_gpio_set_value,
+};
+
+static struct gpio_chip ixp4xx_gpio_chip = {
+       .label                  = "IXP4XX_GPIO_CHIP",
        .to_irq                 = ixp4xx_gpio_to_irq,
        .base                   = 0,
        .ngpio                  = 16,
+       .ops                    = &ixp4xx_gpio_ops,
 };

this is the easiest case in my opinion and the answer to Julia's
question about where to place the new gpio_chip_ops data structure is
easily answered since is just before the struct gpio_chip declaration.

2) When there isn't a global gpio_chip structure defined but it is
embedded in another structure and it is not statically initialized on
compile time but in a procedural on runtime, i.e:

+static const struct gpio_chip_ops scoop_gpio_ops = {
+       .set                    = scoop_gpio_set,
+       .get                    = scoop_gpio_get,
+       .direction_input        = scoop_gpio_direction_input,
+       .direction_output       = scoop_gpio_direction_output,
+};
+
 unsigned short read_scoop_reg(struct device *dev, unsigned short reg)
 {
        struct scoop_dev *sdev = dev_get_drvdata(dev);
@@ -220,10 +227,7 @@ static int scoop_probe(struct platform_device *pdev)
                devptr->gpio.label = dev_name(&pdev->dev);
                devptr->gpio.base = inf->gpio_base;
                devptr->gpio.ngpio = 12; /* PA11 = 0, PA12 = 1, etc.
up to PA22 = 11 */
-               devptr->gpio.set = scoop_gpio_set;
-               devptr->gpio.get = scoop_gpio_get;
-               devptr->gpio.direction_input = scoop_gpio_direction_input;
-               devptr->gpio.direction_output = scoop_gpio_direction_output;
+               devptr->gpio.ops = &scoop_gpio_ops;

                ret = gpiochip_add(&devptr->gpio);
                if (ret)

this one is trickier because you just can't do:

$ git grep "struct gpio_chip [_a-zA-Z][_a-zA-Z0-9]*.= {

first you have to look where the gpio_chip is declared, take that
identifier and search in which function is initialized. Also is the
question to where to place the new structure since it has to be before
it is referenced in the code. Probably a good candidate is to place it
just before the function where the gpio_chip fields are set. For what
I've been looking at spatch syntax that should be easy doable.

3) When none of the above patters are used, i.e:

+static const struct gpio_chip_ops msm_gpiolib_ops = {
+       .direction_input        = msm_gpiolib_direction_input,
+       .direction_output       = msm_gpiolib_direction_output,
+       .get                    = msm_gpiolib_get,
+       .set                    = msm_gpiolib_set,
+};
+
 #define TROUT_GPIO_BANK(name, reg_num, base_gpio, shadow_val)          \
        {                                                               \
                .chip = {                                               \
                        .label            = name,                       \
-                       .direction_input  = msm_gpiolib_direction_input,\
-                       .direction_output = msm_gpiolib_direction_output, \
-                       .get              = msm_gpiolib_get,            \
-                       .set              = msm_gpiolib_set,            \
                        .to_irq           = trout_gpio_to_irq,          \
                        .base             = base_gpio,                  \
                        .ngpio            = 8,                          \
+                       .ops              = &msm_gpiolib_ops,           \
                },                                                      \
                .reg = (void *) reg_num + TROUT_CPLD_BASE,              \
                .shadow = shadow_val,

Here a macro is used since there are many GPIO controllers so the
driver does this:

static struct msm_gpio_chip msm_gpio_banks[] = {
#if defined(CONFIG_MSM_DEBUG_UART1)
        /* H2W pins <-> UART1 */
        TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x40),
#else
        /* H2W pins <-> UART3, Bluetooth <-> UART1 */
        TROUT_GPIO_BANK("MISC2", 0x00,   TROUT_GPIO_MISC2_BASE, 0x80),
#endif
        /* I2C pull */
        TROUT_GPIO_BANK("MISC3", 0x02,   TROUT_GPIO_MISC3_BASE, 0x04),
        TROUT_GPIO_BANK("MISC4", 0x04,   TROUT_GPIO_MISC4_BASE, 0),
        /* mmdi 32k en */
        TROUT_GPIO_BANK("MISC5", 0x06,   TROUT_GPIO_MISC5_BASE, 0x04),
        TROUT_GPIO_BANK("INT2", 0x08,    TROUT_GPIO_INT2_BASE,  0),
        TROUT_GPIO_BANK("MISC1", 0x0a,   TROUT_GPIO_MISC1_BASE, 0),
        TROUT_GPIO_BANK("VIRTUAL", 0x12, TROUT_GPIO_VIRTUAL_BASE, 0),
};

or drivers that also use an array of gpio_chips too. i.e:

struct gpio_chip alchemy_gpio_chip[] = {
+static const struct gpio_chip_ops alchemy_gpio_chip_ops[] = {
        [0] = {
-               .label                  = "alchemy-gpio1",
                .direction_input        = gpio1_direction_input,
                .direction_output       = gpio1_direction_output,
                .get                    = gpio1_get,
                .set                    = gpio1_set,
-               .to_irq                 = gpio1_to_irq,
-               .base                   = ALCHEMY_GPIO1_BASE,
-               .ngpio                  = ALCHEMY_GPIO1_NUM,
        },
        [1] = {
-               .label                  = "alchemy-gpio2",
                .direction_input        = gpio2_direction_input,
                .direction_output       = gpio2_direction_output,
                .get                    = gpio2_get,
                .set                    = gpio2_set,
+       },
+};
+
+struct gpio_chip alchemy_gpio_chip[] = {
+       [0] = {
+               .label                  = "alchemy-gpio1",
+               .to_irq                 = gpio1_to_irq,
+               .base                   = ALCHEMY_GPIO1_BASE,
+               .ngpio                  = ALCHEMY_GPIO1_NUM,
+               .ops                    = &alchemy_gpio_chip_ops[0],
+       },
+       [1] = {
+               .label                  = "alchemy-gpio2",
                .to_irq                 = gpio2_to_irq,
                .base                   = ALCHEMY_GPIO2_BASE,
                .ngpio                  = ALCHEMY_GPIO2_NUM,
+               .ops                    = &alchemy_gpio_chip_ops[1],
        },
 };

But these special cases are the exception and not the norm, I'll
follow Julia's advice to start with 1) and then move to 2) and I'm ok
if I leave 3) out of the spatch and I do the changes manually to have
the complete patch.

>> But I don't want to waste your time since I still didn't have time to
>> get familiar with cocinelle/spatch syntax to get into the details.
>
> I find that the understanding of this syntax is a secondary issue. Is it more
> important to clarify the basic change process before?
>
> Do you need to consider any variations for the initialisation of the affected
> data structure?

Yes, the ones I commented above in 3)

> Is the specification precise enough so that such an algorithm can be added to a
> kind of pattern collection?
> http://refactoring.com/catalog/extractInterface.html
> http://c2.com/cgi/wiki?ExtractInterface

Great, I didn't know that this kind of refactoring pattern was named
ExtractInterface and yes that's exactly what I want to achieve here.
I'm sure other subsystems will benefit from the same semantic patch if
is generic enough so makes sense to me to be included to a demo
collection.

Probably the only change that will have to be made in the spatch is
the regular expression to filter the function names and the name of
the two data structures.

I really appreciate all the help and feedback from you both.

Thanks a lot and best regards,
Javier
