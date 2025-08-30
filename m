Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA09CA0EFF
	for <cocci@archiver.kernel.org>; Sat, 30 Aug 2025 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IXPzaQGbSxqSKCyxzK5TNpnUvNW8lvEFW7Lkj7ZxKII=;
  b=WVsjGfAIWh26NKyhzYor4HdPTovTKdquGxkHXPXT2bD8/Yr8e5jMbNIe
   WnV475eWn5FB23PpRVYGfvse/RXFK7MMiVewbnWTMtoxK1Xg7iPNZKvYV
   Ae+pMKztED5rWRewues0Rn+zrH7x1PENi4ALdljFgeS0kz1RNNb32D667
   k=;
X-CSE-ConnectionGUID: fvgw0svBSVOVbx+iIpIhcg==
X-CSE-MsgGUID: wsDLjNXsSCCcTmW0/1QU5Q==
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
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="236735398"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Aug 2025 14:28:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4584BE0B0D; Sat, 30 Aug 2025 14:28:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DBEFE0172
	for <cocci@sympa.inria.fr>; Sat, 30 Aug 2025 14:28:15 +0200 (CEST)
X-CSE-ConnectionGUID: HnuEeluySda6GxcTxCnI5g==
X-CSE-MsgGUID: Ch3jOhuSREmlEGr7oSrLzQ==
IronPort-SDR: 68b2ee5e_Nf+eKIFbTfPqffv9zO3Wvt/vpwoP8zrXYm1Xv+XKZ3pUMa3
 CuYf1AI6aMr4alo5w+4julrW4GxZAw3wEPFsPfA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FUAADr7bJogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYI/gQdUMwQLSYRViByHNIZfhzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhHYKAownAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHR?=
 =?us-ascii?q?AIBAyMdAQERJgEPCxoCJgICVgYBFAEBgn6CIwEGEAEDNQe0XIEygQGCDAEBB?=
 =?us-ascii?q?tpeHywiWYFkCYEbLgGFa4JkAYYng0J6Jw+BVUSBPAuCRzE+hEODW4JpgiaBF?=
 =?us-ascii?q?oNYl15SeBwDWSwBVRMXCwcFgSBDAyo0MSMPPAUtHYEneYMHgQ2EHStPghtyg?=
 =?us-ascii?q?XU+GUCDUx4Gaw8GgRUZSQICAgUCQz6BbwYcBh8SAgMBAgI6VxCBfQICBAhAA?=
 =?us-ascii?q?gELbT03CQsbBj2VRoMvg2qWXa9sNAeCOIFngWQMn2wGEy+DcQGTYA4GkwWZB?=
 =?us-ascii?q?iKpH4FoOoFcMxokgzZPAxkPjiGEM7xqQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:9Psb6BQ26yr2eCiQ9uc4eIsy5Npsoj6VAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODsLkd27SN4+jJYi8p39WoiDg6aptCVhsI2409vjcLJ4qoL3O+B9PRKxIAI
 cJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQka3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+N
 hq7oAvfu8UMnYdvJKk9xgbKr3ZJdelbxn5jKE6OkRr7+sq/85lv/jhKtfk87cBAS6L6f6o5T
 bxcEjsrNn0+6dPouxfeUwaB/2MQXGoOnBVHGgTI8h70UIrpviT1quRy1i+aPdbrTb8vQjSt8
 71rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSGFfQsheSTBOAoKkb
 4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOm3T437A10/45HA/F0gIvENwBvmnKotjrOqccU
 eK6w7XHwzjYc/NWwC3w5JTUfhw/o/yBW697f8rLyUkoEgPIllKeppb/PzOWy+QNqHWQ4eVkV
 eKhkW4nqgdxojeyzcorjYfGnJgVylPZ9SVi2oo7Ktm4SEBhYd6lFptQuDqXNoVoTcw5WW1np
 Tg1x6QAtJWmcycE1I4pyATDa/ybbYeI+BTjWf6RLDp6mH9pZa6yigqs/EavxeDxVcm53llXo
 iRKktfAqn4D2gLS58WaRPZw/Fut1ziA2g3S6OxJIkE5mbbfJpMgxLM7i5kdsVzbEyPohUn6k
 rWaels69uWq8ejrf7XrqoWBO4J7kg3zNqsjltaxDOglKAQDXmyW9f6h2LDn/kD0RqhBgOcsn
 anDqp/aINwWpq6nDA9R1YYu8xO/DzC70NQEh3UGIkxKdwmdg4f0JV7COPH4DfGhjFSwiDpn2
 e3KMqP7DpnTMHTOkq3tcat95kJG1QY+wshT55dOBbEAJPLzVFXxtNvdDhIhNAK72fznCNZg1
 oMFQ26BDauZMK3IsV+J4OIvLPKBZYELtznmMfQq+uDhgWcjmVABZampwYcXaHegE/RiOUqYb
 2DjgtMFEWoRvws+Tenqh0aYUTFJfXqyXqQ85is6CI28F4vDSJqtjKSb3CinBp1WenxGCleUH
 Hj0cIWLR+sDaCOJL896kj0EUKChRJU72RGvsg/60btnIfDO9i0Wr5LvzN516PbLmhEo6TN0F
 9id032KT2xsgG8EXzA20754oUJ+0FmOyaZ2jfNAGdxJ+fxJTAQ0O4TEwux/DNDyRx7Bcs2HS
 Vm4WdqqGyw+Qcwpz9ATYEZ9GtCigwjb0SSlDbAbiaCFCYAy/K7EwnfxItxyy2za26Q5l1coW
 9NBO2K+iq5k7wjTCZbEnV+Fmqi3aKoQxDXN9H+NzWWWvEFXTgpwUaLdUH4Hf0XYtdv3tQv+S
 OqMFLAmO0NlwNGLLq8CPt/0iVRPAvPqJ93aZ0qwnX2xDFCG3OXIJIHtcG4c9CTbEkkN1Q4Jr
 licMg1rIy67oH/FRBFqG0juZUykpcx3snCmVQkZyw+Qbktu/6W48FgZiKrPGLsowrsYtXJ5+
 H1PF1Gn0oeTUoLYz+IAVKBVYNdmpUxCyXqcrAtleJqpM6FlgFcaNQVxpULnkRttWc1bicZ/i
 nQswUJpLL6Alktbfma91IrzJ6aRB2385hGpZIbJ11uY3NvFsrwX5qEAok749BqsClJk9nxm1
 9dP1H7Jw5zQDxcJF7/1XFw28RdSuLzQJCUwtMvPzXM5F66yv3fZ3s4xQusozhH1Z9BELKaND
 xP/CeUfANWybvMnkR6lY3roJch086g5d4OjfvqCg+uwOfp42SmhlSJB6Zx81USF82x9TPTJ1
 tAL2aPQ2AzPTDr6gFq716K/0YlZeTEfGHa+win4FcZQYKN1Z4MCFWapJYW+2Nx/g5fnX3MQ+
 kSkAhsK38qgeBzaaFKYv0UY8E0NomG83wa8wSZ1lT4BsaeVmiDDgqzjeBcBJm9XVTx6l16/a
 YOwjt0cQA2pd11zzUHjvxylgfEG4v0jfAyxCQ9SciP7Ln9vSP61v7uGOItU7Y8w9D5QSKK6a
 EybTbj0p10b1TniFi1Q3mNeFXnit5Pnkhh9kG/YImx0qS+TXMhqxgrEovHYS+RQ2DUuWyRyz
 zXaTAvZXZHh7ZCPmpHPv/rrHUeoTJ5Oam/GyY2atS20zXJnC1uzkrrg/7+vWRh/2ij92d5wU
 CzOpxupeYjn2ZOxNud/d1VpDlvxgyZjMrl3iZB4xJQZ2HxBw46Q4WJCimDrd9NSxaP5anMJA
 z8N2d/cpgb/igVvKXeAxoSxUXv4oIMpQtCgYX4NnA854dpLDqi887FO2yd46la1tgPeZ/Fhk
 yxVk6J0riRA3KdQ5Ux0km2UGfgKEFNdPDDwmhjtjZj2t6hRaGu1MPCx2Ed4gdG9HeSHqwBYV
 mz+f8RqFitx48NjdVPUhSeqsMe+IoaWNI9V70HH9nWIx/JYI58wiPcQ0C9uOGam+GYg1/Z+l
 ht2m5ezoImALWxpuqO/GB9RcDPvNKZxsnngi7hTmsGO0sWhBJJkT38uVYHrUOnuPTYcr/XhO
 C6RHTd6pnrRSt+9VUePrVxrqX7CCcXhEniNJ2QCi/hmSgOcIkN3nw0eGjk31M1cdEji1Inqd
 0F34SoU71jzp05Xy+5mABL4V3/WuAaibjpnAIjaNhdd6RtOolvEKcHLpPwmBDlWp9fyyW7FY
 nzefQlDCnsFH1CJF0y2dKf7/sHOqqCRVO+5MueIfriE7+BTH/7awJWyzs528TGWKcyVMj99A
 vd91kcmPzgxEpbcnCgTDiYQiiTGYoiEqR369iA/p5K69+n3HQn075aLCP0LONNjola9hqLmV
 abYjXR8LitEk5gXznjS0P5G1Vge0mdlcDzlB70EsWSloLv4vKhRAlZbbipyMJAN9KcgxkxWP
 tadjNrp17l+h/pzClFfVFWnlNv7LcoNa3qwMl/KHiPpfPyPOCHLzsfrYKi9VawYjeNasAe1s
 CqaFEmrNyqKlj3gXRSiee9WiyTTMBtbsYC7OhFjbAqrBMrhcQG+OcRrgCcexLopmjXVOGRaP
 TU9O0JBo7uM7D9J1/VyH2sSixgtZeKAmiuf86zZMsNM6KEtWH4r0bsHpi1mmN43pGleSfd4m
 TXftItrqlCiyayUzyZ/FQFJsnBNjZ6KukNrPePY8INBUDDK5kFojy3YBhIUqt9iEtCqtbpXz
 42FsavpKypZtf/Q89EdAcf8N8+NdnYse0mMenacHE4eQDinOHuKzVRai+2X/2aJo4ISr5/xh
 NwRR7UdWFF/RZZ4Qgx1WdcFJplwRDYtl7WW2dUJ6XSJpx7UXMxGv5rDW5p64N3qLyuFy6ZJb
 V0EzOGgRWz8HpL20QpuZwsj9GwvM1XdV5ZBr385BjI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yRa15KwPBmSGWbdXtTSfKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:e9ZoeGzYbKQ9AyeL0VcuBgU0HN0If3nA3UzcKhGXGW1VWJaTaAKfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AUbMjQg+wXcuHjClfG65A6gqQf+xouKaJCF02q7g?=
 =?us-ascii?q?Dv+SrL3N3AC25ng3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; 
   d="scan'208";a="124232589"
