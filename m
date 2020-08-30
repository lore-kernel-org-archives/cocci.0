Return-Path: <SRS0=72o0=CI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C5C433E6
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 15:47:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2366A2071B
	for <cocci@archiver.kernel.org>; Sun, 30 Aug 2020 15:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2366A2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07UFko25013186;
	Sun, 30 Aug 2020 17:46:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 003747789;
	Sun, 30 Aug 2020 17:46:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B0033F6C
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 17:46:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07UFkk7c001902
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 30 Aug 2020 17:46:46 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="465263914"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 17:46:45 +0200
Date: Sun, 30 Aug 2020 17:46:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <bc3215bbf6c217a06dc2ebbf6ddd977c5d57654c.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2008301742400.3629@hadrien>
References: <de28becbfe76575b18c0bf47567b7f9c20f15f87.camel@perches.com>
 <alpine.DEB.2.22.394.2008300854510.3629@hadrien>
 <b43fac2f903451dba4d5f4ac010b2ae5bfcad0c4.camel@perches.com>
 <alpine.DEB.2.22.394.2008301021250.3629@hadrien>
 <bc3215bbf6c217a06dc2ebbf6ddd977c5d57654c.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 17:46:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 30 Aug 2020 17:46:46 +0200 (CEST)
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

[...]

> Thanks, I used the slightly different from your suggestion
> where sysfs is an identifier with function args and a
> semicolon after the transform type, (otherwise I get cocci errors).
> like this below:
>
> But it doesn't work (no renaming) when there is an
> initializer to the variable to be transformed.
>
> ie:
> {
> 	ssize_t count = 0;
> 	...
> 	count += sysfs_emit_at(buf, count, ...);
> 	...
> 	return count;
> }
>
> I tried adding =0 in various places without success.
>
> Suggestions?
>
> ------------------
>
> // Rename the sysfs_emit assigned variables not named len and not already int
> // and set the name to len and type to int
>
> @not_int_not_len exists@
> type T != int;
> identifier x != len;
> position p;
> identifier sysfs =~ "^sysfs_emit.*$";
> assignment operator aop;
> @@
>
> T x@p;
> ...
> x aop sysfs(...)
> ...
>
> @@
> type not_int_not_len.T;
> identifier not_int_not_len.x;
> position not_int_not_len.p;
> @@
>
> - T x@p;
> + int len;
>   <...
> - x
> + len
>   ...>
>
> ------------------

The following:

@not_int_not_len exists@
type T != int;
identifier x != len;
position p;
identifier sysfs =~ "^sysfs_emit.*$";
assignment operator aop;
@@

T@p x;
...
x aop sysfs(...)

@@
type not_int_not_len.T;
identifier not_int_not_len.x;
position not_int_not_len.p;
@@

(
- T@p x;
+ int len;
|
- T@p x
+ int len
 = ...;
)
  <...
- x
+ len
  ...>

works on the following test file:

int fn1()
{
        ssize_t count = 0;
        count += sysfs_emit_at(buf, count, ...);
        return count;
}

int fn2()
{
        ssize_t count;
        count += sysfs_emit_at(buf, count, ...);
	return count;
}

In the first rule, T@p x; benefits from an isomorphism to get the
initialization case.  That is not possible in the second rule, because the
name of the declared variable is modified.

I wonder why you use a regular expression for the sysfs identifier.  I
thought that there were only two choices?  You will get better performance
if you make those two choices explicit in the rule, with \( \| \).

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
