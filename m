Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A827C369D3
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=GmDYdCFy/X2BM6MIhNTfkBMtV16BYD5eNM/8mtgykck=;
  b=NANxRACl9eyTr+mWmGgfwq5N3h6yJxFOGtqghjVLfJ2MZYU6sid/St90
   JZYSa39ttHN9RcQD2Mvv3YElvUymRyKk4vP6yBUokg8SanALIWETdKwPy
   yct2/fkp4TE6RGY9XlyFMTFcd5SuzS6br1hsbZ063/7FRgDwqjTtdG+5/
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA6FEE0D21; Wed, 23 Apr 2025 10:51:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DAB11E0261
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 19:04:39 +0200 (CEST)
IronPort-SDR: 68028628_AZ3lA1iK3IdnCmyHErGW97lKZW/Ds+7HeNkG44TF62rAGc9
 NPKY//4F5aeEViMYvkGeNicp7bKyAi9SOnVLgZg==
X-IPAS-Result: =?us-ascii?q?A0EJAADAhAJogbbSVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAQGCQn1aMwRTlCWCBB0DhXqMbosqgUA+DwEDA?=
 =?us-ascii?q?QsBATkJAgQBAQMEOIRIAosrAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBIhkHDjuFQQEGMw1JARABggcBgSRhAgUDOwEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCDR9eAQEBAQIBEigGA?=
 =?us-ascii?q?RsdAQMMBgUOBAYZAhMQEAIRAQUBDg4GEyKCYYIvAQMOIwMRpSaBBUKKRHiBF?=
 =?us-ascii?q?wUCFoEBgg0G2l0KGSgNbAOBYgIBBgkBCoE1AYR1KU4OgjcBHQGFbBuDYnonD?=
 =?us-ascii?q?4FVRIQ/PoIfgwEDhWQEghYXRVKDLYQjhD+FM4JuhDqIfggHMQkJEwYKAksLC?=
 =?us-ascii?q?hIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPwwGBB0YDB8KCAgEEQooAyIEDisKA?=
 =?us-ascii?q?1s1CAYCAgQEAgQCCgIJAgIIBwIRAwQBAQgCAgMrBgMGGwoCCAINBRMKAQUEA?=
 =?us-ascii?q?wcFAhsDAwICBQsCCAUCBQcDCQ4BAgUDBBUCEAICAggVAgICBRwDJAMDAwMLA?=
 =?us-ascii?q?QICDgkGGA8EAgMDAg4BAgIJAQIBAwMIAwMJCAcBCgkBAgoGAgkQAQICEAMCA?=
 =?us-ascii?q?gICBgcOAwITDwUGBgIKBw0LAhICAwkGAwUKAwcECg0CFQIVBR8BAggJDhECB?=
 =?us-ascii?q?RIDDgUDAgIRBAIDAwUDAQcBFQMHCAICDAICAgIFAgUCBRcRDQQDAwMCCAEEF?=
 =?us-ascii?q?QYDCQglGxABAQMBCQMCAwQIAwMDAgYMCwIBBwgDAwYLCAkGAwIHCBkDBQQDB?=
 =?us-ascii?q?wULIQIGAwIEBQQBBQITDQIDGQIGAwYRCQ0GCAcJAwcBAQECAgIIAQYFEgIDB?=
 =?us-ascii?q?AIFBAQBAQgDAwQGAgEDAgIECQEBAQIKAggKAQkTBAMIAwMDAwMFAgIIBBEFB?=
 =?us-ascii?q?QIBBQoTDAoGAwYDBAICAgsHAgMDAwcBCxwCAQMCAgUCAgEFAwICBgQDAgEBC?=
 =?us-ascii?q?QIDAggBAgIBAgICBAEHAQQHBgEBAgQCAjICAQMJAgUBAQ4CAgQCAgECAgIEA?=
 =?us-ascii?q?gQBAgYLBAUNAQECAQICAQEBBAEIAwEBAgIDAwUDBQMIDw0BARcLHQMEBQICA?=
 =?us-ascii?q?QEBAQISAgIBBwECAQEDGgIBAwMEAQsCAQEEHgQWAgICAgIEAwICAwICCxMlA?=
 =?us-ascii?q?QIDBQMTAgIEAgECAgUFBQEDBBEQCQMCBQQCAgYCBAYKAgcEAhoEAgICAQMEB?=
 =?us-ascii?q?gMBAggCAgcEBAYDAgIBAgIHGQIZAQMBAQICAgQCAgIJCgQFBAQEAwICAgEMA?=
 =?us-ascii?q?wECAwICAgIBAwICAQEDAQUGDQISAgEDDwgEAgIHAgIhDwsBAgEBAgYGAgMDA?=
 =?us-ascii?q?woDAQoBAgEBAgYCAQISBQICAQIEAQICAwQlAQIBAgEBAQUCAQIBAgQCBwIBA?=
 =?us-ascii?q?gILAQUCBgECAgkBAgECAgIBAgEBAgYCARUBAgICAgIDAQMGAgICAgICCQICA?=
 =?us-ascii?q?gIFAgUDAgMBBgICBQIDAwICAwQDCQMDCAMGBAIDAQEBAgECAgIBAgIBAgIFA?=
 =?us-ascii?q?gMJAQEDAgECAgICAwYCBQUBAwsFBAcBAQIBAwUDAwQDBgEMBAMCAgQCAgICA?=
 =?us-ascii?q?gIEAgIBBQMDAgIFAQUDCAECBAIBAwMDBAQDAQICCgcFAgQBAQEBAgECAgoDA?=
 =?us-ascii?q?gUBAQMDARIDBAEGBQUGAgcJAwICBAIDAgQDCQQCBgMDAgICAQELAgIBAgIBA?=
 =?us-ascii?q?QMDBwYQAQICAgIBDwIDAwMDAw8GAwUNHQIJAyMPAxQIEz0MBzIENgEUFAcGJ?=
 =?us-ascii?q?YEAl2eFJQErgWVWFZY7rxs9NAeEHoFeBgyKKY84hliXMwyTBS6YUI4GhAeRS?=
 =?us-ascii?q?Q0ZhQ4CCgcHESMSgTkGLYFcMxojgzdPAxkPhHeHIoIIg3qFE74OJzU8AgcLA?=
 =?us-ascii?q?QEDCYVDJhOFJIRKLQWBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:WFPnN6usWUSS2RDioLl7E/hG7skDs9V00zEX/kB9WHVpmwKj5q
 aTddAgpGPJYVcqKQwdcLW7UpVoLkmskKKdjbNhWYtKGTOWx1dAT7sSl7cKoQeQYxEWn9Q1vc
 wQEZSWSueAdmSS5fyKgzVQeOxQueVvnprY4tv2/jNDSxp1Y7ps4wo8JgGQCV1uWQVKbKBUKL
 OsouRC4xSvEE54Ui15PBY4tir4yuEjWKiGXffOPX4a1DU=