X-MGA-submission: =?us-ascii?q?MDGhb7F0FcIte3UeqRmEQDX/CiOYppkzBjjLu1?=
 =?us-ascii?q?xUsU2qtZ2aQg91hse5y42/xY7GmdaDCGYuz82WxhOKKs3k1JDUVx09VX?=
 =?us-ascii?q?CqvIQ5cogzwYDWM031kJ/U5z7ks8wVISfxBegsxdeBBk29lwDTRbs94L?=
 =?us-ascii?q?OK4zYHwc0sG6H/HqEYrzyDLw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 14:28:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756556894; x=1757161694; i=markus.elfring@web.de;
	bh=IXPzaQGbSxqSKCyxzK5TNpnUvNW8lvEFW7Lkj7ZxKII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bosIuJ7Upgl/BFwG1nE087Cb9PkZe9lrHeku3boxYj96bctEYFWE5I9Ai2S/vZ1R
	 LnJeApWzaQ6qPIK++ztJTDvJ6/Qhxa6X0VCKe3F9HM7OCdwi/9I/VYExlSXKUzSKk
	 /FDmmClTvVBT+AVpIczhYU+ic+jp6+TL/ViEC0adFK4X6k/H2Vo+OtTmBCLXyeu9l
	 TE61OprjxLYx4bQ9YIRd/VfJ8EdO30j6sODyzbUj8AT/UY+Y5Cjqc9VHMVWtfkUw7
	 1uF8Czx27Sg02cOEnL4gISIjycAESlLiPxBb3IzhoNFlma3YpzrfsXSC5bwaznlm8
	 77PoDewZGr+l271qgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.198]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4eGJ-1uSVuk3aA3-0189xn; Sat, 30
 Aug 2025 14:28:13 +0200
