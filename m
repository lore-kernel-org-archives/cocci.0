Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE53AC6FA82
	for <cocci@archiver.kernel.org>; Tue, 20 Sep 2022 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mcagBDy+jjNclke4sqUbVPsFI/F7edwOVzn01ZHhCpk=;
  b=cZgKG4i6wkWTGlLfb1CiKh82bSGBaBiPBtsuHCwJKmmOmhZ2zvPysVDv
   Dcg+oTwlkFPTh2jjOt4HgLxqRkRjlpZYDVr/jbC6SCbmW173pheYx3Y7Y
   Zj1h/gy1sM3W2yCBufgvgjeU62XUQ5pRH8Qci/96gbd3ETK7FgemsTA18
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="53734378"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Sep 2022 22:13:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 66018E039B; Tue, 20 Sep 2022 22:13:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0E7CE0157
	for <cocci@sympa.inria.fr>; Tue, 20 Sep 2022 22:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mcagBDy+jjNclke4sqUbVPsFI/F7edwOVzn01ZHhCpk=;
  b=cor8gbqtUkmPzOXPSrUEgeosSyyb2FmBwa0s6aPEx9FzAKHnCUjTfpMS
   OAQxglfzspQO4+oabyEAuSffFQsTBbtsho4F8iQuEaKUMJvZYGXG/5Ipa
   0g9GhtcxkAAvSdL1V5lL+SSUPr2rmk/Ni5+C5J89GNyFf5w+ADl2geN1z
   g=;
X-IronPort-AV: E=Sophos;i="5.93,331,1654552800"; 
   d="scan'208";a="24235806"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 22:13:48 +0200
Date: Tue, 20 Sep 2022 22:13:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org
In-Reply-To: <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
Message-ID: <alpine.DEB.2.22.394.2209202211430.2740@hadrien>
References: <20220920025820.105924-1-yuancan@huawei.com> <0896e030-5060-08e7-d0de-c63d77c9ef27@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1710843513-1663704828=:2740"
Subject: Re: [cocci] [PATCH v2 1/2] coccinelle: locks: add
 missing_mutex_init.cocci script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 562
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209202211430.2740%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1710843513-1663704828=:2740
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> > +mutex_init(\(&mm->fld\|&(mm->fld)\))
>
>
> An extra SmPL disjunction is probably unnecessary because of an isomorphism.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3f7496ff9c2c5d4fadae1e585aa458e1a0037972/standard.iso#L382
> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe148775bf4b0e0d/standard.iso#L382

This is correct.  It would be better to only have the version with the
parentheses, because Coccinelle will consider the case without parentheses
anyway.

>
>
> +mutex_init(&(mm->fld))
>
>
>
> …
>
> > +@r3@
> > +identifier s, fld;
> > +position p != {r2.p};
>
>
> Why do you think that such a SmPL constraint would be required?
>
>
> > +@@
> > +
> > +struct s {
> > +  ...
> > +  struct mutex fld@p;
> > +  ...
> > +};
>
>
> Why would the source code search repetition matter here?

He is searching for a structure that is different from the ones matched
previously.

>
>
> …
>
> > +@r5 depends on r4@
> > +identifier r3.s;
> > +struct s *mm;
> > +position p;
> > +@@
> > +* mm@p = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>
>
> I would expect that the usage of the asterisk in the first column should belong
> to the operation mode “context”.

This is correct.  Either the context mode should be fully supported or the
asterisk should be removed.

julia
--8323329-1710843513-1663704828=:2740--
