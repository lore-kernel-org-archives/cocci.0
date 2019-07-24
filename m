Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF3C7618B
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 04:27:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460A82253D
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 04:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460A82253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O4RMfG022323;
	Wed, 24 Jul 2019 06:27:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0460C777C;
	Wed, 24 Jul 2019 06:27:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8BB30420D
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 06:27:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6O4RKNi012191
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 06:27:20 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,300,1559512800"; d="scan'208";a="314532027"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 06:27:19 +0200
Date: Tue, 23 Jul 2019 23:27:17 -0500 (CDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907232326360.2539@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
 <alpine.DEB.2.21.1907231546090.2551@hadrien>
 <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com> 
 <alpine.DEB.2.21.1907232252260.2539@hadrien>
 <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Jul 2019 06:27:22 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 24 Jul 2019 06:27:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
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



On Tue, 23 Jul 2019, Joe Perches wrote:

> On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> > A seantic patch and the resulting output for the case where the third
> > arugument is a constant is attached.  Likewise the resulting output on a
> > recent linux-next.
> >
> > julia
>
> Nice.  Thanks Julia
>
> A couple issues:
>
> There is a problem with conversions with assignments
> of strlcpy() so ideally the cocci script should make sure
> any return value was not used before conversion.
>
> This is not a provably good conversion:
>
> drivers/s390/char/sclp_ftp.c
> @@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
>         sccb->evbuf.mdd.ftp.length = ftp->len;
>         sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
>
> -       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
> -                     HMCDRV_FTP_FIDENT_MAX);
> +       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);

Sorry, I don't understand the issue here.  What specifically should I be
looking for?

>
> And:
>
> I would have expected the bit below to find and convert uses like
> 	drivers/hwmon/adc128d818.c:     strlcpy(info->type, "adc128d818", I2C_NAME_SIZE);
> but it seems none of those were converted.

OK, thanks.  I will check on it.

julia

> I don't know why.
>
> //------------------------------------------
> @r1@
> struct i1 *e1;
> expression e2;
> identifier f,i1,i2;
> position p;
> @@
> \(strscpy\|strlcpy\)(e1->f, e2, i2)@p
>
> @@
> identifier r1.i1,r1.i2;
> type T;
> @@
> struct i1 { ... T i1[i2]; ... }
>
> @@
> identifier f,i2;
> expression e1,e2;
> position r1.p;
> @@
> (
> -strscpy
> +stracpy
> |
> -strlcpy
> +stracpy
> )(e1->f, e2
> -    , i2
>   )@p
> //------------------------------------------
>
> to find
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
