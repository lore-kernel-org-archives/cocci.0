Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55334C48BEF
	for <cocci@archiver.kernel.org>; Thu, 15 Feb 2024 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=4tqNmGWIan7f3iSPMZDXApKKhMG7faYlckVAwGxo/50=;
  b=ZXH+RLqwTu623jfIn55jud/LCj0fuZWjtiK6GwCkJac0NYoFwFHj7I1n
   qLLSYPDuZNnVw/3/7B1Bjkqa5BHI8OY4s7xXfcMtCqoPYX36aEd9mZxm3
   /4PXW+2OrOOlyRHQSXQ8JgvxzaMClRZSbxbpucmSiROtW+3k+1aiEtkXD
   4=;
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
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="152092539"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2024 11:16:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 32175E0CD6; Thu, 15 Feb 2024 11:16:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24B6FE008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 11:16:20 +0100 (CET)
IronPort-SDR: 65cde459_WndTMFj6KEjHp7vbWZRY//Fi9PxvnGAZoR+6L6cbwkUgKMJ
 dkyj0Jfuf4x2WOnJKqRWRA7eYD+PpD0SXd3hJbw==
X-IPAS-Result: =?us-ascii?q?A0GeBQAp5M1lhw4P49RaHgEBCxIMQIFEC4I5fFYyBAtIC?=
 =?us-ascii?q?IFHgwSROYRrgVWNMIhwgVaBQD4PAQMBDT0EAQIEAQEDAwENKgGBU4IuiCMCH?=
 =?us-ascii?q?gcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHD?=
 =?us-ascii?q?hAnhWwNglUYgQ6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAg06ax0BAREnGBwCJgJzAQGCfAGCKgEDMQcNBpYanDSBMoEBg?=
 =?us-ascii?q?goBAQaBWEFOrHQfLCJWgWEDBoEaLogMGgEFZYloD4FVRIE8C4YXAQECgiuDD?=
 =?us-ascii?q?oJoghaDO4EmiDmCQgGNLoFTHQOBBW0bEB43ERATDQMIbh0CESI6AwUDBDIKE?=
 =?us-ascii?q?gwLHwVUA0MGSQsDAhoFAwMEgTAFDRoCECwoAwMSSQIQFAM4AwMGAwoxMFVBD?=
 =?us-ascii?q?FADZB8yCTwPDBoCGxsNJCMCLEADCQoQAhYDHRYEMhEJCyYDKgY5AhIMBgYGX?=
 =?us-ascii?q?SMHDwkEJQMIBAMrKQMhdBEDBAoDEwcLB3iDRgQTRAMQgTSKJ4ErAxkrHUACA?=
 =?us-ascii?q?QttPTUJCxsGPQKeewGDMFkilQE8sgg0B4I0gWAFgVwMiHiBI5UdBhMvlzAOB?=
 =?us-ascii?q?pJfmFiNb5U8hUyBawUugVwzGiSDNk8DGQ+OIBmDYTOBC448QjUCCTACBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tdQiP60FO6l3O9bJqLbffwqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:0z5JTmMToRyVje5DexVY2FEsI/IZXz703nWJc2OjFGxQR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3Aiu8b2Aysj1L9g63KamHfsqnqi2OaqLmeDVkGyKd?=
 =?us-ascii?q?dgveBO3VxKWiDiQz0GqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="79710054"
X-MGA-submission: =?us-ascii?q?MDH/wOchP/LepzU25GzKtVPhm61wNuYDRyorwp?=
 =?us-ascii?q?shwaDc72DpHj4kVXWO7omsXeDr+SQuFJcct8dgxaf3kofNXaaFJrsqMj?=
 =?us-ascii?q?eGgN3Oz1AgxyDqZ6Df6bY7/kW+bmpcMA+qLinknDcMxe0PR5jjCT8IM5?=
 =?us-ascii?q?q3gM1INO9PbpsvwCH2aCtzyA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:15:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707992152; x=1708596952; i=markus.elfring@web.de;
	bh=1fUvIjpql/dZRC2H+V+W3qM851yow3X2t4TDJ/Vs5qY=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=gWDxQKqqZQV7voyIOxXV7uFt8eU+P86+00ylmnkr4d5lBBMMofzoTORXDMu/15A7
	 ZQbsofjdysfStjZvdF8Gzjl9J8wIi7Qp9HEK17v3RXnN7yPx2Quxnw4i+TL2T5fD1
	 W9WXVHT0wIJeG5WOmc0UthtUIkGgePrSGCitIiNUGNPP5+OXEbbudFUDStabvK6Cb
	 hqduegusKKeUMoM85FfNcCCBsoXuWh23dLX/EzB45GaOBqPyKOhp5kz+wWQsaQEN5
	 OAbtgklC1+pEBr8RurNxSDuvG4rxU66j1RhHH6U8qeQKC/Y6lvqxzNUl/RoUp4ezA
	 dPoY1eJQbBilZsdVLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1rjbTP0PFT-009csj for
 <cocci@inria.fr>; Thu, 15 Feb 2024 11:15:52 +0100
