Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8561FCCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nQBSskfH2ELgXa6kPvuWTv0xsHVxBuWS0/JEu7LtRYA=;
  b=guSYSWvvwt0yRje7619+LvqFYSUf9Hwgrf8PrS3JabSr0zit0ni6YOD6
   1hT1DWqNQYzQr8E0/AqySu16gRBK8Y9uOGhKdK3cuF+OTHGW8p4ZEnzjG
   jTDpPwqFZtsVAMMG5xAvr0pCYvGgukWmhkZQjoDHhpbdVIaQ6Xk0yvCcL
   s=;
X-CSE-ConnectionGUID: lv4y7M0pQnKfitSGthjhmg==
X-CSE-MsgGUID: 6nDfmsrTTXGhO1wnUVj3ww==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246874043"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 15:22:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20EB1E0BE9; Thu, 30 Oct 2025 15:22:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 645B9E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 15:22:44 +0100 (CET)
X-CSE-ConnectionGUID: DsaNvn+sRD2oMqRnVlcKcA==
X-CSE-MsgGUID: 5VqNG2JIRz+N7BllBhjizw==
IronPort-SDR: 690374b3_iv0Xss+gV+Z4NA4FekgRW2u/4lHAoHfp8XXnXhR+SEdWTH7
 +nOriK6LCy7/Bq10Wi0J8LBJOieg9Vf6UrPePmQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FDAADLcwNpeAwR49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRViByHNoIkhDuHPIdViHmBVYF9Ag8BAwENTgECBAEBAwSEd?=
 =?us-ascii?q?gEJAoxTAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAFDDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJ?=
 =?us-ascii?q?gEECwsaAiYCAlYGARQBAYJ+giMBBhABAw8nB7BngTKBAYIMAQEG2l8fLCJZg?=
 =?us-ascii?q?WQJgRwuAYVsgmQBhieDQ3onD4FVRIE8glIxPogegmmCJoEOmGZSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSAQMwMqNC0jDzwFLR1wDCgSEB8YEWA9F0CDSRsGaA8GgRIZSQICA?=
 =?us-ascii?q?gUCQDqBaAUBHAYfEgIDAQICOlcNgXcCAgSCG36CDw+JEAIBC209NwYDCxsGP?=
 =?us-ascii?q?ZQzgglyWZlwjiehRTQHgjiBZ4FkDJ9sBhMvg3EBk2AOBpMFmQYiqR+BaDqBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hPoN1yxpCNTwCBwsBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:ytLZJK+nMQf1rdYFP85uk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AXVgW32gJ9vBSB2JkgoGSX6GW6DJuXmbU6mnWYFS?=
 =?us-ascii?q?CJTxubaSvT2GU84Bvup87?=
X-Talos-MUID: 9a23:0pltzAWfmxjBUcbq/GLSnRdNbuVJ2bbtLh8nlZEsu8uFJzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129507189"
X-MGA-submission: =?us-ascii?q?MDEUpDACDoWxAMMp86gCyuEdlXooC6ENVeDd30?=
 =?us-ascii?q?yJ23UM3FgBLLyHoFDsuIKDvIW7MjGBYZQE9jJsCiCQweI4ei3uTxryRz?=
 =?us-ascii?q?VmNVJ7oYB2OzXRaaE6apjEtJlVG1T2OaoFmJIDMAhiHPNAKIhv91/jcp?=
 =?us-ascii?q?BJsLB5Br/AB9LdQcpjyBBHNA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:22:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761834163; x=1762438963; i=markus.elfring@web.de;
	bh=nQBSskfH2ELgXa6kPvuWTv0xsHVxBuWS0/JEu7LtRYA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KGRfSEQ2cpp6T/2Dazmw64bF1jHIKcSmT/DbnWStyGV+RFwedl+XmBG2q9qDSqSB
	 hZHQ0/urJ4CL9sWIRZNf2XD9XDVte7SfWKBx+8ueTGoxQyHXZqqI7/KT1usa3Oxb8
	 6HsixA/Vnb34XHXq2h16BeGUFpruF33+4bgjeaTlFGRFJwW7Ahuie+1ze9XUvwuqt
	 8hDTYt9hlvER89h6KfWdSRkWpkOy3PVLHp13/iHZQvzzMHuqOMNLzpOXIAmaw+Eqn
	 YIqXB22OhxvLbtfCaYLqq1Zrdw1r3sPiLKX/Jf/8HZS0JEYXcVgsAg4X2KTy3TFCN
	 SWWucz6D2QNC8oZnmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1vdwuX48p9-00KieH; Thu, 30
 Oct 2025 15:22:43 +0100
Message-ID: <2232fb5a-2e5d-48a0-a8f7-97826e0946f5@web.de>
Date: Thu, 30 Oct 2025 15:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
 <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NfX8WnPjxKokgpSMU8CrErNXJDXfEOwMizA/0EtVVRtoaz564wF
 MarbB837r2Cs4Ct/jmvCwv/ZMoKbAcf4KsKuQCDiliidal2TPnI6mDbEqu52gqs8tqqrgzo
 3iQhUCCVnC6+W8RLm/ka1crTTjsdvCpAdOhenWVQdhKBtuPJeUxwqTkpFXBGDsSg4z/v1cA
 Nkj1AzxS7edioobgq8GEA==
UI-OutboundReport: notjunk:1;M01:P0:j1ZNHeiNWZw=;cRASlzf9s1VsgVNwDwMMR3JMESC
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3126
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/2232fb5a-2e5d-48a0-a8f7-97826e0946f5%40web.de>

> No chance, given Dan's negative feedback.

Will any additional arguments become more convincing for change possibilities?

Regards,
Markus
