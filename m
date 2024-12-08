Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25674E77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yDt0BJe/EGJ7oQhwrI7QeaGN0O4Nde2cTKVlEu99+WM=;
  b=YpS6OjtwGX2pT7dHdk+fZu3FRnixoM/cLM6l8lFEWfpMH7maGYzpKtYO
   sJRJMYfg6By3xaZhbWIE/NPDGFqUYebrQyPWLUQeKhC9g58ELwnm4mxR4
   vb4o/TtMaP90accN7raud8iZLFuBSUMgQWficO7iwYlQQoVIjSlXyth8u
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197945673"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 13:08:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26338E0D1D; Sun,  8 Dec 2024 13:08:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA787E00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 13:08:04 +0100 (CET)
IronPort-SDR: 67558c24_fUzln9MSyIQiSnJrhgkSZ6B9xbGqwL0h7i3pWP/LDZ87pw8
 gLHoGTLFUveq5c5bBj1RKfhIYlAaZmJp+EV1qxQ==
X-IPAS-Result: =?us-ascii?q?A0EjBADci1VngAQP49RaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?IRWj02BdC0DhDuPEYh2g1QPAQMBDT0EAQIEAQEDAwGCDIJ0AoppAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBF4JmAYIvAQMOIwcNBq8hg?=
 =?us-ascii?q?TKBAYIMAQEGgVhB2EIfLCJXgWQDBoEaLoVrgmMBhiaEPCcPgVVEgTwLgng+g?=
 =?us-ascii?q?mEBA4Feg1uCaYJAhgloimyJMYd8UnscA1kyAVUTFwsHBYEpISwDMDszgguBW?=
 =?us-ascii?q?wU3R4JKaUs3Ag0CNoIkJFmCTYElBAWDaYELg16EWIYlghoVHUACAQttPTcJC?=
 =?us-ascii?q?xsGPZtiR4NRaFmBRVqNY4VZkAWibTQHgjiBZYFjDIooji2HBQYTL5dDDgaSe?=
 =?us-ascii?q?ph7Io1gmyiBfSSBXDMaJE+CZ08DGQ+OIYQtgQu9cUI1AgkxAgcBCgEBAwmFR?=
 =?us-ascii?q?gEBiwxqYQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:V7pnuaviVbjYVXcKQ8gvWmb/7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:zQu4QWBvEk63MQb6Ey9O/UhKJpk9SHfi3X7NIGaaLHZxc5TAHA==
X-Talos-MUID: 9a23:SZRP6gsNkYIWHII2Ps2nuzRdFe5EwK6SGWtcrs8pgvafCitCAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197945671"
X-MGA-submission: =?us-ascii?q?MDHtpdwkrVduKGXtS3FwM9FuMOlouc+Wrwilf+?=
 =?us-ascii?q?Kh5oNEkjifqEFEZFYaEvxSFUpVzA3OeuDod1N+8auiuET6nceGtpRbvR?=
 =?us-ascii?q?POzgfmRpnasaWmgVz6ssyVLIQBE0aXkKZzPRr5z6GOdy7oVs/HZ8rBAZ?=
 =?us-ascii?q?mWFb5jM8F90X0V+YEZdUIKqA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 13:08:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733659683; x=1734264483; i=markus.elfring@web.de;
	bh=yDt0BJe/EGJ7oQhwrI7QeaGN0O4Nde2cTKVlEu99+WM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vsIWw/NKW9d7BMvrVVEWSMLYf17xkltuwuXos/SFy0/yicjH9wLnsoX+UiBCRmTS
	 hfNUrkDXbU8Tq9x5vrk1vE3h2bjsR9pn/WAceAs09kGRU2L7Q0rxazfvMM5CN3okc
	 N31hpY6m9bhr0aNrS5LXXZteG2ErZgnysxM4Af9dacmE3iQyZkCXUNce9HJIlubYu
	 5lv36xVWFa7EPQgwzAe0ts+IV8w2nNzS95N/YHNiCmpdMQ193ZVvmv1922+DF9iHW
	 FAG30GhMSvFY9MDa2bX6C9C145WabeqXo1zfhi9XgH6XeunBVmbaYP52l9YuGlFv6
	 UmSavlALNEIN/ig/rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1t3HST1wgs-00PpUA; Sun, 08
 Dec 2024 13:08:03 +0100
