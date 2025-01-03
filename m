Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD03AE77188
	for <cocci@archiver.kernel.org>; Fri,  3 Jan 2025 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HFnJ2wDNzDvphwqZ6pRVNwOJ7NUtIxFcbrBancnjrW0=;
  b=CJNhLbSS59X1rMB3WqIEaJKnW6H8xxy9hG9FVdZicjWK+dEVf/yV+Mgh
   KnWXDxfnrbkqljJg6m5G7cnk7HdgIYksBEZYiAerTRLvpJhWdIP/xYNc+
   7ZYaRtGU+YcP3IvLpU8aCzX7U7q4Z5xiCXuwCcv9bU38lB9HZycuIgozf
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.12,286,1728943200"; 
   d="scan'208,217";a="201319861"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jan 2025 11:48:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48E46E0D1D; Fri,  3 Jan 2025 11:48:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 980BAE0077
	for <cocci@sympa.inria.fr>; Fri,  3 Jan 2025 11:48:57 +0100 (CET)
IronPort-SDR: 6777c098_eV6jUBxlqoviH24V/S90x/r1qGwUYMCaCJhJxYvTz633+7T
 6k7/3FKvoTcL3xr19Qm5hG9Pguf2ZsFBGph+Emg==
X-IPAS-Result: =?us-ascii?q?A0EXBADHv3dngTKnVdFahE5SgVczBFOEVpFBhGuHO4tMi?=
 =?us-ascii?q?BY+DwEDAQwBQgIEAQEDBI9yAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEiGQcOO4V7DYJbgSxhAgUDOwEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCLHcRHQEbHgMSCQc3AiQRAQUBNwEBH?=
 =?us-ascii?q?oJfgjABAzEDAaUhgQVCiz6BFQUCFoEBgg0GgmnXcwoZKA1sA4FhAgcJAQqBN?=
 =?us-ascii?q?IR0KU4OgjgdASqBMgKICoEhD4FVRIE8glKFf4MOgmkEgjOCZTCDQIZcgyOJA?=
 =?us-ascii?q?YpXCAcfEgkcBgoCSwUQEgMEAwQEAQILCQoJAwMCDgIIAwIIBhkBPxIEEwoNC?=
 =?us-ascii?q?wcFHwgDBwwRCigDIhItDwNbBTQBCAIHAggCAgYDAgIEFAYDBQgDAgUFDQICC?=
 =?us-ascii?q?gIEAxUEBA8BAQIeAgYBAhABBwQBFAIKAwIFBgcCHAICAwMEBAMBBQMSAwsBB?=
 =?us-ascii?q?QYFAQEEDgECAQIBAQIDAw4CAgYCAgEJAgIBAQIUAQQDCAIFAwUDCgEBAQIBB?=
 =?us-ascii?q?AkEDQYDBQMDBwMEAgMCBgIEBAUCAgMDAgMBAwMCAQIDCRAPCQ8CAgMEAgYCA?=
 =?us-ascii?q?gEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDCQgBAgIHAQICAgMVAgUBB?=
 =?us-ascii?q?AkDAwUSDCADAgICAgMHCgMFAgEBAgQDAwMDCQ0HAgMBAgEDBQMBAgECCQMGA?=
 =?us-ascii?q?gIDAwUSGQUDAg8DAgEFBAIIEgsHAQEPFAUECQUVAwYCAwMWCwQFAwMDAQwPD?=
 =?us-ascii?q?gICCwMXBQEBBwEDDQgDBAQCAwMJAgEQAQMEAgkCBAECCgICAgICBAEBBQQCB?=
 =?us-ascii?q?AMCBQICAQgEAwMDDQQDCAgDBQMMEgICAgkCAwECAwMDBA0IHQUJEQsCCQMED?=
 =?us-ascii?q?QIEAgIBBgMGCgYGBAUGAQIYAgIGDAQDAwgDAgMCAgECAgIBEQICCQgNBQkFB?=
 =?us-ascii?q?gIXAwIDCAEJAw8DAhQBBgIIAwcBAQQCAgoRCgEBAgIBBicDAQECFBMHAwgCA?=
 =?us-ascii?q?gICBhYMAQUHAwcPBQUEAgIWAwMSBAQQAgIDAwIBARQGFQEFAgMGCwEGAQIFB?=
 =?us-ascii?q?AIDBAISAhEVAwMEBgMBAgwQAgQCCQoBBQQDBwUCHwMDAgIFCwIIAgIFAgUHA?=
 =?us-ascii?q?wkOAQIFAwQJAhQCEAICAgIIFwICAgUeAyYCBAMDAwMLAQICDgkDBDwGEwQCA?=
 =?us-ascii?q?wMCDgECAgsBAgIEAgMBBAcJAwMJCgcBCg0HAgIKCAkQAQICDwcDAgICAgYHD?=
 =?us-ascii?q?gMCEw8FBgYCCgcNCgMCAQICEwIDCQYDBQ0DBwQKDwIVAhYFAyACCAkLAgcOB?=
 =?us-ascii?q?QIFEgMOBQMCAhIEAgMGBQMBBwEXAwcIAgIMAgICAgUCBQIFGBEBDQQDAwMCC?=
 =?us-ascii?q?AEEFQYDCQgqHhIBAQEFAQkCAwIDBAgDAwMDAgMEDAsCAQcIAwMGCwgJBgMCB?=
 =?us-ascii?q?wgZAwUEAwcFCyECBgMCBAUEAQUCFQ0CAxkCBgMGFAsMAgYOCAkDBwEBAQICA?=
 =?us-ascii?q?ggBBQUSAgMEAgUEBAEBEgYCAQMCAgMEAgoBAgIKAggKAQkTBAMIAwMDAwMFA?=
 =?us-ascii?q?QECAgoEEwUFAgEFDBMMCQoGAwcDBAICAgsMHQIJAyMPAgELCQgTPQwHMgQ2A?=
 =?us-ascii?q?QkLFAcGJYEAmwIBChCBJoNnXyMTgXGUFgqLGadVNAeEHgWBWAYMn1wGDwQvl?=
 =?us-ascii?q?0STD5h8o2qFGQIKBwYRIxKBSSOBXDMaI4EBgjZPAxkPkhutcUI1PAIHAQoBA?=
 =?us-ascii?q?QMJhWmKRYFLAQE?=
