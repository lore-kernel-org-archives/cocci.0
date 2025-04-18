Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49660C369D9
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xXrHi2dDhsHjFRrFFlLx3951AzAuiByzthX8mF+kPRc=;
  b=CPnQSNZfB/CQEFe+dREiN/ZqUCE4wAJ4Zda99arG5vQMJJ7y6gOVh7S6
   MCv7DpmkJSr4LIOVc10cF6ctKcP9Rp0tC/vOfBDuhqoDkWyxT1o1r8URN
   aFG5w05l71ifTOkjEN22OaCOVnM819ch7PkGB3BYAjC9waqeAyS73EuAc
   A=;
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
   d="scan'208";a="219056304"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 828BAE0DD5; Wed, 23 Apr 2025 10:51:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 788FBE007A
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 17:08:44 +0200 (CEST)
IronPort-SDR: 68026afc_FV8zxPp3EMTTLsYORVYTO0rPNeZjoVvNgCbEMmAK223Jdea
 6BQeYDOhyKdwTq2PeH8omhVvf90I8TinYeL/M+w==
X-IPAS-Result: =?us-ascii?q?A0EJAAD5aQJoga7WVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAQGCQn1aMwRTlCWCBCCFeoxuiyqBQD4PAQMBC?=
 =?us-ascii?q?wEBOQkCBAEBAwQ4hEgCiysCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEiGQcOO4V7DUkBEAGCBwGBJGECBQM7AQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINH14BAQEBAgESKAYBGx0BA?=
 =?us-ascii?q?wELBgUOBAYZAhMQEhEBBQEODgYTIoJhgi8BAw4jAxGlPYEFQopEeIEXBQIWg?=
 =?us-ascii?q?QGCDQbaXQoZKA1sA4FiAgEGCQEKgTUBhHUpTg6COB0BhWyDfXonD4FVRIQ/P?=
 =?us-ascii?q?oUgA4VkBINEgy2EI4Q/hTOCboQ6iH4IBzEJCRMGCgJLCwoSAwQDBAQBAgsTC?=
 =?us-ascii?q?QMDAg4CCAMCCAYZAT8MBgQdGAwfCggIBBEKKAMiBA4rCgNbNQgGAgIEBAIEA?=
 =?us-ascii?q?goCCQICCAcCEQMEAQEIAgIDKwYDBhsKAggCDQUTCgEFBAMHBQIbAwMCAgULA?=
 =?us-ascii?q?ggFAgUHAwkOAQIFAwQVAhACAgIIFQICAgUcAyQDAwMDCwECAg4JBhgPBAIDA?=
 =?us-ascii?q?wIOAQICCQECAQMDCAMDCQgHAQoJAQIKBgIJEAECAhADAgICAgYHDgMCEw8FB?=
 =?us-ascii?q?gYCCgcNCwISAgMJBgMFCgMHBAoNAhUCFQUfAQIICQ4RAgUSAw4FAwICEQQCA?=
 =?us-ascii?q?wMFAwEHARUDBwgCAgwCAgICBQIFAgUXEQ0EAwMDAggBBBUGAwkIJRsQAQEDA?=
 =?us-ascii?q?QkDAgMECAMDAwIGDAsCAQcIAwMGCwgJBgMCBwgZAwUEAwcFCyECBgMCBAUEA?=
 =?us-ascii?q?QUCEw0CAxkCBgMGEQkNBggHCQMHAQEBAgICCAEGBRICAwQCBQQEAQEIAwMEB?=
 =?us-ascii?q?gIBAwICBAkBAQECCgIICgEJEwQDCAMDAwMDBQICCAQRBQUCAQUKEwwKBgMGA?=
 =?us-ascii?q?wQCAgILBwIDAwMHAQscAgEDAgIFAgIBBQMCAgYEAwIBAQkCAwIIAQICAQICA?=
 =?us-ascii?q?gQBBwEEBwYBAQIEAgIyAgEDCQIFAQEOAgIEAgIBAgICBAIEAQIGCwQFDQEBA?=
 =?us-ascii?q?gECAgEBAQQBCAMBAQICAwMFAwUDCA8NAQEXCx0DBAUCAgEBAQECEgICAQcBA?=
 =?us-ascii?q?gEBAxoCAQMDBAELAgEBBB4EFgICAgICBAMCAgMCAgsTJQECAwUDEwICBAIBA?=
 =?us-ascii?q?gIFBQUBAwQREAkDAgUEAgIGAgQGCgIHBAIaBAICAgEDBAYDAQIIAgIHBAQGA?=
 =?us-ascii?q?wICAQICBxkCGQEDAQECAgIEAgICCQoEBQQEBAMCAgIBDAMBAgMCAgICAQMCA?=
 =?us-ascii?q?gEBAwEFBg0CEgIBAw8IBAICBwICIQ8LAQIBAQIGBgIDAwMKAwEKAQIBAQIGA?=
 =?us-ascii?q?gECEgUCAgECBAECAgMEJQECAQIBAQEFAgECAQIEAgcCAQICCwEFAgYBAgIJA?=
 =?us-ascii?q?QIBAgICAQIBAQIGAgEVAQICAgICAwEDBgICAgICAgkCAgICBQIFAwIDAQYCA?=
 =?us-ascii?q?gUCAwMCAgMEAwkDAwgDBgQCAwEBAQIBAgICAQICAQICBQIDCQEBAwIBAgICA?=
 =?us-ascii?q?gMGAgUFAQMLBQQHAQECAQMFAwMEAwYBDAQDAgIEAgICAgICBAICAQUDAwICB?=
 =?us-ascii?q?QEFAwgBAgQCAQMDAwQEAwECAgoHBQIEAQEBAQIBAgIKAwIFAQEDAwESAwQBB?=
 =?us-ascii?q?gUFBgIHCQMCAgQCAwIEAwkEAgYDAwICAgEBCwICAQICAQEDAwcGEAECAgICA?=
 =?us-ascii?q?Q8CAwMDAwMPBgMFDR0CCQMjDwMUCBM9DAcyBDYBFBQHBiWBAJdnhSUBK4JQl?=
 =?us-ascii?q?juvWDQHhB6BXgYMiimWEJczDJMFLphQjgaVUA2FJwIKBwcRIxKBOQgrgVwzG?=
 =?us-ascii?q?iODN08DGQ+Ed4kqg3qFE74GJzU8AgcLAQEDCYVDJhOFJIRKLQWBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 NWzyyBWOXlp43y9FFFbJcvlNn6xvr8x4+n1sTPC
