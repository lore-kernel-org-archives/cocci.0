From: guenter@roeck-us.net (Guenter Roeck)
Date: Thu, 12 Jan 2017 20:02:42 -0800
Subject: [Cocci] Coccinelle problems
Message-ID: <d03925e4-f9a0-533c-02b3-b12d3f8236de@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I have a couple of new problems with coccinelle.

First, please have a look at the attached testc.c and test.cocci.
Running test.cocci on testc.c results in a hang. The problems seems
to be related to the number of (to-be-folded) labels.

For the second problem, I attached pdev-simple.cocci. It is supposed
to convert '&pdev->dev' dereferences to use a local variable. The rule
(or, rather, a more complete version of it) works quite well, but it hangs
on a couple of files (listed in the .cocci file). As usual I have no idea what
might be wrong. Replacing <+... ...+> with <... ...> in the 'prb' rule resolves
the hangup, but I have no idea why, and I don't know how to make it work
for the generic case. I also tried a number of variants, which either
did not work or also resulted in a hangup.

I also attached the (almost) complete version of pdev.cocci. It is still work
in progress, and a bit clumsy at times, but works quite well except for
the hangups. Besides the hangup, the most challenging problem for me
is how to count the number of instances of '&pdev->dev'.

If you have an idea what might be wrong, please let me know.

My version of spatch:

spatch version 1.0.6-00053-g45ef175 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: PCRE

Thanks,
Guenter

-------------- next part --------------
A non-text attachment was scrubbed...
Name: testc.c
Type: text/x-csrc
Size: 742 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170112/6a6cda9f/attachment.bin>
-------------- next part --------------
virtual patch

@unneeded_label@
identifier fn;
position p1;
identifier l1,l2;
@@

fn(...) {
<+...
l1:@p1
l2:
...+> }

@fold_label@
identifier unneeded_label.fn;
identifier l,l1,l2;
position p != unneeded_label.p1;
position any p1;
statement S;
@@

fn(...) {
<+...
- goto l1;
+ goto l2;
  ...
-l1:
 <... when != S
 l:@p1
 ...>
 l2:@p
...+> }
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

@e depends on probe@
identifier initfn;
identifier d;
identifier pdev;
type ptype.T;
position p;
@@

initfn at p(T *pdev, ...) {
  ...
  struct device *d = &pdev->dev;
  ...
}

// Use existing 'struct device *' variable for transformations if available

@prb@
identifier e.d;
identifier initfn;
identifier e.pdev;
position e.p;
type ptype.T;
@@

initfn at p(T *pdev, ...) {
  ...
  struct device *d = &pdev->dev;
<+...
- &pdev->dev
+ d
...+> }

// Otherwise make sure that a variable named 'dev' does not already exist.

@script:python expected@
dev;
@@
coccinelle.dev = 'dev'

@have_dev depends on probe@
identifier initfn;
identifier expected.dev;
identifier pdev;
type ptype.T;
position p;
@@

  initfn at p(T *pdev, ...)
  {
  ... when any
  dev
  ...
  }

// Idea is to only replace &pdev->dev if it is used at least twice
// and if no variable with the same name exists. The rule below doesn't
// seem to work, though.
// Q: How do we determine that &pdev->dev exists at least twice ?

/*
@count depends on !prb@
identifier initfn != { prb.initfn, have_dev.initfn };
identifier pdev;
type ptype.T;
position p;
@@

initfn at p(T *pdev, ...) {
  ...
  &pdev->dev
  <+...
  &pdev->dev
  ...+>
}
*/

// The following rule hangs on:
//	drivers/input/keyboard/adp5588-keys.c
//	drivers/input/keyboard/adp5589-keys.c
//	drivers/input/touchscreen/wdt87xx_i2c.c

// transform ...

@new depends on probe && !have_dev && !e@
identifier initfn;
identifier pdev;
type ptype.T;
position p;
@@

  initfn at p(T *pdev, ...) {
  <+...
- &pdev->dev
+ dev
  ...+>
}

// ... and introduce new variable if needed

@newdecl depends on new@
identifier new.initfn;
identifier pdev;
type ptype.T;
position p;
@@

  initfn at p(T *pdev, ...) {
+ struct device *dev = &pdev->dev;
  ...
}

@script:python depends on prb@
p << e.p;
@@

print >> f, "%s:pdev1:%s" % (p[0].file, p[0].line)

@script:python@
p << newdecl.p;
@@

print >> f, "%s:pdev2:%s" % (p[0].file, p[0].line)
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

@prb depends on probe@
identifier probe.probefn;
identifier pdev;
type ptype.T;
position p;
@@

  probefn at p(T *pdev, ...) {
+ struct device *dev = &pdev->dev;
  <+...
- &pdev->dev
+ dev
  ...+>
}
