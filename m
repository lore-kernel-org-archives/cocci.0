Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B724AC02194
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2025 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qygh4laWbR4Pa19KP1GmxqUS8nO4fV6iSJUSX+NTyoA=;
  b=o/W9iga9L3LUtvCHebGX0Mlu3p3nfps82eShPVYNaZ/EmYJb6OE6DIJ4
   CsDudxpixpj75Zjlmja7tfyjtN76cnG5y7r+rwcnIE7kBeivpMv6u8CtD
   iDXqXqTK9JI6sLZqCZpt0S+ZyMzlDRfTDrBAUVJ0EfQKckeGxpe4v1AUg
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206719889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2025 13:20:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF6EBE0D1E; Wed,  5 Feb 2025 13:20:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A3DA2E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Feb 2025 13:20:26 +0100 (CET)
IronPort-SDR: 67a3578a_O21rRq+XvACeT30jxgKBTXm6b26gEDivbLgEDRauiWgaP+g
 QupX7ADFJNTrcAYwrCxKBK+F8m4pGcce0ApuVTg==
X-IPAS-Result: =?us-ascii?q?A0GQIQAdVqNngAQP49RagQmEF2J1MwQLSIRWj0+BdDCEO?=
 =?us-ascii?q?4c7h1OIdYNUDwEDAQ1BAQIEAQEDBIIMgnQCin4CHgcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CMAEDDiMHs?=
 =?us-ascii?q?SaBMoEBggwBAQbaXB8sIleBZQmBGi6FbIJjAYYmhDwnD4FVRIE8C4J4PoRDg?=
 =?us-ascii?q?1uCaYIzhCUlZ4xKhEGEX40MUnscA1ksAVUTFwsHBYEpSAMqNjEjD4EXBTVBO?=
 =?us-ascii?q?oINaUk6Ag0CNYIeJFiCK2sEBYEtgj2EQ4ROhWCCEoFiAwMWEAGCNXB4HINRH?=
 =?us-ascii?q?UACAQttPTcJCxsGPZ8AhAuBFckDNAeCOIFmgWMMn1wGEy+DcZNTDgaSe5h8I?=
 =?us-ascii?q?qkMgX4jgVwzGiSDNk8DGQ+OWYN1x3dCNTwCBwsBAQMJhUYBAYpogUsBAQ?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGz384sYWQcTZepvvDQ==
IronPort-Data: A9a23:LwrO7art1BarKS0CVqmzMKFS9cpeBmLPYRIvgKrLsJaIsI4StFCzt
 garIBmGPPmDYDb9KdggOou3pxxSsMPWyd9jQQBt+yAzFHtB8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvnrRC9H5qyo5WtC5gFmPJingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kHYYsR1OhlHFgN/
 OYTGTknQSiDqvuflefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5twJwm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9//JpvDGCnFMvuFTrGJneVM6KAuRVpGrGp
 nj+7n/aMh0EaOXKnFJp9Vr32r+XxnOkMG4IL5Wz8fVhgXWI12kLAVsXU0G6qL+3kCaWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uha5UgU0Xt1ND6sl5QvLxqe8Dxul6nYsf2JHYfIoptIPBjUw3
 W6AtfzRBRF2mejAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqls1Hojqf48ScaIYs3JJN3m/
 9ydhAQT74j/YOYO0Linu0/KiXSgq/AlrzLZBC2HAQpJDSsgOuZJgrBED3CFtp6sy67HFTG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qG/9pS//Jd8Bu28mTKuMDiriUWC5C
 KM0kVwBjKK/wFP2NPQuC25MI597lPm7S7wJqNiNMoMWPPCdizNrDAk1OR7IhDCy+KTduaA4P
 5CAOd2hZUv2+ow3pAdas9w1iOdxrghnnT27bcmik3yPj+DCDFbLE+ltGAXVNIgRsvjbyDg5B
 v4FZ6NmPT0FALWmOkE6MOc7cTg3EJTMLcyp+5EPLbLdeGKL2ggJUpfs/F/oQKQ994w9qwsC1
 ijVtpZwmQql107UYx6HcG5iY77JVJNy5yBzdy81MFrinzBpbY+z5e1NP9E6bJs2xtxFlPRUd
 vgif9nfI/JtTj+cxS8RQ6Ogp6NfdTOqpzm0AQybXBYFcaVNfTf5ou3fQlO39Q0lLDaGis8lk
 rjxiiLZWcUiQiphPub3adWu7QiDglkAqs1PXm/jANpaSGPz+qdEdg3zif4WJZkXCBPhnzG16
 SefMS06l8Ls/bAnwYLsvr+WiquUCM58IxZqJHba5rOIKiXqxGqv7oteWuKufzqGdmfL1Ii9R
 OdSldfQDeYmmQtUjo9CDLpb96IyyN/xrbt8zA4/PnHqbUyuO4xwMEu9wshDma1c9IB34TLsd
 Bq0xeBbHrGVNOfOMl0bflMlZ9ve88AkoGDZ6PBtLXjq4CNywqG8bnxTGBuxkw1YEqp+NdI04
 OUmufNO0TeFtDgRDo+kgBxXpkO2FV5Rd4U8t5ofPp3ntRpz9HFGfq7nK3HX5LOhVoxyF3cEc
 x6uubr6prVDx0D9XWI5OlrT0MF825kfmhB442UTBlaOm9D616Y790AKwwsWUzZ68xRj+MBwM
 1hNKEdaC/iv/TBppc4bREGqOVhLKyO483zL6WkitTPmXWy3cG3SdksvFP2o7mlA1059Jx91p
 Kq5zkThWhbUJPDB5DM4AxNZmqayXO5P+R3ns+H5Oca8Rr0RQyfv242qbko28yrXO9s73hD7l
 LM77dRLSPPJMAALqPcGEKic77MbTS6EKEFkQf1M+KAoH3nWSAqt2AqhelyARcdQG8PkqUOIK
 dRiBsZqZSSM0CyjqjM6B6lVB5RWmPUvxsQJe5K1BGognoackAFUs8PrxnCjvFMoftRgqtZiC
 4XzcznZLHecq0EJkEDwre5FGFGCX/86WCPG0tqIrdo5T6A4jLk0cGUZ8KeFgHGOAQ42ozOWp
 FziYoHV/cxDyKNtvdDeLYReNSqJKPfYdueBwCasuftgMPLNNsbvsVsOi1/FZg55A5oYa+5Vp
 5+s7uHl7Rjgh6kkdkzkgLyDKvV53tqzV+9pLc7HFnlWsi+cUsvK4RFY2WSHBbFWsdFavO+Le
 hCZbZauSNsrRNtt/n1ZRCxAGRI7Ca6sTKPBpzu4nsucGComzg3LA9O2x0DHNVgBWHczBKT/L
 Qvot9KFxNNS9t1MDSBZIcBWOcZzJVu7VJY2c9H0iyKjMVCppVG/oZrnqwsr7GDaK3uDEfui2
 6n/eDrFSE2Qtp3LnfZjiK4jji1PWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoBbx86mF/7n0wdjaLICRL7
 z0B0iWYA/Rz6sgBqSUvCjiTnuptgP/Xrp7N0V6oiNT8Wn7yHp1TvEGM32NxuejvDMzH0knGT
 YTwqaaoX2njIXPM/Q1cl7K51f3XUP4DD9nlUMtX/Ovihg==
