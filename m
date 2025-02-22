Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12CFC021B2
	for <cocci@archiver.kernel.org>; Sat, 22 Feb 2025 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=0wTZa0Kkcr3qmm6VKMjFNVqBA4FCJpNUSxDAb0tLRbE=;
  b=WvZSqwOxvNPVDBvdMsux/kcxYWIkcNeITLLs1YlFAPUlLEOd9aTfYQb+
   zKmplIF+fSbEU8VcXDM7p+nouci669hv9ffEzxsZAkbvxMxyNw86smpuj
   YyfdeVXvj7haZAje87+ioTcboLr97fR7Q79Wwp40gKvv8Nimxz/duZJJs
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,308,1732575600"; 
   d="scan'208";a="209508902"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2025 14:44:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5058E0261; Sat, 22 Feb 2025 14:44:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C7C31E0261
	for <cocci@sympa.inria.fr>; Sat, 22 Feb 2025 14:44:44 +0100 (CET)
IronPort-SDR: 67b9d4cc_xBBYO4z7bfujGBdxbQdi3CqwRs1v5JaPQBVSnCaCcBiUC9i
 WzNz2k8EVpsxGVeyuFqrP75iDcquXWyyGF97FVQ==
X-IPAS-Result: =?us-ascii?q?A0EIGACp07lngAwR49RaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?Bo8j0+BdIRrlVSCL4FWgX4PAQMBDT0EAQIEAQEDAwE4gVSCdIsSAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECDTpGEBcdAQERJgEYHAImAk0SEgIBAYJ+AYIvAQMxBw0GkW2cRYEygQGCD?=
 =?us-ascii?q?AEBBoFGAgwCQ9hDHywiV4FlAwaBGi6FbIJJGgEFbYRpS4NCeicPgVVEgTwLh?=
 =?us-ascii?q?gAXAQIBGIITgw6CaYIzhEVnmhCND4FNHANZLAFVExcLBwWBcQMqNDGBRnqCR?=
 =?us-ascii?q?WlJOgINAjWCHiRYgitqBAWDY4RDhEeFVIIRggiCMYVQgS6DJB1AAgELbT03C?=
 =?us-ascii?q?QsbBj2gE2w9g0aBfBMWApV0gxWvTzQHgjiBZoFjDIkFgSSVNQYTL5dEDgaSf?=
 =?us-ascii?q?AEuhXSSWyKJZoIEgXmVVYVWNYE5ATKBXDMaJIM2HzADGQ+OIYN6M4ELg1XEE?=
 =?us-ascii?q?0I1AgEBOAIHAQoBAQMJAYFVg3ABAYpmgUsBAQ?=
IronPort-PHdr: A9a23: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
 J7DmfCqQN+j29fT4NdaGMXebs6KYiJJDA==
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:xQorsaiERHFdviwdVypMmKGWz3BQXgIji2hC6mlwRA09TyVXrb
 HNoB1p726WtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNzhHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNj2CJ5sA0+9jYDzra3GeqTM2fabQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AkxnNdWrBQQpJfb99FQDoR5HmUccmYEHy7U/gH0y?=
 =?us-ascii?q?fCFYybeSMZw+N26wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8/kOMg1k9W4E6ynguwNdb3WJWTUj3L33UloimJc?=
 =?us-ascii?q?8tu6/bxRsJgivkReXa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,308,1732575600"; 
   d="scan'208";a="209508901"
X-MGA-submission: =?us-ascii?q?MDE0H/NGJ/EjTFkB2GG5yMeU9j+jmgdQZxnIBK?=
 =?us-ascii?q?98P4+zQsKkUsSB4VQZ07a5S+V3Neno2oxl1XimOAwUrRPz8fW4sh6TfL?=
 =?us-ascii?q?msdf4M1BHzWFN4HZt7UxIZCNCsvYEZV2a09UXvXHMKPF+XzXl56lEonV?=
 =?us-ascii?q?P72oMPeXU6guWAqup9SS1emw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 14:44:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740231883; x=1740836683; i=markus.elfring@web.de;
	bh=0wTZa0Kkcr3qmm6VKMjFNVqBA4FCJpNUSxDAb0tLRbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jfw23gZoxS1V7FWKPnfCM5OX0gfh04PtRmvmN8BFsHvFwMlRBHcnjq7FOXgtPFkQ
	 xHv80RTNR6GhJUWV7NKJoqDQt+eyqiPMeW/bbHiBXxOZwa9CjN9qKVM0wMkC0Tiy/
	 rZaqIhkdkIMdrpOmgaS7Rf5MBFUFenVpPkJMwBuPy3PmRuALDr3Wgd1Jc54lSKgj7
	 Nh3AecW4NnJXMrzgGlP4v3PUHAg17cYomP5fWhMhbg+9NRUBhffAJxk6zGzTXXvMt
	 PkZzx5EVN5ce77mlpt8qs/4qCCPLm+ZlFK54LSP9pvVPea/dbNAS2lLJmYdnHGrTE
	 4k/LIaQjlJE7NZFnzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1t6AXA1H9n-00ec4q; Sat, 22
 Feb 2025 14:44:43 +0100
Message-ID: <04032bab-ad6f-4ef1-9600-27554233b9a1@web.de>
Date: Sat, 22 Feb 2025 14:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, cocci@inria.fr
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ricardo Ribalda <ribalda@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KBopMn0YCRV6z39DeA4axqW2lNIPDu54nztBRouELgFmszUaBF
 Hxp/TrdBhx352nQh+jBj37RA7sPaWckW1zfTtp3lGuG5w/QQbteehMZUr6ZHmQClSe0HhHE
 h6ZEBJS7X4LwRNLfvc/vachUjwLDXVcbVt/bBCOjvcMwJOLEE49okhqsMiC5unbYaWsZcFV
 TDg6EdQdZ/6t0SOvBQM3g==
