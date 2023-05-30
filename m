Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99032C7EE23
	for <cocci@archiver.kernel.org>; Tue, 30 May 2023 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=otnNTLg/TOhsOX6vl+D+8gnRbzHK5AXNUbOJYL6eVAM=;
  b=LMilUTaHQNChE/QUPx9lwwHblNdTqLOtCp0hC8TCx308p5cIaIzjLAUg
   df8M/eGZC4coB0o/3OtGRZJH2CyA0gH3iHfG9mRdJZ/qVh4J93Nwo4vOU
   JgFF/3etxxANWb/mskLP46SajHiFtZzIVaTi/HEDMqIDAPphBAS87U9Wy
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="110281968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 May 2023 14:33:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 73AF2E0091; Tue, 30 May 2023 14:33:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F0A8E0090
	for <cocci@sympa.inria.fr>; Tue, 30 May 2023 14:33:07 +0200 (CEST)
IronPort-SDR: 6475ed03_05hNU9AYu+wOdfZnhM0o6msp63J1HNx93chF5G+GyNIZtjU
 QFIwPq25JUCMZVoaqYtDsa0zd86PQbJYP/pFSPg==
X-IPAS-Result: =?us-ascii?q?A0FZAADB63VkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYIueFMwBAtHhFKPGYZahzCHRIhqgVaBQD4PAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?Uw/gnQChV0CHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICRz8DAyMdAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAzEHrkiBMoEBgggBA?=
 =?us-ascii?q?QacDh8sIlWBXwmBFS0BjGpCgzd6Jw+BVUSBPIMEPoREg1uCZ4kwhQ+NJIEvc?=
 =?us-ascii?q?IEhgSeBAgIJAhFngQ4IZoF0QAINVQsLZYEjglkCAhErExQFSHwOAREDBwQCg?=
 =?us-ascii?q?QcQLwcEMh8JBgkYGRgnBlYHLSQJExVCBINsAwqBIzUlBA4DGSsdQAIBC3A9N?=
 =?us-ascii?q?QkLHwYmAR4CK4FYBC9aeSgkn0OBFS1yxUk1B4IwgVuBXQyfGwYTL4N/jGqGK?=
 =?us-ascii?q?A4GkiuYDiCoEoFkATiBXDMaJE+CZ08DGQ+OIBmEDo9IPzQ7AgcBCgEBAwmFR?=
 =?us-ascii?q?gEBhX4BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:/Wi24KN8ogw4gpvvrR2Dk8FynXyQoLVcMsEvi/4bfWQNrUp20GYOn
 2AXCGHSaP+PYTf1fdokYY228RkEuJHcndRrTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYAfNNwJcaDpOsPre80s35pwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXDf3G0mvo/M3okNIcCx8RxQjhjz
 KUHfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBfmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA2yakKG0A8A39Sawf2GmN4TBX1aPWIt/rZYaJWcVqoF+Fu
 TeTl4j+KkhHaILGkGTtHmiXruvGgir/XKoAFbiy7PcsgVuJx2VVBgd+fVC8qvK4olWvXspWb
 U0S4Csn66YonHFHVfH4WACk5mGJtFgQVrK8DtHW9imIxqCMugnIOVMWRzRbVf4g95YbfGU1g
 wrhc8zSORRjt7icSHS4/7iSrC+vNSV9EYPkTXFbJefiy4eyyLzfni4jXf4+SfDu34yd9SXYn
 27T9nVWa6A715ZTv5hX62wrlBqKgvAlpCYH6xvaWGio9Ax0YuZJjKT0tgaBhRqsBKCeVEWB9
 FIeksKX6vxmMH1gvCmKXflLA7yjofqIWNE9vbKNN8dwn9hO0yT6FWy13N2YDBo3WirjUWK5C
 HI/QSsLuPdu0IKCNMebmb6ZBcUw1rTHHt/4TP3SZdcmSsEvJFLcrHw2Px/JhjqFfK0QfUcXZ
 sfznSGEUiZyNEib5GHmLwvg+eJ1nXxjmAs/u7ihl039i9Jym0J5uZ9cbQfQN7lnhE91iFybq
 p5eMdeH0RNSTKX3bUHqHX07fTg3wYwALcmu8aR/L7bdSiI/QT1JI6GLndsJJdc/94wLzbigw
 51IchQFoLYJrSabclrih7EKQO+HYKuTWlpibXB8YAr2giN+CWtthY9GH6YKkXAc3LQL5ZZJo
 zMtIq1s29wfFWyVyCdXdpTnso1peTKigA/EbWLvYyEyc9QkD0bF88PtNFmnviQfLDuFhe1nq
 Z2Z1yTfXcUiQSZmB53oc/6B9Q66kkUcv+NQZHH2BOdvVn/iy6VUDhDgr+QWJpgMICrTxzHB2
 AexBwwZlNb3oIQ00YfogPmao7eQDuckIEt+GlPfzLepNBv1+nio7p9AXd2pIxHcdjLQ04eza
 dpFy8rTNKU8o29LlI5nAZNH/Lkb9fK2g5N7lyNKRG7qaXavAZNeeki259FF7PBx9+UIqDmIV
 VKq0fgEH7ewYefOMkMbfSghZcS9jcAkoCHYt6kJER+r9R1M3eS1VGtJNEOxkw1bFrx+Nb0lz
 coHuMI77w+eiAIgAu2ZjxJ7pni9EXgdb5oJ7p0qIpfnqg4O+GFwZZbxDizX4pbWZe5cbWgsA
 Duf35TZi5pmm0HtTnsUFFr259R7u6gggh5w8QI9Fwy7oead3v4T9z9NwAszVTVQn0lm0fosG
 21FNH9VBKSp/hUztvdiQlKDJgBlLz+a83zX1FEmujD4TU6pd2qVN0w7G7+H0344+lJmXApw3
 e+n2kP6dw31befN3icWcmx0mczJFNBe2FXLp5G6Ip6jAZI/XwvAvoavQmg58z3cHsI7gRz8l
 9lApepfR/XyCn8NnvcdFYKf6LU3TSKELkxkRdVK3vsAPUPYSQGI9Qm+EWKDUeITGKWS6m69M
 dJkGexXXRfn1CqukCESNZRRH5BKxswW9PgwUZK1A15eqLaOjCtbgLSJ/AjEuWIbadFPk8E8F
 4DvSwy/AlGg3Xt5pmucg/RHa0yZYMYFbjLSxOqa0vsEPLNdvfBOcXMd6KqVvXKUPFFZ/jaRh
 gfiZrDX/cNm249Dj4vhKYQdJgSWePfYdvWEzxC3iPtKNejwCMbpsxgHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx06VsFWW8oyZBepXKY9bNT+uAWJFmTi0BvIprLmkgFm8j3RTGWNFMHh+
 5/eWxzib1KItbrVyM1C+ZlH1vHN4K2RXcFrFq7cxzJ3t9x+JGsBMPhbLpgMTJ1Z+sA3OFcUe
 xmVBFbOyw2kNdiHTfk4yMvuVEGTC4Ti///ncycx8Rr8hzieXeu97XgIysuky2h7cH3vwYlL7
 D3YFmLYZnCM/32ieQrfCjFXTwuqKjM2C0/kIXzArvE=
