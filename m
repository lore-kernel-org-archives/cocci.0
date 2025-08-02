Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5510C87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wdrYMT/UcjHA+TfjHH8GJ+l0kSWONe4gqBB8iUGY9Yg=;
  b=j4Qa5kDVbAjG4ygjarIvP1nRlpkzv7cHDHhKaxYaLXPjDxGrVPW5adGe
   GlJZqnGfqBsR6lh8/dZrlByoY34Bk5a4sEXrv0vhy110ggmG7L85GkVXI
   983NQaeN7CGncSmagv4GrChFx0vmIpArKg+WKre0TMzs/5CwADyrndVH3
   U=;
X-CSE-ConnectionGUID: P4wUJ2kgSPK/XQuRql05Ag==
X-CSE-MsgGUID: KFYDGsljTtqf/llfzfXaEA==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233952889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 13:51:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 463C6E0B0D; Sat,  2 Aug 2025 13:51:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5DF96E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 13:51:46 +0200 (CEST)
X-CSE-ConnectionGUID: dNhZEJyuQz24SihgUAgAoQ==
X-CSE-MsgGUID: uZ4GUqThSEWcu1uYD7LfVw==
IronPort-SDR: 688dfbd1_5p8SMMUa1fgkT7keyjnpdiIPethaUiMr4btul/8OYRtaoKZ
 e5BYxTYXVTLr2D8oaaEylnsth7Nit2mHsI9wGAw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E8AgAA+41ogAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgQAGVDMEC0kIhE2PUIIhA4Q7jxGIeYFpgWkCDwEDAQ1KBAECBAEBAwMBg?=
 =?us-ascii?q?gyCdAKMGgIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfgGCIQEGEAEDDiQHDQawNoEygQGCDAEBBoFGBQ1B2EUfLCJZgWQDBoEbL?=
 =?us-ascii?q?gGFbIJkAYYng0J6Jw+BVUSBPIJSMT6CYQEDgSA+g1uCaYImgRaDY4ZyhhKIc?=
 =?us-ascii?q?FJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ32DDYEOhCcrT4IidYF5QRk/g?=
 =?us-ascii?q?1MeBm0PBoEVGh4tAgICBQJDRYFgGQYaQAIBC209NwkLGwY9k1SDIWhZVIEGl?=
 =?us-ascii?q?zSvbDQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBiKNZps5gX4kgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQzgQu8XEE1AgkxAgcBCgEBAwmFRgEBi1uBSwEB?=
