Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90585C83030
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Fmsst6GKzRIuq8kKQ2++0HW5BMmIkXLGp6iC3cL9Lrc=;
  b=jqCJISiAA1BOlfH3Xzap/AFOzBNoo2RaFQgd9t6P8UBiiNny7AAt8gYb
   XnJPQlmEJfpmLMCwrfRLGVmld/VzxuefB1KlcLsv3vfVPm91yKGeeGjMN
   hU7P5Y3DWaqQHHcIQuEhaYdRDPyyCOhyB128LAidbs/HEK9IdJn/5F9Lo
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230464872"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 21:10:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64733E02E4; Sat,  5 Jul 2025 21:10:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1BA25E0131
	for <cocci@sympa.inria.fr>; Sat,  5 Jul 2025 21:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fmsst6GKzRIuq8kKQ2++0HW5BMmIkXLGp6iC3cL9Lrc=;
  b=msVLortDgwBc7Pb64yoAooTDJJmLgIv1aufXFM/hOkFp/3f2RcAgcBF8
   G4ILnhqy2gLJCoKP7M8W0ErLsihIV04f9a3c+VTJwkY+6HBT3HnQ0irRm
   wAMjaqW645LyednJ3yUp1GuATtHvcmZ1tqq2+kNvHWixBj4e7OqnmwRQJ
   8=;
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230464869"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 21:10:51 +0200
Date: Sat, 5 Jul 2025 21:10:50 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <866027f2-598a-4aff-80ad-f9067ee2a951@web.de>
Message-ID: <alpine.DEB.2.22.394.2507052110070.14317@hadrien>
References: <866027f2-598a-4aff-80ad-f9067ee2a951@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-338647459-1751742651=:14317"
Subject: Re: [cocci] Support for position variables on comparison operators
 with SmPL isomorphisms?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2857
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/alpine.DEB.2.22.394.2507052110070.14317%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-338647459-1751742651=:14317
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 5 Jul 2025, Markus Elfring wrote:

> Hello,
>
> I would like to attach a position variable to a comparison operator in another
> script for the semantic patch language.
>
>
> @x depends on org || report@
> expression limit;
> identifier i;
> position p;
> statement s;
> @@
>  for (
>       <+... i = 0 ...+> ;
>       i <=@p limit
>       ;
>       <+...
> (     i++
> |     ++i
> )     ...+>
>      )
>  s
>
>
> Unfortunately, I got the following information (by the software combination
> “Coccinelle 1.3.0”) for further considerations.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/standard.iso#L316-329
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next2-patched> /usr/bin/spatch --parse-cocci -D report scripts/coccinelle/misc/show_questionable_count_limit_checks.cocci
> …
> warning: iso gtr_lss_eq does not match the code below on line 50
> bool (i <=@p limit)
>
> position variable x.p conflicts with an isomorphism
> …
>
>
> Will any more software adjustments become desirable accordingly?

No.  If you want the position of something, it seems that you want the
position of that thing, not something else.  So the position variable
prevents the isomorphism.

julia

>
> Regards,
> Markus
>
--8323329-338647459-1751742651=:14317--
