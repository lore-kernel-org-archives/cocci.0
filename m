Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE26AC04A95
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 08:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Kps3CaLGOcgkERyLwG6KD5pB3K1OCLEJRiSfny1dzvE=;
  b=S2k4kUemgTc8beA4EN2MdVWYfRCX+VQxduYMrPklmHOLlAp6zLqP6Tsw
   UQlBRMth8yz+e8DnP/640QklNOg5095WR6w7pKrxOdBvRArI9oZMtpdsS
   ORXu15wIDkZic90BxUFdqmyLgps+uaDPN8qFTQJOyxpPo/uZd8PfgpAPA
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.95,204,1661810400"; 
   d="scan'208";a="67851951"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 10:04:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E55FE0152; Sat, 22 Oct 2022 10:04:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3DBEBE004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 03:59:40 +0200 (CEST)
IronPort-SDR: 63534e8b_ioR1yEMhCXsbeOLQKjIiFZVWEeXUX1ycWWTJau61dAfWkQ0
 Mz/rufbhlAAoxAgNdeJA/825t2Jgj7DPmZt/Qlw==
X-IPAS-Result: =?us-ascii?q?A0BYAQD0TVNjkEtEKJFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLYEBVi4EC0UDhEuIfoV0gihpnj4BAwENOQsEAQGJeAIdBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQEBFgkeEA4FIoVoDYI1K?=
 =?us-ascii?q?QGDZAEFIx0BATcBDwsLDQICJgICIhMFHQYTgn0BgyAGAQyrUIEygQGCCAEBB?=
 =?us-ascii?q?oFAAYUsfgMGgREsiF+HAXongimBFTaCdD6CS4VQgmaVSAoDBAYFOAECAUMdQ?=
 =?us-ascii?q?AMLOy8DDVQcWA4JIBwOFw0FBhIDIG8FQQ8oL2krHBsHOFQqKBUDBAQDAgYTA?=
 =?us-ascii?q?yICDSkxFAQpEw8tByNxCQIDIWUFAwMEKCwDCUAHJSQ8B1g7BAMCECI8BgMJA?=
 =?us-ascii?q?wIkWIEkDhgFAw0XJQgFNxsECDoCBQZTEgIKEQMSDwYnRw5KPjkWBidEATQPD?=
 =?us-ascii?q?hYDPiuXFYNSL4FwWMBVgTUHA4Nig02HdZUCMpZqkieXH41BmjOBeSOBW3CBA?=
 =?us-ascii?q?QaCMBIBOxwPiEuFVYNyhRSFZiU0AgE4AgYLAQEDCYpTAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bijai6nCHF8cdA13Mr6X4wbo5gxAIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKDzvVPPnZYmagLtx/aNu/8U4Pv56Bx4BrTgVqpSw3EVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTras1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82MyYz98B56r8ks15q2q4mpA5TTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFLLveRCCXcKvI0LubXT0nfdrDWMMBtMk18tmGkIf2
 9AcAWVYBvyDr7reLLOTQ+x3wN8kMdPgMcUct2tmwDWfCuwpKXzBa/yWuJkEhHFu1oYRQJ4yZ
 OJBAdZrRC/6WEUaHG0zN8dkrLK6liP0L3tTr1fAh6Ms5G77zwFr1rXpdt3PdbRmQO0OxB3C9
 j2WpwwVBDkqOe6x8CGa6knzg/PQsDL5d7IuTo+Bo6sCbFq7nTVIUEBODTNXu8KRgUm1UNN3M
 F0R4iNorK4o9UXtQMOVdxmxv3eAujYOWt9aCeR86QeXy6OS7RzxO4QfZjdEc5o9s9IsTjFs1
 VKTmd7tQzt1v9V5VE5x6J+KoivsOy0UD1U5OxMpYBoewIjNjIUa20enoslYLIa5idj8GDfVy
 j+MrTQji7h7sfPnx5lX7nia2Wnz+8mhohodulWGAT/NAhZRPtbNWmC+1bTMxdBkRGpzZnCEp
 2QJgcSX6Yji5rnUzHXXKAnhNJeu/eqFeB3bhVpmGZVJythA03emZsZL5yxkL0ovMcsefzLtJ
 kjJtmu9BaO/3lP0NcebgKrrUKzGKJQM8/y5DZg4ifISMvBMmPevpn0GWKJp9zmFfLIQua8+I
 4yHVs2nEGwXD69qpBLvGblDiuB0nnxkmDOMLXwe8/hB+efGDJJyYepZWGZikshihE95iFuLr
 ogHXyd0408HCoUSnRU7AaZIdAtScCBjbXwHg9Refe2OPkJmH3o9Y8I9Mpt8E7GJa599z7+Sl
 lnkAx8w4Aeh2RXvdFvbAlg9M+mHdcgk8hoG0dkEYQrAN44LOtz0vc/ytvIfIdEayQCU5aUtF
 KdbJJjYUqgnp/au0211UKQRZbdKLHyD7T9i9QL8CNTmV84+GV766ZX/cxHx9SIDKCOyuIFs6
 /ejzw7XC95LDQhrEM+cOrrlwkKTrEotvrt4f3LJBd1PJ2Tq0oxhcBLqgtENfsojFBTkxxmh7
 TiwPys2n+f2jrEQzMjonoGB9oegLPt/FBFVHk7d9reHChPZ9WuCn65FfvqDbG3PXjjK6ZT4W
 Phclc/tOvg5h3JP4ptOApdw7KcE/9C0jaRr/gdlO3TqblqQFbJrJEed7/RPrqFgwrx4uxO8f
 0CypulhJrSCPf36HG4rJAYKavqJ0dcWkGLw6csZDVrb5igt2pa6SmRXYgexjRJCIItPMI8Kx
 fkrvOgU4VedjjsoKtO3sTBGxV+TL3AvU7QVib9COdXF0jEU81BlZYDQLgTU45vVMtVFDRQME
 w+u3aHHg+xR+1rGf38NDkPy5Ot6h6pfnDBRzVQHGUaFpcqduN8zwy9q0GoWSiZ780x59txda
 0lRGW97H6GsxwtTpdNiWjmsEj5RBRfC9U3WzUAIpVLjTEKpdzLsKnVhHOOopGQc1XxWRRlA3
 bSi0G2+ey3bTMLw+SoTWEBetP3oS+JqxDDCgMyKG8ekHYEwUQH6g6SrW3UEmyHnDew1mkfDg
 +tgp8R0VoHWKg8SpPcdJ7SB9LFNVi2BGnNOccth8IwNA2vYXjO4ghqKCkKpf/JyN+74ylC5B
 +NuN/BweUyHjgjWlQ8iBIkIP7NQt9wq7oBberrUeEg3g4HGpT9t6J/t5izygVEweOpXkOE/F
 NL1VymDGWmul3drizfzjM1bCFGZP/gARiPBhd6QzstYOa4Hgu9WdWMK7oCVpFSQaQtuwAKVt
 ljMZojQ1O1T9r5vlIrNTIRGGwG/LI73Xs/V7gu2uNVqRvHMOPfoqAk6hATGPQNXHL1JQPVxt
 +2Hn+DW1XP/noQdcj7mibjYMIcR/uS0fu5cEvyvHUlghSHYBfPduUoSyV63OblisY175PD+Y
 yCadcHpV9oee+kF9U1vcyIETiosUfXmXJzB+xG4ge+HUCUG8Ar9K9iiy3/lQEdbegIMOLz8E
 gXEgOmv1P8JsLVzAAI4ON8+D69aOFPDXY4UR+/1vxScDUiqhQqMhOKz315oozTGEWKNH8vG8
 IrIDEq2Pgi7vKbTispVqcputxkQF2xwmvQ0YllbwdNtljSmFyQTGIzx63nd5k18yUQeFa0UZ
 Q0hqEMrDD67RjNZax7xptfuRAGSAqoJINiRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeeTb5yuyjb
 9YE9RUc+zCvl4pxS797CuOT2I9aKzCz+p7M0VLtyceuRR0ZBN3mEZCn8BVlDUT6Li0GqKkHy
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:mFFT7KlOZOe/EeikVEq3cup/JPTpDfL63DAbv31ZSRFFG/Fw9/
 rCoB3U726ItN9xYgBdpTnkAsW9qBznhPhICOUqTNCftUzdyQ+VxeJZnOnfKl/balXDH4dmvM
 8KGccRNDSzNykesS+Q2njCLz9P+qj8zElqv4bj5kYoYwVja6QlyRx4BAadGkgzYAVdH5I2GN
 69y6N81kOdkLgsDvhTz0N1PNT+mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,203,1661810400"; 
   d="scan'208";a="32328780"
