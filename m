From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 12 Sep 2018 12:33:04 +0000
Subject: [Cocci] checking and fixing comma operator in if condition
Message-ID: <20180912123304.GA18497@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi !

 The below spatch works for me - and finds the cases I was looking
 for in report mode. In patch mode it fixes some in a bad way though
 due to some additional "bugs" in the if statement like:

+++ b/gpu/drm/nouveau/nvkm/core/notify.c
@@ -136,14 +136,16 @@ nvkm_notify_init(struct nvkm_object *obj
 {
        unsigned long flags;
        int ret = -ENODEV;
-       if ((notify->event = event), event->refs) {
+       (notify->event = event);
+       if (event->refs) {
  
 The extra parenthesis is wrong inside the if but of course it is
 kind of "wronger" outside the if while still valid C-code. Other
 cases that are fixed in a questionable case are e.g.

--- a/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
+++ b/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
@@ -1168,7 +1168,8 @@ gk104_ram_prog_0(struct gk104_ram *ram,
        if (&cfg->head == &ram->cfg)
                return;

-       if (mask = 0, data = 0, ram->diff.rammap_11_0a_03fe) {
+       mask = 0, data = 0;
+       if (ram->diff.rammap_11_0a_03fe) {

 In futher cases it is not clear if the unconditional part really was
 intended to take effect outside the conditional code so it is not
 clear if the placement before the if () is technically correct (I
 think it is semantically equivalent though - so bug-preserving in
 those cases).

 So... is it then better not even to offer the patch mode in this case ?

 Finally as it seems that while this is a general no-go, in the current
 -stable sources it only affects files in drivers/gpu/drm/nouveau/, thus
 not sure if this makes much sense for mainline at all.


thx!
hofrat


/// Check for unconditional code "hiding" in an if condition
/// effectively that code is unconditionally executed before
/// reaching the actual branch statement - which just makes it
/// hard to read and thus is *always* wrong.
/// Some of the cases found also look buggy 
///
/// As of 4.19-rc3 all 50 cases look like they are found and fixed
/// correctly - but as this is in the nuveau driver only it might
/// well be that this only fits that specific pattern.
///
// Confidence: Low
// Copyright: (C) 2018 Nicholas Mc Guire, OSADL.  GPLv2.
// Comments:
// Options: --no-includes --include-headers

virtual patch
virtual report

@badif@
position p;
statement S;
expression E1,E2;
@@

  if at p (E1,E2) S

@script:python depends on report@
p << badif.p;
@@

msg = "unconditional code hiding in if condition" 
coccilib.report.print_report(p[0],msg)

@fixbadif depends on badif && patch@
position p=badif.p;
statement S;
expression E1=badif.E1,E2=badif.E2;
@@

+ E1;
  if@p (
- E1,
  E2) 
  S 

@script:python depends on patch@
p << fixbadif.p;
@@

msg = "unconditional code in if condition moved" 
coccilib.report.print_report(p[0],msg)
