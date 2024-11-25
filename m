Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A49DD58D63
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YZQdfPlpeVF22VRWZzm2fcbYnIB9nRlaZDqPwSudxjo=;
  b=upw7saNYfHMbaBaDtmK5elyan0RcJ9E0CktvkZVAXpr6W/upUacn9Ldw
   xPU+hhRyHSN6sJsmDpcw9Sm6/PcSRaRlSSGXloon/apFY4HN2OyOaGfrX
   E/h0uaS8obEjJZTF2ugtkyzZsTesiKnMU9wsfzjaXc4gxuXqLtE0jFQNS
   A=;
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
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195714184"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:13:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1CF41E0D1D; Mon, 25 Nov 2024 17:13:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24CE2E00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 17:13:32 +0100 (CET)
IronPort-SDR: 6744a22b_rmGQTDMx4fCM3OuvVgovsOGHFHGhRX+6Pp+Uz41Q4I882Fj
 J4/xTfoG3IGTREvnDIK8O33z18BsPN0FmNLcxXw==
X-IPAS-Result: =?us-ascii?q?A0H8BACMoURneA4P49RaHQEBAQEJARIBBQUBQIFTgkRiI?=
 =?us-ascii?q?VQzBAtIhFaRQTCEO4c7h1aIdYFqgWoPAQMBDUEBAgQBAQMEggyCdAKKWQIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCERUCAlYGA?=
 =?us-ascii?q?RQBAYJ9gjABAw4jB7AvgTKBAYIMAQEG2lsfLCJXgWQJgRouhWqCYgGGJIQ8J?=
 =?us-ascii?q?w+BVUSBPAuCRzE+g3xHP4McgmmCRIEzGoNCJYRGgiOBL2iIFYJZg0KCGCiBA?=
 =?us-ascii?q?4lAUnscA1kyAVUTFwsHBYEpISwDZIEVTn+BNoFRAUKCTkqDLhyBQgU3R4JKa?=
 =?us-ascii?q?U03Ag0CNoIkJFmCTYElBAWDa4ELg16EXoYGHUACAQttPTcJCxsGPaFag0Fgg?=
 =?us-ascii?q?QFlgSzGGDQHgjiBZYFjDJ9ZBhMvl0MOBpJ6mHsiqQaBfiOBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hhC3HKUI1OwIHAQoBAQMJhUYBAYtygUsBAQ?=
IronPort-PHdr: A9a23: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
 p7Qmai1JDoQq7o8GOMDCsKSJM/VaBIc
