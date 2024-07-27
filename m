Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49BDC3DA4A
	for <cocci@archiver.kernel.org>; Sat, 27 Jul 2024 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=c6XPM372kmrknkCZihvqgiQ8Wfw8HWoq3Gs93xgmH44=;
  b=er5usyQCG/RtgsP56eOamudfjWSnHXsh+YXE7psz89sPC0dduy3lqqAp
   UoZJtoMMytWqrM5y/j0OQumkPzMabNbd3J0OFrBP+5TLxgfVrWt0aKZ5b
   y11UhRsnZCOanrRF/1oomlpWubsDawm8z2F/P6EssViS/oABjNuZ5GZdT
   k=;
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
X-IronPort-AV: E=Sophos;i="6.09,241,1716242400"; 
   d="scan'208";a="177210122"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2024 18:44:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 772EFE0141; Sat, 27 Jul 2024 18:44:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E66CE0035
	for <cocci@sympa.inria.fr>; Sat, 27 Jul 2024 18:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c6XPM372kmrknkCZihvqgiQ8Wfw8HWoq3Gs93xgmH44=;
  b=idI+KNQZuSA3p6l8GvMkj2cNjS1Y/Uxfeslmor67g6IAL0o/ERqmxGCA
   q8jpHGdhVakROeN8ThrpX9jSKHO8PZ9rK5abQR9jmW08omgKGO6vdO8SR
   evVKOap2rDgjuLXgeT1q0BP9bSklYTqmPwMlrcdYyf6po5RwyNYEtKg7v
   g=;
X-IronPort-AV: E=Sophos;i="6.09,241,1716242400"; 
   d="scan'208";a="177210121"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 18:44:51 +0200
Date: Sat, 27 Jul 2024 18:44:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de>
Message-ID: <alpine.DEB.2.22.394.2407271844070.3211@hadrien>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de> <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr> <74d26d15-2c7f-49d7-8081-3fdaedcac273@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-563449487-1722098691=:3211"
Subject: Re: [cocci] Code adjustment challenges according to the comma
 operator (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1826
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/alpine.DEB.2.22.394.2407271844070.3211%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-563449487-1722098691=:3211
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 27 Jul 2024, Markus Elfring wrote:

> > The above semantic patch does not parse because te ao e, is not a valid C
> > term.  There is no term in the C language that ends with a comma.
>
> I constructed another tiny script variant for the semantic patch language.
>
>
> @replacement@
> expression x, y;
> @@
>  x
> -,
> +;
>  y;
>
>
> I would like to point out that such a simple source code transformation approach
> found 156 files from the software “Linux next-20240726” for possible updates.
> Will further collateral evolution become interesting accordingly?

I think that you have to look at the examples and judget whether the use
of the comma operator is helpful in each case.

julia
--8323329-563449487-1722098691=:3211--
