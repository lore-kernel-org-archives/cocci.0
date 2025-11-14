Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44BCE7A89
	for <cocci@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BcggdO8qz6q2CSEIXXckfk8D/QGMGiRJH0HWfAk1xfc=;
  b=d8aMr2D5gTbfdxIecR22CxrZkafkjF1R3mA94GHzqvyhPwiG4ik33+4J
   xK03eTSq7p65v9C5q9CsQ3JI/fBeARCOFIKmNTXSOfPJxk+addgL4FsvV
   vuBLMMMJIEiOFj1/RgnotbdF2EQ8HKCygrj/2WA8LTAB3ek9u2NPjpLnm
   I=;
X-CSE-ConnectionGUID: 0LkDHE2CR1Ka+eRrmjgVWA==
X-CSE-MsgGUID: N+WjHkpDRZ+hvRIWbOOdLw==
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
X-IronPort-AV: E=Sophos;i="6.19,304,1754949600"; 
   d="scan'208";a="249117677"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Nov 2025 09:30:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8063EE0BE9; Fri, 14 Nov 2025 09:30:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 649ABE0171
	for <cocci@sympa.inria.fr>; Fri, 14 Nov 2025 09:30:49 +0100 (CET)
X-CSE-ConnectionGUID: kNF6A/hiTn+dep8j63q75A==
X-CSE-MsgGUID: kK6KlofbSWOCEFO2mjSRXg==
IronPort-SDR: 6916e8b8_r2EebOh/vrse/lyn3KAGR2XgXR80XD5jBTUUnbxke+JJl46
 hPrP2b1Pj1vU//EATf6uTY4FXEADxLATQU201Aw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FHAAD85xZpgAQP49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/ZR0GWDMEC0kIhE2IHIc3giSEO48Rik6BfQIPAQMBDUoEAQIEAQEDAwGFA?=
 =?us-ascii?q?AKMWwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGFQEBgn4Bg?=
 =?us-ascii?q?iIBBhABAw8nBw0GsTCBMoEBggwBAQaBWEHYRh8sIlmBZAMGgRwuAYVtgmUBi?=
 =?us-ascii?q?Wx6Jw+BVUSBPAuCRzE+gmEBA4Feg1uCaYImgQ6GJ4pPBohoUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwOBCyNLBS0dgSQiHxgRYD0XQINJHAZoDwaBEhlJAgICBQJAOoFoB?=
 =?us-ascii?q?hwGHBICAwECAjpVDYF3AgIEghl+ggoPiUiBGwIBC209NwkLGwY9lRZRgw5ZL?=
 =?us-ascii?q?4IOo0KiezQHgjiBZ4FkDIoulT4GEy+DcZNhDgaTBZkGjgibOYFoOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiGEM4ELwy5CNQIJMQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 0xv4uOfSeEq6Suq/Fo9YFbH9nNYrQ==