IronPort-HdrOrdr: A9a23:dD8hH61hhQGmYb+TvJRfUwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A5Tc+02ivE8itt60GHrrjLoWM+DJuQyHbxVneMVK?=
 =?us-ascii?q?BSm9zQ4ycY3Co+I59up87?=
X-Talos-MUID: 9a23:K++sZwT5eQSsc7lHRXSvjx9wNIBJ456CVkAXqYQdmPmIK3BJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206719876"
X-MGA-submission: =?us-ascii?q?MDGnnp8mSFMleIH86NCZE/IXOV64iMj/6M+EkY?=
 =?us-ascii?q?st9To3SpG3DR58DKeaYvXXwVJU+Rjfo1lrRgs8/NTUaAMDloLsrbuUHQ?=
 =?us-ascii?q?FnDnMwlTkh9OF1IulyIbf6+CWkRXVhao6yVtXO1yfvyeBpnf1RR9I7lj?=
 =?us-ascii?q?BoIlIttoJ2rnCaFgiHKrbDVw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:20:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738758025; x=1739362825; i=markus.elfring@web.de;
	bh=qygh4laWbR4Pa19KP1GmxqUS8nO4fV6iSJUSX+NTyoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nTneLOtHgkEqboTpoTEFjmr72IjxTCNYHHtuNlOEAb4MlgzXKpLfJ04hD4buiywq
	 CAVddq4lT/OwUdWW0Bvcp7IWUTVu0Bpq1Q+v/1mTFERxscVexm8EOh/SoEJkZJzR4
	 yW5OMuMokBtSaz1F044c+zBpTKCysneFxMj8c+CSg6oy5Kimh0XOPb/hjZlnfXbys
	 HuGMpEdiUe5hCpcotau9qqcD+s2nUgPZESqpWyCGaDydvr8UFkN3twFWyHS9qyiR1
	 LjLyiBFkUUddNWn2WXkxMBiILTLD16Y5+JjvuBqYQfse+zVBjagHyquTO+5s9tYfV
	 iIVfPJXwWwNSdFDwqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgiXQ-1tEHC92e8S-00lYct; Wed, 05
 Feb 2025 13:20:25 +0100
