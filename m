Return-Path: <SRS0=EO5m=PO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29466C43387
	for <cocci@archiver.kernel.org>; Sun,  6 Jan 2019 02:35:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B051F222A9
	for <cocci@archiver.kernel.org>; Sun,  6 Jan 2019 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0RWYh0N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B051F222A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x062ZLOS018374
          ; Sun, 6 Jan 2019 03:35:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B189E76E0;
	Sun,  6 Jan 2019 03:35:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DBBE6251
 for <cocci@systeme.lip6.fr>; Sun,  6 Jan 2019 03:35:20 +0100 (CET)
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x062ZIJ5004110
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 03:35:19 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-06.nifty.com
 with ESMTP id x061gp10032628
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 10:42:52 +0900
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x061fgTb010512
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 10:41:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x061fgTb010512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546738903;
 bh=gWJAl3gourNSTPYpOk0Vo+A8mut8xLJhVB0tkrVLYPg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0RWYh0N1ePVEnkkKud+gwHvPM36jKwK563sxwFm39ZpaRObJedSupfLXvSGpvH0th
 Ig6ThATJnxYxT7z/AFM2m1tcyE1mElsCozgPX/ElpIRdCIbWZHmQxtI0PnPaYyqC6r
 cv3u0Lf0iRcVBHgtQHUbkctD3DnKhHvv8Wng8OMnxPxTjeKjrOy5QV5ZVTxzFtWT0Y
 i0FmiMmjFQho/LFdLlz5pAtTz1YuDe0wmBprvvQfRc/6oY3UAolge8cEQYR1lhH9yy
 0r17gk7y3Jt5s3N8lHzib0HUL9k/+xdYHffmqsZ85CP6fF/1kfuvvcJx7YaIApJgKz
 fIduBr4/sxrBQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id t17so24822541vsc.8
 for <cocci@systeme.lip6.fr>; Sat, 05 Jan 2019 17:41:43 -0800 (PST)
X-Gm-Message-State: AJcUukfCLllsfwjLd/kuObXV1YDlqbxpU2X+/A/M0Ew8mD4tzJLgWqnK
 HdCiHAuD+JXHqGC3HTMa3Ep6h9TKygsX3OodLds=
X-Google-Smtp-Source: ALg8bN6Wc4X7RiBNab7ffSI+3XJ4mBIxY8KlC1dEZi+ktXHW+M14futbIJVh9AVGuSxHhX/n0SNUXmRgd/INXw5nFLU=
X-Received: by 2002:a67:385a:: with SMTP id f87mr23102960vsa.179.1546738902123; 
 Sat, 05 Jan 2019 17:41:42 -0800 (PST)
MIME-Version: 1.0
References: <1546008541-3175-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546008541-3175-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 6 Jan 2019 10:41:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBxp8osBd7np5p7m699CaUVHD--r_-5-dCQvdJpQBpzg@mail.gmail.com>
Message-ID: <CAK7LNATBxp8osBd7np5p7m699CaUVHD--r_-5-dCQvdJpQBpzg@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Jan 2019 03:35:22 +0100 (CET)
X-Greylist: Delayed for 00:27:03 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 06 Jan 2019 03:35:19 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        "Jason A . Donenfeld" <zx2c4@kernel.org>,
        kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts/coccinelle: check for redeclaration
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

On Sat, Dec 29, 2018 at 10:32 AM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Avoid reporting on the use of an iterator index variable when
> the variable is redeclared.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---


Applied to linux-kbuild. Thanks!


>  scripts/coccinelle/iterators/use_after_iter.cocci |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index ce8cc9c..66a1140 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -35,6 +35,7 @@ iterator name hlist_for_each_entry_from;
>  iterator name hlist_for_each_entry_safe;
>  statement S;
>  position p1,p2;
> +type T;
>  @@
>
>  (
> @@ -125,6 +126,8 @@ sizeof(<+...c...+>)
>  |
>   &c->member
>  |
> +T c;
> +|
>  c = E
>  |
>  *c@p2
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
