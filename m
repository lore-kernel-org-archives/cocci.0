Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E6C83F1A
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=l355R6snx+QNw3SqgV8R7wyIncxRExA7yhR2uCp2kJc=;
  b=r040lXHhftz/XmAZ4I1Fwm1xW9ZaWRgxbtfuXs7ORVR53IxsmmfCjtys
   2ZKAOxT3lIQk6gRwLC4L90nb/tH3tSuTyXC9+Tv9g7siMGLa9pfaLBvsP
   nE/hvNdv7PzGJp8c6wRMMI2esLBsFSQp8eLhJi8oCzFEgj/YyBMY6RsjC
   E=;
X-CSE-ConnectionGUID: tiloHOjtQnO79rjgZ6jqgA==
X-CSE-MsgGUID: vdewm/QiTQC9hBlv6dSQ3g==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233014811"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 17:09:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D309E0264; Thu, 24 Jul 2025 17:09:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C9F65E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 17:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l355R6snx+QNw3SqgV8R7wyIncxRExA7yhR2uCp2kJc=;
  b=Xh1xlDsRvN+69WB/oQFioEvJvQQOJFQe7mMv2/FhRCVFuVpPqz4LDnUP
   umtby1NMGIwedOHTVRokyQvVyC+YnMM7uj18PtbLzljY2b41rejGEFYdF
   fWJHpAFI+Zw2x2jMUdqPnV7Q+3cHZHDU5LelXxFTA3lVdR5BGX/3xwHRb
   g=;
X-CSE-ConnectionGUID: onhnBdArQLikM1F0KORi8w==
X-CSE-MsgGUID: rwqgSPolR2GFizqpl8tsQw==
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233014808"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 17:09:13 +0200
Date: Thu, 24 Jul 2025 17:09:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Erick Karanja <karanja99erick@gmail.com>
In-Reply-To: <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
Message-ID: <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de> <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr> <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1453167231-1753369752=:3509"
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2910
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/41b71929-b32d-507d-eff6-ca19ea3c965%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1453167231-1753369752=:3509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 24 Jul 2025, Markus Elfring wrote:

> >> @display@
> >> expression x, y;
> >> @@
> >> *mutex_lock(x);
> >>  ...
> >> *mutex_lock(y);
> >>  <+...
> >> *mutex_unlock(x);
> >>  ...
> >> *mutex_unlock(y);
> >>  ...+>
> > * just highlights lines when there is a match.  Theer can be several
> > possible matches.
>
> This is actually the case for a known source file.
> https://elixir.bootlin.com/linux/v6.16-rc7/source/sound/usb/qcom/qc_audio_offload.c
>
>
> >                    In that case, the union of the relevant lines will be highlighted.
>
> I am still looking for further possibilities to avoid false positives.
>
> * The source code search pattern can be simplified a bit
>   by omitting two SmPL ellipses.
>   (But the search approach should be more advanced, shouldn't it?)
>
> * Why is the diff marking missing for the first lock call so far
>   (within the implementation of the function “handle_uaudio_stream_req”)?
>
>
> I would appreciate further advices.

I would think you should do:

@r exists@
expression x, y;
position p1,p2,p3,p4;
@@
mutex_lock(x);@p1
 ...
mutex_lock(y);@p2
...
mutex_unlock(x);@p3
 ...
mutex_unlock(y);@p4

And then use a python rule to print p1, p2, p3, p4.  That way you will keep
the different matches separated.

julia
--8323329-1453167231-1753369752=:3509--
