Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9148CCF9EB
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=YEHOhUcFHey16lyYcbORugfcWN4+Nzo1dgcZeTDky2k=;
  b=G6M6SOGFBy/iFIj3Vcl65BLamU9qKFelfHkaWGopgrXl6qCEjKpofwLd
   GSm3BswcL265B9C3r0wGhuVJ2w0w5UUlD5InBRppoNQPyIZa6nyo5ltHx
   jdVnNy+MZ5pxAUqQ2ZotBRUTXCUnJ+6X51/50drG0Drbz4QH6TyWvz8FN
   M=;
X-CSE-ConnectionGUID: x8dZIfcgTz2yOs72m2OU/w==
X-CSE-MsgGUID: W75G3XgVSc+7cnETC8rUhQ==
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
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246748173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 20:56:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CF7E0E0C55; Wed, 29 Oct 2025 20:56:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A25DDE0171
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 20:56:30 +0100 (CET)
X-CSE-ConnectionGUID: 0+8KFLMtQEOJocvy1G3nMg==
X-CSE-MsgGUID: Unedm0eURHuLq+OBajN62g==
IronPort-SDR: 6902716d_KlDisw6Z93oFWXePYNpCDMw4nsGH5/YsUUa0pR4Wmf+kQdB
 LdBgV1FHvmcFB2wolVN6zURBcT5JjePCbmnuvJA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GZAAALcAJpgwsR49RaHQEBAQEJARIBBQUBQIE9BwELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1KGX4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIIMgnSMV?=
 =?us-ascii?q?QIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QE6Bw4KMYZPDYJbgSyBJgEBAQEBAQEBAQEBAR0CR0YnHQEBESYBNAImAnMBA?=
 =?us-ascii?q?YJ+giMBBhABAzYHsgqBMoEBggwBAQbaXx8sIlmBZAmBHC4BhWyCShoBBW6Id?=
 =?us-ascii?q?4EhD4FVRIE8C4JAB4V/gw6CaYImgQ6GJ5I/gUocA1ksAVUTFwsHBYFjA4ELM?=
 =?us-ascii?q?jwyHYEkQRhxPVeDSSFoDwaBEoNTBokrD4kOAgELbT03CQsbBj2UN4NUNgGCc?=
 =?us-ascii?q?5MJKIMVr2w0B4I4gWeBZAyJCJZkBhMvl1IOBpMEAZkGo2iFWYFpATiBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hGSWDdcscQjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:kk03mxT3Z/n6oX2IyXUOh32r5tpsoqWVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODt7kd1baI6+igATVGvc3a9ihZMdRlbFwst4Y/p0QYGsmLCEn2frbBThcRO
 4BvcmEg1FyAdXZvJcDlelfJqWez5zNBUj/2NA5yO/inUtWK15f/2O+94YDcbBtVjzShf7xyM
 A+2rQLMvcUKnIduMKk8xxXHr3dSZ+hbymxkKU+Skhvz58q84INo/yBMt/487cJNXqv3cqoiQ
 bBEAjkqNn0+6dH2uxXEUQaA6XwQX3kMnBFVGQbF9hb6Xpnwsiv+qOVw3TSRMNP1Q74pRzms9
 r9nRhDwhigILjI07m7ZhNFogK1UvByuqRp/w5XJYI6OL/pxYrndfdIBSmVfWMtaSjFMDZm9b
 4sLCOoBIPpYoozgrFYAsReyGQ+hD/7pxzRVhHH5wLc63vwiHw/I0wMvEcwAvWrUotvoKKgcX
 vu4zLXRzTjZc/9axSnx5YrOfxs8of+MR7Vwcc/JxEcoDQzFlFaQqZH+PziI2eoNt2ab7/BhV
 eKphG4stgZ8rD+1ycc2iYnJm5kVxkrL+yV9zoY1P9y4SEh0YdO/HppfqTqVO5FrTcw8Wmxlv
 jsxxbIat5ChZicK1IgnyADFa/yBa4WE/BztWPqSLDtkmX9oeb2xiwqy/EWi1+DyVtW43UpXo
 ydYltTBuGwA2wHO5sSZVvZz/kSs1CuO2g3X5exJJVw4mKzGIJAi2r49joQfvVndEiPshkn6k
 q2bel859uWq8ejrf6jqqoeYOoJ7kA3zPLkilta7DOgmKAQCQWeW9OC62bb+50P2Wq9Kgeczk
 qTBsJDVO8AbpqmhDg9Q1YYj9gq/Ay2o0dsGhnYLNk9Kdwyfg4joPVHBPuz4AO+hj1ixjjtn3
 e7KMqPjD5nXM3TOkq3tcatg50JEzQo819Ff55ZaCrEbJ/LzX1f8utvCAR8jMAy03v3nBM9y2
 IMaV2KPGK6ZMKXdsVKT6OMgPfKDaJUItznjM/Ql/eLhjWclmV8BeqmkxYcYaHekEft6IkWUe
 mHsg9cEEWcSpAUyVu3qiFuYUT5SfXm+Raw85isjBIKgFojMXpqtj6CZ3CenAp1WYXhLBk2UH
 XfnaYqEXPQCZjiKL8FvnTIITaKhRJE/1R+trgH3079nLu3J+i0Er57i2sZ66PbJmR4v6zN4F
 9mS02KMT2Fxhm4GXzA4065hr0Jh1lqN17B0jOFdFdNJ/fNGTh83O4bFweJiBN7+QhnBfs+HS
 Fu+WNurHSw/QM8pz98Ve0Z9Fc2tjhDd0CquBL8Yj6SFCoUs/KzTjDDNIJN2zH3N1YEgiUMnS
 41BLz6InKl6oi3aHY3UiA20k6iwdKITlHro/X2A0HHIkUVWSg92Xo3aUHpZakaA/oex3V/LU
 7L7UedvCQBG08PXcsOiC/XshFRCH7L4PcjGJnm2gyG2DAqJwbWFaMzrfX8c1WPTEhtMiBgdq
 FCBMwV2HSK9uyTGFjU7MFv1YF73t8R6pmm6SEAc0AyAKUFshPKu4hBAvfWHULsI264c/iIoq
 jF6BlG4ivffEdmdvExMeKtGYNUyyEhK3yTVul81JYSueoZlgFNWaAFrpwXu2hFwX51HitQvp
 Wg2wRBaLKWFzBVeejne0Z2Y1qT/DG708VjvbqfX3gqby9OK4uIU7+x+rVz/vQavH05k8nN90
 tAT3WHOrpPNRBEfV578SCNVv1Bzuq3aby8h5ojVyWwkMK+6tSXH0s4oA+1twwipftNWOqeJX
 AHoFMhSC8+rIe0s01+nC3BMdMVb7q0pJIWLc/Wc2aikFPltlnSqgCUP4Yxw1F6N6zspUvTBj
 N4Ox/CV2BfCVi+p1g779JqtxsYdOndLRznaq2CsHoNaa6xscJxeDG6vJ5by3dBin9v2XGYe8
 le/BlQA0cvveByIblW70xcDsCZf6XGhhya8yCR51j8zqa/KlgnH2ef/b1wqPmBRRW9tpUjhK
 864gppJOSrgJxhsjxaj6UvgkuJ+rb58MnKVbENGZSnwIEl9X6H2urfIMKstoNs49C5QVuq7e
 1WTTLXw9gAb3y3UFGxb3Dkndjuut/0VhjRCgXmGZDZ2pXvdIoRrwAvHocfbXbhX1yYHQy9xj
 X/WAEK9Np+n54fcm5DGu+G4H2WvM/8bOQzi14Cdr22W4WNwABuwt+++kJvrHEA23DT62N9jS
 SjT5EylOM+xjfv8aL0hJxAgDUS088dgH4BijoY84fNYkWMXgJmY5ztPkGv+N8laxbOraXMMQ
 TARxNuGqAPh2UBlMjeI39ejDy/bmJE+IYDlJDpPiUdfp4hQBayZ7aJJh35wq1u89kfKZORl2
 ywa0b0o4WIbhOcAvEwsyD+cC/YcBxo9X2SkmhKW4tS5tKgSanyodO368UNkns26SpyGrBtdX
 nnRZZooWyN9pJYaUhqEwDjo54fodcOFJ/carB6JiFHti+ZPKZQ+vuUHj2xrNCiu2B9tg/5+h
 hto05aguYGBIGg456O1DClTMTjtbt8S8DXg3u5O29yb1Ie1EtB9Cy0GCdH2GOmwHmtY5pGFf
 06eVScxoXCBFf/DEB+DvQ14+mnXHcnjPiOSI2QFi8pvTl+RKQRW0gUTQSl/jpA+DB+j3sCnb
 0pzoDwcgzyw4hIez+V1K1z1VXrZrwrudTo+DpSSZBME6wZf+wLeKsaD6uE1Rihe8sTnpwuIT
 w7TLw0aCGYURgmPHFvkJKHovNDG/7HeDe27Z+3HZbHEwQBHf9GPw5/nko5v/jLXc96KImEnF
 PojnExKQXF+Hc3d3TQJUS0e0SzXPYado1+n9yt7o9rakryjUR/z5YaJF7pZMMl+sxGwj6CZM
 ueMhSF/YT9G35IIzHXMxfARxlkXwy1pcjCsF/wHu0uvBOrInbRLChcAdy5pHM5P8r56wQRHf
 8LWy5v02rN+kv8pGgJFWFjmyaTLLYQBJ2CwMk+CBV7ebu3cY2eRnIeuPuXlEO417q0crRC7t
 DeFHlW2Oz2Ck2KsTBWzKaRXizndOhVCuYa7exIrCG75TdugZAfoVb0/xTAw37AwgWvHcGAGN
 j0pOWZEtL6N9mV1hvtlGmpOxmVoJ6+IlmzKiouQYoZTqvZtDiluwqhC528mzrJO8CxebPlyh
 TeUsdNk5V2r2LrqqHIvQF9FrTBFg5iOtENpNPDC95VObn3D+QoE8WSaDxliTz5NFdDl/axdm
 ICnfE3bNzpItd7Zr5J07yn8LcWaLDw+PBCvFDOGVGM4