IronPort-Data: A9a23:8t+IfaD2qF82phVW//jnw5YqxClBgxIJ4kV8jS/XYbTApG5w1jVUm
 2saC2/UbKvbMTamKtEna4q/9koPv5KGzddnOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYjdJ5xYuajhIsvvZ9Us21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc50TANFfJ0q9/N0psO6En3sN4C3AT6
 cVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGvmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yGlLm0H9A3KzUYxy1WKkBcy4enRCorMccStFZp8tB7Bu
 n2TqgwVBTlBaIzHkmramp62vcfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPXOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AGBB+lw6yTzyOIXHk/RWRHROMCkcA8VGE27
 wrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdbFmPpBPG8++kOYgLzczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr9//AlrSZsuG07u15JCCsnPuZJgKT2sjDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cb2aG3QE0R8l6qmT0k5JGQWy2yG4vTKuOGplVEQIFn
 GeO5VkBjHOuFCDxM/QnP+pd9exwkPOwRbwJqcw4nvIVPsgpL1/YlM2fTU+X2Wf22FMh+ZzTy
 r/LGftA+U0yUPw9pBLvH7d1+eZymkgWmzmPLbillUrP+eTFPha9F+xaWGZim8hjtMtoVi2Pq
 44Hb6NnCnx3DIXDX8Ug2dVOfQ9ScidqXcGeRg4+XrfrHzeK0VoJU5f5qY7NsaQ+90iMvraYp
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhSAXCkeZL9lHgzAxc/ldFDg9Q4IFSuGivE9q
 LyBiCLeGIQPdz1/AJzoadaq9VeQvGccqs12TUDnMtleQ2Sy0YlIegjarO47HNEIEjrHngCl7
 gexBQwKgMX8uKk3+8ntqYWbiby2As1CHkZ+NEvK34acbCX10DKq/t5dbbyuYzvYalLRxIyjQ
 udkl9fHL/wNmQdxgbpWSrpE4/o32IrymuV80A9hIXTsamarAJNGJl2t/5FGlo9J949jlTqGY
 GC90fgEBuzRI+LgKkAbGyQ9ZOfa1f00pCjb3c5oHGrEvh1I7Ji1emQMGSKTiR5tDqp/a6Ik5
 uYDhPQ4ySKCjjgSD9LXqRwMqkqtKCQbXrQFp6MqJtbhqjAWx2FoZb3eDS7L46+zVehcD3lyI
 hKpgPvturcN4GvDbHs5KlbV18V/m5klmU5H3X0CFXuzi/vHgf47hiNQ1TENSiVU0RR1/OZhM
 Ud7N0BOBPuv/hU5oONhTmyTCwV6KxnBwXPIynwNjzf/XWSzc37kdUkRGL+q0hgC0mR+ejN7w
 ump+Fz9W2y3QPCrjzoAZ0F1jtfCE/pzz1Tms+K6FZ2nG5IaX2LUspW2bzBVlyq9UNIDv2yZl
 +xE5+0qVLbaMxQXqKgFC4W387QcZRSHBW5aS8Fa46I7MjDASQ62xASxBRi9SuFVK9zO1H2IO
 chkC8ZMdha5jQKljDQQA4wSKL5Vwt8twvc/eY3QGG1XiIvH8wJVs6/R+BPu204tYdFlyvgmJ
 q3rKjmtL223hFlvoVHrkvVqAGSCXIQ7VFXO59ztqOQtPLAfgd5oanA3g+eVvW3KEQ5J/CC0n
 QLkZo2N/dND1LZDoorIOYdADjWSNtncermp8geyktIWdvLJE57EmD00o2ndHTZ9HOUuSeUss
 I+Sovvb4VjgvotqY1vGmpKEKbZF1f+yUMVTLMjzCntQxgmGZ+PB/DoB/DqeBaFSsdYA+PSie
 RS0WPGwefERRd1Z4n9fMApaMhQFDpXIfrXSnjy8o9uMGyoi/1T+dv3/zkDQbEZfaiMsEL/9A
 FWtu/+Ru/ZpnL4VDxoAX/xbE5t0JWH4YpQfdvrziCK5C1e5iVbTq5rgkhsdsQvwMEemK/qjw
 5z5RUnZTi+Q6ZH4lIQT98Q4uxAMF39yjNUhZk9XqZY8lzm+C3VANugHd4kPDpZPiCHpyZXkf
 3f3YXA/DTnmFyFxGfkmDA8Pgi/EbgDPBjv4GtDt10aTdjvwG46KRrdsnsulD7GaZRO7pNxL6
 /lHkpEzAvR16o5kT6Af65RXRM95k+jCyCtgFV/VyqTP7tV3PVnO/GNsFkxBWEQr1i0LeFrjf
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:Z9oUU6M2BBRVB8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:+jyB8WMkGGTtFe5DUS8g2GsFQNEeeSfb4Ej0BkCyGDt1cejA
X-Talos-MUID: 9a23:GhuavQjReFu/gKFgPhGNjMMpCZ40+OefWXw3wYwNo+7UagVaY26Bk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102587477"
X-MGA-submission: =?us-ascii?q?MDEBeEYJLnpBRKgMT0I/q1cVPspGbA+jbggwXh?=
 =?us-ascii?q?a0m8tz57I1Z8DnOboYozfhGzQVQrZ+mnnrxAAbqKKGXPK4S7tU2FOGvp?=
 =?us-ascii?q?fhclF1XBaK6TPETstk2Xgrh4BRV5x2v6JbCMjzpn3wm2IauN6JtudO+t?=
 =?us-ascii?q?VWarwJVx2gQpDdFEhH20SwqA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732551210; x=1733156010; i=markus.elfring@web.de;
	bh=YZQdfPlpeVF22VRWZzm2fcbYnIB9nRlaZDqPwSudxjo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TG0odj0hsfSxbxJSl6fC86fBimAzewzXT4/FEDM6FuqwK2IMgCLkpi0XcdD8tmm0
	 QjyI5PgGLwXrVoH5EB8q1fChzL+uzZQ+n72Eh5dqYDbGOx//s2c2DiLxcYXp2ytZN
	 /HzE6ZXPt1acoTBxf9zllEWii4o8WngSDEWrVN+uRQpKW+35S5Qnp27hl6IeVUu2e
	 5QtBS1ov6GFzBKcWEW4HayOyTvJIMHC8wo7OlvrSYKAZIadbDlj92QnPJKRz7aYvY
	 YoE+c0Kgjf63XOjN8A1CF+x4kwiKzddsWQZWeiz2pIWOP6UvGiuhiO+8AMvOX6XzI
	 QD8p+GxNuxal0/rxwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtguh-1tZ4hp3Fi3-00vInm; Mon, 25
 Nov 2024 17:13:30 +0100
