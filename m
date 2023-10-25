Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51546C25B47
	for <cocci@archiver.kernel.org>; Wed, 25 Oct 2023 06:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0+l0rK+JTDfVjFvk926Hyl5CUrJ1zfOR7sJV+Nhfb9I=;
  b=is646fAp/0qq4Y3HNvdgq3Vrb9wd4jeLCCDwyPdp/EzJsbY2mrgec28C
   I9hIZJ/VnIR40jRNq7I+TXlHEs8l2JP8vFuR7JUizzYZeahHmfojRPZck
   VcxnpOybTi2mafdypaChQjfyWeRCxmgHFl0a+qR8L1eUZmYCkFxvpyvod
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="133033118"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2023 08:09:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9A038E0CD5; Wed, 25 Oct 2023 08:09:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5D38E00B7
	for <cocci@sympa.inria.fr>; Wed, 25 Oct 2023 08:09:00 +0200 (CEST)
IronPort-SDR: 6538b0fb_LSpDkRfjZWkYRdNzprZliqMtQIv+ZDI3c9oe27JK/TbBOj0
 1BjMQgA7dshjpuan1hYtaIJ6tN/XI4aeUlLXLwg==
X-IPAS-Result: =?us-ascii?q?A0GABQDJrzhl/wMP49RaHgEBCxIMQIQIB3ZTMAQLSIRTj?=
 =?us-ascii?q?zyBdTBVg2aHNIdJiG+DFj4PAQMBDUEBAgQBAQMEhH8ChxkCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KwERgQyBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBESYBBAsLGgImAgJMCwYBFAEBg?=
 =?us-ascii?q?nqCKgEDDiMHsiSBMoEBggkBAQavVB8sIlWBXwmBGi6ICgGENGA9gzt6Jw+BV?=
 =?us-ascii?q?USBPAuCeD6IHoJog3eXcV4iBUJwGwMHA4EDECsHBC0bBwYJFhgVJQZRBC0kC?=
 =?us-ascii?q?RMSPgSBZ4FRCoEGPw8OEYJDKzY2GUuCWwkVDDRNdhAqBBQXgRIEah8VHjcRE?=
 =?us-ascii?q?hcNAwh2HQIRIzwDBQMENAoVDQshBVcDRwZKCwMCGgUDAwSBNgUNHgIQGgYNK?=
 =?us-ascii?q?QMDGU0CEBQDOwMDBgMLMQMwV0cMWQNvHzYJPA8MHwIbHg0gBA4DGSsdQAIBC?=
 =?us-ascii?q?209NQkLGwY+AieeIIJmg0TFHTQHgjGBXoFfDJ8jBhMvg24Bky4OBpJGhg2SL?=
 =?us-ascii?q?yCoMTWBRSaBWTMaJIM2TwMZD44ghCuPSD81OwIHAQoBAQMJAYFVg3ABAYNag?=
 =?us-ascii?q?ikBAQ?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
 WyxjePK
IronPort-HdrOrdr: A9a23:FTLnFq2QQlkjYdYRie2fNgqjBTlyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4expOMG7IU80hqQFmrX5XI3SFDUO11HYSL2KgbGN/9SkIVyGygc/79
 YqT0EdMqyWMbESt6+TjGaF+pQbsb+6GcuT9ITjJgJWPGRXgtZbnmVE42igc3FedU1jP94UBZ
 Cc7s1Iq36LYnIMdPm2AXEDQqzqu8DLvIiOW29KOzcXrC21yR+44r/zFBaVmj0EVSlU/Lsk+W
 /Z1yTk+6SYte2hwBO07R6e030Woqqv9jJwPr3MtiEnEESttu9uXvUjZ1S2hkF6nAho0idprD
 CDmWZkAy050QKqQoj8m2qR5+Cn6kdl15aq8y7mvZPuzPaJOA4SGo5Pg5lUfQDe7FdltNZg0L
 hT12bcrJZPCwjc9R6NkOQgeisa43Zcm0BS5dI7njhaS88TebVRpYsQ8AdcF4oBBjvz7MQiHP
 N1BM/R6f5KeRfCBkqp91VH0ZipRDA+Dx2GSk8Ntoic1CVXhmlwyw8dyNYElnkN+ZohQ91P5v
 jCMK5viLZSJ/VmG55VFaMEW4+6G2bNSRXDPCabJknmDrgOPzbXp5v+8NwOlZOXkVwzvegPcb
 j6ISNlXDQJCjzT4OW1rex2ziw=
X-Talos-CUID: =?us-ascii?q?9a23=3AvT/GTml9ItjJ3EBuqjzXvzduX6nXOSXf5neNcxa?=
 =?us-ascii?q?/MEtGQuOpUHaK2rE9sNU7zg=3D=3D?=
