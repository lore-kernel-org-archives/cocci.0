From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 13 Jun 2014 11:11:28 +0200
Subject: [Cocci] Matching partial expressions in macro arguments
Message-ID: <20140613091128.GJ5821@phenom.ffwll.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

In our testsuite[1] we have a macro to compare 2 integers with a given
comparison operator, print them on assert failure to stderr for
diagnotistics and then abort our testcase.

Usage is e.g.

	igt_assert_cmpint(obj_count, ==, 0);

Now I want to add a simple igt_assert_eq(a, b) macro, so the above example
should look like
	
	igt_assert_eq(obj_count, 0);

I tried to use cocci for the refactoring, but failed. I tried

@@
expression E1, E2;
@@
-igt_assert_cmpint(E1, ==, E2);
+igt_assert_eq(E1, E2);

which failed to parse as a spatch and

@@
expression E1, E2, E;
@@
-igt_assert_cmpint(E1, E E2);
+igt_assert_eq(E1, E2);

which didn't match anything. I didn't find any examples for creative macro
abuse and using iterator metavariables which helped last time around I've
stumbled over macros didn't work out either.

Any ideas and suggestions highly welcome, or is this simply not possible
with cocci?

Example testfile attached.

Thanks, Daniel

1: http://cgit.freedesktop.org/xorg/app/intel-gpu-tools/ - it's for
testing the intel gfx kernel driver.
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
-------------- next part --------------
A non-text attachment was scrubbed...
Name: prime_self_import.c
Type: text/x-csrc
Size: 10498 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140613/e5686fe7/attachment.bin>