Message-ID: <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
Date: Mon, 25 Nov 2024 17:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3vlwF7zPrn4fC2Igyzi061d4WaLN/rmGBUrSd5GMDMM7Z1EgtRh
 HyLHIOg8VGEeqZxcf7UDpiWcX7ij2wP944oOWP3qfFS5kLZqsWNiJLblaXetB7b0Kn39ANc
 NybD6958eXHQVyw7yMNSIjisNDscNuCKg+XWj5yeq6Nag4sfAERsbX0jxpoEsgGjRtk+1Oj
 dJ4xoorGVS7iObiR1psGA==
UI-OutboundReport: notjunk:1;M01:P0:Ml9S273z8hc=;pd08qJGZ5F/IuVFe7MNlPTNvDN+
 dFZuOpD89B7ZmRd0X8pmPPOX7UT7G1LvfqcWbvBCIlwnTagpqcWPrHWg5oQzp3NTQFG3gt2et
 3qnIRZcneGml2Xm/EpCUoV9weBbccdm5Y+6jLEuRsiPUlvE6jf/zgAVJGxBw8ycm4pl7Q1c49
 tfDz1xsqilDFRUaKz1JA3+JFlmfCF2ZuRtSIj3hWDImHtr4KdfeAh1ua/gr3qd1jLP6G4kwGM
 05W9ejqaT7xabJoWwQeBNenLYs2fxDn8k2Xe0cwGpRY35dsTeQ0d3kDqALuntaXyaBI9gsO7q
 1Egxy/p/WNNad2cBTtWVwE1oKRvIAfmD0YF/J8zhceosLFtE4qoybP9Oe2Q/nxIX1bv27l0wk
 X4xQvqZDnu1PDLdBaoQArlOD6XShhvzNZedrEwBTvs12EysMieIM8Cqj1cgNSaNGRkAVBpvVi
 K5fXjj75tQylVn8l7YRfEz/8pgGcJyOgdJ7vJPKi5uXGwWCyTXFbC2cW1abtw/FKn9Lbpumcs
 gMb6v4yiJOydLngidxiTpBz6KuF0yNNIoyF4YJpnM0ovswto++5t93hf4xNApUAJV1ivU2l32
 HBJSkb7yWu8U3pHSFmWO8PgCtzy4VqMnalkGgrsnmM5lnPQPAOubwKq4cyirh8JpIpiZooM+N
 79CaGkt19YzbzOtcXZgoe6Afnez4huHQlWkkHQ/aQMt5NRBQFXV93umfM2DaHjv59Th+ed4si
 2+xJpTCz+r2eeiUb1WNgDTDZcsmeKEsXypOOlDI0EdJF67tlHciOHgGp29hzbjLBcIfgHkkhh
 hSdB6AI6siU1EXnUD1UBVk8mp2MJFNrOplS7TuRuXE+rkLZKKwB4/eejqgvtBXZlAccWVSmEj
 eXRBceiQKU8FU7V9FaHa/EG6tD53s8aCt+t6ka5nzz6z6dC1xafjojsxE
Subject: Re: [cocci] Reconsidering application of selected SmPL isomorphisms
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2100
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/100663c2-6281-49cb-bb9f-55656dff80ca%40web.de>

> The generated code indeed does not look ideal.  But it won't cause any
> wrong matches.

I got the impression that I would need to disable the isomorphism =E2=80=
=9Cparen=E2=80=9D
for the desired use case.



>                 The isomorphisms are applied on the ASTs, not on the sou=
re code.

I remember other description approaches.
Are isomorphisms usually mapped to SmPL disjunctions?


>        So there will be a tree with a ! at the root and a || as the
> argument that will not match any possible source code.
>
> Maybe it would be better to add isomorphisms for the de Morgan laws rath=
er
> than adding some hacks into the generic isomorphism transformation to ta=
ke
> this issue into account.

I am looking for further software extensions.

* I would occasionally like to restrict the source code search to pointer =
expressions.

* Specifying a varying (or even unlimited) number of items for discussed b=
oolean operators


Regards,
Markus
