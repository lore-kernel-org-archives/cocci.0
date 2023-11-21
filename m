Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DEAC54FB9
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0HuhZKyogmP5HakjyzCDzZGEHladzcsYKX5THh5ZTYU=;
  b=NniapEQXIgVOnxYbjvvBSXorcwvJ7O1NKq1J0odujoeoDrjGhcXMGFi6
   2qS9UQDXEGrSTbHrx+vxForV0TzQnn9j4WL0TrE6w05WvK9bSx9XFGXDw
   xMuDnNJI4KKod+/uLNfClQBy8Iw3qZ1quePQpfVimuKaxdyOVAoYJ3LC9
   M=;
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
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="137529958"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 09:19:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56CFCE0CCE; Tue, 21 Nov 2023 09:19:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 809B5E004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 09:19:26 +0100 (CET)
IronPort-SDR: 655c680f_kc4O44lLhsEpTlae6VAgqDH2dhHWEKz0PNZ6dFvC0uEmUet
 5VmQfPh9zsoKE9N4qtmWqk9eos7cgg93u7P6XHQ==
X-IPAS-Result: =?us-ascii?q?A0FZBQDqZlxl/w4P49RaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?IRTjz2BdS0DhDuOfohvgVaBQD4PAQMBDTsGAQIEAQEDBIR/AocpAh4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglUYgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCDTpCAQQBIx0BAREmAQQLCxoCJgICVwYBF?=
 =?us-ascii?q?AEBgnwBgikBAw4jBw2tFIEygQGCCQEBBoFaAQ4JrWMfLCJWgV8DBoEaLogNA?=
 =?us-ascii?q?YVZgzt4AicPgVVEgRUnC4J4PoJhAwKBXYNbgmiJJgeCVINShW2IZV0iBUJwG?=
 =?us-ascii?q?wMHA38PKwcEMBsHBgkUGBUjBlEEKCEJExI+BIFggVEKgQI/Dw4Rgj0rNjYZS?=
 =?us-ascii?q?IJeFQw0BEZ2ECoEFBeBEgRqGxMeNxESBRINAwh0HQIRIzwDBQMEMwoSDQshB?=
 =?us-ascii?q?VYDRQZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDOwMDBgMLMQMwVUQMU?=
 =?us-ascii?q?ANuHzYJPA8MHwIbHg0nJQIyQgMRBRICFgMkFgQ2EQkLKwMvBjoCEwcEDgMZK?=
 =?us-ascii?q?x1AAgELbT01BgMLGwY+AiefQYExgUOCHA4CgV8eARYfNZV0rko0B4IxgV+BY?=
 =?us-ascii?q?AyKFpUNBhMvlyIOBpJPmEAgjUeabYFkATuBRQ0HMxokgzZPAxkPjiCDeDOPR?=
 =?us-ascii?q?0A1OwIHAQoBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23:LPz2RRGtP+r6IzJYiEqOGZ1Gf6NGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33BmQAdWQsqsZw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS+bL9oM
 Rm7ogbcusYLjYd/Kqs61wfErGZPd+lKymxkIk6ekQz76sms4pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQSA+nUTXGMWkgFVAwfe9xH1Qo3xsirhueVj3iSRIND7Qqo1WTSm6
 KdrVQPohSIaPDM37G3blsp9h79drRm8pRJw3pTUbZmWOvRwcazSc84US3RfU8ZfVyJOAJ+zY
 YQUAuodJOZVtZXxq0cQoRa8AwSnGePhyiVPhn/zxaA01P4uERvF3Aw9BNIFrXvarNH7NKcIU
 OC1yqbIxijEYv1Rwzj98ovIcg06of2WUrxwdcTRyVMuFwPDgVWdsoLkMC2O2egXrmeU8fNtW
 OSygGEotw9/uCKgxtswiobXnIIVzEjJ+CZnzYs2ONC0VE52b9C5HZZfqy2UOZV7T908T2xnt
 yg3yr8LtJG0ciUO1pkqwwDSZ+CIfoSU7R/tW/qcLDV7iX9jZbmxiRGy8U26xe39UMm5yEpFr
 jJdktnWqH8N2QLc6tKZRft74kiuxyyD2BzU6uFBOUw7ibPXK5A7zb4pjJYcrUPDHirulEXtk
 K+ZbFkr+uuv6+T5fLrmvJGcN4tzigDwKKghhsu/AeE+PwMTXGab4fyx2KP+8UHnWrlGkOM6n
 6vDvJzHJckXvLO1DgBN3osn5BuzFTmr3MkCkXQEIl9JYhaKgojvNlrTPv34Ceq/g0+wkDh13
 fDII7zhA5TTIXXbjLvse6t25VRGxwop199f4opZCrEfL/L3XU/8rNnYDhgkMwyo2ermBsty2
 ZgEVW2SHKCVKKLSsVmW6eIzO+SAepIZtCjnJ/Q7+fLjj2U1lUIdcKWzwJcaZ2i0HvF8LEWYZ
 XrsjM0BEWAPvgcmS+LlkkeCUT1OZ3apRa4y6TU7CIy8DYfCQICtj6eM3SmlEZJNfGxJF06DH
 W/ud4qfQ/gMcj6dItd9kjwYUrisU5It2Qm0tADm07pnMvbU+ioAuJ3/09h6+/HclRAp+DxvD
 8Wd1nmNQHtukmMJQT82xqF/rlZnxleNy6gry8BfQOFM6rtqVgo7M5OZ7HJ8Ct+6Dh+HfdOES
 VCrB9ahDDcwQfopztkBflpnHNOjnlbP0nzuS7wYjbqGALQs/6TTwmTrIMB82zDK2e1pjFQ8R
 MZLcG+vgK9j8BLIL5DGnl/flKuwc6kYminX+zSt122L6WRRSg1tSu3oWX4FZ03Z5YDc71nBU
 qToJLApKApHxuadJ6EMZtC/3gYOf+vqJNmLOzH5oGy3HxvdnttkDaLvcmQZhmDGDVQc1hoU9
 jCAPBQ/ASGopyTfCiZvHBTheRCk6vFw/VW8SEJ81ASWdwt5zbPg3xcPhuGHDd4X0KgFvigJt
 Dh+WlqwjJrNE9TVnwN6Z+1HZM8lplJO1GbXrQt4a7mpNaN/nRgzdwptvkXh/wp6AMNMnJtit
 2skmSx1L6/Qy1Zdb3WY0JT3b6XQMXX39QuzZrT+31bDzJCJ961J5PlQR0zLmgavGwJi9nxm1
 4MQyH6A/tDQCwFUV5vtU0Ex/hw8prfAYyB76ZmGnXtrebK5tDPPwbdLTKMs1wqgctFDMaiFC
 B66EssUANKrIfArnF7hZwwNPeRb/qo5d828cP7O1KmuNedm1DWo6AYPqKV0yEGR7GxRTuDS3
 pAK6+6V1E2LWna0jVustNz2hZERfSsbTSK0zSnpApIUZ7UnJ99RTz30fIvum5Mn282IOTYQ7
 lOoClIY1dX8fBOTawa4xghMzQENpnfhnyKkzjtymjVvr6yF3SWIzf6xEXhPcmNNWmRmik/hZ
 IauiNVPFm2hdQs0j12I4Ujgxq5UjLtyJS/fTA0bGkq+Z3EnSaa2ureYNoRq4YkrrD4RfeCye
 1GcRZbirhFc3y6pTA48jHgrMjqtvJv+hRlzjmmQeW1yoHTucsZ13R7D5dbYSJa9xxI+TTJjw
 XnSD1m4ZZyy+MmM0o3Euaa4Xn6gUZtadW/qy5mBvW21/z8iDRq6lvG10trpdGpymQryzdp3T
 mPlqBjmY4/k/7u3O6RrcwFkCUT95MxzBoxl2tFp3tdKgydc38jTpCZPmHy7KdhB3KPicHcBI
 FxDi8XY5gTowgwrL36EwZ74SmTIx8JgY9egZWZFkik57s1MFOKV9OkexHEz+ADn61uMJ6Ehz
 VJ/gbM05XUXgv8Eol8oxySZWPUJGFVAeDbrnFKO5sy/q6NeYCCud6Kx3Qxwh4PEbvnKrwdCV
 XL+YppnEzV365A1FVvW02DorKzgdsPRa907qRCe1RvNxbswStp5hr8RiCxrNHio91gs0e0ml
 lpD2Z+gvY6IA3pg9uS1D1QLU1+9L9NW8Tbrg6FEm8+Q1I36BZRtFAIAW57wRO6pGjYf5rz3c
 hyDGzompjKHCKLSSEWBvVx+oSuFQPXJfzmHYWMUxtJ4SFyBKVxD1UoKCS4ikMdxFxj2lpa4K
 gEjvG9XvwSm7EIWmqUyanydGi/evFv6MG5uDsLFc1wPs0caoB2Iec2GsrApRnsepMf+6lXSb
 DTcPVsADHlVCBbdWBa8ZP/3tIOGqbTIQbDvSpmGKbSW9b4ODbHRm8/pi9Y3uW7LbJvHP2E+X
 adihQwcBzYjQ5ufw3JVFGQWj36fNZfE4kjmvHQm9IbhrLOxBmeNrcOOE+cAYY8pok7rx/3ZZ
 qjJ334xKC4EhMNWgyaWlf5FhwZU0XsmYTCpFf5oWTflaqXWl+cXChcab3k2L85U9+cm2QILP
 8fHi9Tz37o+j/gvCl4DW0az0seuLdcHJW2wLjalTA6CKaiGKDvXwsr2fbL0SLtei/9RvgGxv
 jDTGlHqPzCKnT3kHx61NuQEgCaeNR1Y8IazF3QlQXDkV87jYwanPcVfiDor3fsri3mMOWNde
 TlwfkVRr6GBuCNVhvIsfg4JpnFhLOSCh2OY97yCc8xQ66E0RH0p0bsGsxFYg/NP4SpJReJ4g
 n7Xp99q+RS9l/WXjyBgW1xIoypKg4SCuQNjP7/Y/99OQyWhnlpF4GOOBhANv9YgBMfovvUa7
 9HVl7/obhpG/cjV+8Q0GMXebs6KeilEU1KhCHvPAQ0JQCT+f3nYnFBYmeqO+2e9q58ntt7zl
 ZBIRrIRBzlXXrsKT09iGtIFOpJ+WDgpxKWagMA/7n27tBDNRc9es/gvt9qXBujzbimUh/9Ia
 klQqVsXBZsePMv31h47ArGftJvHEQzcUIIVyhA=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:COMoN6htIc7+MrbLXouTwyVJ1HBQXh4ji2hC6mlwRA09TyX4rb
 HToB1173HJYVoqKQgdcPG7Scu9qBDnhONICPcqXItLXWHdyQiVxehZhOOIqVHd8+iUzJ876U
 4KScdD4ajLfD5HZLHBgDVQfexQuOWvweSBmfrZwXtrQRpjdq1shj0VNi+rVmlffSkDIZYiDp
 KT6o5sojK7Yx0sH7+G7wM+Lo3+TqXw5ejbiGU9dnoa1DU=
