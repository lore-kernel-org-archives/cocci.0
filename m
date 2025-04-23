Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25E2C369D7
	for <cocci@archiver.kernel.org>; Thu, 24 Apr 2025 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dyuD9/sJAUbk/RnjGg0DeufQJHAxdMe3Ujkj8v1B1G8=;
  b=eE0HgcBWM98AZX9eepOz+xigYsxCpPNlWUpx82P/GtTy11KbHpXDasgz
   gUJ2nG/bQXH+5LrfBPNXSbfGcXEpu7Ve7FNtaHr3M0iyziPJBjFDAmcfs
   tAHXLdx3lbb9ajpok5lpYz8fGiV4n0vPVABX96KuNwCdVl3EksOnD0OtK
   s=;
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
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="219234238"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Apr 2025 10:55:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD30FE0D48; Thu, 24 Apr 2025 10:55:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7F661E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 20:44:52 +0200 (CEST)
IronPort-SDR: 68093524_/G2umK0SSreGZKX+ll8Pir2CqupzLEWaXMlLGRW58grjZoR
 QdgcUVwql9CZ1Q2gbfUXE5PvG6Hmr425CTjEnpQ==
X-IPAS-Result: =?us-ascii?q?A0GIAADoMwlofLDWVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAQGCQoFSBTMEU5QlggQghXqFfIZyYYwKPg8BAwELAQFCAgQBAQMEh?=
 =?us-ascii?q?QACiy0CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEiGQcOEimFew1JARABggcBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQUCLF4BAQEBAgESKAYBGx0BAwELBgUYLhASEQEFA?=
 =?us-ascii?q?RwGNYUQAQMOIwOlLoEFQopEeIEXBQIWgQGCDQbaXQoZKA1sA4FiAgcJAQqBN?=
 =?us-ascii?q?QGEdSlODoI4HQGFbIN9eicPgVVEhD8+iwcEg0SVVlOIFAgHMQkJEwYKAksLC?=
 =?us-ascii?q?hIDBAMEBAECCxMJAwMCDgIIAwIIBhkBPwwGBB0YDB8KCAgEEQooIgQOKwoDW?=
 =?us-ascii?q?zUIBgICBAQCBAIKAgkCAgUHAhEDBAEBCAICAysGAwYbCQgCDQUPCAIDAwMDD?=
 =?us-ascii?q?AICAwMCDgECAgwIAwMJAgYKCQECCgYCCRABAgIQAwICAgIGBwoDAhMMBQYGA?=
 =?us-ascii?q?goHDQsCEgIDCQYDBQoDBwQKDQIVAhUFHwECCAkOEQIFEgMOBQMCAhEEAgMDB?=
 =?us-ascii?q?QMBBwEVCAgMAgICAgUCBQIYEQ0EAwMDAggBBBUGAwkIJRsKAQMBCQMCAwQIA?=
 =?us-ascii?q?wMDAgYMCwIBBwgDAwYLCAkGAwIHCBkDBQQDBwULIQIGAwIEBQQBBQITDQIDG?=
 =?us-ascii?q?QIGAwYRCQ0GCAcJAwcBAQECAgIIAQYFEgIDBAIFBAQBAQgDAwQGAgEDAgIEC?=
 =?us-ascii?q?QEBAQIKAggKAQkTBAMIAwMDAwMFAgIKEQUFAgEFChMMCgYDBgMEAgICCwcCA?=
 =?us-ascii?q?wMDBwELHAIBAwICBQICAQUDAgIGBAMCAQEJAgMCCAECAgECAgIEAQcBBAcGA?=
 =?us-ascii?q?QECBAICMgIBAwgCBQEBDgICBAICAQICAgQCBAECBgsEBQ0BAQIBAgIBAQEEA?=
 =?us-ascii?q?QgDAQECAgMDBQMFCA8NAQEXCx0DBAUCAgEBAQECEgICAQcBAgEBAxoCAQMDB?=
 =?us-ascii?q?AELAgEBBB4EFgICAgICBAMCAwICCxMlAQIDBhMCBAIBAgIFBQUBAwQREAkDA?=
 =?us-ascii?q?gUEAgIGAgQGCgIHBAIaBAICAgEDBAYDAQIIAgIHBAQGAwICAQICBxkCGQEDA?=
 =?us-ascii?q?QECAgIEAgICCQoEBQQEBAMCAgIBDAMBAgMCAgICAQMCAgEBAwEFBg0CEgIBA?=
 =?us-ascii?q?w8IBAICBwICIQ8LAQIBAQYGAgMDAwoDAQoBAgEBAgYCAQISBQICAQIEAQICA?=
 =?us-ascii?q?wQlAQIBAgEBAQUCAQIBAgQCBwIBAgILAQUCBgECAgkBAgECAgIBAgEBAgYCA?=
 =?us-ascii?q?RUBAgICAgIDAQMGAgICAgICCQICAgIFAgUDAgMBBgICBQIDAwICAwQDCQMDC?=
 =?us-ascii?q?AMGBAIDAQEBAgECAgIBAgECBQIDCQEBAwIBAgICAgMGAgUFAQMLBQQHAQECA?=
 =?us-ascii?q?QMFAwMEAwYBDAQDAgIEAgICAgICBAICAQUDAwICBQEFAwgBAgQCAQMDAwQEA?=
 =?us-ascii?q?wECAgoHBQIEAQEBAQIBAgIKAwIFAQEDAwESAwQBBgUFBgIHCQMCAgQCAwIEA?=
 =?us-ascii?q?wkEAgYDAwICAgEBCwICAQICAQEDAwcGEAECAgICAQ8CAwMDAwMPBgMFCQEDB?=
 =?us-ascii?q?wEBAQEBAhQDAgEEAQQGHQIJAyMPAxQIEz0MBzIENgEUFAcGJYEAlWSDZppMr?=
 =?us-ascii?q?1g0B4QegV4GDKA5g3CNCYY6DJMFLphQqQoCCgcHESMSgUgkgVwzGiODN08DG?=
 =?us-ascii?q?Q+OIYQAwlUnNTwCBwsBAQMJhUMmE4QXhgmBSwEB?=
