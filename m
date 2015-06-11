From: micah.fedke@collabora.co.uk (Micah Fedke)
Date: Thu, 11 Jun 2015 12:53:08 -0500
Subject: [Cocci] failure parsing macro replacement of function definition
Message-ID: <5579CB04.8060907@collabora.co.uk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, I'm trying to use cocci to update an internal API in the 
intel-gpu-tools code tree, but it doesn't seem to be able to recognize 
the somewhat unusual use of a macro to replace the declaration of 
main(), which is used in most all of the igt tests.  Can anything be done?

SmPL and output when run on 
http://cgit.freedesktop.org/xorg/app/intel-gpu-tools/tree/tests/core_getclient.c:


@@
expression a;
@@
- a = drm_open_any();
+ a = drm_open_any(OPEN_INTEL);


spatch -sp_file drm_open.cocci tests/core_getclient.c -debug 
-verbose_parsing
init_defs_builtins: /usr/share/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: drm_open.cocci
with isos from: /usr/share/coccinelle/standard.iso
-----------------------------------------------------------------------
@@
expression a;
@@
- a = drm_open_any();
+ a = drm_open_any(OPEN_INTEL);

HANDLING: tests/core_getclient.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
ERROR-RECOV: found sync '}' at line 62
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 62
parse error
  = File "tests/core_getclient.c", line 38, column 0,  charpos = 1396
     around = '{', whole content = {
badcount: 27
bad: IGT_TEST_DESCRIPTION("Tests the DRM_IOCTL_GET_CLIENT ioctl.");
bad:
bad: igt_simple_main
BAD:!!!!! {
bad: 	int fd, ret;
bad: 	drm_client_t client;
bad:
bad: 	fd = drm_open_any();
bad:
bad: 	/* Look for client index 0.  This should exist whether we're operating
bad: 	 * on an otherwise unused drm device, or the X Server is running on
bad: 	 * the device.
bad: 	 */
bad: 	client.idx = 0;
bad: 	ret = ioctl(fd, DRM_IOCTL_GET_CLIENT, &client);
bad: 	igt_assert(ret == 0);
bad:
bad: 	/* Look for some absurd client index and make sure it's invalid.
bad: 	 * The DRM drivers currently always return data, so the user has
bad: 	 * no real way to detect when the list has terminated.  That's bad,
bad: 	 * and this test is XFAIL as a result.
bad: 	 */
bad: 	client.idx = 0x7fffffff;
bad: 	ret = ioctl(fd, DRM_IOCTL_GET_CLIENT, &client);
bad: 	igt_assert(ret == -1 && errno == EINVAL);
bad:
bad: 	close(fd);
bad: }
-----------------------------------------------------------------------
rule starting on line 1 =
-----------------------------------------------------------------------
dependencies for rule rule starting on line 1 satisfied:
binding in = []
binding relevant in = []
-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
Check duplication for 1 files


definition of igt_simple_main: 
http://cgit.freedesktop.org/xorg/app/intel-gpu-tools/tree/lib/igt_core.h#n244
-- 

Micah Fedke
Collabora Ltd.
+44 1223 362967
https://www.collabora.com/
https://twitter.com/collaboraltd
