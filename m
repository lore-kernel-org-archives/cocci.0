Return-Path: <SRS0=sEpD=VR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52908C76186
	for <cocci@archiver.kernel.org>; Sat, 20 Jul 2019 16:40:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEFC2084C
	for <cocci@archiver.kernel.org>; Sat, 20 Jul 2019 16:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEFC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6KGdnrA029980;
	Sat, 20 Jul 2019 18:39:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0FC6F7780;
	Sat, 20 Jul 2019 18:39:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A3C7777C
 for <cocci@systeme.lip6.fr>; Sat, 20 Jul 2019 18:39:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6KGdk87010731
 for <cocci@systeme.lip6.fr>; Sat, 20 Jul 2019 18:39:46 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,287,1559512800"; d="scan'208";a="314204162"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2019 18:39:46 +0200
Date: Sat, 20 Jul 2019 18:39:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <e499e369-c5fc-2d3d-12f8-51ae103c5bc9@linbit.com>
Message-ID: <alpine.DEB.2.21.1907201832170.2558@hadrien>
References: <e499e369-c5fc-2d3d-12f8-51ae103c5bc9@linbit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1089111742-1563640786=:2558"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 20 Jul 2019 18:39:49 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 20 Jul 2019 18:39:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] spatch inserting the following rule into the patch
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

--8323329-1089111742-1563640786=:2558
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 19 Jul 2019, Christoph Böhmwalder wrote:

> Hi,
>
> I believe I've stumbled upon a bug here:
>
> repro.cocci
> -------------------
> @@
> @@
> - COCCI_REPLACE_THIS();
> + int x __attribute__((some_attr));
>
> @@
> @@
> - foo();
> + f(g());
>
>
> repro.c
> -------------------
> int main()
> {
> 	COCCI_REPLACE_THIS();
> }
>
>
> spatch --sp-file repro.cocci repro.c
> -------------------
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> HANDLING: repro.c
> diff =
> --- repro.c
> +++ /tmp/cocci-output-4924-2aa580-repro.c
> @@ -1,4 +1,9 @@
>  int main()
>  {
> -       COCCI_REPLACE_THIS();
> +       int x__attribute__((some_attr));
> +
> +@@
> +@@
> +- foo();
> ++ f(g());
>  }
>
>
> Apparently this requires the __attribute__ in the first rule *and* the function
> call as an argument in the second rule, if I remove either of those the patch
> works as intended.

What version of Coccinelle of do you have?  I get the correct output on
this example:

diff =
--- attr.c
+++ /tmp/cocci-output-153931-8de7ba-attr.c
@@ -1,4 +1,4 @@
 int main()
 {
-        COCCI_REPLACE_THIS();
+        int x__attribute__((some_attr));
 }

julia

>
> Regards,
> Christoph
>
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1089111742-1563640786=:2558
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1089111742-1563640786=:2558--
