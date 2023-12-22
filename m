Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9686C41535
	for <cocci@archiver.kernel.org>; Fri, 22 Dec 2023 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=gPf1N561oe8j4D82GpGucDP3vlpCI/KWSRThunasTl8=;
  b=C8Pv3Yfe/nCe9bStfaC4ahdXQ3eFdVW0+smxdrTezXUahu6yFAHgThxF
   j74ygCELZ/UJC+W9FRv5HYUanajXoAF8A1j0RyAeQ3Pq0dTNaYBcHwU/h
   cZaDEnLFYomx0TFu1gVKx0i15k6UsNjkeBNCmEq0Mnp9KT32nV3YHkrMd
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,297,1695679200"; 
   d="scan'208";a="143797462"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Dec 2023 17:33:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A547E0CCF; Fri, 22 Dec 2023 17:33:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40DAFE004E
	for <cocci@sympa.inria.fr>; Fri, 22 Dec 2023 17:33:35 +0100 (CET)
IronPort-SDR: 6585ba5e_UmjWlNCYrg36WhToB7nLJfrMvU7djDIK0Ya7CwbS/gaVJzv
 WScm229AuSXnOT3jOeExgpzr6LyECeXvILu5F1w==
X-IPAS-Result: =?us-ascii?q?A0EVBADAuIVle07ASNlaHQEBAQEJARIBBQUBQIFPgjl/U?=
 =?us-ascii?q?zIEC0iEU49BgnqDZoc1h0yEa4QEgWqBLD4PAQMBDUEBAgQBAQMENwGER4c2A?=
 =?us-ascii?q?h4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOE?=
 =?us-ascii?q?CeFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR2sdAQERJgEuAQUCE?=
 =?us-ascii?q?RUCXgESAgEBgnyCKwEDMQeud4EygQGCCQEBBq9YHywiVoFgCYEaLogbAYRFg?=
 =?us-ascii?q?SKDQYEhD4FVRIE8C4M2g3yBBoMcgmiJHQcyghyDUIojhz19BUFwGwMHA38PK?=
 =?us-ascii?q?wcEMCIGCRQtIwZQBCghCRMSQIMvCn4/Dw4Rgj4iAj02GUiCWBUMNARGdRAqB?=
 =?us-ascii?q?BQXgQ5uGxIeNxEQFw0DCHQdAjI8AwUDBDMKHQshBVYDQgZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yCTwLBAwaAhseDScjA?=
 =?us-ascii?q?ixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRA?=
 =?us-ascii?q?wQKAxQHCwdRAwEOAxkrHUACAQttPTUGAwsbBj4CplV7E4J2xQE0B4I0gWCBY?=
 =?us-ascii?q?QyfKwYTL4NuARKTJQ4GklQuh1CQTyCCMaYVgXojgVwzGiSDNk8DGQ+OIIQrj?=
 =?us-ascii?q?wkBPUA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23:QNlQAB2dKDCCyhF6smDOfQ0yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaPo6800xSZAc3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNYAhEniSxba5wI
 Rm5rgjcudQdjJd/JKo21hbGrXxEdvhMy29vOVydgQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetArIfzqVQBohWgCwSyBO3h1yNHiHDt0K0myuQsCx3K0BA+E98MtnnfsdX7NL0VU
 eCw1KTGyi/Mb+lV2Tfg84jDbx8vofWCXbJqcMrRz0YvHB7Cg1uXs4PlJTCV1vkWs2SB4ORgU
 eyvi3QmqwF3rTii3ckthZfSiY4P11/L6zx0zYAoLtK3VEB1e8SrEIdMty6ELYt2RNsvT39mt
 iomybAKpYO2cSkFxpg7xxPSaeGKfYiU7h//SeucPDN1iXx5db6imhq+71StxO3/W8Sp0VtHq
 iVIn93Qun0Lyhfd6dCHR+Nj8ku82zuDzQLe5v9eLUwpkafXNYQtz7wzm5YLtUnOETX6lUvrg
 KOMdUgp+vKk5uDnb7jgu5SRKYt0ihzlMqQyhMO/G/k2MgkPXmeF4emwyLvu9lDjTrpQlP05i
 KzZvYjaJcsFoq65BBdY0oMk6xaiEzeqytoZkmccI15fZR2IkZDlO1DIIP/mEfeym0qgnCppy
 vzcPLDtHI/BImXHnbv/Z7pw6U1RxBI2zd9F5pJUDr8BIOj0Wk/0rNHWCQU2Mxa3w+b6E9Vxz
 IwQWWaBAq+DMaPSt1CI6/khIuaSf4AZoivyJOY96/7olnA2gUUdcrWx3ZsLdHC4GexrL1iBb
 Xr2ntgBCXsKvhY5TOHylFKCViJcaGqzX68n/TE6CIemDZ/ZSYy3gbyB2j27HpxMaWxcBFCMC
 ySgS4LRcv0BbGqsL9Ro2mgNX7WlVYI63DmtuRX8xr4hKfDbrGlQm5vp1d89yvbPmA878HQgA
 cmGz2yTRmRckWYBRjtw16d69wg171aI0aF1h7RkCMZK+v5VTgpyYZvA0vZjFt3uRg/pdN6YT
 FesWNjgCjY0GJZ5+9IIbA5TEtPq2gjO2SXsDbYTv7qbHNo/9aeKmzDKLt12y3+O9KA8gkNuF
 tAJNWS7i7RX7wXVCJPViUKflrbsealKmGb29G6cyyKhoUYQBBVwWLrDUm0YTkjbt9L04gXFV
 bD4TfwcLgZZycOEYoFNe9Gh2U5MQ+bvENfTeWS8nyG3HxnegvuPYZDsdmE1xCjbB1UYiQcV/
 GbAOQV6TiOgpX/OST1rBXrpc1uq+u577Du/T0kp30SBa05JybW44FgWiOaaRvdV2agL/G8lq
 jNpDBO0xdeTCNeaoQdlVKFdes8mplZB23jQuwF0MtqnNa8mzl0TaQJ6uwbs3hN2FoJaiuA0o
 34wigl/M6SV1BVGbTzL84r3P+jyI3Px4QvnRqrYwFDY357C364V6+kj7XjnshuoEEUK7Hhtl
 dVYhSjPrq7WBRYfBMqiGn088AJ38vSDOnFVD+L80HRtNfLxqTrew5cyA/NjzB+8ftBZOafCF
 QnoEsRcCdL9YPcylQ2PaRQJdPtX6LZyJ9mvIt6Pwq22J6BNmDy8jGJIyJ9w2ASA+nk0UfbGi
 q4M2OrQxQ6bT3H5hValvNrwnNVhbCsRA3H55CzqHo9XaYVtcIxNBWr9a9avyIBYgJjgE2Vd6
 EblB14C35qxfgGOalXmwQBK/UEQvGDhhiayiTB5+90whoyY2iGGg+HrdR5cf3VOWHEnllD0Z
 469k9EdWkGsKQkvjhqso0jgleBdo+xkIm/fTF0tHWC+Jnx+Uqa2qruJYtJeoJIuvyJNVe2gY
 FecArfjqhoe2innEiNQ3jc+Pz2tv5z4mVR9hgf/ZD5WpWDaZNo26BPR/t3aStZO0zBASCQ5w
 TjbC16gPsW4qM2OnsSLueS/WmS9E5xLJHOyksXf7m3itDcsXk3s+pL70sfqGgU7zyLhgtxjV
 CGT6Q35fpGuzKOid+RuYkhvAlb4rct8AIB31IUq1/RykTAXgIuY+X0fnCL9K9JejOjbZWAOW
 CVN7trb+gnj12V8I3jPy4+zBRD/ioNxIsK3ZG8bwHd3yslQC7qPqpFAkzF0pFWQsg/bJ/Rw1
 GR4q7Nm+DsRhOcHvxAoxyOWD+UJHEVWCifrkgyB89G0qKg/iH+HSbGrzwI+mNmgCOrHuQRAQ
 DPifY9kGyZs78J5OVaK0Xvp64iidsOCJd4UsxSVlV/HgY03YNoUn+AJmDEhFGbzp3wjxMYkg
 BYo0ZzysIWcKmpr9b60GVYCb2KzOJlVo2C3y/kO1s+Nl5iiBJBgBikGUP6KBbqzHTQeuO6mf
 weCHTsgq2uKTL/WHAuR8kBj/DrEF5GmMW3SJWFMl4w9AkbHYhUO2kZLDGZf/NZxDA2hyc3/f
 V0s4zkQ4gW9sR5Q0qdzMAG5VG7DpQCuYzNySZ6FLRMQ4BsRgiWdecGY8O93GDlVu5O7qwnYY
 EmSfQdVFickXkKeBlbsFqaj75/M/qLLY4j2Z+uLeriIpeFEAr2tzIisz5Ag0jKCLMSJMVF9A
 vd91kcJDhUbU4zJ3j4ITSIQjSfEacWW8Qy99iNApce66P33WQjr6NjHG/5IPN5o4RzznbabO
 rvamnNiMTgBnMBppzeA2P0F0VUVkS0razS9DeFKq3vWVKyJ0q5PU0xBMnk1bpEXqftmgE8UY
 56c0I6QtPYwj+ZpWQ0cDxq7wJ7vPJFMeybnaRvGHBrZbu3cY2eRnIeuPuXkDucPxORM60/q4
 GndTBWlZ2XZ0WO1B1f1YIQuxGmaJEAM6Nv7K0gwTzG+HZS+LUfleN5v0W9smOJy2SmMbzZDd
 2A7KRwFr6XMv3kB3bMgQSoYvyAjc7XDwXj8jaGQK45K46sxRH0qyqQAuiV8kuANpCBcGK4lw
 m2L8IMo+Qr+1LPVgixuVB4EwtpSrKSMu0gqeaDQ950bHG3B4ApI9mKITRIDu9piDNTr/aFW0
 NnG0qzpen9E9JrP8M0QCtKxSorPOWc9MRfvBD/fDRcUBT+tO2bFgkVBkfaUvnSLp5k+o5Lol
 dIAULheHFAyE/obDAxiErlgaN9vWSg4lLeAkMMSzX+5sQWXW8hQ+JzKF7qTDfjpNDeFnOxEa
 h8PktaaZcwYMoz23VAna0Evxt2VXRWKG4kc+Gs+PlxRwg0F6nV1Q2wt1liwbwqs5CRWDvuoh
 lstjRM4Z+0x9TDq6lNxJ1zQpSJ2nlNi/LetyT2XbjP1K7+9GI9MDC+h/W04KJDmWEBYaQOon
 EprHCjJTfRdgvEzEAIjwB+ZopZJFfNGGOdcZwQMwPiMe/gy+VFbtznh2kJNo+fIQ8gH9kNiY
 dunqHRO3BhmZdg+KPnLJaZH+VNXg7qHoi6i0u1ZKO42IkEQ7CWNdSROtEFabtHOyAK38+Yq5
 QHQwlOrnUATWvBsrv84risA
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OTo/k6kp6Mrn1WvHHvdxmPbGStvpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWVtN93YgBHpTngAtjmfZq4z/VICOYqUotKMDOW3VdAT7sN0WKB+VHd8kTFn4Yx6U
 4KSdkbNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:sPvJ12xSykBxY+HcIJalBgUMAsY3UVDf7UzzKneJMF1TerOkCmCPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A10Sj4g32Bjb8Mfnbl4P290gYlTUj4p2gOFIPqLY?=
 =?us-ascii?q?9i4qJaXYsASuR1ga8Xdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,297,1695679200"; 
   d="scan'208";a="75209583"
