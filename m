From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 20 Apr 2016 21:43:07 +0200 (CEST)
Subject: [Cocci] Splitting a function in two with SmPL
In-Reply-To: <CAB=NE6Ugvu39rSib2sFozYMro2ygMx=pMzLHz6+-TcLgS24Hzg@mail.gmail.com>
References: <CAB=NE6XnxL_xMXKZYQtcqWdSmnfAtg2-MhXz5TcgR9a=TmEf6A@mail.gmail.com>
 <alpine.DEB.2.02.1604202057360.2223@localhost6.localdomain6>
 <CAB=NE6Ugvu39rSib2sFozYMro2ygMx=pMzLHz6+-TcLgS24Hzg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1604202140510.2223@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I really doubt that the result of this is exactly what you want, but maybe
you can improve it.

This critically relies on the function f having a return value.  If it
doesn't then you would need two versions, one with a return value and one
without.  It also critically relies on the request_firmware call being at
top level, not under an if.

Whatever rule you end up with, it would be good to provide a rule at the
end that detects the case where the transformation should have applied, but
does not, and do something to warn the user of that fact.

julia


/*
 * You can use this to convert a device driver from the old firmware API
 * to the new flexible sysdata API for sync behaviour
 *
 * For now the confidence is low as this is a new SmPL patch, however with
 * time, as more drivers get converted and this is fine tuned, this
 * confidence in it may grow higher.
 *
 * Confidence: Low
 *
 * Copyright: (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org> GPLv2.
 */

@ find_request_fw_sync @
expression name, dev, E1, e;
type T;
identifier ret, fw_entry, f, drv;
@@

f (...) {
...
?T *drv = E1;
+const struct sysdata_file_desc sysdata_desc = {
+      SYSDATA_DEFAULT_SYNC(sync_found_cb, drv),
+};
...
(
-request_firmware(&drv->fw_entry, name, dev);
+sysdata_file_request(name, &sysdata_desc, dev);
|
ret =
-request_firmware(&drv->fw_entry, name, dev);
+sysdata_file_request(name, &sysdata_desc, dev);
)
<...
- return e;
+ RETURN(e);
...>
}

@@
expression name, dev, e;
identifier ret, fw_entry, find_request_fw_sync.f, drv;
@@

f (...) {
 ... when any
-RETURN(e);
+return e;
}

@ find_request_fw_sync1 @
expression name, dev, e;
identifier ret, fw_entry, find_request_fw_sync.f, drv;
@@

f (...) {
... when any
(
sysdata_file_request(name, &sysdata_desc, dev);
+{
...
+}
return e;
|
ret = sysdata_file_request(name, &sysdata_desc, dev);
+{
...
+}
return e;
)
}

@ find_request_fw_sync2 @
identifier find_request_fw_sync.f;
statement list S1;
symbol context, sysdata;
@@

+static int sync_found_cb(void *context, const struct sysdata_file *sysdata)
+{
+S1
+}

f (...) {
...
-{S1}
return ...;
}

@cleanup@
expression e;
@@

static int sync_found_cb(void *context, const struct sysdata_file *sysdata)
{
<...
- RETURN(e);
+ return e;
...>
}

@ change_headers depends on find_request_fw_sync @
@@

-#include <linux/firmware.h>
+#include <linux/sysdata.h>

@ use_new_struct depends on find_request_fw_sync @
identifier fn, data;
@@

fn (...,
-const struct firmware *data
+const struct sysdata_file *data
,...) { ... }

@ drop_fw_release depends on find_request_fw_sync @
@@

-release_firmware(...);
