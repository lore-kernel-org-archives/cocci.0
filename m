Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20676C25B74
	for <cocci@archiver.kernel.org>; Sun,  2 Jun 2024 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cwhZHDKq7Si0Vo8lf3KqmCFAGgx9dXxHbrkCNJoZqlU=;
  b=AwF/qk3E5O4fDcLSuhG7+NeQMA2c4dzps6UbY200zIMQCnMfRdGMwBk2
   F6KjnFw6oOgO9LjpaC0lAm2/rN2xb0h54KEUjLlciqV9JuimXDb/ubnLA
   u454lAixxrtQqFHXi5prtRPOnH+dlg9qtH/1yJv2rt9Jtx/nCntRLMGNn
   A=;
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
X-IronPort-AV: E=Sophos;i="6.08,209,1712613600"; 
   d="scan'208";a="168588910"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jun 2024 17:08:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6FC51E0141; Sun,  2 Jun 2024 17:08:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 35C07E0035
	for <cocci@sympa.inria.fr>; Sun,  2 Jun 2024 17:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cwhZHDKq7Si0Vo8lf3KqmCFAGgx9dXxHbrkCNJoZqlU=;
  b=ZQydX4mGDaxHgN8ljG0ZFnoFAv8OcO3xzhKaDUKctCostEM9S0Kk2jJR
   eOaSrP1QEnTKsMspzrHqly8mlWreAn7z6v+sAr0fvwKNLOnt0Cawv4FWu
   C+uCVdLVVVkkJc5KYpi7F/wxH9WleFkTKGZS6GT9nWslApTYA3WXZGN8b
   A=;
X-IronPort-AV: E=Sophos;i="6.08,209,1712613600"; 
   d="scan'208";a="88585968"
Received: from unknown (HELO hadrien) ([89.207.171.77])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 17:08:32 +0200
Date: Sun, 2 Jun 2024 17:08:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ali Raza <ali.raza@samsung.com>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <48ecf4ec00c942bb841a356567d2aef1@samsung.com>
Message-ID: <57329629-ffff-f375-775a-faad346ce79@inria.fr>
References: <CGME20240602141758uscas1p292dac565d2e37b835caaccab029d456f@uscas1p2.samsung.com> <81137f7b03f14e0fa92ef726f552a102@samsung.com> <a2d46d1e-fa3-8eb5-ccd-5d28973a18c2@inria.fr> <48ecf4ec00c942bb841a356567d2aef1@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1238381281-1717340911=:3899"
Subject: RE: [cocci] Function name change
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1772
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/57329629-ffff-f375-775a-faad346ce79%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1238381281-1717340911=:3899
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

> >> I have the following.
>
> >> 
>
> >> MY_MACRO(foo(arg1, arg2,
>
> >>                                            arg3, arg4, arg5));
>
> >> 
>
> >> I want to change foo to bar, as follows.
>
> >> 
>
> >> MY_MACRO(bar(arg1, arg2,
>
> >>                                            arg3, arg4, arg5));
>
> > 
>
> >Try:
>
> > 
>
> >MY_MACRO(
>
> >- foo
>
> >+ bar
>
> >    (...))
>
> > 
>
> >If that doesn't work, then perhaps there is a problem in parsing your C
>
> >code.  Take a file that you expect to change and try
>
>  
>
> Here is the spatch you suggested.
>
>  
>
> 18:    MY_MACRO(
>
> 19:   - foo
>
> 20:   + bar
>
> 21:   (...))

There should be at least one space in front of the ( on line 21.

julia

>
>  
>
> And here is the output that I get.
>
> disjunction parenthesis in line 21 column 0 matched to normal parenthesis on
>  line 21
>
>  
>
> > 
>
> >  spatch --parse-c file.c
>
> > 
>
> >See if the code that you expect to change has bad or BAD in front of it.
>
>  
>
> Running spatch --parse-c file.c gives me 100.00% good or passed.
>
>  
>
> Thanks
>
> Ali
>
>  
>
> > 
>
> >julia
>
> > 
>
> > 
>
> >> 
>
> >> I have tried many versions of the following, but to no avail.
>
> >> 
>
> >> 
>
> >> @@
>
> >> expression E;
>
> >> @@
>
> >> <...
>
> >> -foo(E)
>
> >> +bar(E)
>
> >> ...>
>
> >> 
>
> >> 
>
> >> Thanks!
>
> >> 
>
> >> Ali
>
> >> 
>
>  
>
>
--8323329-1238381281-1717340911=:3899--
