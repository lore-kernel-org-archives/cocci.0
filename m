Return-Path: <SRS0=JAIf=VD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8183C0650E
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:15:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6266120843
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JhXcT3tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6266120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DF039002384;
	Sat, 6 Jul 2019 15:15:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61742777B;
	Sat,  6 Jul 2019 15:15:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E9CE5777A
 for <cocci@systeme.lip6.fr>; Sat,  6 Jul 2019 15:14:58 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DEw8I028558
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 15:14:58 +0200 (CEST)
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x66DEJLI015257
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 15:14:51 +0200 (CEST)
X-Ids: 164
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x66DDh70029958
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 22:13:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x66DDh70029958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562418824;
 bh=e2JdIb42SpLrSPeYe2x3rwr5/vj30CwDJrGofHRtPcQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JhXcT3tY2Wq/yZGd+3pUaS1SdtNnM/1oAhQqeajQhVia4lD5nGC03QlOP9DuXvNTU
 iGZT9acvdPaMizjv9kn84PP+alLcfTe6FqEF2bEzIn7Cygc98i1K9N6YhGssF4iJAu
 1IaUQjXzGbQg4Wi8Cs+KolTPMR+2Ij9P0A3Y89vlIS5brf2b599/edHOKYdBFWq4HC
 FjWZdM1JRa8bJJa+xP11vwmvLoFLgcrPwh3/tx/zzbkK27jjJn3QSaQrFB17/ZXAPs
 1iE3mMJRfmvpbJNWKMtYLkEA8jXcXIGJGZ5TKDbIHbU0pcsnZ0ky7+XHfGZMyvhWEM
 5Q8NDXa8QQU9w==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id 34so3174997uar.8
 for <cocci@systeme.lip6.fr>; Sat, 06 Jul 2019 06:13:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXl1B7In0Y/WcV8NfQMV8wQyor8eoydOFPPHwboi9YYhfMt6kVy
 +ZZmYO/PYy/RqqG4+4cYrmFfW33whz6h16sTUlc=
X-Google-Smtp-Source: APXvYqyCmZNNAH3HX1+U1sPCnry+OjVGTzY7HA5gSSqHJPNpCJJ86QhC/3VJO6gn503UNHnpEfLyqBNYAHnoRh4iXtQ=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr4965431uad.121.1562418822502; 
 Sat, 06 Jul 2019 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
In-Reply-To: <308f5571-68f3-7505-d5ad-59ee68091959@web.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 6 Jul 2019 22:13:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmqVDG8V=S5zfSAmKgeDE0M__P_mi0FpahYLLxmAQ-dw@mail.gmail.com>
Message-ID: <CAK7LNARmqVDG8V=S5zfSAmKgeDE0M__P_mi0FpahYLLxmAQ-dw@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5D209EAB.001 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5D209EAB.001 from
 conssluserg-04.nifty.com/conssluserg-04.nifty.com/210.131.2.83/conssluserg-04.nifty.com/<yamada.masahiro@socionext.com>
X-Scores-Stats: 5D209EAB.001 B=0.50000 L=0.15143 G=0.15143 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5D209EAB.001 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.151 -> S=0.151
X-j-chkmail-Status: Ham
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 15:15:00 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 15:14:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [PATCH 1/5] Coccinelle: put_device: Adjust a message
	construction
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

On Mon, May 13, 2019 at 5:59 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 7 May 2019 11:20:48 +0200
>
> The Linux coding style tolerates long string literals so that
> the provided information can be easier found also by search tools
> like grep.
> Thus simplify a message construction in a SmPL rule by concatenating text
> with two plus operators less.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to linux-kbuild.


>  scripts/coccinelle/free/put_device.cocci | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index c9f071b0a0ab..3ebebc064f10 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -42,11 +42,10 @@ p1 << search.p1;
>  p2 << search.p2;
>  @@
>
> -coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
> -                             + "call of_find_device_by_node on line "
> -                             + p1[0].line
> -                             + ", but without a corresponding object release "
> -                             + "within this function.")
> +coccilib.report.print_report(p2[0],
> +                             "ERROR: missing put_device; call of_find_device_by_node on line "
> +                             + p1[0].line
> +                             + ", but without a corresponding object release within this function.")
>
>  @script:python depends on org@
>  p1 << search.p1;
> --
> 2.21.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
