Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F2C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Fx2PvW1vnbtKBJHl0DGshYhQo+DOVDzf3oIV2q8o+Us=;
  b=SnmHPSJmeuM+CSNLkHGKEHjLkB1bR+3CtVsx4lfnJfL49DY0BhUISCVA
   Xb8zbqdNU39OJbon300bKsWx7+TVsybiR2teOEu0E9J1qbHCvfDYPG9pe
   Gpy9+LB9WJcEiGOY01n/qx75RIC9MNKMXY9gOipRiw+6jLWD+X/pmFNNe
   Q=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145859665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 12:52:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72C03E0CD0; Wed, 10 Jan 2024 12:52:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5BB46E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 12:52:20 +0100 (CET)
IronPort-SDR: 659e84f4_oEphF4r0Vg0W1yZuEV73LslSmktdhPOCuTCSlWzOVw1aMo2
 30B8H+FNMTe0J+X4q6zdZTp3jpxTyAkv59ihxAA==
X-IPAS-Result: =?us-ascii?q?A0GwBABUhJ5l/wsR49RaHgEBCxIMQIFEC4I5B3VWMgQLS?=
 =?us-ascii?q?IRTkTYwhDuPAYRrhASBVoFAPg8BAwENOwYBAgQBAQMDAYR/Aoc9Ah4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglUYgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06Q?=
 =?us-ascii?q?gEEASMdAQERJgEECwsaAiYCAlYGARICAQGCfAGCKgEDDiMHDQa1doEygQGCC?=
 =?us-ascii?q?gEBBoFFAgwCQ06sch8sIlaBYAMGgRouiBsBhWeDQXonD4FVRIE8C4J4PoJhA?=
 =?us-ascii?q?4U6gmiFXJAiUn8dA4EFBFwPGw8eNxEQEw0DCG4dAjE8AwUDBDIKHAshBVUDQ?=
 =?us-ascii?q?AZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOwMDBgMKMQMwVUIMUANlH?=
 =?us-ascii?q?zIJPAsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJCyYDKgY4AhIMBgYJXSYHD?=
 =?us-ascii?q?wkEJQMIBAMrKQMjdBEDBAoDFAcLB3uBFwMZKx1AAgELbT01BgMLGwY9ApUqA?=
 =?us-ascii?q?YNyAoITpC2hCzQHgjSBYIFhDIoYlRMGEy+DbgGTNw4GklQuh1CQTyCLVIF2m?=
 =?us-ascii?q?nyBagQygVkzGiSDNk8DGQ+OIIQrgQuDVopmQDUCOQIHCwEBAwmFRgEBg1qBR?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:j9vyi6zK28t3DRoym096t+dSwyrEfRIJ4+MujC+fZmUNrF6WrkUPn
 GBMUTrTMvbZM2L3LtB1boy1pEJXv5fVzINlSgI4qFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjg2Ic3l48sfrZ9Es25ayq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFP36Pt3InsOJ7Q1xf1yWDhL8
 N4nJXc0O0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YBtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QE9QLI9PRqvQA/yiRY64rhKdOKd+DQVOt8xmu/+
 nje9nnAV0Ry2Nu3jGDtHmiXruTIlij6cJkDEaWxsP9smlyagGIJYCD6TnO+puSlzFGzUZRTJ
 iT45xYTkET7z2TzJvGVYvFyiCTsUsc0CoQOQd4pohqA0LTV6Au/D20JBGwJIt8/ucN8AXRg2
 laVlpm7TXZioZ+Ee0K7r720lDKVPTRKDGkgYSRfcxAJzeO+q64OjzXObO1ZLoiLsvPPFwrd/
 RW2vQklprBKjcc0x6Sxpl/GpDS3p6n2dA0+5ySJf2f88A9JXZOpPbKpzV3h6ddBM4erYV2Tt
 1cUm8Wlzb4vDLPcsAevUekyDLWSyPLdCwLlgHlrBIsE2wW23myKJKR8wWhZCh9yE8AmfTTJX
 hfiiTlJ7sUOAErwPL5FXY2hLu8Lk47iLI3BfdLJZINsZpNRSle2zBt2bxTN41G3wVkeqoBhC
 5K1as32MG07D55gxz+IR+sw978n6yQ95GHLT6DA0BWV/uuCVUGRVIs6HgOCXsIh4IOAhTflw
 dJVGs+J6hdYCcnVQC3c96wNJlErc1k/I73LqPJsS+3SGTo+RVkdCMLQz4gxJK1jvaBezdnT8
 l+HB0R39VvYhF/8EzusVExNUr3VYMtAnSoJBhB0ZVeM8Fo/ULmr95YaJscWf6F41elNzsxUb
 vgieufbMMtuVwboxjU5Rrv+pbxEax6Eq1+vPS2kQT5nZL9mZVXD1eHFdzvV1hslL3SIp+4hh
 Ya/xyXnQZYnbCZzPvb8Mf6A4Qu4gikApbhUQUDNHOh2RGzt14pbcwrKkf49JpA3GyXpnze1+
 V6fPkYFmLPrvYQwzdjugJKEpaePF89VPBJTP0vf3IaMGRjqxEiR6q4eb7/QZhHYbn3+x4u6b
 +YMz/3cDuwOrGwXj6VCSYRU3YAMzPqxgYRFzzZUPmTBNHWqLbJCHkOo/+dyso91+7sInjfuB
 2yu/IFBNKSrKfHVNgcbBDAYY9Sp0dAWnTjv7soJHnjq2R8v/Je6VRR9Ahrdrg1cM7p/D609y
 8gDpsM9ylKymzgqAPm8nwFW8GWAdEIBd6AdsrAbH47ZpQ45wX5SYZHnK3HX4bPeT/5uI0UVM
 juvq66avItlx23GaGgWOUXW+Ohg2aQ1pxFByWEdK2SzmtbqguE92DtT+28VSjt54wpm0eUpH
 ERWLGxweLuz+gl3iPh5X2yDHx9LADub8BfTz3oLjGjocFm6ZFfSLWESOfe/w25ByjhyJgNkx
 bC/zHrpdR3If8urhys7ZhNDmszZFNd08lXPpdCjE8G7BKIFWDvCgJK1RG82uhDiUNIQhkrGm
 LFQx9xOS5bHbAwen65qLLOh9+UgeEjRbigKC/Rs57gAEmzgaSm/k2rGYVy4fsRWYefG6wmkA
 shpPdhCTAm6yD3IlD0AGKoQOPVhqZbFPjbZlm/DfgbqcodzrwaFdLrV8TXiwnAmSZNinK7R7
 28Xmy2qSgStabl8wgchb/Wo/kKnbNNCaACUMCWd7rASD5xa2A1zWRha71Z31kl59CN48hjSs
 A6ri2o6CQB94dwEorYA2Zmvy+l5xR0fmQhIHM2OXwxyUO7y
