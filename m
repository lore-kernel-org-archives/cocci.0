Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F2FC43334
	for <cocci@archiver.kernel.org>; Wed,  8 Jun 2022 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=CEsbngddMkp90Voqca9T04crgDEcf1kKJsrgiFQMfxo=;
  b=Zvd1zkqZI/KRHz/kTZqUyYjpD3miRlplWrPBCZ9V2OMOwvvyb/CKFhcM
   E9lhK8Q1vQse+FL3im91hBMQGytGuDDh6CyMv+15m1azpZdBJhe16nUZo
   ALWFmU3Vs9pes4g6G6ybTpNkmq+1+9jRg1rnjdKvqFI46fKGhBoyNG0d/
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40056859"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jun 2022 16:07:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7028DE02DE; Wed,  8 Jun 2022 16:07:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E8B78E010B
	for <cocci@sympa.inria.fr>; Wed,  8 Jun 2022 16:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CEsbngddMkp90Voqca9T04crgDEcf1kKJsrgiFQMfxo=;
  b=tMzbNZhavcK+WEwEOrjPqsy2GS5b+owwF4jd7u9yM55qbJRlctgERYMt
   llWvE4qQPB8QH6wRUYqN08t7X8cYwdnWfGdCEUfv5isPRw22/b0J7tbUl
   3mFNsDTa5vQHR5udDWPmUJhwQqNG2rsRlDEK7sXcH24IeCwBM78AaejM/
   4=;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40056841"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:07:43 +0200
Date: Wed, 8 Jun 2022 16:07:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?J=E9r=E9my_LEFAURE?= <jeremy.lefaure@netatmo.com>
cc: Markus Elfring <Markus.Elfring@web.de>, "cocci@inria.fr" <cocci@inria.fr>, 
    "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <AS8PR03MB76038B2D2E451F0A07AEE4D093A49@AS8PR03MB7603.eurprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2206081605380.2960@hadrien>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com> <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de> <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
 <AS8PR03MB76038B2D2E451F0A07AEE4D093A49@AS8PR03MB7603.eurprd03.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-678616926-1654697262=:2960"
Subject: Re: [cocci] [PATCH v2] coccinelle: ifaddr: Find address test in
 more complex conditions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 423
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/alpine.DEB.2.22.394.2206081605380.2960%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-678616926-1654697262=:2960
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 8BIT



On Wed, 8 Jun 2022, Jérémy LEFAURE wrote:

> > I don't really understand the above, but it made me realize that actually
> > the following is sufficient:
> >
> > @@
> > expression x;
> > @@
> >
> > *&x || ...
> >
> > This forces &x to appear as a test expression. There can be 0 or more
> > occurrences of ||, so eg &x && y is also matched.
>
> That's indeed better because it allows to catch issues in tests that
> are not in if statements (such as loops). Is it ok to rename this file
> to test_addr.cocci in the next version of the patch to give it a more
> appropriated name?

That seems like a good idea, thanks.

>
> It also gives a better line indication for conditions split on several
> lines.
>
> I also noticed that with this change the semantic patch catches tests of
> addresses in if statements when likely/unlikely is used, for example
> if (likely(&a)). This was not the case with my previous patch nor with
> the current semantic patch version on master even though the isomorphism
> unlikely(E) <=> likely(E) => E is in the standard.iso file. I don't get
> this behavior change, do you have any idea why it didn't work?

Isomorphisms apply to the semantic patch, not to the code.  You see the
arrow only going to the right that reaches E.  If it were going to the
left, then Coccinellewould take every expression and try to wrap likely
and unlikely around it, which would obviously be undesirable.

julia
--8323329-678616926-1654697262=:2960--
