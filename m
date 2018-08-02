From: ttabi@nvidia.com (Timur Tabi)
Date: Thu, 2 Aug 2018 15:26:15 -0500
Subject: [Cocci] Code wrapped in macros ignored by script
Message-ID: <e0920777-4b76-dfa3-03fa-97d1d76cd229@nvidia.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

My cocci script (attached) ignores lines that are embedded inside other 
macros.? Example:

#define DB(x)?? x

void func()
{
 ??? DB(if (DEBUG_IO_TRACE())
 ??????????????? DBG_PRINTF((DBG_MODULE_GLOBAL, DBG_LEVEL_INFO, "inb 
%#04x \n", addr));)
}

Is there a way to get coccinelle to ignore the DB( and )?


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
-------------- next part --------------
/*
 * Coccinelle file to replace DBG_PRINTF() calls with NV_PRINTF() 
 *
 * To apply, make the patch file, fix it, call 'p4 edit', and then apply the
 * patch:
 *   spatch --sp-file nv_printf.cocci --dir . > /tmp/n.patch
 *   p4 edit `lsdiff --strip 1 /tmp/n.patch`
 *   sed -Ei 's/(^\+.*)( $)/\1/' /tmp/n.patch
 *   patch -p 1 < /tmp/n.patch
 *
 * Coccinelle has a bug where sometimes it adds trailing spaces to lines.
 * The 'sed' command removes those trailing whitespaces.
 *
 * Note that coccinelle chokes on multi-line string literals that are split
 * with a \ line continuation character.  So
 *     "foo \
 *      bar"
 * should be combined into
 *     "foo "
 *     "bar"
 * before running this script.  Use this command to find problematic lines:
 *     grep '^[^"]*"[^"]*\\$' *
 *
 * After running the script, you want to review the changes and compress
 * NV_PRINTF() calls into fewer lines.  Coccinelle does some combining of
 * parameters into fewer lines, but it's not aggressive.
 */

// Remove the double-parentheses in DBG_PRINTF statements
@@
@@
DBG_PRINTF(
-(
...
-)
 );

// Replace DBG_PRINTF with NV_PRINTF
@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF(x, y);
+NV_PRINTF(y);

// Replace the DBG_xxx or DEBUGLEVEL_xxx with LEVEL_xxx
@depends on rule1@
@@
NV_PRINTF(...,
-\(DBG_LEVEL_INFO \| DEBUGLEVEL_TRACEINFO \| DBG_LEVEL_SETUPINFO \| DEBUGLEVEL_SETUPINFO\)
+LEVEL_INFO
, ...);

@depends on rule1@
@@
NV_PRINTF(...,
-\(DBG_LEVEL_USERERRORS \| DEBUGLEVEL_USERERRORS\)
+LEVEL_NOTICE
, ...);

@depends on rule1@
@@
NV_PRINTF(...,
-\(DBG_LEVEL_WARNINGS \| DEBUGLEVEL_WARNINGS\)
+LEVEL_WARNING
, ...);

@depends on rule1@
@@
NV_PRINTF(...,
-\(DBG_LEVEL_ERRORS \| DEBUGLEVEL_ERRORS\)
+LEVEL_ERROR
, ...);

// Use Python to clean up the string literals.
// Comments are still C-style though

@r@
constant char[] c;
expression list[n] es;
@@

NV_PRINTF(es,c,...)

@script:python s@
c << r.c;
c2;
@@
import re

// Combine "xxx" "yyy" into "xxxyyy"
m = re.match(r'"([^"]+)" "([^"]+)"', c)
if m:
    c = '"%s%s"' % (m.group(1), m.group(2))

// Remove the "NXXX: " prefix
m = re.match(r'"N[\-A-Z]+: ([^"]*)"', c)
if m:
    c = '"%s"' % m.group(1)

coccinelle.c2 = c

@@
expression list[r.n] r.es;
constant char[] r.c;
identifier s.c2;
@@

NV_PRINTF(es,
-c
+c2
,...)
