Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A79CCF9F8
	for <cocci@archiver.kernel.org>; Sat,  1 Nov 2025 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XnMduhjzhBDGIwAVaJw2uT8gPvbm9VHvitEEWKurSqM=;
  b=jOz7azSzFRlLQMjgm6B0fPHyAq66WXh0GBtFhwMKfkZGHfsi9PxGBHid
   3Vr1cj539KkzaHiV1D6/H6npFYhCnieEjZOPgWkHivJ3FcuXPoWBTqAdb
   l9gzsbAPCCe9IHSlgVaTHG8lmZ41hZi+h8hVGdQVqpHea3KaoLtHLzK3O
   k=;
X-CSE-ConnectionGUID: vVmJKv+FRsuce5nEMBUyDQ==
X-CSE-MsgGUID: 5KQpEbRQRjG1kRLYUtKU4Q==
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
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247088620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2025 10:19:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 532C9E0264; Sat,  1 Nov 2025 10:19:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A50F9E0171
	for <cocci@sympa.inria.fr>; Sat,  1 Nov 2025 10:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XnMduhjzhBDGIwAVaJw2uT8gPvbm9VHvitEEWKurSqM=;
  b=RFrIBfXQU561bUQX9B6LgjaLf6ZCR8+URgmW84ybpLgoRPA+68DZzatj
   WOvv27VwqR7zFQrBmsZKzcD45XvMgl8Fo5QldrCTA4Ir8MLqkZdweQ9iR
   eldo+SHlIovrtq2qCTopo7kuGXkiFR5uaq4aOLzHISQTKXWqctyAt0jFZ
   o=;
X-CSE-ConnectionGUID: 3Zw6D/mfQSmQoqCz8usJ5g==
X-CSE-MsgGUID: RMwH4D6uSGSTBt2bjadDLw==
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247088617"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 10:19:08 +0100
Date: Sat, 1 Nov 2025 10:19:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <8586e8c0-a756-4d43-8bf5-2e26fccceeff@web.de>
Message-ID: <603a30da-628-2e4e-8044-a9b686e42a5a@inria.fr>
References: <8586e8c0-a756-4d43-8bf5-2e26fccceeff@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1167633354-1761988748=:7686"
Subject: Re: [cocci] Improving expression list selections with SmPL
 ellipses?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3132
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/603a30da-628-2e4e-8044-a9b686e42a5a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1167633354-1761988748=:7686
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 1 Nov 2025, Markus Elfring wrote:

> Hello,
>
> Would you find the following SmPL script variant reasonable?
>
> @display@
> @@
> *my_action("Hello!", ..., ...);

I have no idea what you think this should mean.  How is it different than

my_action("Hello!", ...);

julia

>
>
> Unfortunately, I was disturbed by the following information.
>
> Questionable test result (according to the software combination “Coccinelle 1.3.0”):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch --parse-cocci parse_test_for_ellipsis_as_last_parameter.cocci
> …
> minus: parse error:
>   File "parse_test_for_ellipsis_as_last_parameter.cocci", line 3, column 26, charpos = 39
>   around = '...',
>   whole content = *my_action("Hello!", ..., ...);
>
>
> Under which circumstances will such data processing work also without using
> extra metavariables (instead of SmPL ellipses)?
>
> Regards,
> Markus
>
--8323329-1167633354-1761988748=:7686--