IronPort-HdrOrdr: A9a23:0qpMaaDcJSO1KXTlHemd55DYdb4zR+YMi2TDj3oBLSC9Afbo8P
 xG/c5rrSMc5wxwZJhNo7290ey7MBbhHP1OkPIs1NWZLWrbUQKTRekIh7cKgQeQeREWndQz6U
 4USclD4arLY2SS4/yX3ODyKadH/DDOytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3Ai+qhGWoyIbVREfF9ZoyqJR3mUdAlfUOa6V7/GXS?=
 =?us-ascii?q?5FT5wQpaIRUau3Zoxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ACHL5jA61FDWUGudlqxcjVQfjxoxk2o33EUsUjq4?=
 =?us-ascii?q?0nNe9aA1aJwqH1T6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="218511302"
X-MGA-submission: =?us-ascii?q?MDFYpWMomScAgs2zj9cR2IPtO5VC8NtUN2Y4+A?=
 =?us-ascii?q?HMKme0RXq4k2GzFPBFRHup5Ht4+3hQfPG+5S6NKuFx7RRNcM+brVie3m?=
 =?us-ascii?q?DjqWgPTNEt9swUhzKgHl4EeBEcMtv6wURGpjSzf2J0mF9znwSj0G8gBW?=
 =?us-ascii?q?UTsRChCh43K6dELnv1pOugKA=3D=3D?=
Received: from mail-pl1-f174.google.com ([209.85.214.174])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 17:08:43 +0200
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22423adf751so23311125ad.2;
        Fri, 18 Apr 2025 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744988922; x=1745593722; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXrHi2dDhsHjFRrFFlLx3951AzAuiByzthX8mF+kPRc=;
        b=ZX5pQ6fOSi0bIYixzVlIQzhNnhc43EppBKIQun2hgM39EZQMY9cGJfIGvcZpVgZyjT
         n/byjyfx6cJFVxpxG3mv5JyBmMSn8kwTNjWCC1xW+53qN7oYFRD2Kf86lQLfExDMPXju
         7snhk4xg0YDu5uBhSePv4luFVnWfDzfYK6UCqT3k4RCSYDctoZccX6vEbbpuGvXW0ZbB
         /L95iT9chJqP+S6UDXOrIjLmQoU+rBS1co/O3hGmX6E8WwSe7xqV59e0YK/YUniNizCO
         lCPwW9SwsI8yhRmkDqO0+ANCl+HvO/Jtt0TyZ+i6PK408CeDDI7kF35loE9uMr0d24T/
         iaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744988922; x=1745593722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXrHi2dDhsHjFRrFFlLx3951AzAuiByzthX8mF+kPRc=;
        b=fWGDMaUT6G4VhcRbw/gFctBqiLNmpyHhbgmwvcVTq+DxkHs4deDc+M89VpExteM+4n
         TxhCs2Im4Flj/ojXgwyoEM0hFosmPNZCkyq5RjvXO9l3pZxVfis0d1yCCt5rAlJLLuYm
         M8K84Q3tMh6pAE5RuIYLf2fYsqnpygvvdXjq/euxeO8EShKh+uNNZXZEBTMXxao+RmMW
         tqUAsuZpxZ141aw6uiDKSgNkuym4NpRDYWiS0DXUIUjUQO0qoM+wfWq//+FpmBpENqiX
         4kKkyJHEQhLyW750JXz5BxTNYZdxo7b86JOBri6+dv9srNboBy5K/+ljv2r2WWhTNDox
         mSog==