X-Talos-MUID: 9a23:6QGorQgOutLgSkcRbAXCK8MpM9dy8/iiT24xl7olgpDaBQ5CORyepWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="133033109"
X-MGA-submission: =?us-ascii?q?MDHY78D2g//8cmQ9Fy3PIwKY1biXtnIXLQCq2g?=
 =?us-ascii?q?SJ2/Ql2+QJhSyP5vqYeUqBpOgwvSLyt0vHBrcQ75TNEsOmt20KVWU9VF?=
 =?us-ascii?q?cvtb5rfE+jkUn+5CccJfCG5BFfgtyXdF9auaOuaIU9UsF/fV6fSYKpfy?=
 =?us-ascii?q?rWIeB7Vj1WLH+wBcrLVaypuQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:08:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698214131; x=1698818931; i=markus.elfring@web.de;
	bh=0+l0rK+JTDfVjFvk926Hyl5CUrJ1zfOR7sJV+Nhfb9I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aYPTGEk5Fby9cLa0qJ1hDrpRXaQ3LRKJF9He3OVhLg7PI78kwY4ulvbKl6i2brsB
	 RNCddhXbXoQJ3BdVSKzu/uh6F6NrglsKSAqMkukSQPcdYtFuhCGlsgyhsIwDUyR+7
	 l+O2MaTnxoHT21AZoZKSBWtrHMxEfyEhINH0gIKY5YRtYCQ9gaDMM+GNzkVjM32Lg
	 ybOA+MIS4j4jeq0zgI326W+HZIVKm2gLufEbs4FYH9XZuFQoHFdXlvIJXYXiQP3rn
	 uY4BWMPH09qlfXHlZFoZvvOacd8P+XD6b6wpWjtmW0ldsMoMRzAueb/BgouC2XFk0
	 r861mhLn4gkFXRaYGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1rkcWW3pTG-00tzJt; Wed, 25
 Oct 2023 08:08:50 +0200
Message-ID: <9e9bd6fe-10bc-4754-bde9-d3ba2743fb02@web.de>
Date: Wed, 25 Oct 2023 08:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: =?UTF-8?Q?Martin_Schr=C3=B6der?= <info@swedishembedded.com>
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com>
 <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr>
 <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de>
 <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
 <alpine.DEB.2.22.394.2310240750150.3911@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2310240750150.3911@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j3+U+p0r8MaxiCjLmJnGm5gCG4QogmfAlCVASGTE4CrO32mgg9s
 2hFGfaqhyRPAp4HB1ZccJmUjrD7ESF0kJ7LCGebci7leo4iUPgncYiFI7QsHaG1xm0NazJO
 qFF8qB5k6KeRIQgoYGKZCl7OJFBkVd9uyXcNb3utFMDnc6izyi5htW9404vVOYvEZokAbrU
 Hq74v0hpsH7vymlyW+XQQ==
UI-OutboundReport: notjunk:1;M01:P0:QAkdh3vqwuA=;lb/Hj5/mlKvB2CSAv46cEuh0NZ0
 CjQFQX5btco190Si3tVg68O6Oq6F3AaaZosNwAAcxgqg+4AECCK+qDfrkxrAJRY7kITcUgx0g
 qr9xqlXMNwAUzcYNKAKg5mQGcNwRp9M7IwoU+BIfb2WNpXQk76KAIXJmEh9mwkDQlEdelKPhx
 aV8cv2YvszLsHbZE0Tv3GiIUtCYtU7B1TqFOzl4znGqcJ/ci38o1j5Z0TWaQevEeuSnlVyPrL
 0d59zNXnAGlh+cQYT/+TbFJGk6R5qjQNpZkaXwzKZn2SWvM6itfrt43XyC7lQid+g5MhzTmZ0
 U459CowUA6hYOGmbiUeZqWUVQTf9Nr98bUj8sXj1zFgqOIK5SkjIeRGhcLCsX+zVdAE4JgVA6
 04VhNKzx8oCiWCzcyTBjiKEwxScoyokW4BZPyQxXWHaiFz2qmdAnVc0dIR42gIQi9G1e8xxkU
 bYE1IrMOX1UVkWcFuc5nlF5TAgAcM4rh6qGT8L27ESaJgPITzoQ1d++3ttnmZ0tDKgYWvheRg
 nqRfBdCLtVcucqnMxj/x+OcRRqHD6rVocG2HKLejrr8AvfUr6jOqXgR5qilfR42aL0xxaLaQb
 71utHKvezZ5uemHJB/ASvSJBnjKI9Mn0fnSJdHMC9PfBm3nyqv4hGLkGxhodCfc+Tqycq1GgS
 Ww/4qZIDyFiS78+1DAeFyo9/l1rNpcozUdg21kPAQUNXpbXdwLr0TkakSDSmbMrsqKvzwYcKP
 U2/G9l07UP5JLoPSJ7LVwA0fmRjnc6LUwgannDQX7u+mICt65s4jyyx4FKJkY/JBWlojiUQcC
 N5j3655m6g01koMNLu3NBrGafLdVQA0tbUUfRueBdnbq84BCSAjv7eNO8unjsipHdEiNI5qtu
 h1UPh/k+HJABG2gbzbqI6TMAveKkO1//qx0QpmS6hHo9LnqSqCZjiZPOzH2fp/fFc03wsrLBz
 JRWPc+iFMAuuw7EJBL/nYiNottc=
Subject: Re: [cocci] Dependencies between key words =?UTF-8?Q?=E2=80=9Cgot?=
 =?UTF-8?Q?o=E2=80=9D?= and =?UTF-8?Q?=E2=80=9Creturn=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1274
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/9e9bd6fe-10bc-4754-bde9-d3ba2743fb02%40web.de>

>> if(r){ ... }
>
> Put a return ...; after the ... to require the branch to return.

Can any more restrictions become relevant for such SmPL code?


> This will cover the case where there is a goto that leads to the return.

Would you like to explain this information a bit more?

Regards,
Markus
