From: timur@kernel.org (Timur Tabi)
Date: Tue, 31 Jul 2018 09:27:58 -0500
Subject: [Cocci] Compacting parameters into fewer lines
Message-ID: <CAOZdJXUXp5gmU7_nBftF=5BrSF0u6tygH71uP2knBMJTjfdgkQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle does a pretty good job at compating parameters into fewer
lines, but it's not always aggressive enough.  Is there a tuning
parameter I can try?

For example, this is good:

-                    DBG_PRINTF((
-                        DBG_MODULE_GLOBAL, DBG_LEVEL_ERRORS,
-                        "NVRM: Failed to allocate object handle in %s\n",
-                        __FUNCTION__));
+                    NV_PRINTF(LEVEL_ERROR,
+                              "Failed to allocate object handle in %s\n",
+                              __FUNCTION__);

But here, the call to NV_PRINTF only needs two lines, not three.
Parameters 1 and 2 can fit on the same line, or parameters 2 and 3 can
be put on the same line.  In this case, it didn't even try:

-                DBG_PRINTF((
-                    DBG_MODULE_GLOBAL, DBG_LEVEL_ERRORS,
-                    "NVRM: Unable to alloc device in %s\n", __FUNCTION__));
+                NV_PRINTF(LEVEL_ERROR,
+                          "Unable to alloc device in %s\n",
+                          __FUNCTION__);

Here, it compacted a little bit, but it could have done more.  This
could have fit in one line:

-        DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_TRACEINFO,
-                    "NVGVI: %s(), Null state\n",
-                    __FUNCTION__));
+        NV_PRINTF(LEVEL_INFO, "%s(), Null state\n",
+                  __FUNCTION__);
