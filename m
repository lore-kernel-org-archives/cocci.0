Return-Path: <SRS0=JAIf=VD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69EDC0650E
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 12:31:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D09A213F2
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 12:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kI7I5iBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D09A213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66CUjVx022699;
	Sat, 6 Jul 2019 14:30:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8DAF6777B;
	Sat,  6 Jul 2019 14:30:45 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 72304777A
 for <cocci@systeme.lip6.fr>; Sat,  6 Jul 2019 14:30:44 +0200 (CEST)
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x66CU7Bh012136
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 14:30:43 +0200 (CEST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-08.nifty.com
 with ESMTP id x66CKVJm027341
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 21:20:32 +0900
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x66CJAQP019454
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 21:19:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x66CJAQP019454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562415551;
 bh=EJ3W14PBrsskJ+euSqEK+tPd+XewB591N5inw23HqiM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kI7I5iBpL5v2OTJd3z2kRG3a4HIQDTa+CtyTYqilme7nWmCIK9tMEThmta7sCsDrj
 dB9dvsTVeZKhdZ8+6PyZsZCTZ7JI1j/4fnyaE3OLryH0gPRsE2oiRuLWZ7pG2LS9Sl
 RL9pElNCuYWVARjvomYa3RETSCrKsW/3e5i1EsgjMtLrxup03mFcPyJMMMiRNBSz32
 wy4C+uvq5jCJUVJtnJLgMdgKIKFmPP39iH0mhh5TZfzCzMwSPf0NLyGAcQCsDw/Zma
 jnle87IsYBZwUk/tLhB9Eb2Vug0vtHXrJ4lMtnU/TB7wMGGUVBWblwWPzS5/9G6rlD
 qj+fmSQiRtgMw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id v129so5378912vsb.11
 for <cocci@systeme.lip6.fr>; Sat, 06 Jul 2019 05:19:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVyqVFlBxMhA2kzjn7P4peRIcifVqWVo46W8kMgN/ui0+gz7PyH
 SiDa3bjY1iuLRyiuIb3G+GEHwgNME3fA5VgMDPk=
X-Google-Smtp-Source: APXvYqw9u6OIEEHZWSCpZvPbBaJl215dh9WqmzIWQwBghHvnbXg89EytVr3UMKjsfD1g6pCehQNTctoXrgBq4JT6o0I=
X-Received: by 2002:a67:f495:: with SMTP id o21mr5066465vsn.54.1562415550310; 
 Sat, 06 Jul 2019 05:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
 <alpine.DEB.2.21.1904082119190.2612@hadrien>
In-Reply-To: <alpine.DEB.2.21.1904082119190.2612@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 6 Jul 2019 21:18:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNB7DM9dPRFRqzKO41hG=dKPfTz8r0dkceSwk4VnvwtQ@mail.gmail.com>
Message-ID: <CAK7LNAQNB7DM9dPRFRqzKO41hG=dKPfTz8r0dkceSwk4VnvwtQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 14:30:45 +0200 (CEST)
X-Greylist: Delayed for 00:07:23 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Sat, 06 Jul 2019 14:30:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Coccinelle: kstrdup: Fix typo in warning
	messages
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

On Tue, Apr 9, 2019 at 4:20 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Mon, 8 Apr 2019, Rikard Falkeborn wrote:
>
> > Replace 'kstrdep' with 'kstrdup' in warning messages.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>
> Acked-by: Julia.Lawall@lip6.fr


Applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