X-MGA-submission: =?us-ascii?q?MDEUfkO7bBv25ZcD7kkEwFhPEJo1LsKEu8oyta?=
 =?us-ascii?q?Ds1B83rSXWTEExTu7MAwtAqvl7hdLFLYNc1s0Ckq3KgzBH+pv66iQ993?=
 =?us-ascii?q?hLX4Hue8FB2VBTuhGb6D+DuAcKiHvH75Yyn0hSuVexv+BGKSPPtqHFFL?=
 =?us-ascii?q?pBz5T/rqt6ik7Pc/ylhppaCw=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 03:59:38 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E8061B82DB8;
	Sat, 22 Oct 2022 01:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194EC433D6;
	Sat, 22 Oct 2022 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666403974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kps3CaLGOcgkERyLwG6KD5pB3K1OCLEJRiSfny1dzvE=;
	b=G5XWKcZfJXfHk4YHrBM4tWQ8O7JOYNfc/qBypQWD4H02IIq6jIKVTdtgvCWu3zb/QtDWQU
	CkqphDlQMsx6e3uDrjB1QH5DNhTjEb/JJetxVLyXiiTAMiuTMP5vf3YnS5HxD0u5oKGMiv
	X2EWx/7MGT1hxOQveBytu/o1nBBpOWk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4cdc2871 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 22 Oct 2022 01:59:33 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id e8so2282594vkm.9;
        Fri, 21 Oct 2022 18:59:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf2un46xp31hQlC398isvq3RxxWFbiYrWKBn86jMVd3iOmMwYa20
	UeRuSeqTEKKs0vLICxNUvSSNSO0YqZmUD70VO3k=
