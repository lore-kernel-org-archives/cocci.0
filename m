Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA1C47258
	for <cocci@archiver.kernel.org>; Thu, 25 Jan 2024 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZtdecKqCn8sIcRhIFMaINueerihGHYj3vq6OVxXcxg8=;
  b=hstrZEUvlhQR53QzKJSQHitIuVeBHVxA1FdY5Xuq14iYhTgYxtUQBQMS
   q0evoBNMNPqABhosz1gUCuUM1PY5ZxqrZsA5uIE/2IWtJQSOAlKxDJUsX
   okfm4Sk13+8U1hgMsm3LnG/1bR9CD4izGDZYHqMRfTmqM5cEa+GB/m9Cd
   M=;
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
   d="scan'208";a="148674152"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jan 2024 18:29:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E77F4E0CD8; Thu, 25 Jan 2024 18:29:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A5B2E0035
	for <cocci@sympa.inria.fr>; Thu, 25 Jan 2024 18:29:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZtdecKqCn8sIcRhIFMaINueerihGHYj3vq6OVxXcxg8=;
  b=jXiNRmUbTBkevtsx7SvVB4by6nXlpNFZgyPR+pDqY6UcbWeJ3UW/fa31
   nOolqvJKk7WzCTlC+HHk13ro3agKA8XCLXTbowhHo/EFBsbdmeUdjsDoc
   Y+Dg+SXFNYtBBlxF7U/BeZkQzjPjmqke2+iP5f+K1ztbKqV3s+UMsRLPu
   o=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148674147"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:29:52 +0100
Date: Thu, 25 Jan 2024 18:29:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ec692ed7-01e5-493b-95b6-75ca7a59fb1b@web.de>
Message-ID: <cd85b5cf-07f-a1f9-ba30-126045bfe15c@inria.fr>
References: <ec692ed7-01e5-493b-95b6-75ca7a59fb1b@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-684945227-1706203791=:3525"
Subject: Re: [cocci] Checking name space conflicts for SmPL script rules
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1487
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/cd85b5cf-07f-a1f9-ba30-126045bfe15c%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-684945227-1706203791=:3525
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 25 Jan 2024, Markus Elfring wrote:

> Hello,
>
> I am trying the following tiny script variant for the semantic patch language out
> also together with the software combination “Coccinelle 1.1.1-00630-gdeb429df”.
>
>
> @search@
> identifier name;
> @@
>  name(...);
>
> @script:python selection@
> id << search.name;
> @@
> if id == "Test":
>    cocci.include_match(False)
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test-name_space_conflict-20240125.cocci
> …
> scriptmeta: parse error:
>   File "test-name_space_conflict-20240125.cocci", line 7, column 13, charpos = 81
>   around = 'name',
>   whole content = id << search.name;
>
>
> Now I wonder how this software behaviour would fit to the documentation.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L87
>
> Will the shown restriction be reconsidered?

name is also a reserved word of Coccinelle, as in iterator name xxx;

Just pick some other name for your metavariable.

julia
--8323329-684945227-1706203791=:3525--