X-Talos-CUID: 9a23:g06s9WCbHqNBuuX6Ezlm038WHvB4TkHY4SaLDxG9BEROTITAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AWFc/Ag15AXjLKLKUqbS4JoHyhTUj+q6lFEUhm8o?=
 =?us-ascii?q?/hOaUNi9QMAiGkS2MTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="218525185"
X-MGA-submission: =?us-ascii?q?MDHP72OSn/Hb1dCLY01ckc36a1suEFr8uA1zML?=
 =?us-ascii?q?PZ6L93aE8br3nOgcNlXkPkTMmPVvMofdEvD+OBLk4O8pqiYjtPLcRRX7?=
 =?us-ascii?q?lgE8qoPgbh0lI3xRQ4P8sDGeu0RAByNaFAct2hmquFObAwiBeyDfoDSw?=
 =?us-ascii?q?j0fqtCuCyrsPOzLM+eD5dxcw=3D=3D?=
Received: from mail-pf1-f182.google.com ([209.85.210.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:04:39 +0200
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736bfa487c3so1855493b3a.1;
        Fri, 18 Apr 2025 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995877; x=1745600677; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmDYdCFy/X2BM6MIhNTfkBMtV16BYD5eNM/8mtgykck=;
        b=gQympHuKYWh7om2NmSRZjK+lZxyiIJt9xPcGvSuRKee3QHcPnSMqkmDVapybYlwRfx
         9F5RGVYgSggzXTznIkdiXUrVseuDNiTIen9qot9OA8czzfXi3iKx6miJugupra/zcCvJ
         ARvsvrvy00ecyManNgY2Ry2MYLx9NNLCJdm+Ls2AvVY5+djtmE9WNj9N+7EfueCdQALx
         6ruyQ9Op7kSuvem7WtFJMFCnQ+qb/AK/3W53o5a87cV7NLHnuX1/1B89meT84OxVZJ3j
         0HwLgpMdxD3p9GH1v5EQBp9HP4tyChN3WpOQRue6Bss604Yr2zzgr4cQn/WAH2kit7ar
         ZUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995877; x=1745600677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmDYdCFy/X2BM6MIhNTfkBMtV16BYD5eNM/8mtgykck=;
        b=ocWMrmwjCJg1ewuCqS84Ez0FmdA1IQTsnymQzH1UHusD1Yjje5xLRvjmum88Xr2DBJ
         0Cv9DgFaIBtNr4G5WHOi+++DBcWHkigWkg1BHmvmE0v0yEcYs0/Na5ApFLzspEU08igI
         CEEybkD/9fQNQy2wktNViFXVf5+uF2XRprv43x1G9H8TmxjIijHGKtFwq5z2TyU0jATz
         xS8Qn8r8N7o5Eov1pr7SdorzxyMOff8IrGvppyxmT2H3yeZsHGwNM8/GrhitxLaKTUbw
         4uBrhWFbLRnvQrcka0Dyr7PKGh6KXZiZNHhL6bim7Ct5/qakE+HpDfDlny+klB+SHYWt
         L24w==
X-Forwarded-Encrypted: i=1; AJvYcCUuWc2s7U9I+15UZ9gK/5lN/JXyrDx3LwC8Z4iDlVuygym00Xd1LtgT/dGGf6qauDENlBC+75mRuWv1rDk=@inria.fr, AJvYcCXFMaq3MSxJq4AizKFJE08y9Bgd6xNkwpQ87cqJ3N8XwNuJsK2AxqdTrCUejgd/YRf+/N+3DgI=@inria.fr
X-Gm-Message-State: AOJu0YwVztfcThi94LJu71MSK8LjRMl+JNMIrS3sI8ybo2fcHk0GomHY
	bzrmcv9ZBhpuWvdJGMVgqgVIl9meke4b88SEQXbnGhEqg5x/E/wPbZZ3YWLx
X-Gm-Gg: ASbGncsSooHV9S7JhCq6Hl7kGyc8ft5DnexlibR0Q32KIEMk71AnGlfhP0O6n4ssn8D
	P7cbl+MN6ZMNAAfNm3Hbe7D5qhv/ef32+AlD1BdQfWWnLK+EHBB8S0842XI52UO7mv2euOAI29v
	pv/NZRO8v3xvecCgbv32yN9eeGsLrp7f8cz9JV0fGAM78XO/v/iAdS8oH/bWgIwCXSohhq8Qg4T
	E191RCX5vwYxRrZ2ZW3BrhaZRImZBiTqT0ZPSDC/lvtV3Yxuc9bPvuFoVLo5nvBJ42RYNC0ufwU
	sgWYHnb3m6IFJ7s5C3Xeqkv/82PfOBZH/tFF7BFE
X-Google-Smtp-Source: AGHT+IFLjBIAYmNf23xJJKoS/fi4jO2Zv3lRydVslbcuKYfFZSoy/LLNwK2RXNGDnjZOnf14RqtA6A==
X-Received: by 2002:a05:6a00:4489:b0:736:ab1e:b1ab with SMTP id d2e1a72fcca58-73dc119334amr4736522b3a.0.1744995877338;
        Fri, 18 Apr 2025 10:04:37 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaace0dsm1823852b3a.126.2025.04.18.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:04:36 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:04:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Luo Jie <quic_luoj@quicinc.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <aAKGHIssRW5jXvdA@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org>
 <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
 <86mscek7h3.wl-maz@kernel.org>
 <aAJq9mGswYsnAOS8@yury>
 <87plh9xz2d.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plh9xz2d.wl-maz@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2705
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAKGHIssRW5jXvdA%40yury>

On Fri, Apr 18, 2025 at 04:35:22PM +0100, Marc Zyngier wrote:
> On Fri, 18 Apr 2025 16:08:38 +0100,
> Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > On Thu, Apr 17, 2025 at 06:45:12PM +0100, Marc Zyngier wrote:
> > > On Thu, 17 Apr 2025 18:22:29 +0100,
> > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > > 
> > > > On Thu, Apr 17, 2025 at 12:10:54PM +0100, Marc Zyngier wrote:
> > > > > On Thu, 17 Apr 2025 11:47:07 +0100,
> > > > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > > > 
> > > > > > Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> > > > > > macros. It is functionally similar as xxx_replace_bits(), but adds
> > > > > > the compile time checking to catch incorrect parameter type errors.
> > > > > > 
> > > > > > This series also converts the four instances of opencoded FIELD_MODIFY()
> > > > > > that are found in the core kernel files, to instead use the new
> > > > > > FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> > > > > > the script field_modify.cocci.
> > > > > > 
> > > > > > The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
> > > > > 
> > > > > We already have the *_replace_bits() functions (see
> > > > > include/linux/bitfield.h).
> > > > > 
> > > > > Why do we need extra helpers?
> > > > 
> > > > If you look at bitfield.h, the *_replace_bits() seem to be
> > > > undocumented internal macro magic, not something you are expected to
> > > > use. What you are expected to use in that file is however well
> > > > documented. The macro magic also means that cross referencing tools
> > > > don't find them.
> > > 
> > > $ git grep _replace_bits|  wc -l
> > > 1514
> > 
> > FIELD_PREP() only is used 10 times more.
> 
> And? I'm sure that if you count "+", you'll find it to be yet a few
> order of magnitudes more.

And nothing. It seems that you like statistics, so I shared some more.

> > > I think a bunch of people have found them, tooling notwithstanding.
> > > 
> > > As for the documentation, the commit message in 00b0c9b82663ac would
> > > be advantageously promoted to full-fledged kernel-doc.
> > 
> > The FIELD_MODIFY() and uxx_replace_bits() are simply different things.
> > 
> > FIELD_MODIFY() employs __BF_FIELD_CHECK(), which allows strict
> > parameters checking at compile time. And people like it. See
> > recent fixed-size GENMASK() series:
> > 
> > https://patchwork.kernel.org/comment/26283604/
> 
> I don't care much for what people like or not. I don't see this
> FIELD_MODIFY() as a particular improvement on *_replace_bits().

Sad to hear that. Those people are all kernel engineers, and they
deserve some respect.

We are talking about tooling here. People use tools only if they like
them. Luo likes FIELD_MODIFY() over (yes, undocumented and ungreppable)
xx_replace_bits() for the reasons he described very clearly. He's going
to use it in his driver shortly, and this arm64 detour has been made
after my request.

From my perspective, both functions have their right to live in kernel.
They are similar but not identical.

I'll take patch #1 in my branch. Regarding ARM64 part - it's up to you
either to switch to FIELD_MODIFY(), _replace_bits(), or do nothing.

Thanks,
Yury