Message-ID: <afe1c659-8524-4233-9631-1c22b4685464@web.de>
Date: Sun, 8 Dec 2024 13:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <ffbdf21e-3807-4a35-8f53-60957606c9e5@web.de>
 <CABQX2QONmtNAScz_-g0Cj3BRmDtoNyFfk-MSoTCMCbNa-FwpmA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QONmtNAScz_-g0Cj3BRmDtoNyFfk-MSoTCMCbNa-FwpmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rl0FVq+jHsVIHKLwANYeIz0P323uKfGZNnqpwocWTKbHxQWPauJ
 9P4ItK1i74mM/oECzYvVpSyzLjuRhgcnwpw+rKvvF0Rd+Ggb16G02+XaQi9YeDSYpl1+1kN
 MlyVV6FQWgn/z2WQlDpHquK7adOoddul/wnjB4kwFPSRuqWc2B7PcNlF69UDLDtXCliazKi
 chLwQ+a8r+vXUPCW++cOQ==
UI-OutboundReport: notjunk:1;M01:P0:zpnmwLvGdsY=;nDOMMO+Tdyn8W6th0FeyMn5Ah+L
 twLfi+YqJ9gSbmVnQjzyt5/sKyaEzwOsnk0FIhY4wl4bvAHy+Yjpf3kXrtBO4dh4yXM4emDEC
 NalVln1tSZtKOYtaqTNEXLmhaTXn97gs3nyEuzSVggd368iXUZuI4gVWTYGSwchjt3aTpl/wT
 fnjCowh6N4X37fIOqh7bQq5k4qFtm6cYEFkd2h7tSj9svfmCsy74ZahvHLDNjxFyLhLJwbv0s
 T60XSRnVf64WCWlBa2evAKQoDa1boCpFsgoF/lL31UYV9PQE9Y0Rg2gu4w1uGuCZvn0IF5zGi
 Wdli430iLwqMFT3vIggt9KixSQioi8LSUmxJTAevhokelB9octb3aaa/YmsCktoS0u9qZIpSx
 t/6flI6rdYi6eqFb+GCLrhzLWdhRSmo2l2Lnfj86OkTSmDkMekCq1hkZdtdZLd90WI+G6spwK
 79WYlV9GRyhnUYTGNzjPWMac3+IXuAlQitHfcOmCfV/uBZLKEP1+Y4jHuybhV/HQHMwxa4PoO
 VmkHcQAjEFXBjCPqNHbp+dYqsKxOjPZ/znA4zGThRtgFl4H+EVXsggbwat+H5SQRuh5u8CBqV
 1CFl1ynOtsGJes7eZbIyzuA4/BDvmlx5d3pN5qM7zn7CjetTdTUMiIOVFzy5c8kk7EAYa0r0T
 1tGTr7gGFSYcyoTglJhBVCRKV4n+sQZyy3Aoa9XTqTUDLK2NRJBsa3T+qXF/rJffg9Y27Jrdn
 97lKC7Pb1Xjr9nrzJZ7pfAH2FwgLczxQJBR9DpkBjqHkxYWTllWyvIjfxNDmzQG7JB/jZgGH3
 vlStB1xYqDrMWpj397EPZgo59wCeWYir6+c+L3V5qr5EsmXhMwEY+KjddwE2sgAZOwc+cO+9i
 UBOQDA9NUYhY+QjKHRIMkfBpVUceeUp4RVUF1WkZzZxUBsHiVoKWJbjGoVDglnc74UzVwCVYn
 8eMJtXNdIcfoxukuvgMVAGMLtr5C5PaA6LH43YHmPJY2uEzEVmxUQyAEp6UXE30sfZtjBN9cs
 o4ZEslQBZ4Ynwu2XnUWskOncp8OzHL1PF93k+qfYT4Zvp70d2PwotSGweXkD+lzYdyA48F5aX
 xqBCrW9a8=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2167
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/afe1c659-8524-4233-9631-1c22b4685464%40web.de>

>> Does anything hinder you to extend data processing for a source code se=
arch approach
>> like the following?
>>
>> @find@
>> identifier i;
>> parameter list pl;
>> type t;
>> @@
>>  t i(pl);
>
> Well, it's just that this isn't the problem.

Can such a source code search pattern demonstrate the beginning of
another solution approach?


>                                              The problem is not coming
> up with ways to match constructs,

This is a part of recurring development challenges.


>                                   it's coming up with a way to match
> constructs that could be overwritten from script.

The desired data processing should be extended accordingly.


>                                                   In this case I don't
> see how we'd convert every type and every parameter name in the
> parameter list (or how to create a subsequent replacement rule for
> identifier, type and parameter list).

Such an use case can be clarified further.
Corresponding software extensions might be needed to handle such
data input in more convenient ways.

By the way:
Will the development attention grow also for the application of
a function like =E2=80=9Cinclude_match=E2=80=9D?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca063=
810dbeacf6fdce08b95/docs/Coccilib.3cocci#L243
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/ff57802f2bd1ab1bca063=
810dbeacf6fdce08b95/python/python_documentation.md#L14

Regards,
Markus
