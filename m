Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CABC48BC1
	for <cocci@archiver.kernel.org>; Wed, 14 Feb 2024 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=e4RL6MQ7L60RWgFV9frie9PCyzZvfxXRBSW5Co9ccDA=;
  b=Zg0M6Caa12NKqQX9GiGE4zApnZj0l0CWoif7nDz7UpJXqT6LAIcAk4xn
   4P45gRZfAmNCeTx7PgavMJgwXSDpyzy50HD30AR77O/81hd32MuUyvZHz
   F+zfSG/lVnXsAWJGuUUPX4+Y35td6pMa9WsoSwCzRf7kcjPbceXO2IV1B
   U=;
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
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="151995166"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Feb 2024 18:49:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC5BBE0CD5; Wed, 14 Feb 2024 18:49:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 87ED2E00B7
	for <cocci@sympa.inria.fr>; Wed, 14 Feb 2024 18:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e4RL6MQ7L60RWgFV9frie9PCyzZvfxXRBSW5Co9ccDA=;
  b=gRVfZUV7c4yedt/u/aEd4nSkHdgjvknaORLUhOOxtTQYQwI26YkZSJEO
   Ld5IZhXmv7+SzeNbHhIHb/HxjUD05kjA7hoE27mCytxrKP0n9I5EG6VUX
   wCIJTOofPek9tMKYybF6xW14AVUHQulV/VO1OqoYsLSuSYsuMhocwoJ0o
   c=;
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="79658299"
Received: from wifi-eduroam-84-228.paris.inria.fr ([128.93.84.228])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 18:49:48 +0100
Date: Wed, 14 Feb 2024 18:49:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <5a3fabb1-32a7-4c44-8825-70a863f76bfe@web.de>
Message-ID: <631c5dc8-285e-810-16b2-b41987e3e24d@inria.fr>
References: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de> <alpine.DEB.2.22.394.2402132145410.5600@hadrien> <5a3fabb1-32a7-4c44-8825-70a863f76bfe@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-23251229-1707932988=:19345"
Subject: Re: [cocci] Fixing a parse error for a SmPL position variable
 constraint
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1553
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/631c5dc8-285e-810-16b2-b41987e3e24d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-23251229-1707932988=:19345
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 14 Feb 2024, Markus Elfring wrote:

> >> position find.p1, find.p2;
> >> position pos != find.p2;
> >
> > Try switching the above two lines.
>
> Did you try this SmPL code adjustment out already in your test environment?
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> spatch --parse-cocci show_same_statements7w-20240214.cocci
> …
> Variable find.p2 in duplicated_code cannot be used as both a position and a constraint

OK, I guess it is not allowed.  Actually, the semantics of positive an
negative uses of a position variable is quite different, so it seems that
it is not allowed to use both at once.

But it should be possible to use two position variables at the original
place.

julia

>
>
> How does this error message (from the software combination “Coccinelle 1.1.1-00687-g0df3efff”)
> fit to the discussed data processing intention?
>
> Regards,
> Markus
>
--8323329-23251229-1707932988=:19345--
