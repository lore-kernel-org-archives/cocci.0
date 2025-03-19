Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A9C35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LORq2KAADE2r9Z8o9tpXvvK4wsy01Q4/tnyeeaUaOUQ=;
  b=jUX6sOw4lA0J9n0w0DaNkCE6C97bTWZXmRfEikCBWQK0n0AvUyvs+CJC
   joxrMo4NdqA9QDExe3QA04Vx5wbOTw/8XRjnJVQ68/MCUWeXTVqUP5Aj2
   jAgZUnhxbg+9sFf0J9aKiAetMGRwhLnAK2gLxymhHV8vnkO1TH3NdIsHy
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213701419"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 13:48:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 355D7E0D1E; Wed, 19 Mar 2025 13:48:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A3CDE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 13:48:31 +0100 (CET)
IronPort-SDR: 67dabd1e_lSmPI93BBtMmasKs653cWpt/GNfch0vUGaPjhKYzj2W764g
 X5/MtcmI2RpseXu0ccz6Im7Ns6fpDvfCF0cVsZA==
X-IPAS-Result: =?us-ascii?q?A0H6AACJvNpnjxj/11VaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgSsrNAcISI1viFueFIF+DwEDAQgFRAQBAQMBA4UAAosgAh8GA?=
 =?us-ascii?q?QQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFD?=
 =?us-ascii?q?juFew2CYgEzghYsDX4BAQECAUABATcBBAsLRlYGE4MCgkISEQeuTIE0gQGCD?=
 =?us-ascii?q?AEBBoJo2TiBXgcJgUgBgVeEFYJjAYpjJxuCDYQ/PoRYhi+CM4Uoqj9ICoEXA?=
 =?us-ascii?q?1ksAVUTDQoLBwWBKUMDNQwLLhUjgSIFND84KYFjaUk6Ag0CNYIbfIIogheCN?=
 =?us-ascii?q?oQ+hECFUIIRgV0DAyIBgx93HIRBP4RhLVCCFh1AAwsYDUgRLDcUGwY+bgeiP?=
 =?us-ascii?q?DqEPDiBcTNpc5MrkQChcYI/gWaBY59lGjOBS5V7DpMDiCmQVaRLhGiBaAE4g?=
 =?us-ascii?q?VwzGggcFIMiTwMZD44hDA0JhAu0e0UyAjoCBwsBAQMJhk2JT4FLAQE?=
IronPort-PHdr: A9a23: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
 Bkwh01ybLZ0nAo=
IronPort-Data: A9a23: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
 Pr+oqpcT516eQYIfQVDi8k=
IronPort-HdrOrdr: A9a23:FOufw6k0SGTAaJQJhjNCKUOCsmLpDfLn3DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IV+rwXJVoJkmsiaKdgLNhQItKOTOI1ldAQ7sSjrcKrweQeREWs9QtrJ
 uIEJIOcuEYb2IK6/oSiTPQe7YdKZu8gdiVbIzlvhBQpG9RGsRdBn9Ce32mO3wzfzppQbIEKb
 v03Kt6jgvlQkc4Ku6fLkM+G8jvzuemqK7b
X-Talos-CUID: =?us-ascii?q?9a23=3AZR5JxmvXQ6zY3k9/6jKWwvf+6It8cGP/3DTfeXT?=
 =?us-ascii?q?jFGczFuaJaXif5oR7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AI3rgSw/+TaQEz5O5IoawR8CQf+NauoqQJ1gjrYw?=
 =?us-ascii?q?968fcGwViJTWUiyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112027069"
