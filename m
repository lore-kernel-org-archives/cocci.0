Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96483CA1015
	for <cocci@archiver.kernel.org>; Thu,  4 Sep 2025 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PhChoXc35AQOzluEiVLK2aBJeMQYTwcCWhOMbBFcWJE=;
  b=eAazBrg0bMJY505qI6n9rqR8hD1hE1HeDleouxLEyxH9aXbRRdfD+me2
   y+GwQH9+leOp6q4II4feGu1H+Lwwrjj7wi0SvBv+CUSkajfR+18CR5rk2
   PCPRZPGG1zhXL8PIWpnqjRhHogTTaJoKtbYbNwruX+UtfNeTlNwPhWupo
   A=;
X-CSE-ConnectionGUID: wf73E1IPSC+forxGtP72vA==
X-CSE-MsgGUID: q017lXWzRSCUupcTtrdTSw==
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
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="237511082"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Sep 2025 14:43:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D96C3E0BE9; Thu,  4 Sep 2025 14:43:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DA734E0171
	for <cocci@sympa.inria.fr>; Thu,  4 Sep 2025 14:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PhChoXc35AQOzluEiVLK2aBJeMQYTwcCWhOMbBFcWJE=;
  b=Wdx9Di+cDDjUW7Ht1QI9lbYz8TcaxO/7tgT6VztBhJJ27vh2Ys12EIgB
   u8saohWnjwA9gTQlHJx7gytoOEuTShVBmHBug4y2GQWckRnRkm52ohJIm
   pxvtPWaCk6aaVXQUcAZJdifHL294G+F5b+JJx92jj3wlycg+IfMU4ZqfX
   4=;
X-CSE-ConnectionGUID: 755ofHNwQmCnWh1fEq5E+w==
X-CSE-MsgGUID: Gno0B6NtSBapFopYAxdqpQ==
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="124639083"
Received: from wifi-eduroam-85-114.paris.inria.fr ([128.93.85.114])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:43:22 +0200
Date: Thu, 4 Sep 2025 14:43:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
Message-ID: <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-489916980-1756989801=:16531"
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2991
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/1bfe79b9-f7a4-c20-f116-75d9fe1642b2%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-489916980-1756989801=:16531
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 4 Sep 2025, Markus Elfring wrote:

> Hello,
>
> I tried the following script out for the semantic patch language.
>
>
> @display@
> expression e;
> statement s;
> struct device_node * dn;
> @@
> *dn = e(...);
>  if (!dn)
>     s
>  ... when != dn
>
>
> It can be determined then that the software “Linux next-20250904” contains
> 80 variable assignments where the object address might not be used any more
> after a null pointer check.
>
> * Would you be looking for corresponding improvements of such a source code
>   search approach?
>
> * How do you think about to take further data structures into account
>   for which objects should usually be released by a cleanup function?
>   Can the search pattern become more generic and safer?

You could add idexpression to the front of the line declaring the dn
metavariable.  If dn is a->b then perhaps the value is used elsewhere.

But if there are cases where dn really should be freed, that could be
something to write a patch for.

julia

>
>
> Regards,
> Markus
>
--8323329-489916980-1756989801=:16531--
