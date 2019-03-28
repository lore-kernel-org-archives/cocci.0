Return-Path: <SRS0=Pg7l=R7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ECFC43381
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 13:25:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8282075E
	for <cocci@archiver.kernel.org>; Thu, 28 Mar 2019 13:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rEJVab+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8282075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SDPS8Y023282
          ; Thu, 28 Mar 2019 14:25:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D6A1E771A;
	Thu, 28 Mar 2019 14:25:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E826B7719
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:25:26 +0100 (CET)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2SDPQKr001363
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:25:26 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x2SDOhnU010543
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 14:25:10 +0100 (CET)
X-Ids: 164
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x2SDOFBB030194
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 22:24:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2SDOFBB030194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553779455;
 bh=rg6O0bH8r6eBYFN10boIZbRo4/182uJ7aj8JKWzN1HE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rEJVab+7NT1fi9v4cUHPhc+cGIrfUDDj5OIt23+pkemXA/RuZxxcDCavv8Q5LTULX
 p7uFugMzQF2G+ejexHz9NXs755teH5L/HPXLFSZw5w/pqIuvphheHpKTw9yGXIDjnT
 aFAU04Jbx2m270wD+d+0VfEismSw+ILedJ9pqJU0bxewucCdtuHxA8swkMvlrd+1rq
 Rj+bS4h4+qwkRGez3UWsapMqHbQ8Vjt2zcIAsg1rk/oT15Ite/YockYOjPRlruBmfJ
 HTPg9ok1PIkucoQKV59zbXZd290z49y801b8Rno/TmQVKnyQMy5Sn0Nv0aIrJu4SJm
 cNYeqhGsHYA+g==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id 46so3104362uan.8
 for <cocci@systeme.lip6.fr>; Thu, 28 Mar 2019 06:24:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXcyQBWOC33P5FfY0pcNPjsVbrS9mQ1+JdyVoKFBgoS5e4jVOhd
 J9wvkgT4y1nCmSqdFWMEVgDSSfJA/2wYi20o3rI=
X-Google-Smtp-Source: APXvYqzbT/uN4geExS7/rbsLhrJbQYZQZuCwZauULmqbWd8/qfUIg1+Sw6L6N4dbKQuu3ntu/DFI3SBh7V1q4RNKD8o=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr24651111uap.121.1553779454420; 
 Thu, 28 Mar 2019 06:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190326212200.21168-1-mstefani@mykolab.com>
In-Reply-To: <20190326212200.21168-1-mstefani@mykolab.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 28 Mar 2019 22:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgYBpELOiXd7zYsK+d-jMDuoj-wD7nPb847oGFfWvHGA@mail.gmail.com>
Message-ID: <CAK7LNAQgYBpELOiXd7zYsK+d-jMDuoj-wD7nPb847oGFfWvHGA@mail.gmail.com>
To: Michael Stefaniuc <mstefani@mykolab.com>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5C9CCB1C.000 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5C9CCB1C.000 from
 conssluserg-04.nifty.com/conssluserg-04.nifty.com/210.131.2.83/conssluserg-04.nifty.com/<yamada.masahiro@socionext.com>
X-Scores-Stats: 5C9CCB1C.000 B=0.50000 L=0.26546 G=0.26546 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5C9CCB1C.000 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.265 -> S=0.265
X-j-chkmail-Status: Unsure
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Mar 2019 14:25:28 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 28 Mar 2019 14:25:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: Fix description of
	badty.cocci
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

On Wed, Mar 27, 2019 at 6:24 AM Michael Stefaniuc <mstefani@mykolab.com> wrote:
>
> Summary was copy and pasted from array_size.cocci.
>
> Signed-off-by: Michael Stefaniuc <mstefani@mykolab.com>


Applied to linux-kbuild/fixes. Thanks.


> ---
>  scripts/coccinelle/misc/badty.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
> index 481cf301ccfc..08470362199c 100644
> --- a/scripts/coccinelle/misc/badty.cocci
> +++ b/scripts/coccinelle/misc/badty.cocci
> @@ -1,4 +1,4 @@
> -/// Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
> +/// Correct the size argument to alloc functions
>  ///
>  //# This makes an effort to find cases where the argument to sizeof is wrong
>  //# in memory allocation functions by checking the type of the allocated memory
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
