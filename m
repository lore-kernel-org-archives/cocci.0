Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8CFC282D3
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D5uGxiyDcm3Shg8mLoX3Q0SCviCq0xuD8oG42U/2OLM=;
  b=aqNJ7Ivm9fCURgP3Le+ZQVzOgRfUiBQt1OOaFhnifZePCHnXEXRqIu8q
   OPo60pUOsAwPBdF2/n3hQ+Wk8IMEXyDx9PKIIRiYvvS1ig6dRicCXmXz6
   cuFhrzbXlxYbJN1uNmERccZFFGY5ajS8u3zxRHEqA06kcp2riKbtutskE
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
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211241923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 08:38:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9334E0D1E; Wed,  5 Mar 2025 08:38:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 54A60E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 08:38:49 +0100 (CET)
IronPort-SDR: 67c7ff89_TjvkgnYRjeMlBAPyZ9WBSGMQDQlDePDqVYb6GEmPh4/XBp6
 PIVrEsRSleUtUOFM/+d5cDHlkmnmoEgtyY0iviA==
X-IPAS-Result: =?us-ascii?q?A0GBBAAp/sdngQsR49RaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0MIQ7hzuHU4RvhAaBVoF+DwEDAQ1BAQIEAQEDBIUAA?=
 =?us-ascii?q?osWAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn6CMAEDDiMHr1WBMoEBggwBAQbaXB8sIleBZQmBGi4Bh?=
 =?us-ascii?q?WuCYwGFazuDQnonD4FVRIE8C4J4PoRDg1uCaYIzhEBnmgaOXFJ7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBKRAzAyAKNDECFA0PFhBuBTQKNzqCC2lJOgINAjWCHiRYgitqBAWBJ?=
 =?us-ascii?q?II3hD2EQoI/UYJCghFxbwMDFg8BgjBvdxyDTHc7hHIdQAIBC209NwYDCxsGP?=
 =?us-ascii?q?aIog090gX9Sx0U0B4I4gWaBYwyfXgYTL5dGDgaSfS6HZZBrIqkRgWkBN4FcM?=
 =?us-ascii?q?xokgzZPAxkPjiGELcg+QjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:wrH+/KtadSlmu3AKGgt3c8JW7skDFdV00zEX/kB9WHVpm62j9/
 xG885x6faZslwssRIb+OxoWpPufZq0z/cc3WB2B9qftWLd1ldAQrsP0bff
X-Talos-CUID: 9a23:djqeFmMr6mQCx+5DYTQ//REwHsYfI2zv8Ez9B2vpAmowcejA
X-Talos-MUID: 9a23:Vp1ITQYraYF/JeBThmP8uhtAbNtU+qWCBUoHwZ86pdGYKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211241907"
X-MGA-submission: =?us-ascii?q?MDHO9/kwnBnB0Cv5ku5PoTySlgUGS9lZ6uQwlR?=
 =?us-ascii?q?+FP+CpBERqm7lDRZWHL1VMwOLbezbGq5hpfRJUZ46lGYl8rl2qMSMunT?=
 =?us-ascii?q?yf058b9Iz82hGJKEAhLHDKUuCGz2+SgA8jahUPWTJvxlbg9tkqrcfTwD?=
 =?us-ascii?q?IaHfk52dMTx03TcvAvhFhalg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:38:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741160319; x=1741765119; i=markus.elfring@web.de;
	bh=D5uGxiyDcm3Shg8mLoX3Q0SCviCq0xuD8oG42U/2OLM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pmL8bH7dtNwwP1NP6sfHcoAB9agjFS2De39RG3ASlY/U4QVNBqnQXdvnoQ+TpCov
	 sKpOHk2EHys1Cavdd5D1+9ma53P2ennYUA3+uqtul6VBSRk8h/1BTrrUN9B8iiQvi
	 6A/TeuMEm3GwDkaZY5f9QRdDwlMRu55EsM4S4swZ+eWFL0HsY45poswFOjvUz1SuV
	 L2oHX8takBJWK3T8NEJAOR8J1oQaUZlbiRbvqpiaiUXXtbh5Zd9izVvI5w/OdJPtI
	 32h1IkdVGGU+1GRtCe/Y7SsZ6FgrfEToNUnAXknAB1I+4JgPfxaU6nA91KjsYK15q
	 Y7qKN5Luxppbvmv+VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1tYJyS21Hz-00SRAI; Wed, 05
 Mar 2025 08:38:39 +0100
Message-ID: <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
Date: Wed, 5 Mar 2025 08:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Usyskin <alexander.usyskin@intel.com>,
 kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9gAUY4g2oS0urtV3vRhhYlTmrsU7dOJ0SyTnwZT/zt+Q6w7MFNR
 j4Fwv0rgeJEjLx2mI5XVdbWuQCwMXtO5n/IhsKL2pMwUxTTTlOglrKQxXJToIWR9tO5IY+K
 1O7yhxiDff5ZkC+WlgzI8QpkAU7ygqRo+oL7F3RB4v+KjCkeYvlpTeMMC5YIj6Le+ZJM8YY
 OCWTTShMTmG1kJIVRwW+w==