IronPort-PHdr: A9a23:5vD4uhIkJ72l59+FCNmcuMdsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvLM01wOCBNSTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRhEiCCgbb58I
 xi6ohjdu80LioZ+N6g9zQfErXRPd+lK321kIk6dkQjh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q
 79FAjk4Km45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWTS+6
 qpgVRHlhDsbOzM/7WrajNF7gqBGrxK7vxFw343abo+aO/VwYK3Tfc4USHFbUcpNTSFMGJ+wY
 5UNAucHIO1Wr5P9p1wLrRamAgejHv/vyiRVjXHz3K061fkuHhvG3AwkAtkDt3HUo8/pNKcJS
 +y1z6jIzTPeYPxM2Tf97JPFch8kof6WXLJwddDdxlUoFwPAl1idr5HuMDyJ2OoXqWeb8/ZgW
 vy1i24hswx8pjahytovh4TKm44Z11LJ+Th5zYs7OdG2R0B1bN2kHZdNqiyXOJZ6TM0mTmxru
 is21L8Lt5G5cSUJ1pkpyQDTZvqaeIaL+hLuTPidLSt8iX5/e7+yhwy+/VWhx+D+TMW50EpGo
 jJbntbWqnwByRne5dKdRfdg+0qtxDeC2g/N5uxBO084i7bXJpwkz7Eti5UfrFjMEyr4lUjyj
 6Kbd0Ap9va15OnpYbjro5GROJF6igz4L68jhMi/AfkjMggSQWeb4/my1Lzi/ELnWLhGkvs7m
 bTDvp/AP8QUvKu5DhdV0ok97xa/CC+r0NECknkGKFJJYRaHj4b0N13XLvD1Deuzj06jkDdsw
 PDGMbnhDYvXInffl7fheK5x609ayAUt0dBS/4xYBq0FLf7pWUL8tMbUAgI4PgG22erqCMlx2
 psbWW2VA6+ZNK3SsUWP5uIqO+SMYZUauCrmK/Q/5P7ujHk5lkIHcqmp2Zsac3+4HvF8LEWYZ
 XrgmMsOEWAPvgYmSuzlk0WNUSRPaHaqQ6I8+jY7BZq7AYvbXICinKSB3DunHp1Rfm1JFleMH
 mv0eIWFQPoMcyKTIsp5kjMeT7ShSokh1QuvtADg0bZnIPDUqWUkssfo09N+5sXSkwsz/Hp6F
 ZezyWaIGkR9gnhAZD4w0Kl/pQQpz16fyu57gvpUHNxXz/xMWwY+c5XbyropWJjJRgvdc4LRG
 x6dSdK8DGRpJjpQ69oHYkImXs6nkgiGxC2yRbkci72MApUwtKPaxXn4YchnmD7dzKd0qV4gT
 4NUMHG+wLZl/l3WDpLS1UaYkaqjdaA00yvE9WPFxm2L7wlDSAAlaazeRjgEY1fO69Hw50fMV
 birXLEuLhAHys+EJqJKbvXmiFxHQLHoP9GNK3mplTKWAhCFjqiJcJKse2gZ23DFD1MYlgkI4
 XucHQ03ByPkp2yHSTIzTRTgZETj9eQ4o3S+JqMt5yeNaUApl7+8+xpOwOeZV+tWxbUc/iEot
 zRzGl+5mdPQEduJ4QR7Lu1aZpsm7VFL2Hi81UQ1N4G8L61kml8Vchhm90Lo2RJtD4xckM8s5
 Ho0xQt2IKic3RtPbTSdlZz3P7TWLCH18nXNI+bT003FltWX/KsG6PAQpFDqvQXvHU0nsj1m3
 9RTz3qA98DSFgNBNPC5Gk0z9hV8u/Tbenxnv9KShSAqaPfr9GKaiLdLTKM/xx2tfslSKvaBH
 Q72SIgBAtS2bfctgx6vZw4FO+Zb8Og1Odmnfr2Iwv3OXq4okTS4gGBA+I043FiL8n82T+fUx
 NAGwveU1wuDfzj5hVal9MvwnMoXAFNaVnr60iXiCINLM+d3dJoQT2SvJcG+xtFWiJvkWnoe/
 1mmTQBjuofhaV+ZaFrz2hdV3EIcrCm8mCe2+DdzlikgsquV2CGmL/3KTBMcISYLQWBjiQypO
 o2ol5UBW1DuaQE1lRyj7EK8xq5Bpa05IXOBCUtPeiH3KSllXM7S/vKHatJUrpAptyleUOCUb
 lWTS7q7qBwfmy/uBGpRwjkneiri4M2o2UwnzjvDczAu9DLQYoloyA3a5cDASPI0vHJOXyR+h
 TTNRxC9M9Sv4dSIhsLGu+G6WXimU84bei3qwIWc8SqjsDcyUFvvwrbqxIKhTFBptE2zn8NnX
 ijJshvmN4zi1qDhdPliYlEtH1jkrcxzBoB5lII0wpAWw3kTwJuPrh9l2S/+N8tW3aXmYT8DX
 zkOlpTQ6RT+nk5iKH6Ax4bRWXCUw88nbN6/KDBzuGp1/4VRBaGY4aYR1y58vkH+rgPXbfF9m
 h8SzPIv7DgRhORD629Phm2NR7sVG0dfJynlkR+Fusu/oKtgb2GqabGs1UB6kIPpHPSYrwpbQ
 nq8ZoY6EHo68JBkKFyVmi6WiMmsaJzKYNkUrBHRjxrQk70fNscqjvRTzSt/ZTCm4Dt8mrZ91
 0Axm8n95tTPKn0xrvzlREQDbXusOZtVona03MM81o6Xx9z9QMsnQ21RGsOuFbXySHoTrai1a
 VjISmFt7CfDX+KYR1fX6V86/S2VVcn3cSjGfj9BiowyIXvVbE1H3FJLAHNjxMN/Tkbyg5W/O
 EZhumJIvg6+80QTjLIub16lCy/evFv6M2hvDsHOcFwOqFkFvhmwU4TW7/ovTXsAr9vx8UrUc
 DzdP0MRUikIQhDWXQm9eOT+o4CRqa7AQbPvZ/rWPefU8LIYDazZg8n1lNMhpmfpVI3HKHBmC
 7dTNlNre3d/FoyZnjwOT3dSjCfRd4uAow/6/CRrr8e5+fCtWQT15ILJBaEAedNoswu7h6uOL
 YvyzG5wNCpY25UQxHTJ1KlX3VgcjDtrfiWsFrJIvDDETabZkKtaRxABbCY7OMxN5qM6lg5DX
 KyTwsvyzaJ9h+UpBk1tUFXgnoSta5VPLTzlclzAA0mPOfKNIjiKi8D7bKWgSKFB2eVZsxrj3
 FTTW0TnPzmFi3zoT0X1abAK3HzdZUIB/tzlIXMPQSD5QdnrawO2KopyhDwymvgvg2/ScHUbK
 X56el9MqbuZ6WVZhO9+EipP9CkAT6HMliCH4u3fMptTv+FsB3E+kutG+zI5yr1Z5SFAbPNwk
 SrW6NVpphv194vHgioiSxdIpjtR0ciTul5+PKzC6pRacXPN/RZI6WvJThpX/51qDdrgv60Ww
 d/K3vGWSn8K45ff+s0SANLRIcSMPS86MBbnLzXTCRMMUT+hMWy3b611lfiT8jiRoMF/pMW03
 pUJTbBfWRo+EfZIUiyN+fQNJZ52WnUvlrvJ1KbgClKxqRDQQINRuZWVD5qv
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DorcVq4M+eWElw2J4gPXwObXdLJyesId70hD6qkDc20sTiX4rb
 HNoB1/73XJYVkqKRUdcLy7SdK9qBDnhPlICOsqTNKftWDd0QPCXeJfBOPZowEIcBeOjNK1u5
 0QCpSWROeAa2RSvILV5E2XHb8br+VvM5rFuQ4d9RpQpM1RBZ2IJj0ZNjqm
