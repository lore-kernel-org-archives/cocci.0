Return-Path: <SRS0=T0lm=U3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E8CC4321A
	for <cocci@archiver.kernel.org>; Fri, 28 Jun 2019 03:02:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555E0208CB
	for <cocci@archiver.kernel.org>; Fri, 28 Jun 2019 03:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555E0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5S32AWZ002281;
	Fri, 28 Jun 2019 05:02:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64903777B;
	Fri, 28 Jun 2019 05:02:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1044B76AC
 for <cocci@systeme.lip6.fr>; Fri, 28 Jun 2019 05:02:08 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5S324aX016929
 for <cocci@systeme.lip6.fr>; Fri, 28 Jun 2019 05:02:05 +0200 (CEST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id DFF94594B33C4A312078;
 Fri, 28 Jun 2019 11:02:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id x5S30C0k068092;
 Fri, 28 Jun 2019 11:00:12 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019062811004795-1800625 ;
 Fri, 28 Jun 2019 11:00:47 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Jun 2019 10:58:52 +0800
Message-Id: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-06-28 11:00:48,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-06-28 11:00:18, Serialize complete at 2019-06-28 11:00:18
X-MAIL: mse-fl2.zte.com.cn x5S30C0k068092
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Jun 2019 05:02:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 28 Jun 2019 05:02:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        Markus Elfring <Markus.Elfring@web.de>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [Cocci] [PATCH v2] coccinelle: semantic code search for missing
	of_node_put
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

There are functions which increment a reference counter for a device node.
These functions belong to a programming interface for the management
of information from device trees.
The counter must be decremented after the last usage of a device node.
We find these functions by using the following SmPL:

<SmPL>
@initialize:ocaml@
@@

let relevant_str = "use of_node_put() on it when done"

let contains s1 s2 =
    let re = Str.regexp_string s2
    in
        try ignore (Str.search_forward re s1 0); true
        with Not_found -> false

let relevant_functions = ref []

let add_function f c =
    if not (List.mem f !relevant_functions)
    then
      begin
        let s = String.concat " "
          (
            (List.map String.lowercase_ascii
              (List.filter
                (function x ->
                  Str.string_match
                  (Str.regexp "[a-zA-Z_\\(\\)][-a-zA-Z0-9_\\(\\)]*$")
                x 0) (Str.split (Str.regexp "[ .;\t\n]+") c)))) in
             if contains s relevant_str
             then
               Printf.printf "Found relevant function: %s\n" f;
               relevant_functions := f :: !relevant_functions;
      end

@r@
identifier fn;
comments c;
type T = struct device_node *;
@@

T@c fn(...) {
...
}

@script:ocaml@
f << r.fn;
c << r.c;
@@

let (cb,cm,ca) = List.hd c in
let c = String.concat " " cb in
add_function f c
</SmPL>

And this patch also looks for places where an of_node_put()
call is on some paths but not on others.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@systeme.lip6.fr
---
v2: improve the commit description and delete duplicate code.

 scripts/coccinelle/free/of_node_put.cocci | 143 ++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 scripts/coccinelle/free/of_node_put.cocci

diff --git a/scripts/coccinelle/free/of_node_put.cocci b/scripts/coccinelle/free/of_node_put.cocci
new file mode 100644
index 0000000..81a9f54
--- /dev/null
+++ b/scripts/coccinelle/free/of_node_put.cocci
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing of_node_put
+///
+// Confidence: Moderate
+// Copyright: (C) 2018-2019 Wen Yang, ZTE.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@initialize:python@
+@@
+
+seen = set()
+
+def add_if_not_present (p1, p2):
+    if (p1, p2) not in seen:
+        seen.add((p1, p2))
+        return True
+    return False
+
+def display_report(p1, p2):
+    if add_if_not_present(p1[0].line, p2[0].line):
+       coccilib.report.print_report(p2[0],
+                                    "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
+                                    + p1[0].line
+                                    + ", but without a corresponding object release within this function.")
+
+def display_org(p1, p2):
+    cocci.print_main("acquired a node pointer with refcount incremented", p1)
+    cocci.print_secs("needed of_node_put", p2)
+
+@r1 exists@
+local idexpression struct device_node *x;
+expression e, e1;
+position p1, p2;
+statement S;
+type T;
+@@
+
+x = @p1\(of_find_all_nodes\|
+         of_get_cpu_node\|
+         of_get_parent\|
+         of_get_next_parent\|
+         of_get_next_child\|
+         of_get_next_cpu_node\|
+         of_get_compatible_child\|
+         of_get_child_by_name\|
+         of_find_node_opts_by_path\|
+         of_find_node_by_name\|
+         of_find_node_by_type\|
+         of_find_compatible_node\|
+         of_find_node_with_property\|
+         of_find_matching_node_and_match\|
+         of_find_node_by_phandle\|
+         of_parse_phandle\|
+         of_find_next_cache_node\|
+         of_get_next_available_child\)(...);
+...
+if (x == NULL || ...) S
+... when != e = (T)x
+    when != true x == NULL
+    when != of_node_put(x)
+    when != of_get_next_parent(x)
+    when != of_find_matching_node(x, ...)
+    when != if (x) { ... return x; }
+    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
+    when != e1 = of_fwnode_handle(x)
+(
+if (x) { ... when forall
+         of_node_put(x) ... }
+|
+return x;
+|
+return of_fwnode_handle(x);
+|
+return@p2 ...;
+)
+
+@script:python depends on report && r1@
+p1 << r1.p1;
+p2 << r1.p2;
+@@
+
+display_report(p1, p2)
+
+@script:python depends on org && r1@
+p1 << r1.p1;
+p2 << r1.p2;
+@@
+
+display_org(p1, p2)
+
+@r2 exists@
+local idexpression struct device_node *x;
+expression e, e1;
+position p1, p2;
+identifier f;
+statement S;
+type T;
+@@
+
+(
+x = f@p1(...);
+... when != e = (T)x
+    when != true x == NULL
+    when != of_node_put(x)
+    when != of_get_next_parent(x)
+    when != of_find_matching_node(x, ...)
+    when != if (x) { ... return x; }
+    when != v4l2_async_notifier_add_fwnode_subdev(<...x...>)
+    when != e1 = of_fwnode_handle(x)
+(
+if (x) { ... when forall
+         of_node_put(x) ... }
+|
+return x;
+|
+return of_fwnode_handle(x);
+|
+return@p2 ...;
+)
+&
+x = f(...)
+...
+if (<+...x...+>) S
+...
+of_node_put(x);
+)
+@script:python depends on report && r2@
+p1 << r2.p1;
+p2 << r2.p2;
+@@
+
+display_report(p1, p2)
+
+@script:python depends on org && r2@
+p1 << r2.p1;
+p2 << r2.p2;
+@@
+
+display_org(p1, p2)
-- 
2.9.5

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
