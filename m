Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E4FD374A9
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=QmU+lj6aHpGIHEWpNUnwICjfo/K3cV+Il3SibsFf9pI=;
  b=ExeSFt8+6I4r/0AmhC9Izl8Wvb97QSU/1koMjrcWdoylexXsqH86vHyc
   27DphkceD7rdOvMuYzUdq+zYnOoNEc6IJk2ZYGohRATmwZFDVQupy3aZE
   ERdlVGJ6tam5tRzdjq/HhU2hZ71LG8CuodFsJChhWPxQi1IipqhwJncqH
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189445657"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 17:42:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D23CE004E; Thu, 17 Oct 2024 17:42:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3AF3CE004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 17:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QmU+lj6aHpGIHEWpNUnwICjfo/K3cV+Il3SibsFf9pI=;
  b=ZO5SDeKp1h0vcEAUdt2x22pwoD6XX+qIbvb197GFw7/tyhj8Kzb1dNx3
   0ZFJvK1TXf81jOC5+WXVFxHwqnKyw/ct2sW1/HDw200CxcE4Vzw6BN+9k
   fHp1OoAbuMi2cEXf9eTHivbbFbkUyne/W6eLBhn5qBqDMdudkPQJlQ1RY
   c=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="99392073"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:42:03 +0200
Date: Thu, 17 Oct 2024 17:42:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
Message-ID: <804049-1ff8-6771-2436-da28ac50eed5@inria.fr>
References: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-550870440-1729179722=:3485"
Subject: Re: [cocci] Clarifying a =?UTF-8?Q?=E2=80=9Csyntax_error=E2=80=9D?=
 in SmPL Python code?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1910
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/804049-1ff8-6771-2436-da28ac50eed5%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-550870440-1729179722=:3485
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 17 Oct 2024, Markus Elfring wrote:

> Hello,
>
> I constructed an SmPL script a while ago. It contains a bit of Python code
> for querying a database by the means of the class library “SQLAlchemy”.
> It can still work (as expected) also together with the software combination
> “Coccinelle 1.2-00038-g2297fc0f”.
>
> I adjusted this SmPL script for another source code analysis approach.
> Unfortunately, I stumbled on the following information.
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> spatch drivers/base/auxiliary_sysfs.c …/Projekte/Coccinelle/janitor/list_free_attribute_usage_incidence.cocci
> …
> SPECIAL NAMES: adding __free as a attribute
>   File "<string>", line 19
>     name: Mapped[str] = mapped_column(String, primary_key=True)
>         ^
> SyntaxError: invalid syntax
> Error in Python script, line 1, file "…/Projekte/Coccinelle/janitor/list_free_attribute_usage_incidence.cocci": Python failure
>
>
> I did not modify the mentioned line (because it was working before).
> Will any more software testers and developers (besides me) get into the mood
> to clarify such a surprising data processing result?

Please provide the code, if you want others to check on something.

julia
--8323329-550870440-1729179722=:3485--
