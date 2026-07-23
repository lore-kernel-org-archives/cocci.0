Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D7FC531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Nvjwd+QQTJrIq20v2huRxUmUe5pGFzHXergjGJYa+mM=;
  b=WbnQGnP2elkjpp9Ufy70VC1Oyghov/cdCtEddD5AWf4G7ve+a2nPNAPo
   hZrHcqiHjAmotmEIfFnd8yEh5NQwsjkOk4W4oehWQXAD0qVmPBUa+gM5P
   I3/rgSIcFffBOQ9t9gWSf7gJKwSBmt5Z50x5ErBkONArwoSvAirhdGdad
   U=;
X-CSE-ConnectionGUID: ZmyaD73RSMSZXWJgXua/jw==
X-CSE-MsgGUID: NbojkFvqThauauBsmCWcMw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734634"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:55:00 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E218E804FC; Fri, 24 Jul 2026 10:54:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D2087819A4
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 23:46:10 +0200 (CEST)
X-CSE-ConnectionGUID: K1sGMpUkQWet+WPWNLyf9Q==
X-CSE-MsgGUID: 6Gpw4ri4RVGYPaVXUNupOw==
IronPort-SDR: 6a628ba2_YEyoeZg/WK5nBKP0oJxyxdAfMaFogF6foG34O3Sf5GFfnan
 odDpxG0l02P8HYQVSBomHmC5e9bbAvCxMminTpg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HbBACcimJqgS7dVdFaHgEBCxIMggULAoI/gWkzBCQwj?=
 =?us-ascii?q?VKGWIIki3cCh1OKT4E/PQIPAQMBCwEBTwIEAQEBAgQ4gRIBgzMCjWACHgcBB?=
 =?us-ascii?q?DAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABASIZB?=
 =?us-ascii?q?w47hk8NSQEBBAcBgguBJWECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQIsXwEBAQIBEigGARsdAQMBCwYFRiACEQEFARwGEyKFA?=
 =?us-ascii?q?wEGEAEDECcDBLYegQJCizuBFwUCFoEBgg0G2mgKGSgNcgOBZgIHCQELAYE3h?=
 =?us-ascii?q?HgqTw6CPQEfAYV3hAJ6J4IohEA+gVJNiGkEgiKBDJIuAQcHMQgBCRMGCAICS?=
 =?us-ascii?q?AsKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/DAYEEwIIAwYECwcFHwoCCAQUC?=
 =?us-ascii?q?igiBA4rCgM1Eg8bFQEIBgICBAQCBAIKAgkCAgUDBAIEDQMEAQEIAgIDKgMBA?=
 =?us-ascii?q?wYTCAkIAgsFERYCDAQHBzEDEAkDAh0DFBYFCBE0BQIBBhYBGgcFBgsBIBEFF?=
 =?us-ascii?q?AEFDBEBAhsCIQQdARAIAwEHAw4EBAIBCQIDBBYECAkEDAEBDwEKEhUDAwsDB?=
 =?us-ascii?q?w8CDQcUBRULAwIOAgkIDBcCAgIGAgMDAwoBAgEBAQEBAQEIAwMDAgMZBwYDA?=
 =?us-ascii?q?wEBAwEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcCAQoJAgUDGwMcBgECA?=
 =?us-ascii?q?gMCAQIDBgMHCAMIBQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICAwMDC?=
 =?us-ascii?q?wECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDAhwDCAMGAxIBEAMDBgEDB?=
 =?us-ascii?q?wMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICAwUDAwMICAQDAwQCAgMMA?=
 =?us-ascii?q?gYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHAgELCwgDAgQCCQcJBwECA?=
 =?us-ascii?q?wsEAgQGBA0HAgQCBAICDwQEBQMDBwEBAgECCAUGAwICEQUICgUGAgICHQMhA?=
 =?us-ascii?q?QIBDwYBCQUCAQUOBwUCAgoSAwYBAQMEBQUBAwEKAQsBAQIDAwEEBQMDBQcBA?=
 =?us-ascii?q?gQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQDBQUDAgUCBAMFAwcCAwMCA?=
 =?us-ascii?q?QUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEBgUDAwMFAgMDAgICA?=
 =?us-ascii?q?wMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFAwMDAwYDBwMDBAMDA?=
 =?us-ascii?q?wcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgHDAE8DAcKJAQEDCoBF?=
 =?us-ascii?q?BQFKRlnBweNayOCQYEpP4FOF4E6AZVAjiihCTQzCgYBgkiBCk6BZpMchl2Ff?=
 =?us-ascii?q?E0TA4Nbk2KTGZMrhV2SE5JHhD4CCgcHESQSgTI6gVwzGiOBboFJUAMZD44hh?=
 =?us-ascii?q?ALLA0I1PgEHAgcPAoFzg3+BOoMyh0mBTAEB?=
IronPort-PHdr: A9a23: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
 CSNnjJCfC4HUP94+pqCGWsyPu2By2Tr1LsRcyiM
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:rkd5gaG5i4vAJZwRpLqELceALOsnbusQ8zAXPo5KOHtom6uj5r
 +TdZUgpGPJYVMqMk3I9urwWpVoLUmskKKdpLNhRYtKPzOWxVdATrsSlLcKqgeIc0aOldK1l5
 0QCJSWYOeRMbEQt7ed3ODXKadF/PC3tI+vnvnX1HpgQEVHbKt6/x5lBgvzKCFLbTgDK558Op
 T03KR6TvmbFkj/rP7XOpB8ZZm4mzQDrvPbXSI=
