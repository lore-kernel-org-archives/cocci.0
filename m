Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59728C433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=PO0lYc/w2lKJWAJ/Jlr5+z/WRZksA+bMcPrRMoedFnc=;
  b=fDQFblTQdOEuDFuEW+hnMZGNY3euRODOHND6FmefPVKxN7NMSXGIwRcd
   NxdzzgaCpouMo1da6OHUpCiWzANuPZNilEDwEkVBpYF6woIxSu4eEGjrG
   GiWfOSDcOLD8ABQae8krodDUQl74Vm06jRLV2vZWoaGcjqF3j8T03a+fO
   w=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56681058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:19:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A2FCBE02CA; Sun,  9 Oct 2022 17:19:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D377E0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:17:31 +0200 (CEST)
IronPort-SDR: 6342e609_tHxx7V6dCBa/gteGnvBL9RX/Y4dYf5NoiQn+n5e4DJCPgDF
 uCFNgF2fkwfoy6eV2g+U94mySlCTlvIKCY9VsQQ==
X-IPAS-Result: =?us-ascii?q?A0BKAACo5EJjkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgVcuBAtFhE6IfoVygiifHAEDAQ1CBAEBiXsCHQcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCR4eBSKFaA2CN?=
 =?us-ascii?q?SkBg2QBBSMdAQE3AQ8LCw0CAiYCAiITBR0GE4J9gyEDA6t2gTKBAYIIAQEGh?=
 =?us-ascii?q?mx+CYERLAGIUIZleieCKYFLgnQ+iBuCZpoYCgMEBgU4AQIBQx1AAwtCMQUYA?=
 =?us-ascii?q?xQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkOCSEcDhoNBQYTA?=
 =?us-ascii?q?yBvBUIPKC9pKx0bBzhUKigVAwQEAwIGEwMgAg0pMRQEKRIPLQcpcQkCAyJlB?=
 =?us-ascii?q?QMDBCgsAwlABygkPAdYOgEEAwIQIj0GAwkDAiRZgSgOGAUDDRkmCAU3GgQIP?=
 =?us-ascii?q?AIFBlMTAgoSAxIPBidJD0o+PZtWQ4IApS6eaAcDg16DSpxyMoNkkwSSHpcQp?=
 =?us-ascii?q?2+BdySBW3CBAQaCME4cD44gg3KKfSI0OwIGCwEBAwmLFQEB?=
IronPort-PHdr: A9a23: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
 RBUh7j/KNZLXmUU809vcF93mMLNAUWCBLhw
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wqECn6jrzhaGfpe5RWcn1c60nXBQXgwji2hC6mlwRA09TyX5ra
 2TdTogpGLJYVcqKQ0dcLW7VJVoLkmsk6KdjbNhWotKGTOW3FdAT7sSj7cKoQeQYxEWn9Q1vc
 wLHMZD4Z/LfD1HZK3BkXKF+rgbsaO6GWOT5Nv2/jNCSQlrbuVH9Ad2CgGSFwlTSBNdDZQ0UL
 qwj/A33gZItU52Ui1zPAhnY9T+
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56680896"
X-MGA-submission: =?us-ascii?q?MDHTiaHnpQLrxZ6981r56Q6ds5k1Otv1+SpR5+?=
 =?us-ascii?q?uMicqvoFizE4MmRCB4GhXDHsXt9m+K33VAWiNCNC7ifbXym0Yqj7AtzZ?=
 =?us-ascii?q?QZHceV2jqNnTWvRdelv3tDeCd1wB3MCkQrZFiZOZTRua5oQ2OKHGIrXr?=
 =?us-ascii?q?2Le0YiuVB+AUbXp6RrYsFSTw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:17:29 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B215D60C08;
	Sun,  9 Oct 2022 15:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E88C433D6;
	Sun,  9 Oct 2022 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665328645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PO0lYc/w2lKJWAJ/Jlr5+z/WRZksA+bMcPrRMoedFnc=;
	b=FYTze0ZmZ7kaYn7R9T3ou6j/O9UGKnYnWWe004JN0Jg9Ml/B9mOPcRVLQzS1EEgcP0wtz8
	fkqj9N0y4/WBj9wJYRBfO7blddZXfnAAuZAuE+8qHeEMmaMhV7qw9PvMfLWzKk5+9f9nBe
	PgZdjN/rdNEYqMkH/5DCHLT4GkMzSh0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 13c5795e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 15:17:25 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id v68so8289941vsb.1;
        Sun, 09 Oct 2022 08:17:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf0KKqOgHoLhIL7/VQhlmx37k++sXHge+MAQQhxj2nFVn26oQPRa
	Nz5+7ZRu/9i/xH7gdc20GejXVS8ksFXGwye4TLc=
X-Google-Smtp-Source: AMsMyM4EQku4HkItmHVQ9GWVetQfW2t55zJ7vwLRh64JfjNxklEWEtlNsrY5590bHCjdso4m8avoSHvo+sACk8CodIE=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr6672242vsv.70.1665328644368; Sun, 09 Oct
 2022 08:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 9 Oct 2022 09:17:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com>
Message-ID: <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 628
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F%3Dy3%3D%2Brh2Gw%40mail.gmail.com>

Hi Julia,

On Sun, Oct 9, 2022 at 9:15 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> The meaning of the message is that Coccinelle thinks that it is possible
> to get to the call that you have changed without going through the u16 v
> declaration.

Huh, okay. That seems like a bug then?

> > {
> >       unsigned int range_size, min, max, i, attempts;
> >       __be16 *keyptr;
> >       u16 off;

The declaration is the third line of the function and there's no label
above the declaration.

Jason
