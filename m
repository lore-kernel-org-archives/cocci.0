Return-Path: <SRS0=S6Ku=UP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B8EC31E50
	for <cocci@archiver.kernel.org>; Sun, 16 Jun 2019 20:16:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C270B20861
	for <cocci@archiver.kernel.org>; Sun, 16 Jun 2019 20:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C270B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5GKFtOg006875;
	Sun, 16 Jun 2019 22:15:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 40EEA76A7;
	Sun, 16 Jun 2019 22:15:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39C807699
 for <cocci@systeme.lip6.fr>; Sun, 16 Jun 2019 22:15:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5GKFrSt017701
 for <cocci@systeme.lip6.fr>; Sun, 16 Jun 2019 22:15:53 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,382,1557180000"; d="scan'208";a="387650350"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 22:15:53 +0200
Date: Sun, 16 Jun 2019 22:15:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
Message-ID: <alpine.DEB.2.21.1906162214390.2537@hadrien>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1306249686-1560716153=:2537"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 16 Jun 2019 22:15:55 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 16 Jun 2019 22:15:53 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking for a null pointer with SmPL
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1306249686-1560716153=:2537
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 16 Jun 2019, Markus Elfring wrote:

> Hello,
>
> A patch on a topic like “staging/rtl8723bs/core/rtw_ap: Remove redundant call
> to memset” caught also my software development attention.
> https://lkml.org/lkml/2019/6/15/220
> https://lore.kernel.org/patchwork/patch/1089416/
> https://lore.kernel.org/lkml/20190616033527.GA14062@hari-Inspiron-1545/
>
>
> The following script for the semantic patch language points the shown
> change possibility out as expected.
>
> @display@
> expression ex;
> identifier zm =~ "_zmalloc";
> statement is;
> @@
>  ex = zm(...);
>  if (ex == NULL)
>     is
>
> *memset(ex, 0, ...);
>
>
>
> I would expect that the following SmPL script can work in a similar way.
>
> @display@
> expression ex;
> identifier zm =~ "_zmalloc";
> statement is, es;
> @@
>  ex = zm(...);
>  if (ex)
>     is
>  else
>     es
>
> *memset(ex, 0, ...);
>
>
> But this approach does not point an update candidate out at the moment.
> How do you think about the software situation?

In the second case, Coccinelle has no way of knowing that ex is a pointer,
so it doesn't feel motivated to consider that ex should be compared to
NULL.

I would imagine that you would have gooten at least some relevant
information if you had tried spatch --parse-cocci.

julia
--8323329-1306249686-1560716153=:2537
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1306249686-1560716153=:2537--
