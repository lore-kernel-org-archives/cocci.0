Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B351C47E49
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+wj1Cp4VKyiZol9Pd6CSxIPx5WtBuVYUYwivxoFTtIY=;
  b=MFY6G9iwMxSPva3R4cpWkfB/ApS3Cre80vn5fE5KS8fP+t5lNoqUjtz8
   Vmq9OTT3SmvF3VFuVBL21b27wTJl/djKbh6Zw4OHcxFfWytatMR4BZ+qg
   GuI67n8nsf3CG/J4m3W0TWrt1vasPCPBa+RGl65gMHSX/1tZoFjN/Bi4m
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148457612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 18:22:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F32CE008A; Wed, 24 Jan 2024 18:22:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CD321E0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 18:22:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+wj1Cp4VKyiZol9Pd6CSxIPx5WtBuVYUYwivxoFTtIY=;
  b=t0qGixWdmMuBwmgbBKuz3J1kxAtc6Ox5ZxplCv/YVDTKAFTxoG3ANqLp
   ENJXNGDcnylcgJQdTkHHr/l3TL76ogmszmRdCr06+NZyR/GkOyM7LmV1R
   fwk861xkfUhdlS0kCjlg3QtdIkZBTc/VfNOvdZhUCSvCKR2c4ztWHuj9e
   w=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77730106"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 18:22:55 +0100
Date: Wed, 24 Jan 2024 18:22:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
Message-ID: <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-335696400-1706116975=:3680"
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1477
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/c5407d97-913-f788-7ffb-11b65373cb5%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335696400-1706116975=:3680
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 24 Jan 2024, Markus Elfring wrote:

> Hello,
>
> I am trying the following tiny script variant for the semantic patch language out
> also together with the software combination “Coccinelle 1.1.1-00630-gdeb429df”.
>
>
> virtual report, org
>
> @or depends on org || report disable sizeof_type_expr@
> position p;
> @@
>  my_action@p(...)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci or-test2-20240124.cocci
> …
> rule name: parse error:
>   File "or-test2-20240124.cocci", line 3, column 1, charpos = 22
>   around = 'or',
>   whole content = @or depends on org || report disable sizeof_type_expr@
>
>
> Now I wonder how this software behaviour would fit to the documentation.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L87
>
> May SmPL rule identifiers be chosen freely?

It seems that they should not be keywords.

julia
--8323329-335696400-1706116975=:3680--