IronPort-HdrOrdr: A9a23:zpVQCqNJo9vbO8BcTjejsMiBIKoaSvp037BK7StMoH1uA66lfq
 +V9sjzuSWYtN9VYh8dcLO7Scq9qBHnmqKdiLN5VYtKHjOGhILCFuFfBP7Zslrd8lrFh4pgPM
 lbH5SWcOeAaGRSvILA+hCxF9tl6NOb8Kau7N2ut0tFfEVQcbhp6wo8MhqWDkEzZAQuP+teKL
 OsovFcvjKldDAsYt+lCmJtZZm5m/T70Kj+aRoKQyUq8hWKkFqTmcfHLyQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AVM2JQ2shFCVcH3PhEZEAkq/s6IsgfneFlXiBHHS?=
 =?us-ascii?q?qAGxzdZ+TCga9wfp7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ASh7wkA7neuGEgJMqSpP1S5bzxoxT4vqDNGYIiq4?=
 =?us-ascii?q?Uvvebby9sOwijlSmoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,204,1681164000"; 
   d="scan'208";a="57338007"
X-MGA-submission: =?us-ascii?q?MDFJ/PJBLY0Qd3TugdK6EFvX/svmINWp5LwFc+?=
 =?us-ascii?q?ReEQKN8mRRVukPYCUbrESNWpQ4qKKtKiqUMU05KnOtSgNOLrieLgMc8k?=
 =?us-ascii?q?HoOYBi1mv+SBaEzn314qT13qOl8Vh33CZc2B0nuAivF7RFNHJ7WSeXDN?=
 =?us-ascii?q?hf5AQ1riQrbhbabCFuR+moZw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:33:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1685449981; i=markus.elfring@web.de;
	bh=h8Pmq85fy+5IcSf5mJBECgxgrTnYE+D/FFrVxgjUTKk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J5Zk4Rrm+BOMGf5QzVruhB2Wmnoomwuc7AOMgH5mq08hDWNnAxjhP8Pv1vpVAriny
	 tlTfmn7JjEBft+qxDMvbDWvFiW7G/lhtijITe5nyJ0iO6FEmKROqtCOzKbjR1E71oN
	 ImsuCHhHJeWhEPcgVz7e7R+Ijg3PYGywKv8f5211pjlTE1416BWdMD1NiUvjRkHjsm
	 DYIHRvwfap5+RcqJNRKXpTKYAOc9FnohNHN4ke3+Zk0WqJm+Cq4GsmtdfMYfOrRbf5
	 LO22rlm0kqk+1tNgULvYWE1O0d+yAENmD2qnSzIdtMEjKsOmp5mbXib5/SPmD5Q1Ax
	 NrinGnVKKDSmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1pkvg80pd7-00J3BJ; Tue, 30
 May 2023 14:33:01 +0200