X-Talos-CUID: =?us-ascii?q?9a23=3Ae9hkrmrRrP9vjEAtgjVnDprmUd44b2WB93vNGku?=
 =?us-ascii?q?XJ1xDYeCtdESw1awxxg=3D=3D?=
X-Talos-MUID: 9a23:el4aJwjXuA6rlZR/FxjAHcMpCdlDxv+fKEA3jog+h8aKaGtsP2qyg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="137529937"
X-MGA-submission: =?us-ascii?q?MDFNfewNod5wdwbMCAwiz212RvVjT0wsx6k1gj?=
 =?us-ascii?q?0X/tO5lAPPCqpjG7aFEWPfCKnc0wh/HiyFwm2D/kZe+nsdVmmCr7VO89?=
 =?us-ascii?q?ALNqC/xR+NPBmF13Anhx/CeXTIWpVrvXrk8fx/+fX7dNqY/w+Zu0/j+t?=
 =?us-ascii?q?2AXxTnxhN2B+nwWmnWWaanaw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:19:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700554754; x=1701159554; i=markus.elfring@web.de;
	bh=0HuhZKyogmP5HakjyzCDzZGEHladzcsYKX5THh5ZTYU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=o4RHe0HsSH1xGGGwwpeZQuX7nBjJRMBG7mhghdqen3FBeu4EOZQ3xVOdym3UXocN
	 Baa7gq3Da7zV8uuj2JeIflAsAWjkakjmnVjrUiPxuV9SYNXilqtktQWGgZ6c6j6IO
	 WXV/zXoJ0wFf91kY0v54bT2P6E3IcrpUmfdjBr2FwdUxG+TMAWRS9YOJdi2jFUP2k
	 zg5PkOXLe09am3aVgauYBX3TKnp7aqAOpJWQ49z3A/y5/Roy1kG6M6FcBzgXmmJl1
	 R5U/dih9rta/dI43w1bUP2UtxOfF0BOnUsRP3LerOs29o8sQkAbCqfXW8saeN2s08
	 1tu9NvchmNmKr7F5wQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1rXpZl1pSJ-00hmdQ; Tue, 21
 Nov 2023 09:19:14 +0100