X-Google-Smtp-Source: AMsMyM4xPWKY7sr59YicADrx8TpfIk3pYaLZ+XaH+/o3KwoFhaWO//Oby5I2zfoMhE4L46DYl3OToflR+5kFAOTICgQ=
X-Received: by 2002:a1f:7843:0:b0:3ab:9727:3f14 with SMTP id
 t64-20020a1f7843000000b003ab97273f14mr14590169vkc.3.1666403972919; Fri, 21
 Oct 2022 18:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 21 Oct 2022 21:59:22 -0400
X-Gmail-Original-Message-ID: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
Message-ID: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] "not supported"
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 663
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ%40mail.gmail.com>

Hi Julia,

On Thu, Oct 20, 2022 at 1:11 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> Maybe you have an old version of Coccinelle?  For a long time do while was
> not supported.  But it's supported now, and your rule seemed to work fine
> for me.

Bingo, that worked. Thanks. Might consider cutting a new release soon
so that that's available on OPAM. I built it myself for the latest.

I just sent these in:
https://lore.kernel.org/lkml/20221022014403.3881893-5-Jason@zx2c4.com/

I wound up just having a bunch of different instances, rather than
trying to teach Coccinelle about strange equivalences.

There's another one in that series that's kind of interesting:

https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/

This one has a very simple rule:

@@
expression H;
expression L;
@@
- (get_random_u32_below(H) + L)
+ get_random_u32_between(L, H + L)

This worked as expected, but I had to do a lot of hand simplification.
For example, a lot of code had a pattern of:

get_random_u32_below(H - L + 1) + L

which then got converted into

get_random_u32_between(L, H - L + 1 + L)

which I then had to clean up manually into

get_random_u32_between(L, H + 1)

It's not like that's all that hard to do. But it would be cool if
Cocinnelle had some sort of algebraic simplification possibility.

Jason