X-Talos-CUID: 9a23:HM1JaGF0tYDhfMH0qmJXqUAzJeIfMUHxxUrIIX6+FjdFU+esHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A0yyYzw23+/uFK7NDwz0sCEaMezUjypWuU29Vsa8?=
 =?us-ascii?q?/i/K7HgJSKzG2oC2yTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728943200"; 
   d="scan'208,217";a="105433336"
X-MGA-submission: =?us-ascii?q?MDHXw87hV685kL+CTQn6EDHWkHp6wDgKgequ8w?=
 =?us-ascii?q?kMycVPmeI7FHGOGihDo3y78PyU3ZeUZMQQ/KtfmnI29tc7r3aJDgyZ/z?=
 =?us-ascii?q?NspyIsf3AZkg0q2zV++UKtR3dFNmyL7vTJI1OE8xtkZ6TBOVy6VpkNv9?=
 =?us-ascii?q?mFArt5d/KROQnSsb/ETN+W+g=3D=3D?=
Received: from mail-lf1-f50.google.com ([209.85.167.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 11:48:56 +0100
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so11658146e87.1
        for <cocci@inria.fr>; Fri, 03 Jan 2025 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735901335; x=1736506135; darn=inria.fr;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HFnJ2wDNzDvphwqZ6pRVNwOJ7NUtIxFcbrBancnjrW0=;
        b=fDfDq9Ks7W+vMXy4mNK4MG3Q9s1EScir/4LY+4Eih+W6wrucb+8A05g65446hYgsyv
         zcuRbgv/yqSqQxL/zcPf/c4NwOE7L411u31M9eDkwuuFh1dzZcMqAstdhZobcRCF3b1x
         wN/W6Q2At80ZlIdhCQnN5ppQ6H2kBdT4j3+FalPCuv10AY4FqV9FDgWhI2dOKAA0HRWi
         kE2KdTm73yojD2xHl+cnnnM0j/u69VJYN0Srdo/OOBB/CUFrQT8w/IldcYChEPjsoJtb
         soSLgV4Ks2mZr83wcUAht88fxASxz6hPagkuC2MKp7WwOlNn8BvkX36XJ6AOrpoLm/RR
         2R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735901335; x=1736506135;
        h=subject:from:content-language:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFnJ2wDNzDvphwqZ6pRVNwOJ7NUtIxFcbrBancnjrW0=;
        b=oArhG52i2AREETpL8nq6oeeyygR2wtJG+nU4G8WV42xxnd69yJPlAm+LXeONYFhtxp
         0p4ft0JOszzJ1VFV2NHqtdCQ23OfSF/6pV0U3A4yy+ZhzH59bsP4NJqMtUbZkOgEc9QO
         H81Jwbc7NvmxLxyzaKaO9UDskIMe/C76IDP6pKQScYutwYhedNjoJP3UmslZBlDAH2sO
         r5VwAwsXd/lm0HqcRlkvLYuxL0MZKVMVA9jeQUqSXuPWus0G7FKSHh540cUmWagby+wo
         ARFRlnK+SmZ2w8QEXhzsk59HDs6jcS5KpAotNFj/NRbVSmrJP1ZUwnk8x8l9564HIxqY
         lWyQ==
X-Gm-Message-State: AOJu0YxRggXI9WKHmm2S+YhFwzp0gUw+HAa4nvIMeRmOSfx9RUihNuQT
	ueY5Vq1JX/Yslfz9QAC19FuUtrzWWIt8TwzTmXUZS09GaqBI+riNtLb0Ug==
X-Gm-Gg: ASbGnctbTLl4J5aqCtU+m1RWM30UTWfluM10NCigiwI7GnkQrjJHQMGqK3r4SnRC0gK
	K3stzG5/YI7CL6n012BTpELrdf2OR9P4tMtiAFR7B8JEduqa9AvdOTj74ccb73UhsXyQC9bOo1O
	GgqmoJ2Y+Xi/Y9NTOinVCKO3AqTEomMKi7DheAKJ0hLX4E+wD/PCYOeIMdJg+JceOqdnF3JAhJ/
	P5GWCjLoQOvcwl1cyq6gb9BHD9xFAn7DQNcSISfmOEsIMV9InO18Cc12gV+zRo3x7aAG9egxITl
	CF77n2Yw3seqoaPBZnUnJVjY+RSk6Q==
X-Google-Smtp-Source: AGHT+IFf9WU3VI9L08ZEvl9wY6nJ3vU5TqNXnRTzIX9AGKic60IskcgVr5E/SWi44K9Wi6blkvBMcw==
X-Received: by 2002:a05:6512:b0f:b0:542:2141:2ccc with SMTP id 2adb3069b0e04-54229450ab9mr14622701e87.15.1735901335135;
        Fri, 03 Jan 2025 02:48:55 -0800 (PST)
Received: from ?IPV6:2a02:aa1:1642:a207:dd1c:3986:2d38:3ef? ([2a02:aa1:1642:a207:dd1c:3986:2d38:3ef])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238135f9sm4178791e87.117.2025.01.03.02.48.54
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 02:48:54 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------Ac8UW6YGlyaju4xSNwme0SYf"
Message-ID: <3938a0d1-64c6-438f-a689-2714da8cf0b6@gmail.com>
Date: Fri, 3 Jan 2025 11:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
Subject: [cocci] Matching and replacing array types in sizeof()
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2195
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/3938a0d1-64c6-438f-a689-2714da8cf0b6%40gmail.com>

This is a multi-part message in MIME format.
--------------Ac8UW6YGlyaju4xSNwme0SYf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

Here is yet another problem I ran into.

I would like to replace malloc() of an array with calloc() instead, but 
I cannot match the array type in this code:

    #include <stdlib.h>
    #include <string.h>

    int main() {
       int* mem = malloc(sizeof(int[2]));
       memset(mem, 1, sizeof(int[2]));
    }

I tried with this semantic patch:

    @@
    type T;
    constant C;
    @@
    - malloc(sizeof(T[C]))
    + calloc(C, sizeof(T))

But it gives a parse error:

    mats@abzu:~/lang/cocci/tests$ spatch --debug --cocci-file
    array_type.cocci code
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    -----------------------------------------------------------------------
    processing semantic patch file: array_type.cocci
    with isos from: /usr/lib/coccinelle/standard.iso
    -----------------------------------------------------------------------
    @@
    type T;
    constant C;
    @@
    - malloc(sizeof(T[C]))
    + calloc(C, sizeof(T))

    minus: parse error:
      File "array_type.cocci", line 5, column 17, charpos = 43
      around = '[',
      whole content = - malloc(sizeof(T[C]))

I have also tried replacing the "T[C]" with "(T)[C]" and even tried just 
matching "T[...]" and "(T)[...]" in the hope that the parser is just not 
able to handle the type, no no avail.

This parses fine in a normal compiler, so I suspect the Cocci parser is 
missing this case (looking at the code I see nothing similar to the 
direct-abstract-declarator from the C99 standard), so are there any 
alternative way to deal with this?

Best wishes,
Mats Kindahl

--------------Ac8UW6YGlyaju4xSNwme0SYf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi again,</p>
    <p>Here is yet another problem I ran into.</p>
    <p>I would like to replace malloc() of an array with calloc()
      instead, but I cannot match the array type in this code:</p>
    <blockquote>
      <p><font face="monospace">#include &lt;stdlib.h&gt;<br>
          #include &lt;string.h&gt;<br>
          <br>
          int main() {<br>
            int* mem = malloc(sizeof(int[2]));<br>
            memset(mem, 1, sizeof(int[2]));<br>
          }</font><br>
      </p>
    </blockquote>
    <p>I tried with this semantic patch:</p>
    <blockquote>
      <p><font face="monospace">@@<br>
          type T;<br>
          constant C;<br>
          @@<br>
          - malloc(sizeof(T[C]))<br>
          + calloc(C, sizeof(T))</font><br>
      </p>
    </blockquote>
    <p>But it gives a parse error:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/tests</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch
            --debug --cocci-file array_type.cocci code
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
-----------------------------------------------------------------------
          <br>
          processing semantic patch file: array_type.cocci
          <br>
          with isos from: /usr/lib/coccinelle/standard.iso
          <br>
-----------------------------------------------------------------------
          <br>
          @@
          <br>
          type T;
          <br>
          constant C;
          <br>
          @@
          <br>
          - malloc(sizeof(T[C]))
          <br>
          + calloc(C, sizeof(T))
          <br>
          <br>
          minus: parse error:  <br>
           File "array_type.cocci", line 5, column 17, charpos = 43
          <br>
           around = '[',
          <br>
           whole content = - malloc(sizeof(T[C]))<br>
        </span></p>
    </blockquote>
    <p>I have also tried replacing the "T[C]" with "(T)[C]" and even
      tried just matching "T[...]" and "(T)[...]" in the hope that the
      parser is just not able to handle the type, no no avail.<span
        style="font-family:monospace"><br>
      </span></p>
    <p>This parses fine in a normal compiler, so I suspect the Cocci
      parser is missing this case (looking at the code I see nothing
      similar to the direct-abstract-declarator from the C99 standard),
      so are there any alternative way to deal with this?<br>
    </p>
    <p>Best wishes,<br>
      Mats Kindahl<span style="font-family:monospace"><br>
      </span></p>
  </body>
</html>

--------------Ac8UW6YGlyaju4xSNwme0SYf--
