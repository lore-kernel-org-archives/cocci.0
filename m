Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFFE77180
	for <cocci@archiver.kernel.org>; Wed, 11 Dec 2024 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HjhdgGcPbVrpz9rma524aJpSRrzAR2WbTGfkuznWY38=;
  b=s0LtQJ32rAbQb7pUvCfCL1ooKFXh1rX1YyzNq6tuI/xtG0amFkbwtMAj
   K3WK6Of9Clz/QSjEK9A3k7jAHqxVe92yQR9GhT57euXsYVL9NeCe3Jrxh
   84g/jiWaRZ6sl6Vo5KtmC7JBq/z7/OQ/x/f1QuahttmoIk4AmYTnLdRrf
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="198618010"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2024 14:05:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE2A8E0D1D; Wed, 11 Dec 2024 14:05:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 45043E007A
	for <cocci@sympa.inria.fr>; Wed, 11 Dec 2024 14:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HjhdgGcPbVrpz9rma524aJpSRrzAR2WbTGfkuznWY38=;
  b=Bxn1K/8uSIAtZ0DCdh+RT7tWk4/MjGtgY5oiit5k97bJGZUHCO2bf9EO
   IK/5opicTTO2NBjO3AGJsQGA3s2suz6NhMLlA5mpBDvBM1QQMtri8qpu3
   nZTWdsuvL7XnTMUnOIdDuwY8DmACWYVu//rajJumgTrbkb0Ccgd+V4ItU
   U=;
X-IronPort-AV: E=Sophos;i="6.12,225,1728943200"; 
   d="scan'208";a="104040866"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:05:04 +0100
Date: Wed, 11 Dec 2024 14:05:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <11adee55-edad-4f0e-b80b-cfd9099ab4eb@web.de>
Message-ID: <78704675-cc81-b635-6161-a2fb91d2b6d@inria.fr>
References: <11adee55-edad-4f0e-b80b-cfd9099ab4eb@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-258464898-1733922304=:3368"
Subject: Re: [cocci] Development challenges for handling of selected code
 repetitions (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2177
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/78704675-cc81-b635-6161-a2fb91d2b6d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-258464898-1733922304=:3368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 11 Dec 2024, Markus Elfring wrote:

> Hello,
>
> I hope that some software development concerns can be clarified also together
> with a script variant (like the following) for the semantic patch language.
>
>
> @adjustment@
> expression call;
> expression * pointer;
> statement action;
> @@
>  if (pointer)
> +{
>     action
>  <+... when != puts("Hello");
>  call(pointer);
>  ...+>
> +}

As noted, there is nothing to attach the } to.  The ... goes to the end of
the function unless there is the when.

julia

>
>
> Questionable test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci move_call_into_if_branch2.cocci
> …
> 12: no available token to attach to
>
>
> A) Can any collateral evolution become possible according to the shown error message?
>
> B) The information “Dots may be modified with a when clause,
>    indicating a pattern that should not occur anywhere within the matched sequence.”
>    is provided in the documentation.
>    https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca063810dbeacf6fdce08b95/docs/manual/cocci_syntax.tex#L1030
>
>    Such when clauses influence extra code which may eventually appear around
>    the searched code pattern.
>    But I would appreciate here if only selected repetitions of the specified code
>    will be taken into account for this use case.
>    https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca063810dbeacf6fdce08b95/docs/manual/cocci_syntax.tex#L797
>
>
> Regards,
> Markus
>
--8323329-258464898-1733922304=:3368--
