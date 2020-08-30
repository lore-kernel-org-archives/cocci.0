Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301CC433E2
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 17:33:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BC820707
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 17:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BC820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07UHXfGr029729;
	Sun, 30 Aug 2020 19:33:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C89287789;
	Sun, 30 Aug 2020 19:33:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 551C23F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 19:33:40 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0252.hostedemail.com
 [216.40.44.252])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07UHXcUv029394
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 19:33:39 +0200 (CEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 49602181D337B;
 Sun, 30 Aug 2020 17:33:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chess86_4910bc027088
X-Filterd-Recvd-Size: 2854
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf15.hostedemail.com (Postfix) with ESMTPA;
 Sun, 30 Aug 2020 17:33:36 +0000 (UTC)
Message-ID: <7ce009d5f538feae7a6a20e0bbecdf73d74ea9f9.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 30 Aug 2020 10:33:35 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008301742400.3629@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
 <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
 <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
 <alpine.DEB.2.22.394.2008301021250.3629@hadrien>
 <bc3215bbf6c217a06dc2ebbf6ddd977c5d57654c.camel@perches.com>
 <alpine.DEB.2.22.394.2008301742400.3629@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 19:33:42 +0200 (CEST)
X-Greylist: Delayed for 21:55:20 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 30 Aug 2020 19:33:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] transform oddity / bug ?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Sun, 2020-08-30 at 17:46 +0200, Julia Lawall wrote:
> The following:
> 
> @not_int_not_len exists@
> type T != int;
> identifier x != len;
> position p;
> identifier sysfs =~ "^sysfs_emit.*$";
> assignment operator aop;
> @@
> 
> T@p x;
> ...
> x aop sysfs(...)
> 
> @@
> type not_int_not_len.T;
> identifier not_int_not_len.x;
> position not_int_not_len.p;
> @@
> 
> (
> - T@p x;
> + int len;
> - T@p x
> + int len
>  = ...;
> )
>   <...
> - x
> + len
>   ...>
> 
> works on the following test file:
> 
> int fn1()
> {
>         ssize_t count = 0;
>         count += sysfs_emit_at(buf, count, ...);
>         return count;
> }
> 
> int fn2()
> {
>         ssize_t count;
>         count += sysfs_emit_at(buf, count, ...);
> 	return count;
> }
> 
> In the first rule, T@p x; benefits from an isomorphism to get the
> initialization case.  That is not possible in the second rule, because the
> name of the declared variable is modified.

Unfortunately this does not work when the declaration
is comma terminated and not semicolon terminated.


$ cat julia.c
int fn1()
{
        ssize_t count = 0, another;	// <- multiple declarations
        count += sysfs_emit_at(buf, count, ...);
        return count;
}

int fn2()
{
        ssize_t count;
        count += sysfs_emit_at(buf, count, ...);
        return count;
}

$ spatch -sp-file julia.cocci julia.c
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
HANDLING: julia.c
diff = 
--- julia.c
+++ /tmp/cocci-output-77064-888900-julia.c
@@ -7,8 +7,8 @@ int fn1()
 
 int fn2()
 {
-        ssize_t count;
-        count += sysfs_emit_at(buf, count, ...);
-        return count;
+        int len;
+        len += sysfs_emit_at(buf, count, ...);
+        return len;
 }


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
