Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1102FC48BC4
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3fNfPX8L3hXT1vnWEvwi6mJYlsS2zME4jCUE1D8h2is=;
  b=nBx+j1YZUpdBxqDtavoMjvtMfmCzeSD9ZNMVCpxW21ZKQ/cuPRXVKFUj
   FV1gdD8NngFT0L8MTtOiX6MjxSDHwVecuc/Hoe1/ll1+MnYPGDXZadGmn
   wXsU49cRbgSQgbQmNNbkiZEc/2tCAWQZsmKCGMjuu4yR/+N4BunezKbgl
   E=;
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
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153410046"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 08:54:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BB2BE0CD7; Fri, 23 Feb 2024 08:54:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D4C75E008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 08:54:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3fNfPX8L3hXT1vnWEvwi6mJYlsS2zME4jCUE1D8h2is=;
  b=bj/MkECn5fj/l5KFN91qb7qhXCfa23jadbpQeTyXs8TMgT7QCoyXQawS
   nTwawTq4PcjwYfYWCDyitxhsMsJHYU7bEwuje1aWosbmaJ8s5iVf8k3Mb
   lCQbyFsMgLA3dSXySsZZIj/jHwNXa0EfH/ljItZ41Tf/nV9Vu26anKxm/
   8=;
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153410037"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:54:37 +0100
Date: Fri, 23 Feb 2024 08:54:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <e3d5d5ca-ab22-49a4-8483-75e35a88446b@web.de>
Message-ID: <d4527c39-a26-ae3-86d-be23b6d457b@inria.fr>
References: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de> <71f51659-e163-abfd-7f96-fb6f40e0117@inria.fr> <e3d5d5ca-ab22-49a4-8483-75e35a88446b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-303529878-1708674876=:3400"
Subject: Re: [cocci] Using inherited input data for SmPL script rules?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1601
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/d4527c39-a26-ae3-86d-be23b6d457b%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-303529878-1708674876=:3400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 23 Feb 2024, Markus Elfring wrote:

> >> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test-inherited_input_for_script_rule.cocci
> >> …
> >> scriptmeta: semantic error: bad rule second_search or bad variable id
> >>   File "test-inherited_input_for_script_rule.cocci", line 12, column 21, charpos = 161
> >>   around = ';',
> >>   whole content = x << second_search.id;
> >
> > You should have inherited it from where it was defined, ie first_search.
> …
> >> Can the application of input data become supported for SmPL script rules
> >> even if such data would be inherited by longer SmPL rule chains?
>
> I am looking for extended data processing support.
>
> The second rule could also specify additional SmPL constraints,
> couldn't it?

I don't know.

> May SmPL script rules depend then on search results from a previous rule
> which references also inherited metavariables?

No.

If you want to do that, just make another metavariable.  You can write
i1@i2 to make two metavariables match at the same place.

julia
--8323329-303529878-1708674876=:3400--
