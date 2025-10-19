Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C21ACCD183
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=20zBhthqQBTvttL/UwxwFvEbsfvheQBh8oEVP362MLo=;
  b=Ef0YAmauFnqBlqmUjKNBMCitqDbP8CKvhF2UwIPWit3Cn0cOZ2myGNYM
   mwo+mTlLp2xCYBVaQSYcLFlDghVwUFRJzu5sQ0UNvPDd2NVifB5Gt+EwZ
   JLD/EMwgqfkr/NxhPIQ9Ndx9DlHznrC2MCemUlI/ge24okdkkMnT3VvXp
   0=;
X-CSE-ConnectionGUID: 0LFUrf7gSrOoGxJgpyq8wA==
X-CSE-MsgGUID: kKh2fcAYQoyD0dvMdJ5q/w==
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
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="245012067"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 16:10:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1184E0CDC; Sun, 19 Oct 2025 16:10:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4AF39E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 16:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=20zBhthqQBTvttL/UwxwFvEbsfvheQBh8oEVP362MLo=;
  b=l6IdUiVXtH7G0wTn9UxWyBxVIvbLRedg/gFLwDcD/a7Xs50UcfQvsLj+
   nV1S5vfBtryhvBxj5OVxx85RkplooPP21swnUxJG3jlQueKJcOM/FkSGi
   EFqu7xajeXt0hmxXUOWytiLLQOjvHLRq4tP3u02YFCPrymC8lgGvsip0a
   o=;
X-CSE-ConnectionGUID: rjHYRKpbRhKE2pjM1p/4Ww==
X-CSE-MsgGUID: S0BK37mdRVSES1nrhorEOA==
X-IronPort-AV: E=Sophos;i="6.19,240,1754949600"; 
   d="scan'208";a="128610540"
Received: from unknown (HELO hadrien) ([202.187.229.14])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 16:10:07 +0200
Date: Sun, 19 Oct 2025 22:10:04 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
Message-ID: <d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d@inria.fr>
References: <4afdfd37-3177-4480-9648-ab0d7f59097c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2099342365-1760883007=:17784"
Subject: Re: [cocci] Analysis challenges with SmPL for pass-through
 functions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3077
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/d1b6d33d-cfc0-ff6b-47de-7bbc28e8a7d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2099342365-1760883007=:17784
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 19 Oct 2025, Markus Elfring wrote:

> Hello,
>
> I am curious if further developers will become interested to discuss technical
> details like the following (in combination with the software “Coccinelle 1.3.0”).
>
> Another source file example:
> #include <string.h>
>
> void my_test_copy(void)
> {
>  char text[123];
>  char* target = strcpy(text, "Hello!");
>  target = strcpy(target, "Bye");
> }
>
>
> A)
> SmPL script variant:
> @display@
> constant char[] input;
> identifier x, y;
> @@
> *y = strcpy(x, input)
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch show_selected_strcpy_calls.cocci test-copy_literal_to_buffer2.c
> …
> @@ -3,6 +3,4 @@
>  void my_test_copy(void)
>  {
>   char text[123];
> - char* target = strcpy(text, "Hello!");
> - target = strcpy(target, "Bye");
>  }
>
>
> B)
> SmPL script variant:
> @display2@
> constant char[] literal;
> identifier i;
> @@
> *i = strcpy(i, literal)
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> /usr/bin/spatch show_selected_strcpy_calls2.cocci test-copy_literal_to_buffer2.c
> …
> @@ -4,5 +4,4 @@ void my_test_copy(void)
>  {
>   char text[123];
>   char* target = strcpy(text, "Hello!");
> - target = strcpy(target, "Bye");
>  }
>
>
> The variable definition was not matched by the second source code search approach
> because the used identifiers are obviously different there.
> This aspect did not hinder an additional match by the first source code search approach
> according to another assignment for the variable “target” while the same identifier
> was found by two metavariables.
>
> Will further clarifications become more interesting for corresponding case distinctions?

There is no guarantee that two metavariables don't match the same thing.
If you don't want them to match the same thing, then you need to use a
disjunction.  In the first branch, the same metavariable should be used
twice, and then in the second branch there would be the two different
metavariables.  The match should only be indicated for the second branch.

julia
--8323329-2099342365-1760883007=:17784--
