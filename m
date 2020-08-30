Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC89C433E2
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 08:27:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECF920714
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 08:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECF920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07U8RLAg003602;
	Sun, 30 Aug 2020 10:27:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DEBBE7789;
	Sun, 30 Aug 2020 10:27:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CCB6F3F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 10:27:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07U8RI48002651
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 10:27:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465245217"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 10:27:18 +0200
Date: Sun, 30 Aug 2020 10:27:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008301021250.3629@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
 <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
 <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 10:27:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 10:27:18 +0200 (CEST)
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



On Sun, 30 Aug 2020, Joe Perches wrote:

> On Sun, 2020-08-30 at 08:57 +0200, Julia Lawall wrote:
> >
> > On Sat, 29 Aug 2020, Joe Perches wrote:
> >
> > > Is it me not understanding cocci grammar again?
> >
> > The problem is the loop.  You are trying to change something in the body
> > of a loop and the body of a for loop might not be executed.  ... means
> > that the thing must be found on every execution path.
> >
> > Do you want to make the change in the function header even if there are
> > not changes in the body?  If so, <... ...> is what you are looking for.
> > If you want to be sure there is a change to make in the function body then
> > you can use <+... ...+> but it will be more expensive.
>
> Thanks.  <... works (and I thought I had tried that, oh well)
>
> Another thing I'd like to do is to change the various uses
> of a type and identifier to a specific type and identifier.
>
> In this sysfs_emit transform I've been working on, there
> are many variable names used in the assignment of the
> sysfs_emit result.
>
> $ git grep -P -oh '\w+\s*\+?=\s*sysfs_emit' | \
>   sort | uniq -c | sort -rn
>     145 ret = sysfs_emit
>      80 len = sysfs_emit
>      74 len += sysfs_emit
>      69 rc = sysfs_emit
>      50 count = sysfs_emit
>      25 count += sysfs_emit
>      19 size = sysfs_emit
>      17 n += sysfs_emit
>      15 n = sysfs_emit
>      14 status = sysfs_emit
>      12 ret += sysfs_emit
>      12 output_len += sysfs_emit
>      11 retval = sysfs_emit
>       9 res += sysfs_emit
>       7 rv = sysfs_emit
>       7 offset += sysfs_emit
>       7 l = sysfs_emit
>       6 i = sysfs_emit
>       5 size += sysfs_emit
>       5 err = sysfs_emit
>       4 written = sysfs_emit
>       4 l += sysfs_emit
>       3 written += sysfs_emit
>       2 rz = sysfs_emit
>       2 r = sysfs_emit
>       2 result = sysfs_emit
>       2 res = sysfs_emit
>       2 i += sysfs_emit
>       2 idx += sysfs_emit
>       2 error = sysfs_emit
>       2 cnt += sysfs_emit
>       2 buf_len += sysfs_emit
>       1 offset = sysfs_emit
>       1 length = sysfs_emit
>       1 cnt = sysfs_emit
>       1 bytes = sysfs_emit
>       1 bytes += sysfs_emit
>
> Most are declared int, some are ssize_t.
>
> I'd like to change them all to int len.

@r exists@
type T != int;
identifier x != len;
position p;
assignment operator aop;
@@

T x@p;
...
x aop sysfs_emit

@@
type r.T;
identifier r.x;
position r.p;
@@

- T x@p;
+ int len
  <...
- x
+ len
  ...>

This only works for the case where the type is not int and the name is not
len.  You would need other similar pairs of rules for the case where the
type is int and the variable is something else and where the type is len
and the variable is len.

Or you could get rid of the constraints and hope that replacing int by int
and len by len won't have any impact on the layout of the code.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
