Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7CC61CE7
	for <cocci@archiver.kernel.org>; Wed, 11 Jun 2025 05:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=xXqaDA0dV3gapcLtBuDq9ZJ8tYw7eZn4CGJjwXJXJak=;
  b=W+O+Hd3DsxgrWAV0LRi5aB8Za7Qfn3plD8U3RValopoECIInCp3PYyb1
   1RyqwKBovJ/og2lSBOKivlWMcn3eiP140bsTJ2glSa+hSDDp1UrOwV9HC
   ydIqORSS7U1V5hkpZqPGaF/l8hHVtQaNA9Epr5xNdjdCaEK4/RhB4zoOQ
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.16,227,1744063200"; 
   d="scan'208";a="226212336"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Jun 2025 07:50:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5B83E02E4; Wed, 11 Jun 2025 07:50:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 425C9E0131
	for <cocci@sympa.inria.fr>; Wed, 11 Jun 2025 07:50:52 +0200 (CEST)
IronPort-SDR: 6849193b_kzAGt/OEK0WTSXC0gaV9VkvSN9IvkNVLvQaBK90eMgvp4HX
 wH9lTFVC1vGupkuy6zj8FKOSSAETITV4U1ZJkIQ==
X-IPAS-Result: =?us-ascii?q?A0HIBADaF0logAwR49RaHQEBAQEJARIBBQUBQIFTgkSBW?=
 =?us-ascii?q?jMEC0mEVY9QgiEDhDuHPIdTiHeDUgIPAQMBDU4BAgQBAQMEggyCagoCi2YCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxh?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIiAQYQAQMOJAexFYEygQGCDAEBBtpeHywiWIFlCYEbLoVtgmMBh?=
 =?us-ascii?q?ieEPCcPgVVEgTyCUjE+hAqEFIJpgiiBFo0Vh02MLlJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDKjQxIw88BS0dgg2FGR+Bc4FZAwMWDwGCJIFeHIM/gSOESStPgyKBf0wZQ?=
 =?us-ascii?q?YNhHgZyDwc2QAIBC209NwkLGwY9mHiDaQiBDQGBMEClZKFCNAeCOIFmgWQMn?=
 =?us-ascii?q?2gGEy+DcZNaDgaTApkEIqkWgX8jgVwzGiSDNk8DGQ+OIT6DdbcmQTU8AgcLA?=
 =?us-ascii?q?QEDCYVGAQGKTzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:IuKuq6v/QD/gC055b+IQRnWWSefnVJdaMUV32f8akzHdYApBsoF/q
 tZmKT3UaPyNa2D2ftAkOdvi/UoE68XVn4NgSwtrqSA1EXhDgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNtcpvlDs15K6v4G1B5wRnDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJFw3HZIp98B6PWsN3
 tkCdBUMcTOgntvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235om8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PNnvDGMklApuFTrGN/vJZvTf90MpBm/5
 WfI4TXiGSo/FMPKnFJp9Vr32r+XxnOkMG4IL5W8/+FjhFm71G0WAgcfE1q9u/iwzECkM/pUL
 Ecf+wI1vK0q/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsUz9hd+0rksIKT38B8
 0XVutL2Jh92iejAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqls13ojqf48ScaIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2HDwpJDSsgO+ZJgrBED3CFt56sy67HFzG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qGj8pi77Jt4LsGouTKuMDiriUWC2C
 KM0kVwOjKK/wFP3MvAnC25MI597lPm7S7wJqNiPN4IUMvCdizNrDAk1OR7IhDCy+KTduaA4P
 5CAOd2hZUv2+ow3pAdas9w1iOdxrghnnT27bcmik3yPj+DCDFbLE+ltGAXVNIgRsvjbyDg5B
 v4FZ6NmPT0FALWmOkE6MOc7cTg3EJTMLcqq85UOJ7bYeVUO9aNII6a5/I7NsrdNx8x9/tokN
 FnkMqOB4Auh2y/0Ok+RZ2p9abjie596oDhpdWYvJFukkTxrK4qm8K5VJdN9cKgF5d5T66d+b
 8AEXMGcXdVJaDDMoAoGYbfH8YdNSRWMhCC1BRSDXgQRRZBbajLsxs7FZSrqrSkHMTq2v5Axo
 pqmzQLqfqAATAVDUufTMeyj/2qssSIjmcZ3ZU/pI8ZSSmro4oNFOyz8td5pAsAueDHo5CqW6
 BaSOjgc/dLymo4S9MLboIy1tKK7OrJaMmsDOEeD9pewFy3R3lT78L96SOzSIAzsDjLlyputd
 cB+7q/aMsReuH1oroAlMbJg7Zxm1uvVv7UAkzhVRiTaXW+KVIFlDGKNh/RUl6t3wbRchwu6d
 2SP9vReOpSLIMnVK0EQFiV0ctW80ewopReK4cQXOEna4ApFzIiDW2hWPDiOj3V5B5lxO4UH3
 +wgmZA37yqStxkUCeuF3xtkrzm0En89Uqscps47Bq3vgVEV0V1sW8HXJRL3x5CtUO9yFHcWD
 AWav4f4vIQE9HH+KyIyMVPvwdtigY8/vUEW7V0aeHWMtNn3pt42+xxzqgYIbxln4ShG98lRO
 WFbEVJ/CovT3jVvhelFB3uNHSMYDjKn20XB8Xk7v0yHcFuNSUr2M3wbBeaB2Gs74lBsVGFX0
 5/AwVm0TAuwWt/62xUDfHJMqtvhfIRXzRLDksX2JPa1NcA2ThS9i5D/eFdSjQXsBP4wo0j1p
 eNK2uJUQo+jPA4yp5wLMaWr5Y4yejulelMbGepA+ZkXF17yYDuxgDiCC36gc/N3esDlzxWKN
 NxMFOluCTKFyye8nhIKD/UtIph1vsITyvgsR7fJHVMC4pyj9mdHkZSI7SXvpn4Zc/M3m+YHF
 47hXTajEGuRuHhqp1HwvPR0YlSfX91VSzD/jcaU8foIHa0tqOtDU18/+ZrqsmS3MDlIxQO1v
 gTCa/Xozshn84BNnpTtIIpHFQ6bOdP+b8XW0QGR4vBlT8LDDtfKjCwR8mLYBgVxOaADfvhKj
 pGPjYLH51zEt7MITGzpoZmNOK1X78GUXuAMEMbIAFRFvCmFAunA3gAi/j2mFJl3j99t3Mmra
 A+mYs+Wd9ROedN8xmVQWhdOASQmFKX7QafxlxyT983WJEAm7jXGC9e7+VvCT2JRLHYIMqKjL
 D7Ega+l49QAoblcABMBOepdPKZ5B13eQoojScz6sGiJL2uvg27agIDYqzgb1WjpBEWHQeHA2
 rCUdiimIV728OvNwcpCuoN/ggwPATwvyaMsd0Ya4Jhthyr8EGcCKv8HPI4bDo1P1Bb/z4z8e
 CqHeV5K5f8RhtiYWU6UDBXfsgaj6igmP9DkOno28knSZyre6EZsxld+3n8I3pu0UmKLICKbx
 RU25XD6eBS8qn2sbfhG/eS12I+L2duDrk/lOinBfwjaHBsUR7kHvJCk8MyhSgSfe/zweI73y
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:A0DDlaruo76gKCwGvrDTDpYaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:SB9kYm16fMTsfR5KaW8f6rxfB8EFbUzQ6nrsKQyTLHw1bbyKanyJwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AZeWn/A4trFcPCTDp1x5xt7q/xoxt2fvpUXoVyK9?=
 =?us-ascii?q?ZnIqBOzIhICymqRSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,227,1744063200"; 
   d="scan'208";a="118717640"