IronPort-PHdr: A9a23:od2WCB9x24+wg/9uWbq2ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 wqHvr401AGVDc3y0LFttan/i+jYQ2sO4JKM4jgpUadncFsor/tTtCEbRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiTSzbL9oM
 Bm7owrdutQKjYZjJas8yQbCr2dVdehR2W5nKlWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQ
 KJbAjo7LW07/dXnuxbbQwSA/3cRTGoYnAdQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86
 apgVQLlhz0GNz4992HXl9BwgadGqx+vuxBz34jZa5yOOfFgYq3SY88VRWtZXsZQSSNBBJ+8b
 5ASBOYFJOpUspXxq0cLoRa4GAKiBv7gyiVQi3H106M13OouHxzY0gE+EdIAsHbbo8n6OqoJT
 eC11bPFwSnfY/9I2zrw7pXDfBA7ofGLWLJ9ac3fxlM1FwPGk1WQspHuMTyR1uQDqWib7uxgV
 e2ygGMgrA9+uCKvxsQxionSnI4bxVTE9StjwIY0I924R1V2YNC6H5RLrS2VKpV5T9okTmp1t
 yk01qcItoSnfCgW1psn3RjfZuSZfoaH4R/uWvudLSp3iX95e7+xiRS//Ei+x+DySsW4zkpGo
 jdGn9TOtn4Ayh/e58yZRvdh4kqv1jaC2gHQ5+xEJ00/iKTVK5kkwrEql5oTt1zOHi7wmEXsj
 a+ZbF8o+uay6+nhf77opYecOpdqhg3jLKgigNKzDfo6PwQUQmSW+f6w2bP78UD9T7hGlPM7n
 rTDvJ3YOcgXvLO1DglI2Yg58Rm/FS2p0NEAkHkHMl1FfBWHgpDsO1HJPfD4Ee2zglqynzhw3
 fzJI6PuDo3MLnjFjrjhYa5w51BBxAYt19xT+YxYB7MbLP7uWkL9rtLVAgc8MwOuwubnDNt91
 pkZWWKKGqKXN7ndsUWL5uIyOOmAfoAbuDLzK/g/5v7ui3A5lEQTfKa3xpQbcm23Eep+L0WDf
 XXsmssBEXsNvgcmSOzlklODXiRXZ3a2RK895zA7CIe9AofZXI+hmr2B3CGhHp1XfG9KEF6ME
 W3we4WeR/gMcD6SItNmkjEcSbehTJMu2g2vtALh0LpmLu/U+jUCup751dh14ffTlRAo+jBuA
 cSdyXmBT2dvkWwQXT85wLh/oVBhyleEyaV0neRUFdNN6PNOUQk0L4bRweJ1BdzqQALOYMmJR
 lW8TNi+BDExSc8xw8MUb0dzBdqtlQrP0De0DLMNirOLB5008qfE0nbpKMhyxWjI2rU9glcgW
 sdAKGimibRl9wfPH4PHi1yXmb6le6gExy7N7GmDwHKUskxETQB+TL3JXWsHZkvYtdv55l3NT
 7upCbk/KgVP0NaMJKQZIuHu2HdbQPbqcPDXfGu1ny/kBwuMx7rKaIP1cmEZ9CTbEkkN1Q4Jq
 zLOPg81DSaJomTEDTUoG0i8TVnr9LxboWm4U1R84gWEdUxn2PLh3xcPhuGHDd4X0KgFvigJt
 Dh+WlqwiYGFQ+GcrhZsKf0PKeg2501KgCeA71QV1v2IKqljggVbaAFrpwb10A0xDIxckM8sp
 XdszQxoKKve3kkSPyiA08XWPbvaYnL34Ajpc7Tfj3TXytWL4eEi7PoiqlPslB6kHAwu/iYvy
 MFbhkOV/Y6CFw8OSdT0W0cz+QJ9ouT/azM++piS+HliK6iyvRfd1thvCOZ2gg24cYJ5N6WJX
 BT3D9VcB8WqL7kynEO1axsfIO1I3KszIt/gaPaMnqKmVAp5tBShi2kPoIV000bXsjF5VvaNx
 JEdhfeRwgqAUT74ylanqMH+345eN3kUGSKkxC7oCZQ0BOU6dJsXCWqoP8y8x8lvz5/rVXlC8
 Ve/BlQAkMa3cBuWZlb50EVez0MS6XCgnCK5yXRznVRL5uK61TbN3v+kWR4JIG9NS0F9gF2qL
 YX1x9EWUU60bhQ4wQO/7BWyzKxaqaJjamjLFB0RJW6sdT4kC/b27ennAYYH8p4jvCRJXf7pZ
 FmbTuW4uB4Gy2b4GHMYwjkndjass5G/nhpgiWvbImwgyRiRMcx22xrb48TRAPBL2T9TDgxxk
 zrKHR6RO9ez/NObv4jOuKayWijyM/8bOTmu1o6GuCahsCdPCAe8guv1t9npCwk83gfk2tMsW
 SiC/3OeKsH7kq+9N+xgZExhAlTxvtF7Fo9JmYw1nJgM2HIei/155FI/mHzoeZVe0KP6Nz8WQ
 CIThsXS+E7j0VFiKXSAw8T4UG+cy41vfYvybmQT0yM7p8dEbcXcpJlNhyhouRyVqQzLYP5yt
 igQw70i5TYWjvoItwwk0iiGSupLRw8CZ3OqzknOtJi3t+1PaXyqcKSs2UYb/5jpF7yErgxGG
 T74dpokAS5s/5B6OVPI3mf079Ksc93RYNQP8xyMxk2Z1a4Pcs13z6dM3nkCWyq1p3Auxu8lg
 AY72Ji7uNPCMGBx5OeiBQYeMDTpZsQV8zWrjKBEn8/Q0Zr8e/cpUjgNQpbsSuqlVTwIsvGyf
 SOHCj4hsTG2HbTFHAmQwFhrpTTDHtr4UhPfbGlc1thkSBSHcQZ6iRoXQS58s5o3DAGsy+T+f
 U0/6j1btTua4lNcj+lvMRf4SGLWogylPyw1RJaoJx1T9ghe5k3RPJ/W/qdpEipf5JHksB2VJ
 znReVFTFW9QEB/hZRirLvy06NLH6eTdGueuM66Ef+CVseIHH/7awJWyzs158jzKOsjHNytnC
 OAnn1pNWmpmEt7V3SoCQWobmkevJ4aS9hK75zEypMei9v/mHh3i782DBvNbY9Bo5gzziryJK
 uqTwn9wLzoBkJgLwBqqgPAWjlsVlj0rfCKmFq4Y83fESq6J3KRQClYNYid3fqOk9ooa2Q9Ac
 Y7eg9Lxjftji+ItTkxCTRrnk92oYsoDJye8MknGDQCFLubOIzqD2Mzxba6mLN8YxOxJqx29v
 yqaGE7/L3yCkTfuTRWmLeBLimmSIhVfvIi3dhslB3LkSZrqbRiyMdk/ijNTo/V8nnTRKWsVK
 iRxaWtIqaCMqzxViLNzFi0J73ZoK/WFhzfM7+TcLcVz07MjCSB1muRGpXUinuEMtmceHqMzw
 XaU9Y0LwRnuiOSExzt5XQAbrz9KgNnOpkB+IeDC8YEGX3/Y/RUL5GHWChIQptIjBMe83sIYg
 tXJiq/3Ly9PttzO+s5JTe3dMsGaKzwMNRTzGTjbJBQIR3inOCuM4i4V2OHX7XCTopUg/9L0n
 4EST7ZASFEvPvYdF1gjA9EIZpt6FGBB8/bTnIsD4nywqwPUTcNRs8XcV/6cNv7oLS6QkbhOY
 xZgKVzQMokZcIH2iRUKgrhSmYPXBwzPUNoLriAzNmfcRW1S/XI4QmBhgyrY
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KrniPq8nh3Y68k3koiduk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A0Iu3Umif+xBkCuE1eqRlVYFMdjJuflvd/lryMlK?=
 =?us-ascii?q?BGzw1c7yVRmK594pjqp87?=
