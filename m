Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C230CC3DA79
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lumFx96YbyqpFGdNKgbNRfmLF1newdq/q5HXOSerItM=;
  b=A3I35V05vW+xvhGLhZjeGFf/F7taI+qdjN9qrRG69fElrLjrt9Cm96H7
   DACzueZDMinTKvWppSH+wtbQXOsrrJm2ulPUz1s/b92y0gcnv3jFrSNWl
   z8dYk+d27FQarQctE7/1rlP1RKTLT72l0/MLgfBH31veEsfBCrcMk1y85
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85078447"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 12:36:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01992E0138; Mon, 26 Dec 2022 12:36:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 93E53E0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 12:36:10 +0100 (CET)
IronPort-SDR: 63a9872a_C6OIvENgubQOzEf9MbGbOqhAIEaFnezPsfWE03+UCWjJGzE
 v7ImgQBkspc2w2ddsILzwIlrfGJwS1gaHA6ZUuQ==
X-IPAS-Result: =?us-ascii?q?A0H1BwDwhaljhk7ASNlagQmDfIEHVi4EC0WET456giiEK?=
 =?us-ascii?q?45Wi3g+DwEDAQ09BAECBAEBAwMBgguCcwKFEAIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEYCRkHDgULBSKFaA2COCkBEWSBC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdTP?=
 =?us-ascii?q?QECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYJ6AYJtAQMOIwcMrxuBMoEBgggBA?=
 =?us-ascii?q?QaBQAEVQZlxHywiU4FeAwaBFCyQKXonEIFVRIE8glMwPoJiAQOFNYJnjmeDA?=
 =?us-ascii?q?Ic0CoE9fYEnDmQlBA4DGSsdQAIBCzsyCkE1CQIMSysaGweBCiooFQMEBAMCB?=
 =?us-ascii?q?hMDIgINKDEUBCkTDScmawkCAyJhBQMDBCgtCSEfBxURJDwHVjcBBAMCDx83B?=
 =?us-ascii?q?gMJAwIfT3ACLhEVBQMLFSpHBAg2BQYbNhICCA8SDwYmRA5CNzYTBlwBKgsOE?=
 =?us-ascii?q?wNQgU8EL15/CgYpKJptgwFZgWijSZ9xNAeCIoFPgVAMiXeUeAYTLoNmkxAOB?=
 =?us-ascii?q?pIal0aNRpo4gXkjgVwzGiRPgmdPAxkPjjmEDIELiSFANAIJMAIHCwEBAwmFR?=
 =?us-ascii?q?wEBhloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Lkk2TaEx8j2l/EkOpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="43651786"
X-MGA-submission: =?us-ascii?q?MDHgQ6UqGD8SNnKAIUv4cccN5soOU3xy72H3q0?=
 =?us-ascii?q?DSAZboLd2MssWSmfZm4S5/bfb03QfpBMS1E7828mZzwbxQExs+EHAMms?=
 =?us-ascii?q?P9eehAhQU5DHKpVmIDggOBYxuQoog22YvsMzn6aTloTUF2aGXJf9FqVD?=
 =?us-ascii?q?b9qVfyrbObivqHVHLwtF8l5A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:36:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672054569; bh=A324/IgoEhObY8PYO7DS7sSzVrcBxAF/XeinyQ9GyYA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uUwTaMp921wdHmoqcfvD16m7kR4gS1p21+1ZlwxZVP9Nv9SssjXKuea2KvqyEX3zu
	 3TzWSnlM3jq7HK2maRo6Vgut+35ZX6/xHIucWOWr32f7s8N9sCaYxT+aFX4VdEvlTP
	 RXPo48EO+AzsOXrB9UvNH2RT1CbSGTTMS2ksvbVfPF/fPjoJiLA15wvZA7rVmv2286
	 g5RekMu7rqIth5cIAMt4tY5noZ3gwK6dX0/d1lhy06hJreidG93r4Jr13J+iqZ0H/E
	 URf11LDpqhgJW5cG/aaVgc79ivLdWAz3dfmP27L1SsZfTATDWh4dAg5cjXayOWK5kY
	 9FtqqJnaxxA1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1oWdOl0uSA-00nJlE; Mon, 26
 Dec 2022 12:36:09 +0100
