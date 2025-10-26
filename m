Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2ADCCF9E5
	for <cocci@archiver.kernel.org>; Sun, 26 Oct 2025 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MYSSS89SM00MxOFhcXEC245dO/FfL8TS2szCmm0BByg=;
  b=g4oftMsBNOSfzdSqPdPzcsLzzOlp6Opi0ch3y+7qYubdQSs9gqHjGMRW
   aBpn+OUTUucFBHc8ua2+MQklb8zX2X7m5USqZJxjQCUVYhCdUi/hIMkpe
   7OCiqP4yXG4hAT/2bh0UkxPnCyNfmYe4OoHw45o/86RZbvo3jTxKKYxrV
   I=;
X-CSE-ConnectionGUID: Y7/D0QxvSRypP9zuyHAvOw==
X-CSE-MsgGUID: F5Olqe92QY6n1iAZ6wydkQ==
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
X-IronPort-AV: E=Sophos;i="6.19,257,1754949600"; 
   d="scan'208";a="246202294"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2025 18:32:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79AA9E0264; Sun, 26 Oct 2025 18:32:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E6911E0171
	for <cocci@sympa.inria.fr>; Sun, 26 Oct 2025 18:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MYSSS89SM00MxOFhcXEC245dO/FfL8TS2szCmm0BByg=;
  b=vXogiGnR12VrwdW8Nf6f5ykrPRYWwa0G9/29uQxgrt1SGrn12rFYuNMR
   rt1k5D2W5W5W20IVek9McrWG/HU1fzjr8j4+ZFPUzCt1pVYK1sMAp9E6y
   iEcNeJBnBj6jd75AOo9eNkt9F8j3PupNZVW59yGSKjyShDr0rAO9W5M/w
   E=;
X-CSE-ConnectionGUID: 4R+GQ2nnSF2E4C0+xldKFQ==
X-CSE-MsgGUID: jQUF+Ag5QdqjIkwdxoAPSw==
X-IronPort-AV: E=Sophos;i="6.19,257,1754949600"; 
   d="scan'208";a="246202289"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 18:32:51 +0100
Date: Sun, 26 Oct 2025 18:32:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
Message-ID: <ade38bd-6997-b95-cce1-74944218af1e@inria.fr>
References: <67c4f12a-5b58-459f-b02d-cfa5e6275693@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1268582013-1761499970=:4153"
Subject: Re: [cocci] Searching for selected function declarations with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3099
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/ade38bd-6997-b95-cce1-74944218af1e%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1268582013-1761499970=:4153
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 25 Oct 2025, Markus Elfring wrote:

> Hello,
>
> I would appreciate if another source code analysis can be achieved
> also by the means of the semantic patch language.
> Thus I tried the following SmPL script variant out.
>
> @display@
> identifier i;
> @@
>  my_type
> *i(...)
>  ;

It would work properly if my_type were declared as a typedef.

julia

>
>
> Unfortunately, I am wondering about the following information.
>
> Questionable test result (according to the software combination “Coccinelle 1.3.0”):
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --parse-cocci show_selected_function_declarations.cocci
> …
> (
> my_type *(*...*) *i;
> |
> my_type *(*...*) *i = ...;
> )
> …
>
>
> It seems that isomorphism rules converted the SmPL code into something different.
> I would interpret the generated data representation as variable declaration variants.
>
> The intended source code search pattern might be ambiguous.
>
> * C: function declaration
>   https://cppreference.com/w/c/language/function_declaration.html
>
> * C++: variable definition
>   https://cppreference.com/w/cpp/language/declarations.html#Simple_declaration
>
>
> Under which circumstances will such data processing become better supported?
>
> Regards,
> Markus
>
--8323329-1268582013-1761499970=:4153--
