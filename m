From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Jan 2017 15:24:42 +0100 (CET)
Subject: [Cocci] Coccinelle problems
In-Reply-To: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
References: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1701131521480.2041@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Attached is a new version of pdev-simple.cocci.  The rule m1 checks for
the existence of a &pdev->dev and the rule m2 checks whether there already
exists a device declaration.  If the first is satisfied and the second is
not, then the transformation is made using <... ...> rather than <+...
...+> which is often nore expensive.

julia
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

// The following rule hangs on:
//	drivers/input/keyboard/adp5588-keys.c
//	drivers/input/keyboard/adp5589-keys.c
//	drivers/input/touchscreen/wdt87xx_i2c.c

@m1 exists@
identifier probe.probefn;
identifier ptype.pdev;
type ptype.T;
position p;
symbol dev;
@@

probefn at p(T *pdev, ...) {
 ...
 &pdev->dev
 ... when any
}

@m2 exists@
identifier probe.probefn;
identifier ptype.pdev;
type ptype.T;
position m1.p;
symbol dev;
@@

probefn at p(T *pdev, ...) {
...
struct device *dev = &pdev->dev;
... when any
}

@depends on m1 && !m2@
identifier probe.probefn;
identifier ptype.pdev, dev;
type ptype.T;
position m1.p;
@@

  probefn at p(T *pdev, ...) {
+ struct device *dev = &pdev->dev;
  <...
- &pdev->dev
+ dev
  ...>
  }
