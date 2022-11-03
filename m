Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA1C4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yKrq5/jEbQEVBjWTon2ZIWfrbJ5zd9p/n0ZvTrxWcxE=;
  b=Y4MirlbEDOG3aYhAQS8m+cZBuUN0FL4At+ppY190oTYKaEOU4N9/uBKs
   SbuQn8bAvipMoeTzY4PyPk9eU+ekkFuIn5Bz7uTQ2jyKo/w4oBA/gU57d
   KQPSsane3mH6Jw8oubIU5LoY8x3tRczSJLoZkh59rCpyenSJD3HzJ3Zvk
   k=;
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
X-IronPort-AV: E=Sophos;i="5.96,134,1665439200"; 
   d="scan'208";a="72858427"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 16:50:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 867CBE738A; Thu,  3 Nov 2022 16:50:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 27B66E7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 16:50:55 +0100 (CET)
IronPort-SDR: 6363e35e_3xaBrgXkUbASIjf7iq+Dq8dZQBZInqKxVpVMByMTsWZvNkf
 Gx2t+TBul2+ZS/iWCD+B/PPYrCbl05Y36QfQwnA==
X-IPAS-Result: =?us-ascii?q?A0BeBwAC4mNjhw4P49RaHgEBCxIMQIFRgiuBBVMuBAtFh?=
 =?us-ascii?q?E6OdYF3MYQohxyHLYwzDwEDAQ1BAQIEAQGCEoJzAoR5Ah0HAQQ1BQ0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSkBg?=
 =?us-ascii?q?2QBAgIBIx0BAREmAQ8LGgImAgJXBgEMCAEBgnmCbgEDDSMHqzqBMoEBgggBA?=
 =?us-ascii?q?QaYEh8sIlOBXgmBFC2MTYM2eicQgVVEgTwMgnc+iBuCZ48Bh2ImBA4DGSsdQ?=
 =?us-ascii?q?AIBCzsyAwpMGzEnDgkfHAoEFw0FBhIDIG4FCjcPKC9nKxwbB4EMKigVAwQEA?=
 =?us-ascii?q?wIGEwMgAg0pMRQEKRMNKwcjcQkCAyJlBQMDBCgsAwkhHwcWESQ8B1c6AQQDA?=
 =?us-ascii?q?hAiOgYDCQMCIlhzAi8RFQUDDRclCAVNBAg6AgUGUhICChEDEg8GJkcOSj45F?=
 =?us-ascii?q?gYnRAE0Dw4UA2CBcAY1nQOXOYxon0s0B4IegUyBTAyeYgYTLoNlkwcOBpIUl?=
 =?us-ascii?q?y8gp1eBeiKBWzMaJIM2TwMZD44gGYQMiixANDsCBwsBAQMJhUcBAYR1AQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:sAwU7a5U5vMd3WFrWQPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,134,1665439200"; 
   d="scan'208";a="36383272"
X-MGA-submission: =?us-ascii?q?MDG9ZDk3IWof7MdFx6Qx7vkrSmnccMUAAVS/bZ?=
 =?us-ascii?q?xTDRjQ28u59cFq0EIuzMmDrYm8o9/JIMMFnfuwHlih3ZcFW0MWVG4uuZ?=
 =?us-ascii?q?08sxwML3BwDYO5kA5vie0qMt0T85C1L0ipv7MoMp3IFxm7kQBWDaF4ZX?=
 =?us-ascii?q?BL3tFTCa+i4/gFxJoHooPBbw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 16:50:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667490653; bh=BDT1/nsxVYyyI8t8gM8pLCg7RtH2QM6aU2TS8L3+rBc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SCvKsRZIpMNu9dARJzGgCFWwci35tdYvSeyRCxZ5NphL1WW7cLk52YFJzm44XTEEh
	 nKU1l7K5w/Zbx1fOrUkPNGdJeHIxZY8VkYq3C9SzW6MRrRmKVn+HAPvoKqxxHFxgeO
	 CSO63d97tqmmwvA0QbgNceTO2tnrpdbzJbPtyCSKbcjjqt2hHoLgAA+h30QCUfQML1
	 8HHyZdD/6HDR/NNvpUeoiMxUpgXS6k4/POrjm+XLY/TASm/AYrmYPGOzf7IvEVSROM
	 ipfA13om3aZ59OblxhuQz3SgP5wvgpF+/Sq7eP/S6ykmun7vP6OoXhOmFT2SBxeoOX
	 co9IMXyrorZ2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1p6dH61pTp-017jbE; Thu, 03
 Nov 2022 16:50:53 +0100
