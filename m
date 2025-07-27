Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1F9C87FCC
	for <cocci@archiver.kernel.org>; Sun, 27 Jul 2025 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MPLZYfFh1tbe7Mc2KcZKGjPPrOdFjD5v5acTVI3AzR8=;
  b=SQWf9PkDYopt9UZynD7Z8HFRCYQdZcuCbG7WTFDod2Zw2qxY63BrDkph
   VcvbQzrz2qAu1ueSe2evSqQGPbhm6sjAUEYpPjdB5CAzQ9G5xJvPdlwvL
   2KOOBE1LTXMGwCMt2RIn/qHOmc3lMEy2pXWH34qG+nf2UhlXAq93SumpQ
   g=;
X-CSE-ConnectionGUID: 7TwiSbl/RPW/B5KRNt85nA==
X-CSE-MsgGUID: beNYNim1SwOHqRWBNaiinQ==
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
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="233262208"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2025 16:19:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 74752E0264; Sun, 27 Jul 2025 16:19:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 536A0E0171
	for <cocci@sympa.inria.fr>; Sun, 27 Jul 2025 16:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MPLZYfFh1tbe7Mc2KcZKGjPPrOdFjD5v5acTVI3AzR8=;
  b=jL/jOtCqCKCVEI+UKOXeb3yW/JKExsO23cSnZ4LlFrwDl55+LLE0En2W
   U/2Kcv0qMWEL6skClJgMlbpqMiKsVphbfoz3pwHLdy53Jb4i1JC1RMgsx
   UVdUTYJLwJ5ezWOh31dwid68dxZxzXQ9kUe+uTQw4tf4d/Eny1N5OcFXT
   o=;
X-CSE-ConnectionGUID: iUPSeBjrTg+Giv8/L5be/Q==
X-CSE-MsgGUID: PF/nqu5rT0ml/ZBTR/jA/g==
X-IronPort-AV: E=Sophos;i="6.16,339,1744063200"; 
   d="scan'208";a="122273882"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2025 16:19:42 +0200
Date: Sun, 27 Jul 2025 16:19:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <67e35fac-d223-4067-882b-a632a57c792c@web.de>
Message-ID: <alpine.DEB.2.22.394.2507271618550.3493@hadrien>
References: <67e35fac-d223-4067-882b-a632a57c792c@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1769689047-1753625982=:3493"
Subject: Re: [cocci] Supporting expression fragments with SmPL dot variants?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2918
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/alpine.DEB.2.22.394.2507271618550.3493%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1769689047-1753625982=:3493
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Jul 2025, Markus Elfring wrote:

> Hello,
>
> I would like to try something out with another script for the semantic patch language.
>
>
> @display@
> expression x, y;
> @@
> *(1 * x) /
>  ...
> *(2 * y) /
>  <+...
> *(4 * x) /
>  ...+>

You have to make a real expression.  What you show is not a real
expression.

julia

>
>
> Unfortunately, I stumbled on the following test result then.
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/janitor> /usr/bin/spatch --parse-cocci show_questionable_evaluation_order1.cocci
> …
> minus: parse error:
>   File "show_questionable_evaluation_order1.cocci", line 9, column 1, charpos = 76
>   around = '...+>',
>   whole content =  ...+>
>
>
> Can the data processing be extended anyhow also for expression fragments?
>
> Regards,
> Markus
>
--8323329-1769689047-1753625982=:3493--
