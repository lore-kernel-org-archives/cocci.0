From: guenter@roeck-us.net (Guenter Roeck)
Date: Sun, 15 Jan 2017 08:29:03 -0800
Subject: [Cocci] More coccinelle problems
Message-ID: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I got another script which hangs for me. It actually works on almost all files,
but hangs in drivers/input/keyboard/gpio_keys_polled.c. The hang does not happen
if I remove the 'reformat' rule.

In case you wonder, the idea is to reformat the code if another rule touched
function parameters. I stripped the context to make the problem easier to
reproduce.

If you have an idea what might cause the hang, please let me know.

Thanks,

Guenter


-------------- next part --------------
virtual patch

@initialize:python@
@@

f = open('coccinelle.log', 'a')

@probe@
identifier p, probefn;
declarer name module_platform_driver_probe;
@@
(
  module_platform_driver_probe(p, probefn);
|
  struct platform_driver p = {
    .probe = probefn,
  };
|
  struct i2c_driver p = {
    .probe = probefn,
  };
|
  struct spi_driver p = {
    .probe = probefn,
  };
)

// Get type of device.
// Using it ensures that we don't touch any other data structure
// which might have a '->dev' object.

@ptype depends on probe@
type T;
identifier probe.probefn;
identifier pdev;
@@
probefn(T *pdev, ...) { ... }

@e depends on probe exists@
identifier initfn;
identifier d;
identifier pdev;
type ptype.T;
position p;
@@

initfn at p(T *pdev, ...) {
  <+...
  struct device *d = &pdev->dev;
  ...+>
}

// formatting cleanup

@c@
identifier e.initfn;
identifier fn;
position e.p;
position p1;
identifier e.d;
@@
initfn at p(...) {
<...
  fn@p1(d, ...)
...>
}

@script:python depends on c@
p << c.p1;
@@

i=0
while i < len(p):
    print "%s:%s" % (p[i].file, p[i].line)
    i = i + 1

@reformat@
identifier fn;
position c.p1;
expression list EL;
@@
<+...
- fn@p1(EL)
+ fn(EL)
...+>
