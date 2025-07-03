Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195E3C83030
	for <cocci@archiver.kernel.org>; Thu,  3 Jul 2025 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eI9DiC//U/gRCx5fbKnyO5mbwgixaFILy432z1rSEQ0=;
  b=hGE6Vm+FLIS+I8S4r8CoSQ3GrswQz1aMj3+lebMI6gvdgAOglHV+8Xur
   QC+VeuD+S9GXVW6a5GdZbNmW/8QweiyNmPvdR0ZflARlKp7KZUIlc1zs7
   1ZLCYfSbEEj8Apc1CcIqU0l+U+GaMMw8nQ+GOoF7Dx7ZjdRqH5qm8EbHW
   o=;
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
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230161739"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jul 2025 13:54:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7BEAE0131; Thu,  3 Jul 2025 13:54:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 51D38E01A8
	for <cocci@sympa.inria.fr>; Thu,  3 Jul 2025 13:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eI9DiC//U/gRCx5fbKnyO5mbwgixaFILy432z1rSEQ0=;
  b=qxUU4y43hvGJCkoTIJv+znTCAa+hWE6UqB4N/YiOzcZS37yf7I8hd8r3
   j8ktnD79Yixa2e7EM0TYLH2xQQl82UIghjzsuYXXhvmRelP3DJ/yQhTD3
   VL4JD2jPdLfp/22t4wTF1Y1kdp9QAK9JWyS0AdAS/kkYQkp87oPwcm8UC
   4=;
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="230161708"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 13:54:24 +0200
Date: Thu, 3 Jul 2025 13:54:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7a1ae793-7f9b-4ec7-9cc7-db176207369a@web.de>
Message-ID: <50208889-e99b-28ad-cc61-af8f92511192@inria.fr>
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de> <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de> <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr> <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de> <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de> <8a69338-c049-cce1-2d66-a9607c175270@inria.fr> <ab0209a9-fbf7-4bd8-ae78-d6fb337ee294@web.de> <44735e62-2ed6-730-6ab3-b2251d8b6723@inria.fr> <7a1ae793-7f9b-4ec7-9cc7-db176207369a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using statement list combinations?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2851
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/50208889-e99b-28ad-cc61-af8f92511192%40inria.fr>



On Thu, 3 Jul 2025, Markus Elfring wrote:

> >> Would you find an SmPL code variant (like the following) more reasonable?
> >>
> >> @display@
> >> statement header, footer;
> >> statement list sl;
> >> @@
> >> *header { sl } footer
> >
> > I don't know what you expect it to match.
>
> Such a source code search approach is very generic.
> I am curious how often this code pattern could be found finally.

Probably never.  People don't often make a {} between two other
statements.

julia