UI-OutboundReport: notjunk:1;M01:P0:9hvXnXV3tvM=;B84svodVSnaqDoVJgwE8XzBlAOI
 OI7hjM0XpHECNyo56fG4Hr5QV6msmNM81mW3fi7Ixxas7EIJTaRPTGp4zA/K0d/CcND5AqdIP
 gMkePNu2ZCPWNAz1sVSIkh28sf4yfzhLskGwBfkiPQu8W/WOS58/i2pVYI3aG86kac7UjdqWl
 JuvZNLuoLsz+bWBKESF9UfK5FKjcxFxQKb306YgdKMXSQXPypIh08B6OrhQkUxceqQ207Il0A
 bhPBW2dvD+Yfi1G94fWNK5rzb2EdHU9XfaBDYeiw6CSzBpfU+BWlflxvl0ropyxgIcNZ1QloD
 1vtuT4/GOVAandOmhQH9OGBcae40wsFRMWrr3UtYCPrHYENgOgKW+b/EyGLr4+ZSnTuU+JQ0v
 5BNKKmJUqNBW8lfTlnSocNeonwDdpEiymjZSVjjDm1+TYzCmLCMipRwyCd4JgZcpZ8mKqjF/P
 IoUgZ5C5aKR+SR6ydLqRCntaivTZdWwc8v6Jl1+WWkAqAPnAZtuO/bEz7GT9Fja8gkYYi4/8Q
 2Z7bPGe7qYQSpCtOZOz6kOAuZzigtvGMIYyePYsnAUW/caSo/3YnnF8EBXKQL8I/fhpKyo1nD
 tv2GOcaEjITXNIO49JzjG6VWKNJPObIbNhXTeb1c4xQ2M4bMhPoWa3PTLub15ne6tJ6Cz8Itl
 U09Z7ZImvlbprBaj2mLfnXEXFXusOrplgy065ExSfFY90rsfKPaQO2GZ26WDZZjp48dTPcXfA
 dVu3tCO6opiKou0Xog0Un6x+mcAH89eQ6lXsOsM9JvQ9/1Y4yNqwBHc+G+a+LaXe/xnTooSnF
 gljV+WbBaJ40kaNhMGmGuxnQRnyuJXVsTxiubeB33TAxyUI5QHoU5ex0TtFxyDWhtTliFZKnA
 ZHvdJI/se82qS1LUaHl1MH5Nrl9AtuqtezSsOIyJhtRglVUuE54nn91dtlpPRjPijeE8drAP0
 +2a8hDiuexPk8Cjp3tZOxnB6rKGDukkWlDDZi82Zto5RYBBrrSH0GcazMnjIElzl0Je4Ga3WH
 44/on5HAuOXzQ24LkA5Lhl4uVhD+fcVqGWF6b9mPOYo48/Q/cYWTz6eRZymIlBpJDzlCZjc7Z
 ygOuIj3/eJmp5R2RG1JdQwB7XW6y+CKVIUHmZnCaqgH0zE7JALnH2ZuQ93ueC10tHVawv+yxJ
 LDJvrYQHFNcgZraj9d5yclWt0WHDDpuz5jX9uw2rkBDbcBQfQtkMABj4zPgqa90rE79JXLoqt
 LmWoVXtCX/ZoQYlBWhV7JTLmkss53A+APC+44AEyyNzxYglg30Vl9icbitut60jU5EmWmNmnI
 ZeGlkQqFZ4+Jf2bjmsBMjS8Sjs2dSrdWvTEbbHLkkgT/RC90XcT6W2R4YXf3G2FXpBubJS9JL
 b/BMmOT1uWoVZK30HCtr33bB5MnwUQCijII2PLu0OaviYBpCsSbw61/Kmf0ts3/WabngG6Lr5
 v7zQhEQ==
Subject: Re: [cocci] [v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2538
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ccdac63a-4a04-4243-9350-05acc23f413b%40web.de>

>> The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function =E2=80=9Cmei_cl_irq_re=
ad_msg=E2=80=9D
>> that it was determined already that a corresponding variable contained
>> a null pointer.
>>
>> * Thus use an additional label instead.
>>
>> * Delete a redundant check.
=E2=80=A6
>> +move_tail:
>
> In general, why not, but the label naming is bad.
> It hides the original intent to discard this message.
> Let's rename existing label to discard_nocb: and leave a new one as disc=
ard:.
> Also, the patch will be smaller in this way.

Do you expect a third patch version according to your naming preferences?

Regards,
Markus