X-MGA-submission: =?us-ascii?q?MDHJGun2dJGNKEw/ewCDEQ7LhArk/UZ/ENh+GP?=
 =?us-ascii?q?TH6Nv8vLzMChKo7W7rmjVamTGOC30xHH3ClDYlCQm4V3q4jiWG+/H12c?=
 =?us-ascii?q?PbUE3vqw7WoLBqueVbcYi4M10hS8iGXYHRKIY8tKblI/2l/Pm0ShvFYB?=
 =?us-ascii?q?qxZEsVaoIqTlinUK69hqPsIw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 17:33:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703262801; x=1703867601; i=markus.elfring@web.de;
	bh=II1Syu+QZpTTdKNVAA8lEUdquR1iIiAORrysqoovEIw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=h2jY+MEXYpMVABxYGUvm996cPhhIram0PivmZeM9XTQuG1paepFqqv531VIYPkpF
	 tKIonNpSLhGLswkvBs2/2Jfd6y2DdNTW4gK0RG1QFmHRld5P/Rk1MkDwODqym3RWx
	 IwI/rG+lm+qKVmKyTyNDna6fTCbwbkwBrip9lO8rMrZWn3qB/k/H6S90/CzxLZ3Ng
	 pqPRduHHj+0eNa6O2ZqK5rEDK7BPUE9H+J0v88mDOZGYUuRoFcI7k1gnCZulICGNd
	 eESfxaOrbbpt6/K9mU0mFSeK05AK9wR8qjhl5R6Zt8sn6Laz8K/JzD/njgVJ5BvMh
	 NAdi+ouDfXEga2lRHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vsx-1rBvG53VZJ-014Irv; Fri, 22
 Dec 2023 17:33:20 +0100
