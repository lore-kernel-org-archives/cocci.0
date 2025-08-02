Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1913C87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XH932ILGwqPnWfhIdFUe5PO9SAcyDUDb10dZKGU1NpE=;
  b=IWWEjNrzQjqNF+8yBSG/6oIQa/DjpFpvX9GhtdqQB/9VIiyz0CGqFNVL
   AXCqNdwoDaYf2uiwERYf9zW4JY4KJEl9/JS+h1BU7Wa1hYBLDFFjRkHQf
   V8gnZJR6vdsWnetT0h4N52miECqGHr0PCCZnC2B/jX66RuNkn42x4L/mp
   E=;
X-CSE-ConnectionGUID: D54G+0YbSpGMLxKDHlrBYw==
X-CSE-MsgGUID: YM9eFcc5S1aFC5oOVdrK8g==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233951713"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 13:28:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 73479E0171; Sat,  2 Aug 2025 13:28:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EFCE3E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 13:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XH932ILGwqPnWfhIdFUe5PO9SAcyDUDb10dZKGU1NpE=;
  b=XTz8HxWsxPoAYvOdzSfoM6+mA6JY43wZ3kclOgNq7BcdeqTz0GRmUjKp
   mJYXrlxCnsQFrKX4R+Q75tjgTU0y3mpcJw92Hh03+Q8zxynXsZ367Gvgj
   TOXFyVNELTY1XPf4hPJmLg1JYiJTGXL9hAf16qby6arVgYWn+aDd+Fj6h
   A=;
X-CSE-ConnectionGUID: F9eZI44WQjSFVUG82NZgqw==
X-CSE-MsgGUID: DNczm831Qi+4gQOPQPJRiA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233951710"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 13:28:55 +0200
Date: Sat, 2 Aug 2025 13:28:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
Message-ID: <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de> <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr> <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de> <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr> <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de> <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-717246625-1754134135=:3428"
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2927
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/alpine.DEB.2.22.394.2508021326250.3428%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-717246625-1754134135=:3428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 Aug 2025, Markus Elfring wrote:

> > Would you get into the mood to clarify data processing challenges better
> > for another source code search pattern (like the following)?
>
> How reasonable would you find a test result for another source code search approach?

Completely reasonable.  You match pairs of subsequent locks, but you only
mark the second one in the pair.  So you match two pairs:

action_lock(&blockage1); and action_lock(&blockage2);

and

action_lock(&blockage2); and action_lock(&blockage2);

and you mark the second one in each case.

It would greatly help communication if you would also provide the answer
that you expect.

Please do not include the running time in every run, because that doesn't
seem to be related to the issue you are concerned about.

julia


>
>
> @display@
> expression x, y;
> @@
>  action_lock(x);
>  ... when != action_unlock(x);
> *action_lock(y);
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch ../janitor/show_second_lock_call_variant.cocci test-action_locks-20250725.c
> …
> @@ -2,13 +2,11 @@ void my_action_test(void)
>  {
>   action_lock(&blockage1);
>   my_log("blocked 1");
> - action_lock(&blockage2);
>   my_log("blocked 2");
>
>   if (my_surprise(123))
>   {
>    my_log("surprised!");
> -  action_lock(&blockage2);
>    my_log("blocked 2 once more");
>    result = 99;
>    action_unlock(&blockage2);
>
> real    0m0,067s
> user    0m0,045s
> sys     0m0,021s
>
>
> Regards,
> Markus
>
--8323329-717246625-1754134135=:3428--
