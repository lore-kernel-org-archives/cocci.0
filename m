Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2107C04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lqBaCc3lWmDRKjvkkTcE5vvOSFxl6zBn/Pi6GyWWWcw=;
  b=HDj1YV/ua7P4HUDoGD10qk3sRMi3341qOyu+7ezAswPJCRyKm6fKx256
   G+o84hoZY9Wmv4PaSjmfkqQPW4GBG8bYweq6OF0Zgl76eBesnDPPHy8DP
   9W0RkwbSr4ZSJXcTEv2ZtGbM1G1Xxn6Y+l+SgzKMUJ8G3uxBGSKNf52Vw
   I=;
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
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165201060"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 18:37:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BEAC0E0CCE; Sat, 11 May 2024 18:37:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CDA8E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 18:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lqBaCc3lWmDRKjvkkTcE5vvOSFxl6zBn/Pi6GyWWWcw=;
  b=fQdoQHgCXNYQHztbYYBPorFUIStnLuL34UJNWoQUezKMwwInTqRkJGAC
   +9FY0p3rWRHTYBKVNDSJtV98VfMSTjHz4j8kT2VLyqCqcxFpUTDXrV7Kk
   2I3kHqTuaDmVExW9eSEckjr7Rp8nn94y5kuIQ88uERSWF1w5zCUNtJaEY
   4=;
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="86775200"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 18:37:07 +0200
Date: Sat, 11 May 2024 18:37:07 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
Message-ID: <alpine.DEB.2.22.394.2405111836340.14453@hadrien>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de> <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr> <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de> <alpine.DEB.2.22.394.2405111803140.14453@hadrien> <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2119344076-1715445427=:14453"
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1716
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405111836340.14453%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2119344076-1715445427=:14453
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 11 May 2024, Markus Elfring wrote:

> >> Why is no diff output generated by the software combination “Coccinelle 1.2-00008-g75525032”
> >> so far?
> >
> > Your semantic patch needs to be:
> >
> > @display@
> > @@
> >  my_action(...);
> >  <+... when any
> > *my_action(...);
> >  ...+>
> >
> > Without that, a call to my_action is forbidden in the region matched by
> > the <+... ...+>.  Because any kind of dot thing matches the shortest path
> > between what comes before and what comes after (here the end of the function).
>
> Thanks for this quick feedback.
>
> It seems that we expect different data processing also for the shown test case.
>
> The SmPL construct “<+... … ...+>” supports a search for code parts
> which occur at least once.
> Thus it seems that the specified search pattern needs be duplicated before
> if you would like to find code which should occur at least twice.
> I would appreciate if undesirable duplication of search patterns can be avoided here.

If you want to find code that occurs at least twice, isn't it most natural
to make a pattern that shows the thing occurring twice?

julia
--8323329-2119344076-1715445427=:14453--