UI-OutboundReport: notjunk:1;M01:P0:XuauyZXjj4g=;Ex7yATVTFt+De4YPVdosrs6YTWy
 9RTnhWutFuZVHTgC3/ShbhQ9sB92rjVsKWFsAhIqAH+57VO8hUHZvqbOsC+YKKOxCpIfX6ncr
 4n4qPiA+mUW4L1SBNojtHN3UNH3qmYegmaR37wBfUs8JQTRBsSnFJIkD4uKnvX38fHcYl4PgK
 fOED2OdsNATHIU2T7T0Dlthul3X+vjMsN/MaGBfbi1VpjCCMXsofoLF+TbEExPZLYhRaKV4O4
 Vk3+IwDXYP1HnD9+8elEcCAqGXDTknukvFnlJ1x1J4N+i8jNquSlPqf/OPCXz+g3270hwLvlL
 BYi7+KE7MSmX83msfHZ4b1lgAw/ZSst3WBehkU9BIgWaMQcOOt/Mf9pTIao1h7qVJbWxFpY8T
 A1nojOhh8H6h4mZyPVZ34M4+kYcZKb5oti9ISExhuPKfFefCxtBv9XtmoTGySIi3PGiweC2ON
 k0sRDYWQindDK3jTS1VDaAZBUyDmahk4gn9u3/j9NPf4FARmXWU14KAY29MqCezWPnwZD59/7
 ko2b17rA1mxa1HU4XT7uJq1KOuwYcVX24QCJbNHZQHws/8DetLUFu26/PlGvPoFl2zZB8Prcz
 5YoNdqsSe2mRRDSZUEABGYfT6RkJ0HT9udcCrALS5PwMl8zZB4FE3wHqmb9wivuKZ+cyRIOUj
 uOugPnPFq2SL1aNUfxLQuHtEDDMAcTLnQku9rr/82reomSLJ+gdhLV0NgnG/gus6InvvNBFLB
 PslQhXPx02KbcKaJvrpqIylzDU8i/H9ewiAMnWvJrd+Csd2iE2eCCrUcSzL9LNdjW1I0RINRW
 EmVZhLM9etGJGrFAi4fJ2pD1Bk9AHXBKBwN6AziJUVelO3q3OhugF8/v9YKPrqAS9i2msKuUh
 ToEhRn/Lj2OioCr8y1v1t5L5rgioY0cK26ZIj0X84i5cBILoYIqXt62m0wH0hG+8ns3GNuMYJ
 iPxFX6WCWZkpiH21bT+phAkAJ6lVqWSghnPFm4w3ik5gZTxq/3yjuBjekR1G0y8B6auV0wi9+
 Cbkc97tQsV3V3GfL1OZ6c7RoJfOj0DswgdwwRuNrHuSWEOUf5A0og60rhbBxOsOo2u8PF9qhY
 /BtKQbeS/D8ur8WMBovd9kftGVYBTGn3C2vOFPHlc7hSY6Wfm1DB2jnz0wvIqNs9G3dhgpO5P
 SjyPJqVG3jBdpa3wsZY/MwlQu15nr6kYL0fO4to/nsYE2FW9gas94fhJjy1PgsETLZmTc48gO
 Ado8VpWpIL4Ztpqgd+hLjQBdFvsJwDWcbkvUnIolqulSPiMHczViHIltBzZD8YEk4oR8+6AwD
 0Yh8MKQGuZarv8a6kz/thWhWpP9q5jwVIpJbvInO1Z9oYFT6Tdls6AoX+ERwQ4IR+jmI33Gef
 BaqNKv4A3sCbzyY8j3c5jL2klW1UnZDyQZm2NPa70qWFrHlVgdmBqTfjI2IQVP5GdmH7nCM92
 4WkM8FmmHQOxlDsVhIeiB1h/4hZg=
Subject: [cocci] [RFC] Extending usage of attribute =?UTF-8?Q?=E2=80=9C=5F?=
 =?UTF-8?Q?=5Ffree=E2=80=9D?= (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2428
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/04032bab-ad6f-4ef1-9600-27554233b9a1%40web.de>

Hello,

Various software extensions were developed based on the programming langua=
ge =E2=80=9CC=E2=80=9D.

* Object-oriented software development became supported with some programm=
ing languages.

* Scope-based resource management became also supported for Linux componen=
ts
  to some degree.
  See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
  Introduce __cleanup() based infrastructure") from 2023-06-26.
  Some contributors are still struggling with corresponding collateral evo=
lution.

  But a well-known source code cross-referencer can point out that an iden=
tifier
  like =E2=80=9C__free=E2=80=9D is used in 281 source files so far.
  https://elixir.bootlin.com/linux/v6.14-rc3/A/ident/__free

  See also a previous presentation of analysis results:
  https://lore.kernel.org/cocci/e8bf7b33-01da-43fb-b71e-cd86a02be2e6@web.d=
e/
  https://sympa.inria.fr/sympa/arc/cocci/2024-10/msg00011.html
  https://lkml.org/lkml/2024/10/17/1393

  Thus there can be a need to adapt advice which can be offered also by
  coccicheck scripts.
  Example:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
scripts/coccinelle/free/put_device.cocci?h=3Dv6.14-rc3#n2

  The attribute =E2=80=9C__free=E2=80=9D belongs to properties of variable=
 definitions.
  Source code search approaches can eventually be adjusted also by the mea=
ns of
  the semantic patch language.
  Corresponding software run time characteristics might become more intere=
sting.
  How will development interests evolve accordingly?


Regards,
Markus