IronPort-Data: A9a23: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
 N0AgKXOxMk9sfl5nc3A3ene
IronPort-HdrOrdr: A9a23:PQQ6Ra042IRd7YqXZrKC0AqjBGokLtp133Aq2lEZdPWaSL37qy
 ncpoV56faSskd2ZJhAo6HmBEDkexjhHPFOjrX5UY3SOTUO21HHEGgB1+ffKlTbckWSygc379
 YFT0ERMr3NJGRbyeDn/QK/D9Es+9Wf9ru07N2utEuFATsKV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:mcpEGWwKxwf0GyUQpkKmBgVMWZAGXFn40E79BG2/Anh4EZLOT3qfrfY=
X-Talos-MUID: 9a23:hdmrawS1crdJAVTkRXTRgjxuMZ9l3p6OFWQU0rIsssuia3Z/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="129436619"
X-MGA-submission: =?us-ascii?q?MDHo2a397HlcxWTkNxhrLJAabS21efx5+bObXr?=
 =?us-ascii?q?X6tPUnbV83O4H0cHrY/byjci0RtwbKasEaErMyA91pC1drO4bK5ladm0?=
 =?us-ascii?q?BrIos8wp2xUAFUKTZgxBufNZ/eRRA5smO0BlERoqAEnHwKPpeAZnMrEP?=
 =?us-ascii?q?YefKVp0E7XWtm5QPAiMxlnhA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 20:56:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761767788; x=1762372588; i=markus.elfring@web.de;
	bh=YEHOhUcFHey16lyYcbORugfcWN4+Nzo1dgcZeTDky2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f8ATp90Q3nQCBfLggZWJcyY1rBT9J37XCIaLlgrAFXV47PvHu7RjwL/pL5bnfglw
	 q/HM97xLKnNaQ1cBPpt84A/FeeN1rZ1AX7Ir8LRSImG0B9hatihcC+uiK2kJn4j4F
	 m40GRSULW50jNQBh1qbUg1w1TDM4QbJ0Ntsl47J0ByC1Ct8qhrVFjAiWDO4sRSjtp
	 rzNhM+e9vsodKFrq9QrHJk+XTnzlJzPtO1mvcfsp0zmdZzMWMDhE6R97Ks2iQMol6
	 Yri5b92sHTgWv5Rt6INAe5t4IflODBzQxKAyLrccpTswO/tu99+dF7fYxFe+4ENQT
	 kDY2qq3nw9Q+1Ng4wA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkEhH-1vymQf0Jgn-00ZdHw; Wed, 29
 Oct 2025 20:56:28 +0100
