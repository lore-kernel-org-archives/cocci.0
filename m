From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 29 Dec 2016 12:08:26 -0800
Subject: [Cocci] Adding calls to devm_add_action_or_reset()
Message-ID: <20161229200826.GA3657@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I am trying to replace explicit calls to clk_disable_unprepare()
with calls to devm_add_action_or_reset() right after the call to
clk_prepare_enable(). Unfortunately I can not get it to work.
The rule below (derived from the kzalloc -> devm_kzalloc rule)
only works on three of 20 watchdog drivers.

Can you by any chance tell what is wrong ? I am completely clueless.

A secondary issue is that the added call should be

	v = devm_add_action_or_reset(&pdev->dev, (void (*)(void *))clk_disable_unprepare, e1);

but coccinelle doesn't like that. Is that a problem with coccinelle
or a problem with the statement ?

Thanks,
Guenter

---
@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@r depends on platform@
identifier platform.probefn;
expression e1;
expression e2;
position p;
@@
probefn(...) {
<+...
e1 = clk_prepare_enable@p(e2);
...+>
}

@rx depends on r@
identifier platform.probefn;
expression e1, e2, e3;
position r.p;
statement S;
@@
probefn(...) {
<+...
e1 = clk_prepare_enable@p(e2);
S
e3 = devm_add_action_or_reset(..., e2);
...+>
}

@prb depends on !rx@
identifier platform.probefn, pdev;
local idexpression v;
expression e1;
position r.p;
@@

probefn(struct platform_device *pdev) {
  <+...
  v = clk_prepare_enable@p(e1);
  if (
(
v
|
v < 0
)
  ) { ... }
+ v = devm_add_action_or_reset(&pdev->dev, clk_disable_unprepare, e1);
+ if (v)
+        return v;
  ...
?-clk_disable_unprepare(e1);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression prb.e1;
@@

removefn(...) {
  <...
?-clk_disable_unprepare(e1);
  ...>
}

@a depends on prb@
expression prb.e1, e2;
@@
e2 = e1;

@rem2 depends on a@
identifier platform.removefn;
expression a.e2;
@@
removefn(...) {
  <...
- clk_disable_unprepare(e2);
  ...>
}
