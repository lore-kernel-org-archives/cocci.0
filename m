Return-Path: <SRS0=xXNX=HU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8364C433DB
	for <cocci@archiver.kernel.org>; Thu, 18 Feb 2021 11:29:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1EF64E4B
	for <cocci@archiver.kernel.org>; Thu, 18 Feb 2021 11:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1EF64E4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11IBT5he011689;
	Thu, 18 Feb 2021 12:29:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5E38439D7;
	Thu, 18 Feb 2021 12:29:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F7B1376A
 for <cocci@systeme.lip6.fr>; Thu, 18 Feb 2021 12:29:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11IBT2ZX016751
 for <cocci@systeme.lip6.fr>; Thu, 18 Feb 2021 12:29:02 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,187,1610406000"; d="scan'208";a="493656325"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 12:29:02 +0100
Date: Thu, 18 Feb 2021 12:29:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102181227230.2748@hadrien>
References: <20210216080133.455456-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
 <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com>
 <alpine.DEB.2.22.394.2102181114380.2748@hadrien>
 <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Feb 2021 12:29:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Feb 2021 12:29:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add swap script
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



On Thu, 18 Feb 2021, Denis Efremov wrote:

>
>
> On 2/18/21 1:17 PM, Julia Lawall wrote:
> >
> >
> > On Thu, 18 Feb 2021, Denis Efremov wrote:
> >
> >>
> >>
> >> On 2/18/21 12:31 AM, Julia Lawall wrote:
> >>>> +@depends on patch@
> >>>> +identifier tmp;
> >>>> +expression a, b;
> >>>> +type T;
> >>>> +@@
> >>>> +
> >>>> +(
> >>>> +- T tmp;
> >>>> +|
> >>>> +- T tmp = 0;
> >>>> +|
> >>>> +- T *tmp = NULL;
> >>>> +)
> >>>> +... when != tmp
> >>>> +- tmp = a;
> >>>> +- a = b;
> >>>> +- b = tmp;
> >>>> ++ swap(a, b);
> >>>> +... when != tmp
> >>>
> >>> In this rule and the next one, if you remove the final ; from the b = tmp
> >>> line and from the swap line, and put it into context code afterwards, them
> >>> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
> >>> function xfs_lock_two_inodes where two successive swap calls are
> >>> generated.
> >>>
> >>> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
> >>> the function ath5k_hw_get_median_noise_floor where the swap code makes up
> >>> a whole if branch.
> >>
> >>> In this cases it would be good to remove the {}.
> >>
> >> How this can be handled?
> >>
> >> If I use this pattern:
> >> @depends on patch@
> >> identifier tmp;
> >> expression a, b;
> >> @@
> >>
> >> (
> >>   if (...)
> >> - {
> >> -       tmp = a;
> >> -       a = b;
> >> -       b = tmp
> >> +       swap(a, b)
> >>         ;
> >> - }
> >> |
> >> -       tmp = a;
> >> -       a = b;
> >> -       b = tmp
> >> +       swap(a, b)
> >>         ;
> >> )
> >>
> >> The tool fails with error:
> >>
> >> EXN: Failure("rule starting on line 58: already tagged token:\nC code
> >> context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574,
> >> column 4, charpos = 41650\n around = 'sort',\n whole content =
> >> \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c
> >
> > A disjunction basically says "at this node in the cfg, can I match the
> > first patter, or can I match the second pattern, etc."  Unfortunately in
> > this case the two branches start matching at different nodes, so the short
> > circuit aspect of a disjunction isn't used, and it matches both patterns.
> >
> > The solution is to just make two rules.  The first for the if case and the
> > second for everything else.
> >
>
>   if (...)
> - {
> -       tmp = a;
> -       a = b;
> -       b = tmp
> +       swap(a, b)
>         ;
> - }
>
>
> This produces "single-line ifs".
> Maybe generated patches can be improved somehow?
> Moving -+; doesn't help in this case.

There is clearly some problem with the management of newlines...

The other alternative is to just have one rule for introducing swap and
another for removing the braces around a swap, ie

if (...)
- {
  swap(...);
- }

I don't think it would be motivated to remove the newline in that case.

julia

>
> diff -u -p a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
> --- a/drivers/net/wireless/ath/ath9k/calib.c
> +++ b/drivers/net/wireless/ath/ath9k/calib.c
> @@ -32,11 +32,7 @@ static int16_t ath9k_hw_get_nf_hist_mid(
>
>         for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
>                 for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
> -                       if (sort[j] > sort[j - 1]) {
> -                               nfval = sort[j];
> -                               sort[j] = sort[j - 1];
> -                               sort[j - 1] = nfval;
> -                       }
> +                       if (sort[j] > sort[j - 1]) swap(sort[j], sort[j - 1]);
>                 }
>         }
>         nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
> diff -u -p a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> --- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> @@ -1011,19 +1011,11 @@ static void __ar955x_tx_iq_cal_sort(stru
>                 for (ix = 0; ix < MAXIQCAL - 1; ix++) {
>                         for (iy = ix + 1; iy <= MAXIQCAL - 1; iy++) {
>                                 if (coeff->mag_coeff[i][im][iy] <
> -                                   coeff->mag_coeff[i][im][ix]) {
> -                                       temp = coeff->mag_coeff[i][im][ix];
> -                                       coeff->mag_coeff[i][im][ix] =
> -                                               coeff->mag_coeff[i][im][iy];
> -                                       coeff->mag_coeff[i][im][iy] = temp;
> -                               }
> +                                   coeff->mag_coeff[i][im][ix]) swap(coeff->mag_coeff[i][im][ix],
> +                                                                     coeff->mag_coeff[i][im][iy]);
>                                 if (coeff->phs_coeff[i][im][iy] <
> -                                   coeff->phs_coeff[i][im][ix]) {
> -                                       temp = coeff->phs_coeff[i][im][ix];
> -                                       coeff->phs_coeff[i][im][ix] =
> -                                               coeff->phs_coeff[i][im][iy];
> -                                       coeff->phs_coeff[i][im][iy] = temp;
> -                               }
> +                                   coeff->phs_coeff[i][im][ix]) swap(coeff->phs_coeff[i][im][ix],
> +                                                                     coeff->phs_coeff[i][im][iy]);
>
> Thanks,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