Message-ID: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
Date: Wed, 29 Oct 2025 20:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8YbU0H3UkNK2M80Ij6vheyA3aAZaQMAyr9CgbhfweLj8TVd/YP3
 IzFbJqXND/AeXEy5D7xv4mP3f5Zw5xDziJYP0Dnx/+iNIJ7GOm+yAtIK8IJIoDJnuvSHQ5a
 A+8+aTdvB3BlJoMWecLA0pGpzVqw7hWm9CSgYVm8Vlz/GaydJdCE1JkyenDnCHU7yDv2TG9
 kaDZrgo4tVW5mzo9yxOog==
UI-OutboundReport: notjunk:1;M01:P0:zEmfI8NxgwI=;mcJozFaEFU3o7W5haAH0/SJlNjh
 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
Subject: [cocci] [RFC] Increasing usage of direct pointer assignments from
 memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3112
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/ddc8654a-9505-451f-87ad-075bfa646381%40web.de>

Hello,

I got into the mood to try another simple source code transformation out w=
hich
can be achieved also by the means of the semantic patch language.

@replacement@
expression object, size, source, target;
@@
 target =3D
-         object;
 memcpy(
-       target
+       object
        , source,
        size);


Test result (according to the software combination =E2=80=9CCoccinelle 1.3=
.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --max-width 100 --timeout 23 -j4 --chunksize 1 --no-loops -dir . =
=E2=80=A6/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci > =E2=80=
=A6/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-2=
0251029.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy=
_assignment-no_loops-errors-20251029.txt
real    5m35,579s
user    20m20,037s
sys     0m14,467s


It can be determined then from the generated diff file that mentioned
implementation details can be transformed in 304 source files at the momen=
t.
Thus I became curious if it would be supported to adjust any places there
according to (Linux) coding style preferences.

Regards,
Markus