Message-ID: <0118a1aa-4327-488e-84d2-433cbf3ca2d1@web.de>
Date: Sat, 30 Aug 2025 14:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: =?UTF-8?Q?=C5=A0erif_Rami?= <ramiserifpersia@gmail.com>
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
 <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
 <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
 <fa82455f-6294-4200-ad6e-c31add12b303@web.de>
 <alpine.DEB.2.22.394.2508301400410.26590@hadrien>
 <d50936c0-ec28-4f8e-95b1-e065d3b3bc3c@web.de>
 <alpine.DEB.2.22.394.2508301423190.26590@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508301423190.26590@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NrFsXULFmwLQMgE5O6njUISgW2s91xekwdnBZWX1rcbUZ4uqOWu
 qq//Dw/mKCpEt10mP6v8AAL8mplygHa+vaMYjGmu50yHR1idbZRkGYCDcaoS4QH4P8ktC5Z
 QRF+nMq4yqrJPGypBT5lBEpw3zKJx9L9Khl8Iazj6sOn6tH09oZR1IohdiwOqwt/vIAH2Kb
 dBqdOdd/wX/4F5HP0pbnw==
UI-OutboundReport: notjunk:1;M01:P0:i9gbdLTrEd4=;QzOwdMlDjF5YhyJ5w9U4k7YqvZf
 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
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2989
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/0118a1aa-4327-488e-84d2-433cbf3ca2d1%40web.de>

=E2=80=A6>>>>  ... when !=3D handshake_buf
>>>>      when exists
=E2=80=A6>> Do you propose to generalise such a source code transformation=
 approach
>> any further?
>=20
> I don't propose to do anything.  If you want to do something like this,
> you have to check that handshake_buf doesn't occur on other paths.

Do you find the mentioned SmPL code exclusion specification insufficient
so far?

Regards,
Markus