IronPort-PHdr: A9a23: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
 vEehQ53YOBr/zDpsQ5fGw==
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:Xcevmqjffs80/yjskoKIuVUnE3BQXh8ji2hC6mlwRA09TyVXrb
 HJoB0+726JtN9xYgBcpTnkAsO9qBznhPtICOUqTNOftUzdyRSVxeJZnPHfKl/balXDH4dmvM
 8KAspD4Z/LfCNHZK7BkWqF+r0bsaC6Gc6T9IDj5kYoYgdwdal64gt1TiqdGFZnXRRLCPMCeK
 a0145oo36Pdx0sAPhTxUNrYwEAnbD2fV7dACLuziRG1DWz
X-Talos-CUID: 9a23:Js9CS23XrCANCnyfjbGAJLxfQJoCbkztk0jqCFKFVWZicqKTVWCZ0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AH6+rlg9eUuNbCFuQgmico/6Qf9VIzfj+NREpq7s?=
 =?us-ascii?q?5pOeraTRCNzKUzw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219163715"
X-MGA-submission: =?us-ascii?q?MDHWmw3OA6vg6oKpBDZQTJgeG7+wi2rRGQ9oe0?=
 =?us-ascii?q?JBA/92OddmKFR/bFCucAB8dxYCEP/S6YWmj2UswzSruWqDrsd9LqNrmM?=
 =?us-ascii?q?4b3FWVD1KnN7TKI3/v35J7xmOkgRum9kgHFtTCnuvUrSIog9C0Ch9/Ym?=
 =?us-ascii?q?DjKDRo6McpR6iT6NDIHF2zCA=3D=3D?=
Received: from mail-pl1-f176.google.com ([209.85.214.176])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:44:51 +0200
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so2377715ad.0;
        Wed, 23 Apr 2025 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745433890; x=1746038690; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyuD9/sJAUbk/RnjGg0DeufQJHAxdMe3Ujkj8v1B1G8=;
        b=cpanUhRHh+NXICIPNzEOZ3ZW6r5CzLoCzwg3vP3RpJGGjN+OkZCMDZzMcsUVT4hgRl
         OHaLn4wtB9/+UDLKGikcwcg1B4QCswkFildhQI2P/1Cr9KfOOyTvtjYDbBXSr72pHq33
         Fdt7s9bMc3fY/ubTz2LY4QkM5syGDB+flKeOehjOcXKiI5e1U0wkl42rksKsbglB3qF9
         rglNfbPOONSaNwzTZsQ0ln9YkMfPymT7t81rahPWttI5pug44KuAmhUbMZf95SqrU1yh
         TI2jiVE4nqdrc6+3uWJYdDERfzWzPDfKjgSU+3X7FPI7ezDls99YlCeM8E+yFeT2b6dK
         roBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433890; x=1746038690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyuD9/sJAUbk/RnjGg0DeufQJHAxdMe3Ujkj8v1B1G8=;
        b=Pwkkh+eknzAU/eVZ1fk7uTBxtmu/aR69sTtaVApVdaTwHCStfgG96nDy2WdgqZSONP
         UTfvcXeMPXPGfv2/yTWTrU7NCd+0FCeUOo8tLdbFNsxnniI8v/CM/5A20Q+0EQ0V/YvS
         KqXLuE1MC7P/Oc5RrCEeXUccCjcm5vLmDtSEJpYULdwQALSbi3waVZibaNzj8IxqegFs
         AmvriqrgDGM4xrWqyk8jbSUUPKQShPvldF4aF8FPHeyqYp/aKhWr6Vh8u0hzema2Lsw7
         I5tluvL2zMhYAXZFXWc4/xiPKhmEwNvdCz2nWtE/zm3pQy9HekeUJgugw7JcVg+/pK62
         4mew==
