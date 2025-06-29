Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF759C7EE30
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=L8Nri+aadaEpt/Z1W2O/MWNBfZPrt87RozoLbe6BZ+g=;
  b=i5c2lVryRAoHvlDVwIgnrAI9+42yumkxun/6Cm5fFH0SLfQLmazN6I36
   x6QeQkkcERJJiPrJlhv5TaWOBMKwuFEuGLe1NjR8/9OKxgfuRQSdJcB8a
   QibvPQTtP+dtMR6IwifG3mllEjJSnrAWvOwglFhs+0dKPVCJgsqALyphk
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229464074"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 16:04:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3F4E5E0157; Sun, 29 Jun 2025 16:04:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3BF93E0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 16:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L8Nri+aadaEpt/Z1W2O/MWNBfZPrt87RozoLbe6BZ+g=;
  b=iAMf3ElC/XXX8C79/6RoGhOEqm8T5fDZYQnEgO8xI0k/5BRduWEKiHE/
   hWbRGXl1kCi46xtAKwSkK73vPQW/6gehCtl5xIUrkJy6obiYPTvCDp8pe
   MBwY1E0tyDEVIOQwVotR6ouEjAobTIVKqolVF5ewAZTLFaR6NKJQwBoVZ
   I=;
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="120224106"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 16:04:27 +0200
Date: Sun, 29 Jun 2025 16:04:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <36062929-58d6-424c-acf8-8cdab4ffa738@web.de>
Message-ID: <alpine.DEB.2.22.394.2506291602400.95572@hadrien>
References: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de> <alpine.DEB.2.22.394.2506291528480.95572@hadrien> <36062929-58d6-424c-acf8-8cdab4ffa738@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for longer conjunctions (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2813
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/alpine.DEB.2.22.394.2506291602400.95572%40hadrien>



On Sun, 29 Jun 2025, Markus Elfring wrote:

> > I don't see the point having both cases.
>
> Do you expect that the following source code search pattern should present
> a bit of diff output?
>
>
> @display2@
> expression a, b, c, d;
> @@
>  return
> *a && b && c && d && ...
>  ;

OK, there is an isomorphism for &&, but it only works when the && is in a
test expression.  That is not the case here.  the ... just matches any
expression.

julia