IronPort-HdrOrdr: A9a23:2IbJvqg7rZsAHkwGLx7p/tA1ZHBQXs8ji2hC6mlwRA09TyX4rb
 HNoB1/73XJYVkqNE3I9ervBED4ewK4yXcX2/hzAV7BZmTbUQKTRelfBO3ZogEIcxeUygc378
 hdmsZFaOHNMQ==
X-Talos-CUID: 9a23:e5I3z2GHYaWt3D6NqmJ830ANNPodaETw82zVeha9DERWRfqsHAo=
X-Talos-MUID: 9a23:M/ifpwSDG9xsI+YVRXTFvwNuLc437pj0GW4kybgh59OcPDFJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145859656"
X-MGA-submission: =?us-ascii?q?MDEKT/KHAb5PDN3xWKXHeRsxbg01Br9MUD3rZ+?=
 =?us-ascii?q?RW4JcpOK5XqTWELgfWGW66Y7LfuhCNCd0qs2ytZgHPhnMK3ZJuOLZ5UT?=
 =?us-ascii?q?WFRLf/XGPgyM35HHZ9T3wbJMMYFQAkv4wAcCFDPNKBRwDDbuoP7qxWQv?=
 =?us-ascii?q?q9x0HASu1czXwJFB9emqB+4w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:52:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887531; x=1705492331; i=markus.elfring@web.de;
	bh=Fx2PvW1vnbtKBJHl0DGshYhQo+DOVDzf3oIV2q8o+Us=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=iY327sZQGe5qfkwc/wAg5TLNCJODecJQWoqVMWlHS+jHUVxj40EZeG6yJrbw18jp
	 oLdzXWf7xtREx6O3Heur+sbLV3UR+Rd1vYuRElckzGOQJci8uJGTU10s9rGr8Qe5o
	 btSLPc6B8miFN7eN6wvvkS/xXGA/pEEyvopP9pV7tjXY0RIF4aHCT776uiJYYARaF
	 CKnRkLdBMz8kHV/ra9ZpEZcXXoola790E3YWAXEqSk7zHaUzda2qqO+fy24wwK3tO
	 bDhxALLyFSQYndThjMBl14IO0NhrXPafjmClY6KL19RgaYirJYTNzFjoDEH8Z5HCb
	 HaWVgz9yjXrdyKQERg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1rPWOO2Y39-00GN4U; Wed, 10
 Jan 2024 12:52:11 +0100