Message-ID: <6d571cb5-ed04-426f-8375-0c3c2ba3ef6d@web.de>
Date: Wed, 5 Feb 2025 13:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <55fe2528-2405-4762-8e2c-f326810dc2ea@web.de>
 <9cfd83f7-cc7-fbf-1432-c3ce47337987@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9cfd83f7-cc7-fbf-1432-c3ce47337987@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iw0XgUyE7XV+fKTvWVP4C1ueSvg4rIpqIJDOpklY0D0iHVC5ucy
 shphN+jpvlVk5BUDkMHF3og0ybFPYnpkSY+kVHpTG9FRal5HzOP/Y8HWjTcgbxHx0fczsdz
 5gFc1bbojYhZyY1A7247CEmT1kpHU9CZVEiTCsI2EGiQNuCb0rsX9SkgTeHLAWVGOsQGmr+
 ylCbwq5s8f61jwAmdEEEg==
UI-OutboundReport: notjunk:1;M01:P0:yBeNVnFW0gg=;oacXBijwCi0ZOJew4BJoSHCr5YM
 no/FiYq39uU+fhHB0tFq9rr1Dn+xaef8OWlS4vM94Gcqfuiu0v7uXCjeuF4OZC88j2v0tpoHQ
 6YkDx9ks0J1uh5iBvojx8/g83/Er/4+GR6uSFEVDjoZJsziECWOkNZ8IxVsc0kt/Ocg0olcba
 Mg/nCCNv1biskTku9kCNh8UWWK/WVRQ/Y1yyzMKxE8T6COuVQUWqi2GUBQvQ3w4bu9WHiDCqf
 ydaWospwmJZg/6qvRfplapM3d4ZBQQjK0n59/xccWk0Oi5OQy26DnvhhH5CMf5hBiNwQVSwqZ
 HsJzPzhRkPX1zRDq6XBIv10k+mivqfGVT9kJ2hdM0ElHaVdSptu6Td8+pasY7o2gJsGijY/SY
 PkxiQkjYFBBP31ui/Xa7KoYz8eb59x7FxrXl5S0fyhBskofSobisN8xBqjJNXyLDxATUlYXHb
 bT+fWF0RoLcDJt259MFCnmEf2XbffhweIr5szXkC6jWcYEvWKKajX+14RN2P2EewGB5Zl+Oqi
 yitYA3S3/nqp5wIAVb/jCL9uEl0xQ6KPVlYD6xdncA8nbwKLBtNoao3bnl5DTNhcQPuh1UQjV
 BAZ1LpiAcg7kWea7YQStRnmNt3H1ZGEEKKrlojy/nXM5RTaHtvC3icsfu0svAg2XPM3HQTyTJ
 umy38LFb7S/Na3L+OjSLlA6jsvyByJq6RxZvdgUQIXxnS945CyonBmPxgyFmqAc5aV7AnfMbY
 zJEdxuF7wCLB+X65nh21NI98gCHxv3gfFh8YwLUXzDl55AkZYC6T7q2/iwXcOkft9mAZgDXEM
 qdPwxnOgn0bbi+MsrxTqR8/AuEVXfXA4K+ltnd1l1aSyVXUqKPnfJQZHRvcaiR9QysZAWDXCE
 I7cdlrnRHTQCPC/mHJcSf1yl6WUPgtV2prTpbZxIoqiVyn8CEY/RLDo46hTS/ZV6WC/RuduaK
 UVuZ5q5NFY17MpLbQHZmMa2exWVCbULs33vbmcOyM78z6Qyypvee1NPl5yocCYuDcgsHgvAC1
 s66jm9SSOg3N1YeRZUkzj7gIwvGPRTf2KVLro9L64jjsYbBLtIGTLPVaOfaYrP/hd9mvgtSzj
 rHJZ89Rfw54jSMr1Kb3kiqQkYOwt38FZKGRd6xSJglqOlhLkzNeBSco2U6xp4n7XBE+F/jTot
 jjE2uJYuZYn+GcxM0ISUdD66kk9h25qfD8M1yzGy6/EJz3e2dzpjDJcse1zr8dDXJl/WGLuLo
 OLIZgoSw+RYxkUJqros2W/y8iLBxfFVEESTpm035CADi0GmYuP4oAofpNMFIN6AveMA0y3NEi
 zOaGHbNYfSO40u9Gn0ILGviNi0ckFVqcEwq7KbwkyRyTN9lrNCjSKcnWlQyT09eo/om
Subject: Re: [cocci] Increasing awareness for short-circuit evaluation
 consequences by SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2348
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/6d571cb5-ed04-426f-8375-0c3c2ba3ef6d%40web.de>

>> The usage incidence might be unclear for involved case distinctions.
>> How do you think about to clarify possibilities any further for the reo=
rdering of
>> SmPL disjunction items?
>
> What is unclear?

* How will chances evolve to improve the software documentation for
  mentioned functionality?

* How often can case distinctions actually be applied in an analysed
  source file?


> The disjunction branches are not reordered.
Are there system configuration and software development concerns to consid=
er
just because of short-circuit evaluation?

Regards,
Markus
