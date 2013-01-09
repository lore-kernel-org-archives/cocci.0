From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 8 Jan 2013 22:01:08 -0200
Subject: [Cocci] #if defined ()
Message-ID: <CA+MoWDpH=vZAiSAY_RxqtZNtKz1Gm4A7v+RpMW1eca=j0oB1Gg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

There is a recent commit on Linux Kernel:
$ git show 37b44a0f04184998073633887d2f1e724aee130a

commit 37b44a0f04184998073633887d2f1e724aee130a
Author: Antti Palosaari <crope@iki.fi>
Date:   Fri Jan 4 15:21:26 2013 -0300

    [media] dvb_usb_v2: use IS_ENABLED() macro

    replace:
     #if defined(CONFIG_RC_CORE) || defined(CONFIG_RC_CORE_MODULE)
    with:
     #if IS_ENABLED(CONFIG_RC_CORE)

Is it possible to write a semantic patch for this preprocessor code?
Something like:

@@
constant i,j;
@@
-defined(i) || defined(j)
+IS_ENABLED(i)

Thanks!
--
Peter