Message-ID: <a243719b-5c02-fbd1-e1aa-dec9e09d5a2f@web.de>
Date: Mon, 26 Dec 2022 12:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uwj/RFsjGTZBZ1t1vthqrgaQCbMJkRDm3I4l5fp+dqGo7mcyUfj
 Rk/4O8WhLsYiB5i0A7vtqDO28DJIj0+FVyCRSUvh5aKp7PVlDzQ9DoZJ5zJ4KKBuOQXuv83
 qejuf9rABl54yxIALYvBtJd2IooPY/DaetlJ60NsHsq78wrRwPMaqjZCaCGdmDrV69KCNhI
 jMB3PCnKwYZ6YhQCmtnLg==
UI-OutboundReport: notjunk:1;M01:P0:83RmFQZVnaM=;ulY+NE7+LuJlsE5g5h9vwlpdN6L
 JMDkvfdWzETqHzhwxzINX0TF7ZFJ3hBJXoXfbNoEctTlIE2/cDaE+aUl43PuqU2aT8R8wQrSh
 eylxwbjD38yi3iSe7jfsvtm0K05t1giK+vS88tRzdJiS73Jhe8oS8WrQammcXsZyHI9plwZXu
 JqMVZ6QjPnAaEEhlVszj60o55jGVfrv6hZ1B9ed6G5KCQZk1bekRGdejFVWMpN17wgE/BIpah
 JrFkHIOrKpUyhOwESiuNfLuHNXIqGrDbbQATAo3voEDQ/6BHdO/kpOj5Z2PdyxZb6aRpTT/2q
 OyrE9K0q+1TCVk5jow8Smr+yx7cbMknv3vftyP9PieNiaqKUlEaucOnysnmUPxxt8WHl2wpP2
 4FHYZiGVm/4kS1mtFxmbGENlytrjo/AQA5SyiDxTUWG+WTopLZcT1Dyvp7m1bwy/iql3KVl/i
 8ijF0wAkMcAATDwKAmo57ZotrZIagEObNsqyYd9cw2xOXfS85WdbxhC6FoX9pb4LkBXbNp2sd
 TN5YMkWNA4AWZsI3dPlm5UxboK8ITsA/q7LTgQ2N/t1FKYcZWLCPyGIMvTm2JEy7xDPmBZf2y
 4igB6txCEv8TmjYJTlZqrz63NgRxzyI7D2Q5Me6XPXpirlTpmtOfud+6Lrq5529qTrPiwhuzi
 Xvfd5XWIW0ReVxoYlwDWl7zG9eHJRdgVo6bO4pqxW9pLkTwnth7UDdR16a5ItbQf2D7KVHjHt
 q1x8Klbc6os0ZoQme2ft/NnLxg54Tdw2AaOY43kqu24k0xq4rkOJuQP1xv7tLb5fPVU0HoLxV
 On75tKY6oO2vt+9hZXbEm7Idcc2iaySR+eJwBOoSeus+XIj1nhbdRbyxXFlwlS98lZ7IPVnK6
 P7LoMBgzdLKDochk0N3NAK46/vBxtbF9nr5GA4p4pd/k19FUGYhnj3GeqKotNArammochh36B
 HTkNZw==
Subject: Re: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 791
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/a243719b-5c02-fbd1-e1aa-dec9e09d5a2f%40web.de>


>>> Don't you want something like
>>>
>>> expression list e1,e2;
>>>
>>> and then call(e1,active,e2)
>> Does the specification of this metavariable type indicate the expectation
>> that the applied metavariables will receive contents?
> No, it should not.  Lists can be empty.

Will the distinction if list metavariables may be empty (or not)
occasionally become more relevant?

Will the chances grow to extend the software documentation accordingly?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15af39865329c2fe23460d/docs/manual/cocci_syntax.tex#L425

Regards,
Markus
