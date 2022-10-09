Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C593C433FE
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Khyhk8TCIgm+7LA1zKY94sukpB5klntPZ8GC0O63Ulw=;
  b=sIMI1l2z/tVtanQVb3dkzcLmc2lxgiMcmzmJj7D/aLtmCzyET4MP+f8r
   sEGBXK4x+/55LrO8LgiXwTL7Wg3eR7lPApjziR2JGKNHKoupJgMh8giz6
   wFUXUMq82/kHEuNs1lI2jcHavWts5bzqmBCpNdFPnfLpGd4/NYEhjfmVB
   U=;
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
   d="scan'208";a="56683004"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 17:55:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F168FE028F; Sun,  9 Oct 2022 17:55:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3094DE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 17:54:00 +0200 (CEST)
IronPort-SDR: 6342ee97_ZPv0+dmaRk8w2gnq0GN+j2wpfmmxgnsnNsyLGX82ZA9RhK+
 liSfOkZchd/Nv5VRyiAmPIYYIAgDMbkZjZyoPng==
X-IPAS-Result: =?us-ascii?q?A0DRAQBW7kJjkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8CgiKBVy4EC0WEToh+iBqfHAEDAQ1CBAEBiXsCHQcBBDUFDQECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCR4eBSKFaA2CNSkBg2QBB?=
 =?us-ascii?q?SMdAQE3AQ8LCw0CAiYCAiITBR0GE4J9gyEDA6t+gTKBAYIIAQEGhmx+CYERL?=
 =?us-ascii?q?AGIUIZleieCKYFLgnQ+iBuCZpoYCgMEBgU4AQIBQx1AAwtCMQUYAxQDBSEHA?=
 =?us-ascii?q?xkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskDwUCBy8FBC8CH?=
 =?us-ascii?q?gQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBVkOCSEcDhoNBQYTAyBvBUIPK?=
 =?us-ascii?q?C9pKx0bBzhUKigVAwQEAwIGEwMgAg0pMRQEKRIPLQcpcQkCAyJlBQMDBCgsA?=
 =?us-ascii?q?wlABygkPAdYOgEEAwIQIj0GAwkDAiRZgSgOGAUDDRkmCAU3GgQIPAIFBlMTA?=
 =?us-ascii?q?goSAxIPBidJD0o+PZ0NJYFmky2RAp5oBwODXoNKnHIyg2STBJIelxCnb4F5I?=
 =?us-ascii?q?oFbcIEBBoIwThwPjiCDcop9IjQ7AgYLAQEDCYsVAQE?=
IronPort-PHdr: A9a23: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
 jMEz6y+NoMOLIb2nU9vcF93mMLNAUWCBbhw
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kupiJaGMRQogGfidpLqEPseALOsnbusQ8zAXPiBKJCC9vPbo6v
 xG/c5rqSMc7Qx8ZJhOo6HnBEDtewK6yXcx2/h0AV7AZniFhILLFvAb0WKK+VSJcEeQmNK1l5
 0QFpSWY+eAdmSS4/yKmjVQ0OxA/PC3tI6tjefai1F3TQ9rbKlkqyN0EBySHEEzZCQuP+tBKH
 NR3Kp6TvObCBcqUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,171,1661810400"; 
   d="scan'208";a="56682916"
X-MGA-submission: =?us-ascii?q?MDGRFVeo5F9HRerc4GgAqoFw/EmKMZc3JKP1+3?=
 =?us-ascii?q?k7vhzxp3eQGQcNHpWapzIkPQgsZbTL8N0CV9/9oGvTqnlcOwOgEm+BsB?=
 =?us-ascii?q?ogepgy+45j6isj1KGZ3lLThVI1XUfpzk6cjXw+7zl22aeBIBkBINMepU?=
 =?us-ascii?q?bahC4VrGhsnSTOx59wrynY8Q=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 17:53:59 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 322B160B07;
	Sun,  9 Oct 2022 15:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE0C433D7;
	Sun,  9 Oct 2022 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665330835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khyhk8TCIgm+7LA1zKY94sukpB5klntPZ8GC0O63Ulw=;
	b=I6SnOo7RwAioRUJ/R39H1f20i1Q9Ck3HRE+B4qiWCkCjCcIQTHIAfl9PVdOyRoYWQZBDHW
	QHbo6LL582SLpBxdKVtDfBtxjGKPTLd0KuNP+u1ltD83wGbTh2z7pstCTOrSIRzwFhTlzc
	eJnUPFJUR5zWTvq30PFsTAE8v0fpyRE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f052bbaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 15:53:54 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id 63so9251829vse.2;
        Sun, 09 Oct 2022 08:53:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf0/zUYV1kOwdBJWRme25feqf8w/t3pHSaRPTpGBn548OLU/smPH
	lPd4pHkkRWa6tAtHtU6mQ5Itpo6Elh3BpSnJ2sE=
X-Google-Smtp-Source: AMsMyM4pa8oO3UAL4tsS6gyWaOVPE8UVpgwJWKQhQ7fk+nd+sg/b5wb9WQNqSYnrrLiFn2Sm7W4NngFM1OOaAw6JkmA=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr6707742vsv.70.1665330834047; Sun, 09 Oct
 2022 08:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <Y0LiyBxZ0pU+NOPR@zx2c4.com> <alpine.DEB.2.22.394.2210091713270.3091@hadrien>
 <CAHmME9q_hYvZjSHxHse2fmMrjkFON4vSVESBED3F=y3=+rh2Gw@mail.gmail.com>
 <CAHmME9pzRtsEBFNBvX=j25D8ANUjLHoVxn0fLnFERgr6FR+VfA@mail.gmail.com> <alpine.DEB.2.22.394.2210091726280.3091@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210091726280.3091@hadrien>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 9 Oct 2022 09:53:43 -0600
X-Gmail-Original-Message-ID: <CAHmME9qj3ePZwnJnaZEy2Ds2J4d40a8P5DZxjtc=sS8=Jep6-w@mail.gmail.com>
Message-ID: <CAHmME9qj3ePZwnJnaZEy2Ds2J4d40a8P5DZxjtc=sS8=Jep6-w@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] "reachable by inconsistent control-flow paths"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 632
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9qj3ePZwnJnaZEy2Ds2J4d40a8P5DZxjtc%3DsS8%3DJep6-w%40mail.gmail.com>

On Sun, Oct 9, 2022 at 9:30 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> @@
> identifier get_random_u32 =~ "get_random_int|prandom_u32|get_random_u32";
> typedef u16;
> local idexpression u16 v;
> @@
> -  v = get_random_u32();
> +  v = get_random_u16();
>
> It would be faster and completely avoid the problem.
>
> You only need "local" is you want to ensure that v is a local variable.
>
> If you don't care at all about what form v has, you can put
>
> u16 v;

Oh that's terrific. Much simpler. Thank you.

Jason
