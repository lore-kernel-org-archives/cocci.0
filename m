Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23159C433FE
	for <cocci@archiver.kernel.org>; Mon,  3 Oct 2022 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mfShqkWxMVHaxzPZ4myC36M9dVoioYr+QmfaZUH3tE8=;
  b=dRmTtPCyGzdOq8f6B5jv2q8ktJIkoq9JlstaYIK42b2oD3uqyoJCFAVK
   x0uXJQzwqyqe4tx/NuazUWeI9/LXWxXCPp0FK/rv0sbJa7nPIndkJPuFP
   Cys04imsZRChVNwFQ+GKF9IOE6KyAZ/yQW72EIgFD5G2erHgCkWEyCGVq
   M=;
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
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55602138"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2022 09:29:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79420E0241; Mon,  3 Oct 2022 09:29:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 04FF1E0076
	for <cocci@sympa.inria.fr>; Mon,  3 Oct 2022 09:29:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mfShqkWxMVHaxzPZ4myC36M9dVoioYr+QmfaZUH3tE8=;
  b=AsmZ5SUuee+eNid99Iqf94P0uQ3XvcZyOBPRpfQKaPuY1igI+zP0BmzF
   gntIr1w8KWZrzai5MB49D5CDxOs29qneVxTsnm3GGxKUSQ9bfyXv39XO7
   Tjyf5MWp03cARnP4rePeGF1J8q3xZPPBmJ5MKfDpOtg1osi8zaCo3oRya
   A=;
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55602125"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:29:02 +0200
Date: Mon, 3 Oct 2022 09:29:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Julia Lawall <julia.lawall@inria.fr>, Yuan Can <yuancan@huawei.com>, 
    cocci@inria.fr
In-Reply-To: <fbdb47a7-1673-b741-08cb-5703931a8b2a@web.de>
Message-ID: <20be8691-3860-8c6-a169-1cbc332015e2@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien> <fbdb47a7-1673-b741-08cb-5703931a8b2a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1614538278-1664782141=:3755"
Subject: Re: [cocci] Checking explanations for SmPL functionality
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 610
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/20be8691-3860-8c6-a169-1cbc332015e2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1614538278-1664782141=:3755
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 3 Oct 2022, Markus Elfring wrote:

> …
> > (* check for aliases or non-standard uses *)
> >
> > @alias1@
> > type t;
> > t o;
>
> …
>
>
> I got the impression that such a code specification is not completely explained
> in the documentation for the semantic patch language so far.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/19454bc12f6f8cc0a7a6091edb28e8a2ca4518c2/docs/manual/cocci_syntax.tex#L199
>
> Which metavariable declarations may be started with a metavariable name?

This is what the documentation says currently:

It is possible to only match expressions of a specific \NT{ctype} or a set
of them with a pointer level using {\tt *} by writing these instead of the
{\bf expression} designator pattern.

It seems that that should be changed to type rather than ctype.

julia



>
> Regards,
> Markus
>
>
--8323329-1614538278-1664782141=:3755--