Message-ID: <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
Date: Wed, 10 Jan 2024 12:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
In-Reply-To: <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:78MVXJYGeOng5Nrg3pXzSH+pVQlPJscZCzkpuAXP/MvbNNfr0oY
 hmvsMBZKJ0iy/FbSLADC1sBQEH8yjRPkcUZwXzLAz3Q5pKyWNPmHyf9wCzi+mtVmWICpr6Q
 TtJprGgbtOvAJ+yfZK7Im0NhDcxv5xLvskGTUxpY/Az4bVgqI007/YmuMvXMtc0DT3xTPW8
 L3rOLFTzEXPgpwbnObH0g==
UI-OutboundReport: notjunk:1;M01:P0:euQvSKxPaY4=;HxgieC7LrfEjUWt50KQoSpmEHI3
 bMmCqQHlYuxsGQUhwIWUcM2PuatrGd/zt1NU670VgRtoIsI/2l8xlRX8oo5+2W07e5yHVZS6c
 grTIxjmffp3W2UGa9mR+Dt08w1SN6DVtAlvzWy3BxdPbSCnKaMsqwV3YkzfbUFMtP2pJTfcFt
 e/vtfxORqS9gVGAnJRXTohuOUvM3YxSnZ94wTgpRpBlu4R1Uatq+UPB533uIf11LXZr3ufQxv
 gSm+WZSi0GJRg9WcCCaqD6LzxXbUFX/jWuDGya3tbDw7OD81DKpAJPEdTy3uVoXFa/H4uwr20
 tUUn64IgGcGzT0oQa1qYQXlnthpdQQgnESmOGPg7S2kiPNnapTZOAbq9RFZ/A52OqQWPfW8vE
 Ph9KIjVUYwjGKPFDYR4nm+lGYEKBSF5I7a+c3rcNxmkrQ9h0G2Cd8vyiA+wpHAhGG3/+AwNMM
 dhtIhZ5JA0SxXQeCKWcryE/qVifHVCbIBeEIBElc4EjBpetwWG3miahd24cGPB8RZfasVwOdi
 nevnNiM/IjyjD+Kp5U4M0JlPGCOlqeYprLqiJ8P6fcir47ocY8jBRbn7cD9PQKcwNhgnCMWqI
 iRHYCJzipnt0tQRDBNmasAHLftZPBNxV7sdljfanfpcegs+Qc/k+VYmisMQmgXJ3ZsmLgUJQ8
 3yi1DFf0nRWQGhqzIjZdw5L5OFiSQZMTBExdnRKP+O6xEwEKsJYaZJXlIifejLBWUw8hXMMLo
 sYtjRCBVfKxtIETQG7vR8TK8d1Hrkv7gXErQ9PyJkor1T8P8pSiIp6xTYB68A7kETj3TgimVM
 lT3r5Zrmeu066nIE3qDqSx4le/ZmiSevUiP5lM3NrzrJy92iEQNmWNiIYp2wyuLBe3LLqnpyV
 cwBbeIJ7QWpVuKZEb2dTH0uKRMuTbSJT+6FMf0PXqJlvGwUW8bnhTXJzDVACmk4ryj3ao+c/M
 6vY0iRWMKJOOUKAkN8ru9J2XTso=
Subject: Re: [cocci] [0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1448
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/7dd19987-6590-4756-a929-1ff01503ad1c%40web.de>

> Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html

Regards,
Markus