X-MGA-submission: =?us-ascii?q?MDFyWrH2d4Ry2DjzZZw3nQLY7iv2iInAVenq4H?=
 =?us-ascii?q?mvCTpualM6eOGrTwUFR9oVWSaC7YWZKyX6nfrmzQYfiEg1IT+46Eqf50?=
 =?us-ascii?q?prRWVfDpM5dGptTN5cqbcvnYDRHe5NHlJ1l0m4f6fFseDJ2ZRmHnwiBo?=
 =?us-ascii?q?yw3TLwCO692YSNajPZ+UKLdQ=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 13:48:30 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742388509; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Kd9IIXx7J3ezLXsTtGJXJpP/akv36qH5ZMdZs7JE6WQUxFkaqXVBEJ51dSNRJIAe/V
    +hPGvNEfeVoQIVqpYbz8IJaAquDkk7jStmNfIEe4hviX5+65hE43XSgl4SrS+KtJVyle
    IzE9pZvnl4uCippF2Ye07HEoRBXoyzvqPluqJX4kPpaUEliHl8P7oyfP32WS66+THY8e
    5CkBl1XW0Lhx9LoPCcrLfB42jk/kGUfSm21IebqqbhU9mwYXsGyt8ZumnQOgYo43XXpx
    a+POAlwtGF/HkEkx20/Hu8UPE8dT/IP6uiYdfAAKQ4l8OUKO7/3rfPC3UuicO0x0MQF7
    BZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742388509;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LORq2KAADE2r9Z8o9tpXvvK4wsy01Q4/tnyeeaUaOUQ=;
    b=oUdTEO+i93comAsdMjGsgcAiBX15tjpvVArcRGOCbTvupaZ+hiKoK52UE2M/n6ot/D
    LiaTdhr5+AF/dzuxOBJar00OJ3vwaAWRmSgredAz7S4wKWkD5LDUkKP8ar1c6IPq5uSo
    qp6wo6VYhNrptlJKGi1zr7OM57Q9k/FeCL6V2P2jA0WOqYksle1UA/r9XswIY7MAFxtV
    nnIn+MYrYXjh4dUeQOEQGa1XHI2qEiNswNIL6yLS2wDe74RsX7tlJSFAFdhBtTcM/awA
    IEq9qZiUJ0Gd7WuDHDPozcESrXHMmuzBVoThfRMIcx/4hubLc8VdB6qDgeZWPMDu0/Ru
    pvtA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742388509;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LORq2KAADE2r9Z8o9tpXvvK4wsy01Q4/tnyeeaUaOUQ=;
    b=JBNLoyIdzjO5VB/k2kRLMW8DhVwYtwZqfmywhwmCH1ZDIkxeQ67DImRBVfmlvfyBLt
    E/0RpmtoNTGwzfdFPc2PzISfTfmEqB2goK4wAIvQ/R7wJY5wmOZ7PawUZWtBRcz3jvt+
    pYv73I1OmeRidfY7L6fSO5yq0GQlFoYNCqcOElHlkON9eIBuFtKNtS3R2Fk+xve0BkoW
    draNKfg0EHoYxPYtBb/bIO3yh4f9CmjgWq8baReLh/YoO/46hyhsI5QZhhnxRUUbTTfi
    KE+6Wlvjp+NKL5y4ABrWGpvAodfkGgFsPkwu52PD3LwNp4jbNZLet9dT+9tFaoQ8OvV5
    4p4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742388509;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LORq2KAADE2r9Z8o9tpXvvK4wsy01Q4/tnyeeaUaOUQ=;
    b=14AxHEQxD7dzU12RxZPf7V4wawn7iB2zCZgmn5QQEivITnxmtjm1P4SqsZ5lItYJCI
    OTwOA1fOpSS3k5EaNrCw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12JCmS6Av
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 19 Mar 2025 13:48:28 +0100 (CET)
Date: Wed, 19 Mar 2025 13:48:16 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, <cocci@inria.fr>
Message-ID: <20250319134816.3b7d026c.olaf@aepfle.de>
In-Reply-To: <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
References: <20250318111305.281abcca.olaf@aepfle.de>
	<2b3232fa-ad32-c17f-8e97-8144c648c19c@inria.fr>
	<27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gJs+r.MHUP6oQ=ehrXVlD16";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2647
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250319134816.3b7d026c.olaf%40aepfle.de>

--Sig_/gJs+r.MHUP6oQ=ehrXVlD16
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 18 Mar 2025 14:52:42 -0700 Jacob Keller <jacob.e.keller@intel.com>:

> Why not go the other route and optionally use the bundles?

What is there actual purpose, what does (any) bundle actually fix?

As you said, every bundle becomes stale. The way it is implemented
means one can not even test them because the one from the environment
takes precedence.

If one wants coccinelle, use the package manager to install it.
In case it is unavailable there, get a copy of opam and install it.
In case one has to actually work on coccinelle.git for whatever reason,
there can not be any convenience, except 'opam install coccinelle'
which will install all required development packages.

In the context of Packman I had to deal with way too many packages
that bundle something which has to be provided by the system.
Every single one was and is a mess to work with. Today my first reaction
when I see any bundle is: purge that repo from disk and do something else.
Which is what I'm going to do now.


Olaf

--Sig_/gJs+r.MHUP6oQ=ehrXVlD16
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfavRAACgkQ86SN7mm1
DoA19RAAgQV7C/6Vz/wW1BpwwYg66HWRFU2OzvsK8KeHQdUEDxFSnkaPN/WbbdjT
otYwlEicDjZlHuJ3sgFC4vLAMHlJEiCd5qYOd/woLBFxoPa5e3LCArD1Jormr3Hf
zeRbUzJVJE1E2yE7lRSzHOoseY1D+CjFYdySmncWf16ppZrf30VHaQDWe4WEqxpD
ed5urknwxrS2tIXEY+Wmp32e8QdvhdFLY2c+zh1/eD1e4P9a41zUb0hdnMUVzer2
iUaXExetpffgpddJ0sPGBPkUVeI13UMRMQTjPJHM1SxQJNVEpMVkl9HgjRy8urF7
Wil29/c23JEsM1ZHKX7Nm7EWyNC1bEqwH5LEALne6oVgEU21llAcXSfBpjsXiIvz
0SgswEoFVNcCOzynRmS+7Ec/VOEetwvLXKgcxbWNSB1y7k+nFir+Lcm5CWoA6b9F
dhI3mmjV1J1sN6BMmYy+JcPd8K9S6VJin+6nwviP9K9aD5FdFD8pPpUdGO4kZLwC
kQiXgr82tTs858m5Sr6IPRMCjhT7HC+sy4veBVuneuVG/D9JC3Zes5A4t22X8TeC
RPOgHfYb5Xp+3PelE81HHbkpWHrkZmlXaFHWbM6Lhs5TSLPsw8iz6nBxy6orCTTB
VMuGWW0UbYHWJSy8bWa6cANVgY+t+t1TKQEuMda0hofAs1zSzDg=
=jikM
-----END PGP SIGNATURE-----

--Sig_/gJs+r.MHUP6oQ=ehrXVlD16--