X-Talos-CUID: 9a23:LZp1u2ADUI2XeLX6Ewo+72ExAv0mS0LQ0DTvG3CeLXdnGYTAHA==
X-Talos-MUID: 9a23:sZOT9ghvP2vVQnWTn9M8xMMpauhw/Pi0CRw3r7o3g8C6BRFWJi+6k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152822092"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFK+/pJeSs6Vu0jx1+th6b/LNF9yMFM6lAo0Z?=
 =?us-ascii?q?jHq1VJ3iqnBNuvTboPfgbDA/0IMBiJ3TWB5v8PmrSiJ90/Zp7BZY8uk6?=
 =?us-ascii?q?5pzZjNMdw10e4rqr8ZmEPA/Ta1/FhKbEGvzjfhQ/DRS8b8vo5rE/5BVo?=
 =?us-ascii?q?mHbFdyoXvDeYYo2IwO9h8Rjg=3D=3D?=
Received: from mail-wr1-f46.google.com ([209.85.221.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 23:46:11 +0200
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so793881f8f.2
        for <cocci@inria.fr>; Thu, 23 Jul 2026 14:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843169; x=1785447969;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nvjwd+QQTJrIq20v2huRxUmUe5pGFzHXergjGJYa+mM=;
        b=Z4C62O1eNz3uK4HKH2eupXUUQXrPgJ660TMDt6nOsdx7A5wAmyb8JhF/aG+JMjGEq5
         KFJu6yOQ3ZfhdN+3IYdO5Rt7i4JdT+N3F/p39UH4yCEWKz1rfSVGBpfOO8jLoKBeA2to
         RJqE3b+EIOes2EtvKCCaqi6dvOUxpgnijH40bZ8yEL+Jz20a6MSFZb4x/X1uJCJ/Q3Lc
         tNI2Q2PcUiUeZzdM/5vINxSo5U3ns/sdIUkMZHXji2gUe2iZWzu+/vgovffr9/0iYSut
         qcGEMOTDAAEMelOiaEyGHp9Gp5Ed4vIZEKL6TXoHiQDmXFxIvtRx+oLjTfrtjlomdqM7
         H50Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCOZfTmekJwK0T/ReYLKTfn3rTbyUYsO0KByIA1gMaZfSqapcLoodVcwNw/Xu7L9ZfFR45Bg==@inria.fr
X-Gm-Message-State: AOJu0YzqNnp9m71FTTWs52ghYUM2SPK2H06ImlY8X1rIF0DmlMGNF5AE
	VDAWNfqspEIkio6kYwNri6fC9ZxsL02iOoEitoMcmzxLlYiwQXLKqQ0t
X-Gm-Gg: AR+sD13Wibm4AfzD4U/YdRN2Ob3MZJHaokMtWRRgKM1UHB8h1EymUqGqm160Xryb71k
	EudC9oLq8vUNu5sw2h4e+e94fyfK2FGYA0ngzJP471Cr6YB0zaO+rXUXdFpDjkAjdsc7z7kn1ci
	RApd65ELadIVW9se0xb7nc1Obb27jNf1qc3wb37CjDyuYrKGk6NmKVhcmKitNVRom5LfeldsmX4
	oMAuNQIEpP3/ooJvePzVzSnHsnAqjeIKGcQM9iI4syLmBxS22BBkYoDKIo67gVUj+NP67Wgmogr
	bAiq1qTR/JoTxxnTg8JYC1yxYUgs2nyTG82AN9jZ4z00RFqdtOXwgnpHgiNCNiuCZg9BpgcHLWs
	ZUYIahb4trO2Lqut8p6ryHagdLhRLzJ1i/Bup6yBlH/0FL2m9o+3I+TE0sIelVP1hFeuhXB0wee
	Gd9vzaq2NUJjcfKGyehdkhL1AFMh6Og4SeaXhHvNxAmx4d6+uXonsrM3SIhL1MehCf9jibN0y4A
	iaOs5lVZ1Q/fUiKzavLvrJvo3rkAr1+zr7Nk5NPRvjsATqrEuIMwSOu8AVEvy30+ozjQ1w8Nr8i
	NVFzTsbOsGo9yMSxpFWrb9kknBNxuSHeAzNOL9ZWE5437CWWaoPlXwSE/GgNMmGRdgpRyADw4+3
	4HZ9UcLk+W2oYwdABA/MLEA==
X-Received: by 2002:a05:6000:2c0d:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-47f8d755388mr6206915f8f.28.1784843169422;
        Thu, 23 Jul 2026 14:46:09 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm18919144f8f.35.2026.07.23.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:46:09 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:46:07 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Jonathan Cameron <jic23@kernel.org>, Linus
 Walleij <linusw@kernel.org>, cocci@inria.fr, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Message-ID: <20260723234607.52b67523@systembl0wer>
In-Reply-To: <20260723184538.3888637-16-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
	<20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 15/36] iio: remove conditional return with no
 effect
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3640
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/MTZXUTVFZphLSC1ITz8lFw>

On Fri, 24 Jul 2026 03:45:17 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

Good idea adding a cocci script for this!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
