Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCECC48260
	for <cocci@archiver.kernel.org>; Thu,  8 Feb 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=NaQZ8D6pz44gkwxxgJSeiVNzIbYI8UBhK2WHDfoQ4so=;
  b=mDR+EPC9HtYpi/LvwE/DPIjROfPrl8u6aUaBiT4PtZZ0rU/4OZlhhvD7
   AicOqRGSFWv1Wv/NOzLlVgFNZBhrucbgWewoEF3sAbeiRFU1ikvUENzdm
   kb39pxrJm4838B4pStYaowaghWX2ud9c/w0PPp631tJW68DFjO4UeboUE
   E=;
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
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="150939226"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Feb 2024 12:41:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5688BE0CD5; Thu,  8 Feb 2024 12:41:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1D3F3E008A
	for <cocci@sympa.inria.fr>; Thu,  8 Feb 2024 12:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NaQZ8D6pz44gkwxxgJSeiVNzIbYI8UBhK2WHDfoQ4so=;
  b=BdBoN8tWOpBDXL1ahGe0Bf0zDY2JD6jD3QLMrSXbr7XE2cd4asCzALxU
   KDGz0c426Aa0cqaNNF9Ti/97PsiebBgYLBvWhzmlO87gObsxIByqiwMd5
   kk2DQu1P4Tbt16FxUHnw8FceSpshk08lSoTVK9Xoe3gv2jHBxtMWXHfmc
   E=;
X-IronPort-AV: E=Sophos;i="6.05,253,1701126000"; 
   d="scan'208";a="79096043"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:41:24 +0100
Date: Thu, 8 Feb 2024 12:41:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
Message-ID: <7639c70-41e8-9a1-3a5-3a7711fc465@inria.fr>
References: <dcb996ea-f041-406e-b641-0e6b515b9a0a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1858000682-1707392483=:3408"
Subject: Re: [cocci] Improving support for code positions with opposite SmPL
 dependencies
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1513
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/7639c70-41e8-9a1-3a5-3a7711fc465%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1858000682-1707392483=:3408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 8 Feb 2024, Markus Elfring wrote:

> Hello,
>
> I suggest to take another look at questionable data processing according to
> a script variant (like the following) for the semantic patch language
> also together with the software combination “Coccinelle 1.1.1-00676-g99513ec1”.
>
>
> @find disable decl_init@
> identifier var;
> position call_pos, declaration_pos;
> type t;
> @@
>  t * var@declaration_pos;
>  ... when != var
>  my_test@call_pos(&var)
>
> @test_switch disable decl_init@
> identifier find.var;
> position find.call_pos, find.declaration_pos;
> type find.t;
> @@
>  t * var@declaration_pos;
>  ... when != var
>  my_test@call_pos(&var)
>  <+... var ...+>

I have no idea what "questionable data processing" could mean.

I don't really know what you are trying to do, but the:

<+... var ...+>

seems unnecessary.  Maybe just

... when exists
var

Furthermore, I don't see the point of repeating:

t * var@declaration_pos;
... when != var

Once you have the position call_pos, I don't think that adds anything.

Likewise in the adjustment2 rule below.

julia


>
> @adjustment1 depends on test_switch@
> position find.call_pos;
> @@
> -my_test@call_pos
> +test_case1
>
> @adjustment2 depends on !test_switch disable decl_init@
> identifier find.var;
> position find.call_pos, find.declaration_pos;
> type find.t;
> @@
> -t * var@declaration_pos;
>  ... when != var
> -my_test@call_pos
> +test_case2
>  (
> -&var
>  )
>
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch --parse-cocci test2-switch_opposite_dependencies-20240208.cocci
> …
> meta: semantic error: position cannot be inherited over modifications: call_pos
>   File "test2-switch_opposite_dependencies-20240208.cocci", line 28, column 44, charpos = 572
>   around = ';',
>   whole content = position find.call_pos, find.declaration_pos;
>
>
> Will source code transformations become better supported according to
> opposite SmPL dependencies?
>
>
> By the way:
> I observed also that another test case can work as expected (in principle)
> if the specification “virtual test_switch” is used instead of the shown
> second SmPL rule.
>
> Regards,
> Markus
>
--8323329-1858000682-1707392483=:3408--