Message-ID: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
Date: Fri, 22 Dec 2023 17:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W6dljh25Z3qX0ewVj1QQEwoJbI1MVRnyEOTGeRUMxGzbQwCIVg8
 Jpn+2Q85+M+DNp1/ozepjDmvieNaTOwDo9oEd9yJ46ddZ0GoKKWUYkA9fT0nniXAPnb1bTN
 Q/syistUvudxN9oH4763xgTR5TTE0+xZsBzzcruzYhNG5JMpCqdIdkTmpWw1ZHJonWN5o6D
 Mgqr6UohTu9mC9LNFY6ww==
UI-OutboundReport: notjunk:1;M01:P0:FqRND/JLYg4=;EfoGxG+5SJAxzghPY0IrN5E4rez
 B3m9cjA6AaMtZsXqG+7gh2LC4fM4ug0OpwJsissxr6ftApZKl3WaiqAIbqpCDb5+DImS5juaC
 1pMfTjZMfU2rU99L1aky4ZCjGXyKg9j5les2Psg4RGYvWaGm0migpIzCMPov67m2Au+6NDb1C
 MsJ51mOaCwTzmppJxK4+scgBGbAlEM1WB7q0BvTWpXT6W4VjMnfI3CgOBW0g50551HUIBCNrG
 qNr7wjKrJgs1xu7vfvQJ7hWpo1TyFY1Rdx+PaX6qT3EJGgFhwbbrzK+ZBrmeP2+CWBC2PmVT1
 1PCvXyMaaAkSmVk0SO2oruZJTNZUVVg2cmznukUwQYQQmr0el/+6KlDUu1wBNqqnvVf1Lj0wX
 Y8E4x9/xNKDmQ86RRjPx0RGcEgvKSxPcre5ADhkZlN8MSb2KwMJdT/Tcdo7/79PldRP77RtXt
 9Gch/59opWQOq6SA36pdjAXzj/iic+22cj36g3VAnnKfC+/e5BAfaJBHemdtCS10tJmw6vpMT
 X8+poAovKjR7jrdJpoyIuqpmsKJ610WTIjWa38UVi1rrcgYmMNgVq/8mlnnec6cyxTin6mF/O
 eCddRYVgZOuYqZYJzkY7osI8F1OU9DvLQGRGe7B9unqIfphEJqf6IEXl9L8yZITy/Uu2S1L8W
 MbTJFHVC837bDVFjr8dtn7iGztI3h+Ppvjm1YuBDkMmt2+Rbrrv8Jx1djjwaW4N+gmX2feBMg
 6xgv5oKNUc9HVPhHJ3xjG7a2bL5kgzMkDV4Ysxjn0SuX9+kBU4Vbxzx/lBcDflrji/CvOdr4N
 LDB5uZtdLsp/MYBOjA3441rWR5gQyrLl7HEBmxCCIPoihmO4uewdDsPCUyff5QVgfFFSinn44
 d2RX/4LLUP/qti3HmY1bihp7wKt/cksc+VhsqAK/YPMI39y3GjFxLTzasuXOjkveSOyh40CG9
 ULA0Apt+kDuvXq5h+P8suLoutmI=
Subject: [cocci] [PATCH 0/2] clk: imx: composite-8m: Adjustments for
 __imx8m_clk_hw_composite()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1360
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/1d494176-2238-4430-bc26-4e4c78fe4ede%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 17:24:32 +0100

A few update suggestions were taken into account
from source code analysis.

Markus Elfring (2):
  Less function calls after error detection
  Delete two unnecessary initialisations

 drivers/clk/imx/clk-composite-8m.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

=2D-
2.43.0