Message-ID: <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
Date: Tue, 21 Nov 2023 09:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: Amit Dhingra <mechanicalamit@gmail.com>, Mark Brown <broonie@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
 cocci@inria.fr
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
 <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gooUD8s2uK98dBRyL1W1Lxel6QcDCzCZtGlfKnGzZZhof1iMf5s
 qy4fXsnhagtd9E1FKnFubv6+pPsRFesbE+7a8xWweot1NKxUbhuNNB5ozXB9wBhkBIQti7o
 MCMueIWEWIN027qE6gKqhD0lFrkzwC5nK1/b/swUX94XS46DSX+FhU7HhyS57WbRj1yiVlf
 p2lSceIusomEUDCImWbxQ==
UI-OutboundReport: notjunk:1;M01:P0:2p/HjapdwpI=;Myh3/zxQG3fpn+gnpAUpwhEkmnC
 O+zv3rQwpUYrhw6PewgJ0ZuDMXCX+a63vx/OJGQcw0P7rJfZSs8PRhOj+U4IJi2JYoRpI9tz3
 50jcHxKngxjWnSBoRKDtT1g5KUnL9N64bACA7ysLLwIuxOkky8J7Au7ray07WrTfpgauudR5i
 g3mFOeGXYx4QYlMreBA6QJebP0IElRntKVwD3S0yZ1gv6z5XdJK8sorM3vfR6d7yj2H+DIe/5
 CaE+Pgu9YK8TCHQFPxMvWVftXuBUlmTThxvvJH8i/aQGFfIeAQFA75N9m2Hx+SGgyPeqFIqUU
 8nyCnUgPhD7yX6cN+L56GkzRnUJKGlZoM3IMbtCQ6i7vTMP/jtstEvysbzgnlm0WqmCu69CF5
 SgddyHXHazt+T8nm515Tq33yaczpkL2dDoVZ5UlIC1K4tuPy4VE6VKNZqXI6KQ1nPCyBzfeTd
 jI0f/Lc7yZAbPSmiBNzuEL9Va5OQicEalUhzf8ZViVARY+LpxNBcgYHfetTikRpA75sL8uk00
 U31JIxjC/mZgNpWYaMuyy4+i6ZTKYlJqMl2dpM6fM8YoVm3DxkyPqpsO4mlqnTtotwTp2z0uE
 uaY/UtkEUc+69QV6zE6Bu1fUxThSfQZIEE77KYfLn7GUkJrcLZy8zIlKHGBbN3c4ElhM67srw
 Ca9oPmSDQ0/CwDmws3qasp/8Dg7xMHm3b6Tx3nO3UKfbQ+ESMgxGKJCzp9e3iuQWuot827zT5
 TALwkWPlM71hABMaiCs4k992/I2pindSgU8gYeXJeuZ5UjGSsCGzlRcWbf+7ptsqL82k6bhEM
 AzSx3BLLhvusZa/aD9iYtRrmz6uS/AflyQciKLJQX6Bl1XmN9T17EdGkPmkcAjdKtz2bEAHtq
 UqFWHNuoejhLHRu25a57LTum3A0a4dAEKCNT0OnPFDMIWSN+N1HBp32I/JJMoyUZHYi0e07T+
 L4TiSetrUUS7XPStfZmhjGGHYq4=
Subject: Re: [cocci] spi: cadence-xspi: Drop useless assignment to NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1299
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/3e4c0c06-9681-43df-be12-b2bbc599fdfb%40web.de>

>>>>> Static structs are initialized with zeros for unspecified fields.
>>>>> So there is no advantage to explicitly initialize .remove with NULL
>>>>> and the assignment can be dropped without side effects.
=E2=80=A6
> Removing =3D 0 assignments should be carefully reviewed. I skimmed the
> changes to drivers/pwm and would oppose to both changes.

How does this development view fit to information from the patch descripti=
on?


> Even for my patch I wasn't sure if it's a good idea and talked to Mark b=
efore
> sending it.

Would you get concerned that null pointers would eventually be represented
by non-zero values on any execution platform?

* https://en.cppreference.com/w/c/language/nullptr

* https://c-faq.com/null/machexamp.html

* https://stackoverflow.com/questions/2759845/why-is-address-zero-used-for=
-the-null-pointer


Regards,
Markus