X-Talos-MUID: 9a23:bL8LcAi+BknjiNjof4xFRcMpKfU0zJm3NEA2vKoNppCZBAAvHzmjk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122656521"
X-MGA-submission: =?us-ascii?q?MDHbeKYKw04+EVewoS5lO8VXmDi+JIyT/i31hD?=
 =?us-ascii?q?oQF5OBD+33k1j9l53WuRdwoXuVmrSC66aVoJYqCKANvowmyEsiFkx+Ys?=
 =?us-ascii?q?MizQZch1HVDn54ljDs+8VDYqiyxNp0c31JFRcbYMn8EKQDex+8nWlz86?=
 =?us-ascii?q?iJ5Dx7BL1ouhaxpPRytW3mZA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 13:51:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754135504; x=1754740304; i=markus.elfring@web.de;
	bh=wdrYMT/UcjHA+TfjHH8GJ+l0kSWONe4gqBB8iUGY9Yg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JCoSTkswOpdnfvlrcLMokZ0US8IbCx8qBeVXC40+o8p739/xHpsDcKvxXIc+z1S2
	 Vwy82hfAMO0N7vTa1rlAiDu06oxBbZi/Fyqvx7y2iMLlGUa9fl6LYl9eEXtdobeMK
	 uGe3ZqB2medmJ6G2FAVTMDpfKwpAQ3MMafiFojD9O+6kcao3PPDVwuONmo8/MVk8b
	 MAlUDSerlBVcctYcYZ/aQQuurRedElefpBxXg+Bl6J2QPIKs3VQsmDfN/B0Sl7j4P
	 S44cGERITQ5x52FaPw6OxAtr6m/hLgvgiEEa4i890rKZ3aKKvZSBPOn4/diqEsUXC
	 3gjK/al48wu02YtHDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1umpLQ3hER-008ouG; Sat, 02
 Aug 2025 13:51:43 +0200
Message-ID: <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
Date: Sat, 2 Aug 2025 13:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5hnBgORzwXbrr9+c1gmln83xZyDcZhOCoarTzmohrtRy/V+UtSA
 j6kSDPf8tIv92MWQBV9IPsPQiD0XW6xr9tqieUJV1LeTxgK349tq+Zm9UxMMO5BJe7ogmlH
 5erxNYYHm2bszltAJ4Phajx78Do40s8fqgvex399UzKWoUsZsJa4ICyJ8iOXZ+nYr9q465e
 jm+hsp75WozImwFICssng==
UI-OutboundReport: notjunk:1;M01:P0:KgPS5wysp/E=;Qv3gqXxEX/bhctTlAFsAOJk/j9z
 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
 cSC5mSEz8Vi/9c=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2928
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/7560a81f-ba29-4b16-b8ed-95cb4d72f3f4%40web.de>

>>> Would you get into the mood to clarify data processing challenges bett=
er
>>> for another source code search pattern (like the following)?
>>
>> How reasonable would you find a test result for another source code sea=
rch approach?
>=20
> Completely reasonable.

I got an other understanding for the functionality of the Coccinelle softw=
are here
so far.


>                         You match pairs of subsequent locks, but you onl=
y
> mark the second one in the pair.  So you match two pairs:
>=20
> action_lock(&blockage1); and action_lock(&blockage2);
>=20
> and
>=20
> action_lock(&blockage2); and action_lock(&blockage2);
>=20
> and you mark the second one in each case.

It seems that our data processing expectations differ once more.


> It would greatly help communication if you would also provide the answer
> that you expect.

A =E2=80=9Cshortest path constraint=E2=80=9D is mentioned for the usage of=
 the SmPL ellipsis.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e31292be=
31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1035-1043


=E2=80=A6>> @display@
>> expression x, y;
>> @@
>>  action_lock(x);
>>  ... when !=3D action_unlock(x);
>> *action_lock(y);

May I expect that only a single call should be marked for such a test case=
?

Regards,
Markus