Message-ID: <01fe8b37-9fff-4137-818c-8a851ce588a3@web.de>
Date: Thu, 15 Feb 2024 11:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVTsMtKiXDUkW2j90Zhvn2WQYVeq8HGDaRsOJ1K00xRoNmqT2NC
 yBnlwmBwDbTgR9zUUQyTWxzyAKWpmvDv7kpBkt1f4u5aciB50W0ghqq7yPQpLy5iRDtVSu4
 JgmOqWNngHJnJVnz33e0APSNHJPYyxSZrGkLY4tSLOxmoYxhOKBS5/6y9UJ9xophOgedb0k
 fQwqlvcTY3+0+clpS6vDg==
UI-OutboundReport: notjunk:1;M01:P0:cM/PkJg7AnI=;hRt7dgL/+uyGT4duVnf44LK1Zc6
 UU6DYomzq0v3wsEHnubvy6xZvjk6toVc5iZQnmkbh2wlAN3SpLwB5MeN01qc42pyGr8TU3gwU
 FxVIzk+p6PN2PMS+PfVFb6azt9nri+heRJAVKtDrW1x38uLBkrqMojwyfX9KJkZVolxtJRRM1
 S9WEr2jUdCk+XNbxfSsuReEJDBS+0xG6i3Hx3lXEZV2TQJ9Fi9JNpr5kXzz3ynTcig+nl7aBX
 kqIShq249Y1DWTlVwPFrgYgXlzy4FqzLpsVgvVR0ZROiuNl5iWPgv/wGROACPyEKgox2vltZV
 JtDJRvpJNhH5s/FoK01+jeV+DUIROSaENfn5d0kjp3znfZ5525LeQP7j/vQAS4Bika3xqX2rV
 +gnwSlrtrJoc33EvflZb1DBxSsEV3e1aWIdNLlFNk5YRbHvVNuKcTNQ2z3WNqsaO3gl1ylaLL
 3chE+t51Ij4hrbagHDIpDPLXO0LxBFK82nIEUm3eqJDWHV7pePVe+8I25+0/rdylC7D+FRv7R
 2vpPtdGHMm9NUioQ2yFvHFih7vLK3A2PFrCTGCglLbLBEXRCExAvVRhtyk1cNyNXUs0BhgL28
 JngFOVP8GhIoyo0YQBAmTu33gNXS/A1cfZrJvs34zPO8kMjhjDb2boqXLB9kkswilRbGjpIqW
 cgIMPjxnVkdUEJMejWRnWFcwzbg0gQkVGPn8T9B8Oxkx1A5atPJW+jVc0bc0PzHUYalxh91Td
 sFtibL/YV8MfUveij0FaX7ewy/bc5na4YD8aMc4CqEK1Ex8winGBVviV2c/aEYiNKVywUy39u
 lWYVe1e9Z4jcuXnAz+7h3cKEeqp/eMt5WX49qxxorgUJY=
Subject: [cocci] Wider applications of SmPL conjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1557
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/01fe8b37-9fff-4137-818c-8a851ce588a3%40web.de>

Hello,

Special =E2=80=9Cconjunctions=E2=80=9D are supported also by the semantic =
patch language.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/cc7ff34b307724845875b=
e57d5fe9a5fadb36844/docs/manual/cocci_syntax.tex#L1041

I accordingly got some impressions from applications of this software func=
tionality.

Some source code search patterns can be combined then by the SmPL operator=
 =E2=80=9C&=E2=80=9D.
It seems that an ordering of involved items would be more reasonable
for such a combination than others.

* An identifier can be searched.
  It can be determined then also to which expression it would belong.

* A specific compound statement can be searched
  (together with included metavariables as needed).
  If you would like to avoid the repetition of the same specification
  for a subsequent search, it can be a corresponding metavariable defined
  based on the type =E2=80=9Cstatement=E2=80=9D.

* Would statement lists match the next bigger item in the abstraction hier=
archy?

* Will development interests grow for further topics?

  Example:
  Add a metavariable for the handling of source code
  2018-05-23
  https://github.com/coccinelle/coccinelle/issues/140


Regards,
Markus
