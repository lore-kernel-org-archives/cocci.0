Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9841BC4829A
	for <cocci@archiver.kernel.org>; Tue, 13 Feb 2024 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=iFT3ShHCH/PkTcOT4bSBBAYKDNHBJFPtPFT9xMAgNek=;
  b=PNQ2u0Msw5WT3d4UR1+xcHQj7mLgpqTEqw+/27TnLuO+a3eBiUVFYjUI
   yydmkJjvDmNOO0s8baBYnVm+Weg/8a8kPERYnkFRRtdP450tkuAwQnBi1
   BNoeRLbS2vjVJqR6f3FwkmDLJihofnCOW/3qRed7kk9stv2NsVJqZS0Hn
   4=;
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
X-IronPort-AV: E=Sophos;i="6.06,158,1705359600"; 
   d="scan'208";a="151808200"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Feb 2024 21:45:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 438EAE00B7; Tue, 13 Feb 2024 21:45:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AD243E008A
	for <cocci@sympa.inria.fr>; Tue, 13 Feb 2024 21:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iFT3ShHCH/PkTcOT4bSBBAYKDNHBJFPtPFT9xMAgNek=;
  b=L4d3mE87PzhNZ80xeKrWTaGwbPMKfqTLyqtYuVW0XHdjSEHgYwpR+mqb
   07O08mmeHU8jFxAm0iCH2yFG9rwsYe5QH3dEmJ2m3vTaezZeKbX3WOGXt
   41jyYMo+YWtnH006DQ8wVdxYfFmK8i1OQRNjoFYM2I/HDJAS+DW0Zd8PQ
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,158,1705359600"; 
   d="scan'208";a="79554551"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 21:45:56 +0100
Date: Tue, 13 Feb 2024 21:45:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de>
Message-ID: <alpine.DEB.2.22.394.2402132145410.5600@hadrien>
References: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1650136473-1707857156=:5600"
Subject: Re: [cocci] Fixing a parse error for a SmPL position variable
 constraint
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1551
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402132145410.5600%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1650136473-1707857156=:5600
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 13 Feb 2024, Markus Elfring wrote:

> Hello,
>
> I hope that you would like to take another look at a script variant
> (like the following) for the semantic patch language also together with
> the software combination “Coccinelle 1.1.1-00676-g99513ec1”.
>
>
> @find@
> position p1, p2;
> statement s1, s2;
> @@
>  if@p1 (...)
>  {
>     ... when any
>     s1
>     s2
>  }
>  ... when any
>  if@p2 (...)
>  {
>     ... when any
>     s1
>     s2
>  }
>
> @duplicated_code@
> position find.p1, find.p2;
> position pos != find.p2;

Try switching the above two lines.

julia

> statement s1, s2;
> @@
> *if@p1@pos (...)
> *{
>     ... when any
> *   s1
> *   s2
> *}
>  ... when any
> *if@p2 (...)
> *{
>     ... when any
> *   s1
> *   s2
> *}
>
>
> Temporary test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci show_same_statements7z.cocci
> …
> meta: parse error:
>   File "show_same_statements7z.cocci", line 21, column 21, charpos = 226
>   around = 'p2',
>   whole content = position pos != find.p2;
>
>
> Will more desirable analyses become possible by similar source code search approaches?
>
> Regards,
> Markus
>
--8323329-1650136473-1707857156=:5600--