Message-ID: <431fcf10-3272-3a64-3d77-ff68032ead24@web.de>
Date: Thu, 3 Nov 2022 16:50:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Sebastiano Miano <mianosebastiano@gmail.com>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
 <bac05976-cacf-1a2b-a1d0-712dbad725f1@web.de>
 <54b441e8-13e7-be9-23ee-692ccb1ac04f@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54b441e8-13e7-be9-23ee-692ccb1ac04f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:krZUAH9sLaXPS6u0ILcWgZKYFu4m4+egdZTd13Ea3+6Mt2fZW64
 cI5dL3d3+f5H9Fw3dPlDDGrerdhYHUdFLd/zEsd3FOt/gJWo0HbiFthlKQ4WWIE4tK+pFKp
 xaolZ1SKEgaVG7pFAfdKpcephUuw1ECKCbPCfTlpYWBiopKZXlICBHWnihGyWh79AhyzyO+
 DZRizePzPYZDBcwVVG69w==
UI-OutboundReport: notjunk:1;M01:P0:y8/lGK6Go80=;qg12PypQZSI1RHvskdvrO0QKI50
 V1bASQSRAF91iK+ozAnwln1EIGSZWjKl8ITh4gRKRqmhafp5YEy22sdfeqxiS000RRtqopt1M
 H31mmHL/CnT2NGUjDqT5kaHzxuNjUbjMR/ODc0Z4xj350V3jkeKQ/aMwZb09cC5+oeVJLrNmN
 CA6+dVvp4c0H2+yggOgLf1xAfg8ZDcOVvKHv2QblrCurkSeb5N3b7OHl0R6ib0Zv+pwar63q9
 H66MocqMFW4vcYdZlkKVmTsELgjMo/KAiwnBMK9baLSQykkrJhqaZO3dSq85/FoJQaBsYMFF0
 uJXRTbJ9Vt7YVDETLNphz5PhqdDZzTv/RhtXVp2NyMjUsLb51NWO8o+H1GfC2IQaHWwtIovCM
 eRfxxC7ZdvFZ39af8U4kIpiNZP0/oSB6X9BMy7MUZ3FE0EV2geMdFBK8Cx91SKFA5CxBe5v3j
 ONdyUBykkMIo6tYBpyEijwvmNSOWvxDquVggndSHd+9CQ/DdeieOKO39xNdjNfO9ylmmJg4Kt
 smhHo2QRfu/8byMsQatax/Q5sfrHHWUokNgrKpsUsdsCbkVifw5GR6/PFg+aXCB8RpjdB5iY7
 mOUg+k184nsotb2ht46hKOH6m0aBod+zI3FZlAacePDKRN8M6ed2tv1uG/3mX7OreyW+OZiuY
 zPdZSFBA63igPQXqJOEcBKwJ5kgZSoLOUGQxhVVlARI2Qj8giHhe40QXQR37YwwQoEWuCKqy3
 qBPodfE+EtTyRIgYVtqf25aJjKMZJ/v8pPSAojiUUBSqU8Sn8B8b8VRVTswYd78kn9CDCekBa
 du+h4Jo/+JWhez6toEJeVucOUtLNCmIg2IIYU2xtfKvmMgxKU+GVIXKHH2hbvAISlls9bG8TZ
 sL+GhSVjdhNGBwusbJvO45pSeEJqzpPJV71h0yvQzwFAXskU7yqlv6cvgYpLlSkNZJoqYlZcE
 ePhUiA==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 713
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/431fcf10-3272-3a64-3d77-ff68032ead24%40web.de>

>> I got the impression that the usage of position variables can have desirable
>> data processing effects for the safer evaluation of some SmPL rules.
>
> It's better without position variables.  If the same path and fn are used
> in multiple cases, adding the position variables will cause the python
> code to be run for each call, whereas now it is only run for each unique
> pair of path and fn.

Can such information be transformed into enhancements for the software documentation?

Regards,
Markus