X-MGA-submission: =?us-ascii?q?MDF+umpgIkrgawSDYpTvhYisiGXYJuHnIMr4SJ?=
 =?us-ascii?q?IetazLnu58i2g7F3wNKSrR7xlq3pNaL2KPDk2oL3KrWXujXxLE93L+C9?=
 =?us-ascii?q?0oHaKfT/PEm2NZMKQlghSjn4fSkh41ImCtAxog22q19prmkDLjLps2Hr?=
 =?us-ascii?q?CFKK6RlMqV3usvbLwO1b0hnw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 07:50:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749621050; x=1750225850; i=markus.elfring@web.de;
	bh=xXqaDA0dV3gapcLtBuDq9ZJ8tYw7eZn4CGJjwXJXJak=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EqxPh9xi3IebkditieRCeRNhSZOcPvd56ScvFbLLqM6j6K/Wual4HyJeLZjLMYoS
	 JFhNeQ9Qy9WGx51bObuz77kN85eiwkMQHLkUbfGK/UcOMAukEeL2hh+1UBM0AR4NN
	 RY8ORM+PiW0CDRGBZJboHzzYbN/HDbOl8raZyO1xlHUnxvi290pa9VW+bSwhB0HDw
	 ETnHhhreIEdqEZvO/xLPnXTwIy/biyQQYoH624tGlh2y7SAbvd8xdDKuauSw6h5v6
	 Gl6me/K9G3xihgY/wwVivE/EC7e3JKTvn5otSiverHH5Fv7/MO4WwuR/mblsCbgFq
	 boqiY8As2pi8kED/Ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1uIBtE0JTK-00HpDl; Wed, 11
 Jun 2025 07:50:50 +0200
Message-ID: <aa3bb54e-a55f-48f9-b39f-e2261f8859b7@web.de>
Date: Wed, 11 Jun 2025 07:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
 <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
 <be43fd17-4386-4ddb-bb14-72d2d33d793a@web.de>
 <alpine.DEB.2.22.394.2506101850030.4658@hadrien>
 <3f9b8788-e9fb-4643-aee7-5ce5400e94e7@web.de>
 <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101925310.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:F1gLRl/N7H0Qjwcqvoke5VAPdx1GJjhjQMJEFcwdrJyuyy6+fdF
 JLMXV06THk3EUGgDXbvknXalckPVf5/mINuzpRkUBbB6TFverFNNTncMrn38NsVl9ovoHY3
 Kvr7aVcpY07yXy9ZbDd78hpf8/67ElnE8XUbEPMbT9wXQqg7ckQSc4EVKqq/jePr3aLWQHT
 2Kf7zBK180Q1J9m9p/GBw==
UI-OutboundReport: notjunk:1;M01:P0:ENcM3rUjwFo=;OANpUEIFGYyW3yi9CMyPiuOOXK9
 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
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2759
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/aa3bb54e-a55f-48f9-b39f-e2261f8859b7%40web.de>

>> I would appreciate to clarify if mentioned files would be completely accessible
>> for the shown source code transformation approach.
> The number 7675 is not going to help me understand what the problem is.

* Would you dare to check data processing results any more for different
  sizes of source file directory hierarchies?

* How will the set of processed files (and software run time characteristics)
  evolve further for the presented use case?


Regards,
Markus
