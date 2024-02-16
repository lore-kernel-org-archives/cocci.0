Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515F7C48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XGWbdaQ6TwvSfbh703ZW3B/c6gfV+0xuwkO3NNogFhI=;
  b=OGYpvLFGlWjGlVu+78Vm4XJPjKUtRT/WmDLQSOhOt2CRGv07feldG9AG
   DijlZjZae3FIkrTbo5IAnMsW/MRQBOLO2DsB4Eg7Oxa8FL0wjkky9xSru
   V0ovGvLt+LMh1pWHTFCHThpPhlRdWPEkgeMtELPJ+tF4S6fxzNMaUHbKi
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152320070"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 14:05:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4ED3BE0CD6; Fri, 16 Feb 2024 14:05:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 15C28E00B7
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 14:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XGWbdaQ6TwvSfbh703ZW3B/c6gfV+0xuwkO3NNogFhI=;
  b=Z2UTtXlbg7QJ8NGrDl0JkVGmbbvt/7p6ErsR4NuB9xMLg/lI0UMmF3fc
   YHRvnGZtHtctH27IKvWt9HnDFBaKv/iWJoW+9PAxQKI/LwndQtJrUJsUg
   U+50+JtNbSWzyAgPmpzN73y747V1kTFVnfvf3vXIc6rBMMc2ylOh7Ytbm
   c=;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152320027"
Received: from wifi-eduroam-84-238.paris.inria.fr ([128.93.84.238])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:05:49 +0100
Date: Fri, 16 Feb 2024 14:05:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <86f82a44-129a-4a84-be4d-4b230c2c018e@linbit.com>
Message-ID: <5f7a6b3d-89b2-c7b8-bada-87741dfe2c92@inria.fr>
References: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com> <654c2ee-755b-d245-d1c9-371b314d9efb@inria.fr> <86f82a44-129a-4a84-be4d-4b230c2c018e@linbit.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1570868878-1708088748=:3317"
Subject: Re: [cocci] Spatch 1.1.1 backward incompatibility
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1569
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/5f7a6b3d-89b2-c7b8-bada-87741dfe2c92%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1570868878-1708088748=:3317
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 16 Feb 2024, Christoph Böhmwalder wrote:

> Am 16.02.24 um 10:51 schrieb Julia Lawall:
> >
> > Thanks for the report.  If convenient you could try the github version.
>
> The latest GitHub version (0df3efff) has the same problem. It also seems
> to have some other issue, because it took 1385.5s (instead of the usual
> ~25) to process the patch.
>
> I also noticed that Fedora used OCaml 5.0, so I tried with the same
> commit the Fedora version is based on (0afff7f), but compiled with OCaml
> 4.14. It didn't make a difference, so it's not an issue with OCaml 5.
>
> I'm trying to bisect this now, will report if I find anything.

OK, thanks.  It may be sufficient to bisect your example.  You can try for
example

--debug --show-trying

to see at what function it is getting stuck.

julia

>
> >
> > I really need to make a new release...
>
> I was going to ask about that... :)
>
> >
> > julia
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
>
--8323329-1570868878-1708088748=:3317--