X-Forwarded-Encrypted: i=1; AJvYcCUaHsN8PQO6eRYVLRUA6IDPT6Ea+i9kDs62I9zfGR22/CqQ2PMU+E7sMIdMXiq1vV/3BHEwiN+rIf8yCIk=@inria.fr, AJvYcCX6/Je/P/K4qcCxY0+kasMHcoyn3s9z2GBX1NFUBIjwgokh7GygN830X4JAqidGJq773y7yJY4=@inria.fr
X-Gm-Message-State: AOJu0Yx5p5ZhuN2G9riWExCzdWXewH5kPEfERYbmZSOc67h+8HHoepAr
	7zeensAwAWiB293XKZipu4+Gu/HawSrtUEuhvNW8uij8MrHiXkeY
X-Gm-Gg: ASbGncth9tNnuJvoH9+54snAMJsvO5iUVicfly226pXAYrNH71W7rkWtHIo1x8Tm7rf
	y9pugEWHiWRWxIjO3HGiFYODXZtezj11US78GRYicS0EjAFU6f0IxGrfV5mCbRLVbkWfjt9h3WJ
	zVqw1O6+9L/q6F7XnScdRklPAwZusNe5OWPUeXbngl0fkZKW01KF32GeJ8jwSfS8RiQXUo6xWDt
	g1X2Gws6dDpCLyyA8qT7UX5VBaB6hRHXmYtJyXnj42FxaO/RnBlQ2Zd9gBioEZrGhNVnuE7XEy1
	O2jbU/XyQdhXEKA+gmNOZPoMDrozF6hROy+bRTmL
X-Google-Smtp-Source: AGHT+IFgyjtFyh0D1cewNDh4KCf3omEopwXw/CgC9qM37WkDXknCiuMsdR9x6yE6lYdQVJp7loAorg==
X-Received: by 2002:a17:903:3202:b0:224:c47:cbd with SMTP id d9443c01a7336-22c530bc965mr45650025ad.0.1744988921670;
        Fri, 18 Apr 2025 08:08:41 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3fcbsm18016695ad.78.2025.04.18.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:08:40 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:08:38 -0400
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
Message-ID: <aAJq9mGswYsnAOS8@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <86sem7jb5t.wl-maz@kernel.org>
 <0c97c659-bd28-45e0-8537-d9be2637cb22@lunn.ch>
 <86mscek7h3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mscek7h3.wl-maz@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 0/6] Add FIELD_MODIFY() helper
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2701
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAJq9mGswYsnAOS8%40yury>

On Thu, Apr 17, 2025 at 06:45:12PM +0100, Marc Zyngier wrote:
> On Thu, 17 Apr 2025 18:22:29 +0100,
> Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > On Thu, Apr 17, 2025 at 12:10:54PM +0100, Marc Zyngier wrote:
> > > On Thu, 17 Apr 2025 11:47:07 +0100,
> > > Luo Jie <quic_luoj@quicinc.com> wrote:
> > > > 
> > > > Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> > > > macros. It is functionally similar as xxx_replace_bits(), but adds
> > > > the compile time checking to catch incorrect parameter type errors.
> > > > 
> > > > This series also converts the four instances of opencoded FIELD_MODIFY()
> > > > that are found in the core kernel files, to instead use the new
> > > > FIELD_MODIFY() macro. This is achieved with Coccinelle, by adding
> > > > the script field_modify.cocci.
> > > > 
> > > > The changes are validated on IPQ9574 SoC which uses ARM64 architecture.
> > > 
> > > We already have the *_replace_bits() functions (see
> > > include/linux/bitfield.h).
> > > 
> > > Why do we need extra helpers?
> > 
> > If you look at bitfield.h, the *_replace_bits() seem to be
> > undocumented internal macro magic, not something you are expected to
> > use. What you are expected to use in that file is however well
> > documented. The macro magic also means that cross referencing tools
> > don't find them.
> 
> $ git grep _replace_bits|  wc -l
> 1514

FIELD_PREP() only is used 10 times more.
 
> I think a bunch of people have found them, tooling notwithstanding.
> 
> As for the documentation, the commit message in 00b0c9b82663ac would
> be advantageously promoted to full-fledged kernel-doc.

The FIELD_MODIFY() and uxx_replace_bits() are simply different things.

FIELD_MODIFY() employs __BF_FIELD_CHECK(), which allows strict
parameters checking at compile time. And people like it. See
recent fixed-size GENMASK() series:

https://patchwork.kernel.org/comment/26283604/

The _replace_bits() functions return fixed-width values, and intended
for: "manipulating bitfields both in host- and fixed-endian", as the
very first line in the commit message says.

Those using _replace_bits() for something else abuse the API, and
should switch to FIELD_MODIFY().