IronPort-Data: A9a23:D9fAxqxgASPwKrK+jyF6t+dVwirEfRIJ4+MujC+fZmUNrF6WrkUFy
 mAWUWyPa66MMTf3ft9wOYzi/EkP6pTVyoRqT1ZtpFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtFg06/gEk35qmr4WpE5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K33CuDgRrukoKHKJ0hXV/011lrPgto
 Dl5jqFcfC9yVkH6dEvxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRhOlqbyfh7K6du8visk7fMu1Z5pA51g1mFk1Dd5+KXzCa6DN+MMewzo6wMxDdRrcT
 5BAM3w1NkuGOkAJZj/7C7pm9Ausrlz2aT5FsxS4oaQt4m7c5BN82v7hPbI5f/TTHp0FxhzB/
 D6uE2LRATJEF9iYxzC+zVWHq8Hoxyb5Y7giG+jtnhJtqAbPljRIWEJ+uUGAifK+gUW/c8lOL
 lQdvCsot6k7skKxJvH5VgKxpHqsrB8ZUcBZVew88gCEjKTOizt1HUABSSNdLsMrvok6SFTGy
 2NlgfvqIxIxmfqVSE6btbuZtWOwZ3MMcjIrMHpsoRQ+3zX1nG0kpj7iJuuP/YawicDpXy79y
 XaGoUDSZon/b+Zajc1XHnie0lpAQ6QlqCZot207uUr4v2tEiHaNPdDA1LQixa8owHyloqa9U
 IgswJTOtLteUvlhZQSMR+MKB/my6p64DdEounY2R8NJ3231pRaLJNkMiBkgfhsBGpheJ1fBP
 hSJ0SsPv8A7AZdfRfUnC25HI556lfC4fTkkP9iIBudzjm9ZLl7aoHE+PhTPt40v+WB1+ZwC1
 V6gWZ7EJR4n5W5PkVJans9Mj+F59TN03m7JW5HwwjKu1LfUNjbfSq4IPBHKJqo15b+N6ledu
 dtOFdq4+zMGWs3HYw7T7dEyK3IOJiMFHpzYkZFcWdOCBQtEI1sfLcHt74kvQbE4oJQNpNz0p
 im8fmR61GvAgWb2LFTWS3J7N5Lqc5VNjVM6Gi0OZmSX+mURTruuyIw9dJIHW6Yt28I+7PxzT
 tgDI96hBNYWQBv52j0tV7vPh608SwaOmiS1IDuDXDgzW7VCVj750IboUSW3/RZfExftk9U1p
 oOR8z/yQL0BdlxEN9nXYvf+9GGBlyERt8wqVnSZP+QJXlvn9bVrDCnDjvUXBcUoAjebzxu40
 zemOzspldPvkaQUruaQ3bulqr23GdRQBkBZRmnXzYinPBngo1aM/9Vyb/aqTxv8CkXP56SQV
 cdExardMdoGvmpwnahSLrJJ9Z86tvzT/+J07wI8B3jaTUWZOpU5KFm84MR/nKlsxLhYhAiIZ
 nyy6uRqYbWnBO61EXo6BhYUUeCY5PRFxhjQ9asUJWv51g9W/Z2Gc1lYZCfUrCpRKIp0bYAX+
 sY6mcss8wfkoAEbAtWHqSF19mq3MX0LVZs8hKwaGIPGjgkKyElIRI71UAvaxY6pUMpdFHUqL
 hu/prvwt54FymXsK3MMRGXwh8xDjpEwiTV25V4lJWXRvOHah/UyjSZjwR5uQit7lhx4gv9OY
 E51PEhIJIKLzTdipO5He0uOQwhhJhmoynbd+msztl/ybheXDzTWDWgHJ+yy0lgT8Dtcchhl7
 bio8jvZfgiwTv7h/BkZeBBDkOPif+xT5weZucGAHua5JbcYTwfhoJeTYTsvl0O6L+I33FbKt
 Mt7ztZWMKfbDxMdk4c/Koud1IkTdiy6GXx/calh0Z4NTE7he2CU+DmRKkqOVNtHCN7U/GSZV
 cF/BMJ9eC6v9SSJrzxBO68oJoVwvf825egtfqHgCn4GvoC+8BtoksP03QrviFA7R+5BlZ4GF
 brQUDaZAEm8uGBxmVKRnPJbO2G9X8YIVDf80M+x7u8NMZAJ68NoTm0fzZq2uC+zHDZ83hfJo
 j7GWbDa/9ZixatogYHoNKdJXCewCNHrUdW34BKBiMtPYfzPIPXxmVss8He/BDtvPJwVR9hTv
 paOuoSu3Er64ZAHY1qAkJyFT6R09cG+WdRMCf3OLV5YoDCjXfH96B5S6kG6Lp10yOlm3PeFf
 DfhSsWMdo8yYex/lU1lM30UV15XDqnsda7vqB+st/nGWFBXzQXDK8jh7nPzK31ScigTIZDlF
 wvooLCU68tFqJhXTgoxbx2870SU/He4MUfnSzHwidVcJmyvn0/Epbbo0xYtgd0O5r9oD+6ii
 a8phDCnHPhxhE0M5M5Uucp+s3X7yV5j1PIocBt1F8Fe0liH4a1vEQjZGYoLANdYn0QeEX0+i
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:yOHQqa50EH2WoOJvCwPXwfeCI+orL9Y04lQ7vn2ZFiY6TiXIra
 +TdaoguSMc0AxhJE3Jmbi7Scy9qADnhOFICOgqTPiftWzd0ldAQ7sSlbcKrweQeBEWs9QtqJ
 uIEJIORuEYb2IK9voSiTPQe71Mobm6GeKT9J3jJ7IHd3ASV0gK1XYcNu/vKDwReOAwP+tfKH
 Pz3Lskm9IiEk5nNviTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIO/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfqWG0hYczBgNkGmpDq1L/sqq
 iKn/4UBbU315oWRBDynfKi4Xi47N9k0Q6d9bbRuwqTnSW+fkN6N+NxwbtDdB3X8kwhu8w5/p
 5q8guixsFqJCKFpT/64dfQURFsiw6TmloN1cAur1E3a/pFVFd2xbZvo399IdM4ByT955kgEO
 5ySPvE7PITXF+GZ3DdpC1Cx9bEZAVvIv5DeDlfhiSYvgIm7ExR3g8WwtcSkWwH8494Q55Y5/
 7cOqAtj71WSNQKBJgNTtspUI+5EWrIBRXHK2rXLUXgfZt3T07lutr256gv7OewdvUzvewPcb
 n6IRtlXFQJCgnTINzL2IcO/gHGQW27UziowsZC54Jhsrm5QLbwKyWMRF0njsPl+pwkc4Hmcu
 f2PIgTD+7oLGPoF4oM1wriW4NKIX1bVMEOoN40V1+Hv8qOIIz3se7QdurVOdPWYHsZc3K6Bm
 FGUCn4Jc1G4EzuUnjkgALJU3eoYUD79YIYKtmSwwHS8vl6CmRhiHlhtb3i3LD5FdRriN1FQH
 dD