X-Forwarded-Encrypted: i=1; AJvYcCVeoIHC/WHOMB1WablF4xvHsNfVQNX3A6tZl4r7NyrtpLotVDvXCSZogSnz2Dpuwb8snlQhdSutjN2G/Ww=@inria.fr, AJvYcCVhHOQi1K94lszj3v1RE4t+/qHzHJVTamSqKdHI4DCi1xBWYWHskKC+usqTWyKaLDuEwcOJmbE=@inria.fr
X-Gm-Message-State: AOJu0Yz89oGfkmZaOjVTMa+Q/LVokLLKADXZfY154slX/g2tm8cshAkG
	K5VSAqbyCO4kK+WVdCXzyLXBsGy9qEv7u9hkXUfITdhOKe+XtOs/PRrklb2x
X-Gm-Gg: ASbGncshEwY2Dsza+3byWkM+gu8cVPsdSQcmIwTvnEyXkX9Cgl+2noRdvUuebXY2Nei
	ll6kHuEGD0DZ5zGN9btLzclV+/lUHu/skU4sjRTPdFOT341Raatb5QO1YeWDMP0cadFS2XkbupY
	v3S8I8+aJk+g36gAX7oZpC0IKoWF+QOSWuy4WTTLj5+pMwY2EZg2QTRztpLF50iTJfKJ2LxXuKk
	qB43DXi/BuiAXBsci1HaGmgVeHcAIFk/cVVgYMDCrBMRAV180Ipgd3kdua5wxrg6Feu/MxmrQ17
	QByBdPv8mzzIT4CfZP/g3g76YN4phcKgEwGVfocUDzaA/EOXIe8=
X-Google-Smtp-Source: AGHT+IHehkEM0GpRg5zfuUpHGpY51Oz35KQoy2mf8GVVVNyjw21DRg3BRF5CuxGd2alCupb+hBqELw==
X-Received: by 2002:a17:903:247:b0:220:da88:2009 with SMTP id d9443c01a7336-22c53619eb5mr285278835ad.45.1745433889820;
        Wed, 23 Apr 2025 11:44:49 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db13a3e63sm9433123a12.29.2025.04.23.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:44:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 14:44:47 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Luo Jie <quic_luoj@quicinc.com>,
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
Message-ID: <aAk1H0Msi3lMKNR9@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org>
 <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
 <86mscek7h3.wl-maz@kernel.org>
 <aAJq9mGswYsnAOS8@yury>
 <aAkm79R8f5Vf6TLh@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAkm79R8f5Vf6TLh@shell.armlinux.org.uk>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2717
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAk1H0Msi3lMKNR9%40yury>

On Wed, Apr 23, 2025 at 06:44:15PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 18, 2025 at 11:08:38AM -0400, Yury Norov wrote:
> > The _replace_bits() functions return fixed-width values, and intended
> > for: "manipulating bitfields both in host- and fixed-endian", as the
> > very first line in the commit message says.
> > 
> > Those using _replace_bits() for something else abuse the API, and
> > should switch to FIELD_MODIFY().
> 
> Sorry, but please explain this statement, because it means nothing to
> me.
> 
> FIELD_MODIFY() replaces bits in host endian. _replace_bits() also
> replaces bits, but has a wider range of which encompass FIELD_MODIFY().
> 
> I see nothing that precludes using using _replace_bits() with
> bitfields.
> 
> I see nothing that would differentiate the behaviour, other than maybe
> religous ideals about C functions vs macros or upper vs lower case.

Interesting, never heard about religious ideals in C.
 
> Please explain why you think there's a difference between the two
> because I really can't see any reason not to use one over the other
> apart from asthetics.

I explained that in subtread for 4/6 in this series. Shortly it's
about compiler's ability to catch various errors, like overflows,
and (not unlikely) generated code quality.
