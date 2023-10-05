Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF41AE8FDC7
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4V3yN6e5BUEAfFCv42NAONwFnWJZM3PgB2gzFs10soU=;
  b=eCBRV++uzqBAEXaeod4eFr4xksqFkZH5VMTWUiaPT36v4oDfzfG78d3I
   O4/iInIerjiuTANilWre5NgY4u1S/KJ2NXikPvmuEXeM/3Q9mR2J743Ij
   iXXMyyql4gZT2RSZiq8sM2SwzOEE7+Xj6rSswcX+RFjzyazrjCIyEXxiq
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129633751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 12:23:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21D07E00BA; Thu,  5 Oct 2023 12:23:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 175BFE00B7
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 12:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4V3yN6e5BUEAfFCv42NAONwFnWJZM3PgB2gzFs10soU=;
  b=iQ1ZFP8zUWIn2kUWYTOCu+onb/N24/haDyEYWUF7y2knGbp2fuE3dG7/
   ncIAqR5K5GwtVodbAdfD0+ePvEQhQoHMMZXrOtutxgc/TXAdID20g5NRd
   /Ri0zeqGzBcKpBia4/CY+VaiWwe34osGI9e0/cuXCNBrs4aOgQLv1aDpp
   E=;
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129633741"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:23:26 +0200
Date: Thu, 5 Oct 2023 12:23:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <29542ba7-5d13-4089-abc3-5ab314af4fc6@web.de>
Message-ID: <alpine.DEB.2.22.394.2310051222530.3375@hadrien>
References: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de> <alpine.DEB.2.22.394.2310051159410.3375@hadrien> <29542ba7-5d13-4089-abc3-5ab314af4fc6@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for variable definitions in C++ source files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1247
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310051222530.3375%40hadrien>



On Thu, 5 Oct 2023, Markus Elfring wrote:

> >> @display@
> >> identifier x;
> >> @@
> >> *RPC x(...);
> >
> > Some dy we will be able to parse more of C++.
>
> Is the current Coccinelle software status so far that the search for variables
> (where a constructor initialisation is applied) is not supported?
> https://en.cppreference.com/w/cpp/language/definition
> https://en.cppreference.com/w/cpp/language/constructor#Example

I don't understand the question, but I think that the parenthesis notation
of C++ causes a severe parser conflict.

julia