X-Talos-CUID: 9a23:3t4ZVG3Uv974n18PAHl147xfGeYLLFSazHbsJQy0BH45SuPOUADN0fYx
X-Talos-MUID: 9a23:ovrJNwhHwY7NcHvIVmfJr8MpN+Q2wKCpBko2rrItluejbylyAA2tg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,304,1754949600"; 
   d="scan'208";a="130802124"
X-MGA-submission: =?us-ascii?q?MDGQpiDqywBe2glT5MTBXGapbb5lYmfXe0l0jG?=
 =?us-ascii?q?jbqWnORmM8RZL9pVj0uSNnc8b6W2yzJdiDkLPbKGJT9aZksKhO+93iEz?=
 =?us-ascii?q?EiVEuyFJ7sug7xWVrtjeRWpRu2xTvP16VzTpJ/SnvLizXmSKLOQaTjrF?=
 =?us-ascii?q?WF1E699w7ulQzUOWhipsfeLQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 09:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763109047; x=1763713847; i=markus.elfring@web.de;
	bh=BcggdO8qz6q2CSEIXXckfk8D/QGMGiRJH0HWfAk1xfc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jKbHpC42qLYm0zmKuTg64ZhRVnWTKPB+Re87Q5t8dAl/mDd7HlTC42t+deaj5+B4
	 2QiFeHBHN/f90bETFBRtR1TG8dXtXf3E/99tuCnBwYkDKkT3mCMQiiFQwguUdj+DP
	 uT+ET2FGMuk9w80vPcGeOKC/dcJqh3RrsoglgE22/Q/5Vwsroj+utgDtbJ6BIME88
	 Iqyl/Jwr4p+x8mYQVtLgANcNhfTzpj1H5vy+JCc9cgZeUj27A55WuBefVsQNFD36+
	 KTG+7hm18h695575SlekP8gQ8dorsJ6l0etyf+lx3m5jOrLYI9g6EKmM4u7lbmG4m
	 qU+sOEqV2F3A5QhQxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.197]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1vN6yh1v1Q-00H2Vr; Fri, 14
 Nov 2025 09:30:47 +0100
Message-ID: <81e13b2e-3895-4531-97c8-2e7fa035e6cc@web.de>
Date: Fri, 14 Nov 2025 09:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
 <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
 <205e1503-d79f-4580-b496-67d16df26c51@web.de>
 <b311a87d-7d1-359f-42db-2c5618b6158@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b311a87d-7d1-359f-42db-2c5618b6158@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ccIoo3NWo+Jfqhf8bhhxmohPVqcj5N+uF/TwhOiqhvd97qMDHpF
 SJ4j7EezHD1efwcGRUkTGgmhfoFzpdifR4JRD5a2uwwWzNaSCOjRpm9YSeP1Y3Gx/+wAOf+
 wcM8fSh9U9ohDYXUsA7D4erFmT0LQj/N/tYgvTArZutTi1S3pUnsTFVv5HV7rPQ7VkdzrSa
 cljUthq8MiVuj7SVlbdZA==
UI-OutboundReport: notjunk:1;M01:P0:ywGORVCK4Ls=;cvQPLzI3HqhS1K/Uldku7JsM6dm
 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
 LOM3WcXc=
Subject: Re: [cocci] Improving support for casts in SmPL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3175
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/81e13b2e-3895-4531-97c8-2e7fa035e6cc%40web.de>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2=
731a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L456-466
>>
>> I find this information source unclear in the way for pointing a possib=
le property
>> out for metavariables of the kind =E2=80=9Ctype definition=E2=80=9D.
>> Do they refer to a fixed type name?
>=20
> typedef is for declaring that a name is a typedef.

Some metavariables tend to represent the concept that that they may refer =
to
variable items.
There are also metavariable kinds that contain a =E2=80=9Cname=E2=80=9D.
Are these ones fixed finally?

Regards,
Markus
