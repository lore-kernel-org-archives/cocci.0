From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 17:39:07 -0500
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
Message-ID: <CAOZdJXV_hpNQBpOtyCUqV--tH65o5GLTe93F2NnTKJ0m-h01sQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Also, while I have you attention, is this correct?

@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF(x, y);
+NV_PRINTF(y);

@depends on rule1@
@@
-DBG_LEVEL_ERRORS
+LEVEL_ERROR

This appears to work, but I think the "depends on" is just saying that
if rule1 succeeds, then go ahead and replace all DBG_LEVEL_ERRORS with
LEVEL_ERROR.  However, I really only want that to happen inside an
NV_PRINTF.  I tried doing this:

@depends on rule1@
@@
NV_PRINTF(
-DBG_LEVEL_ERRORS
+LEVEL_ERROR
 );

That that doesn't do anything.
