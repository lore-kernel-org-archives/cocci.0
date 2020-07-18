Return-Path: <SRS0=hRma=A5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734FAC433E1
	for <cocci@archiver.kernel.org>; Sat, 18 Jul 2020 08:42:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CBA20759
	for <cocci@archiver.kernel.org>; Sat, 18 Jul 2020 08:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CBA20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06I8fpvw008928;
	Sat, 18 Jul 2020 10:41:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0E7617779;
	Sat, 18 Jul 2020 10:41:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5FB3C3F6C
 for <cocci@systeme.lip6.fr>; Sat, 18 Jul 2020 10:41:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06I8fmDd009857
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 18 Jul 2020 10:41:48 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,366,1589234400"; d="scan'208";a="460290487"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2020 10:41:47 +0200
Date: Sat, 18 Jul 2020 10:41:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
Message-ID: <alpine.DEB.2.22.394.2007181034530.2538@hadrien>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de>
 <alpine.DEB.2.22.394.2007180841520.2538@hadrien>
 <fa0ec546-9aee-5c95-428c-a225a3521f6f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1044091524-1595061708=:2538"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 18 Jul 2020 10:41:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 18 Jul 2020 10:41:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [v2 1/4] coccinelle: api: extend memdup_user
 transformation with GFP_USER
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

--8323329-1044091524-1595061708=:2538
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 18 Jul 2020, Markus Elfring wrote:

> >>> Applied.
> >>
> >> Do you care for patch review concerns according to this SmPL script adjustment?
> >>
> >> * https://lore.kernel.org/cocci/5c0dae88-e172-3ba6-f86c-d1a6238bb4c4@web.de/
> >>   https://lkml.org/lkml/2020/6/9/568
> >
> > This one it complete nonsense.
>
> I hope that different views can be clarified for such a software situation
> in more constructive ways.

You proposed essentially  \( A \| B \) \( | C \| \)

This is not valid syntax in the semantic patch language.  The branches of
a \( \| \) have to be a valid expression, statement, type, etc, not some
random string of tokens.

> >> * https://lore.kernel.org/cocci/c3464cad-e567-9ef5-b4e3-a01e3b11120b@web.de/
> >>   https://lkml.org/lkml/2020/6/8/637
> >
> > This on is indeed a problem.
>
> I find this feedback interesting.
>
> * How does it fit to your response “Applied”?
>
> * Will it trigger any more consequences?
>
>
> > Markus, if you would limit your comments to suggesting SmPL code
> > that is actually correct, ie that you have tested,
>
> Patch reviews contain usual risks that suggestions are presented
> which can be still questionable.

These are not "usual risks".  You can easily test out your suggestion by
yourself to see if it produces valid code.  If it doesn't, then don't make
the suggestion.

>
>
> > and 2) stop suggesting stupid things over and over
>
> We come along different development views.

Whenever you propose the same thing say 10 times or more and it is
rejected every time, I thikn you should be able to conclude that if you
propose the same thing again it will be rejected.

>
> > like that putting all of the virtual declarations on
> > the same line would save space (it does, but who cares),
>
> It seems that you admit a possibly desirable effect.

No, I don't consider the effect to be desirable.

> Will any more developers care also for SmPL coding style aspects?
>
>
> > then I would take your suggestions more seriously.
>
> Your change acceptance is varying to your development mood
> (and other factors), isn't it?

Not really.  My "change acceptance" increases when the person reporting
them raises real problems that is blocking them in some work.  And it
decreases rapidly when the changes are almost all related to presumed
"efficiencies" that have no impact in practice.

julia
--8323329-1044091524-1595061708=:2538
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1044091524-1595061708=:2538--