Message-ID: <7394b111-5abd-ac9f-df0a-4a6db9c7f2c9@web.de>
Date: Tue, 30 May 2023 14:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>,
 kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
 LKML <linux-kernel@vger.kernel.org>
References: <20230530074044.1603426-1-claudiu.beznea@microchip.com>
 <f16a66f7-460e-3577-ec5c-e4ccf00065f2@web.de>
 <7f63dd13-f69a-8171-90f7-5a4f46ed5790@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7f63dd13-f69a-8171-90f7-5a4f46ed5790@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fteOKr5hDcnn0W2PO7WDG00ZA7pDYhJwI154L9oUwZ2VY98f7lm
 6XxBl0FdCkBgBLwZ5G1aKECfOy7tWB04LPasmQk1JXwdc0i7utjt7XxJQyOqMqrykAFqMFN
 jx+x1f/Nw/sNGqSN0d342u8Xhc+mVjLM3UcaIilV4quUX1Qc5bIx4b/VCxowSyKJTB+ULVE
 BdapJvPGWL+L2cXF6IIuA==
UI-OutboundReport: notjunk:1;M01:P0:IIZBfwttLt4=;s7vTDyXHez/hFkFn2xvpMiMV6sU
 mL8SOsLdj4+LVaDqXaft+ZvLgYW1ghAq8K66YBdIab+VtV0DEvA84seM7KbZFycmAaGAw5CbV
 tYZ1GRpOH3KC9PoLlll3zu2PkakvGXj7YJahwRJUxgPDxq3Xa25q574g2+CS2TXGhSBcR/OXa
 PkaG9zvKbGEucYHgiV+SBoYTLeiUoespinWvT501QyeBuOtuL8asyiSpSPUTJQRiz2mzWbT8y
 mA/xLSHJegZzqjmLn83L0BxHkMVOsadFbQde71T9UlTEkMnEVhxUyeU+BL89B/N5TuIE8U7T5
 2+2D3Y/J1abzAsXpa9pFC2YksFwMX3RRUGfR9S10M62AgByrDLxrgkXQn+HwnBDUomJLnugd0
 5vea8y7h9F3oYnc3kvnyUvwOp9XBFV+U/vSsDkBF7JI6T9mkYN6S7Nxf1YPcftE1jqaV3SN0i
 XWkJkxLJUYu/VOqqEdg/AJqngUmBDiGAGOuxNBadBcmgffMJgcGptu8S72OARV5nUspIrf+J0
 dhWmajK8KqOxdzpQDIscVcFLoceZhoW3NWxOe3Qx6AsvLfPhTUCYzvwNs2ve+nz/rnk3mSnBb
 c07fBm5ZuOsovunyVUW/9/taKCwAuAEejSGDnHKlyXKS6UsWg3xHxPGD3cYbOHnUgBNu6SciF
 g2tjGZ6Xj/ROkOgVfVhyfZImITT1wpqggofgMVSCFVzEYtapM17Yeow+62eRFETu12GIyxVXg
 obtctqhX/5OqxnWvr2p9uHpSF7TNJSd85DfWzmimW2octvaIUCbQ2zuqFS11OAGdPw3qeoxLh
 5VuaFItyqLq0CBMRoCx09IgQa/VaAgclr7Q6zdZnpdMQgFX/vFo8ED7O6yZ1tOpoW05q1WMzM
 +C1fS6OgtyH/xU4usLN2ZfBKnX2CtZmCrOWur8wiypdBBgz+pzhtHXaZsu2d1mAYAgWBM8cM/
 EgNRjA==
Subject: Re: [cocci] [PATCH] Coccinelle: kmerr: increase check list
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1164
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/7394b111-5abd-ac9f-df0a-4a6db9c7f2c9%40web.de>

>> =E2=80=A6
>>> +++ b/scripts/coccinelle/null/kmerr.cocci
>> =E2=80=A6
>>> @@ -51,7 +51,7 @@ position any withtest.p;
>>>  identifier f;
>>>  @@
>>>
>>> -x@p1 =3D \(kmalloc\|kzalloc\|kcalloc\)(...);
>>> +x@p1 =3D \(kmalloc\|devm_kmalloc\|kmalloc_array\|devm_kmalloc_array\|=
krealloc_array\|kzalloc\|devm_kzalloc\|kcalloc\|devm_kcalloc\|kasprintf\|d=
evm_kasprintf\|kstrdup\|kstrdup_const\)(...);
>>>  ...
>>>  x1@p =3D f@p2(...);
>>>  if (!x1) S
>>
>> Can it be nicer to specify desired function names on multiple lines
>> for such a SmPL disjunction?
>>
>> Would you sort them according to their call probability?
>
> Please don't follow either of these suggestions.

Why do you not like my ideas here?


* SmPL code variants can influence readability in different ways.

* Short-circuit evaluation triggers special consequences
  also for the software run time characteristics, doesn't it?

Regards,
Markus
