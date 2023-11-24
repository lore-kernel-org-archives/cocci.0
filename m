Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78D0C61DF4
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3rknZhD87CUBuviUqdDnsdJ+fVuc7MAxeh4eHd6ScYI=;
  b=l/HKjbp2LSV+Tog3MVbOMR3+BX0FftPU2BaCPQ7RnrBQKbR4QzoPS1rn
   M853JlZK1WKyaF00paMgzMrQL84t2Spk3t3T+PKp7y1qnQ9fQ3cqYcFQ/
   rnjjygadDioxvewjQzHkUz3+jw/zS9zIQFQG0qPe/hz1L10CfX1Czsz+d
   E=;
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138321364"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 12:32:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05E0BE0CCC; Fri, 24 Nov 2023 12:32:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 83494E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 12:32:16 +0100 (CET)
IronPort-SDR: 656089bf_sL7CFRSHWqBU2zzGwIXzpqHtb1YBLe2x7VKeFTw6LbHvZQh
 yC2VIjx2mwp5V7Pp1bWCUmnPwyctTZPh4yKFoHw==
X-IPAS-Result: =?us-ascii?q?A0EmBwAciGBlhwsR49RagQmBT4I5gVAwBAtIhFORMjCEO?=
 =?us-ascii?q?4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIILgnQChykCHgcBBDEIDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDgUFAQUnhWgNglwBE?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJwQLCxoCJgICV?=
 =?us-ascii?q?wYBFAEBgnyCKgEDDiMHsBCBMoEBggkBAQaCZqxvHywiVoFfCYEaLogNAYVZh?=
 =?us-ascii?q?DUnD4FVRIE8gksHMT6EQ4NbgmiJJAeCVINShHWKA10iBUJwGwMHA38PKwcEM?=
 =?us-ascii?q?BsHBgkUGBUjBlEEKCEJExI+BIFggVEKgQI/Dw4RgkArNjYZSIJbFQw0SnYQK?=
 =?us-ascii?q?gQUF4ERBGobEx43ERIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0UGSQsDAhoFA?=
 =?us-ascii?q?wMEgTMFDR4CEBoGDCcDAxJNAhAUAzsDAwYDCzEDBylVRAxPA24fNgk8CwQMH?=
 =?us-ascii?q?wIbHg0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvBjgCEwwGBgkeBA4DGSsdQAIBC?=
 =?us-ascii?q?209NQkLGwY+AiejPoEWghMEM8UHNAeCMYFfgWAMnyMGEy+EAYxzhi4OBpJPi?=
 =?us-ascii?q?BmQJyCoNIFkATiBXDMaJIM2TwMZD44sDQmECY9HQDU7AgcBCgEBAwmFRgEBg?=
 =?us-ascii?q?1qBQAEB?=
IronPort-PHdr: A9a23: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
 bIRR7UdWFFnTpvy5Wx6EdZELJolB1sZ
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:ocHuVKAu6Q07PhXlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBHhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOktK1vp
 0BT0ERMqyUMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:esKHim7F6qXlHekOV9ssxF4KKus4TC3h9G6ODGmJFWhWWJeKYArF
X-Talos-MUID: 9a23:jQ0wAQj/EtE97tuZXGE3M8MpKPVj+avxT1I0qb5ZkOKFDDUqOCzetWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="72474056"
X-MGA-submission: =?us-ascii?q?MDFrtYq1Xqysw5ZSe4fgoBdN9meHHeX6lnQ4S6?=
 =?us-ascii?q?fnNF+3Tqz425TZ0LVAp2CfuQolX7BF40YfOex4+8dpwafWHZtalAFjop?=
 =?us-ascii?q?vdQVcR4YvEUvkckGDo39LBLbrWJFUmfw71QOFBaFRNeRgaX5l7u2FyjH?=
 =?us-ascii?q?FSgqdwhNqPdh0SkD7lnZwFAw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:32:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700825534; x=1701430334; i=markus.elfring@web.de;
	bh=k/rOTMsDhYuOkd0/0RiSZZ89UBBiTF+n3sAVHJH+/I4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=WdHaCJZ9n6qam/9+MHnuOksj0gUjN+skDIVBxBW1HL59X03YSnH/0UTEYqKkpcMR
	 jkB4bzhGEC4SXgJiSC5tZ9AnwiteCvQvNkvfeB29BfIz7HLEBkvOLWeKqYx1rksLk
	 mGUqoTrJrKWyfanGMvx1JTv7dssygKiPDpT7DOOFmuGOjtQoe0joHYMkt//nQBWBN
	 rvjRKeS+JkST9AAYmAwc5EKghcvXhyUxUoTZLQ5PSYVJfV735jiSRUVmiC+b6XcTs
	 5nvp8/OvV2GEoTnGJgXqy9IB3deReq9XKeGe3rQAg4oU8+ie3MGm3zZlrXn256VLC
	 /0uuv9nyGfR/bdeGzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYX5-1rUtx12sTB-00xu8T; Fri, 24
 Nov 2023 12:32:14 +0100
Message-ID: <ee749bea-9fdc-40c6-818f-7c14cb705586@web.de>
Date: Fri, 24 Nov 2023 12:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
 <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
 <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
 <d22bd929-b0cb-1b1d-9c8d-3e2e9e1e024@inria.fr>
 <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de>
In-Reply-To: <087e1c6a-31d2-4205-8afc-5925cc01b20e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g+XoJOhFILAOcHBrEdjW6TTTyNMfLaSYB5tAJb9OsgMlFaNCO5S
 JpF3JnI6o0hdW1ef+VyZwTFR5A9piZUv/VYOMCNuFuphkAKIAEVlUBNG7aAiV0d8AaFzQUj
 G/h+ireYsXYtRRY1E+WDj5Z2xoz2q89fDMm3/NSlbvtWVZ/wpTg8/+oiF4iQ+UT2DiOnuMn
 4MAXQBsJefwPNLwKAoYAA==
UI-OutboundReport: notjunk:1;M01:P0:4NzRi2Nz3p4=;G0bfCWG1gp8BALIuvqggTOyo3xt
 KJQEtnFp0O0nvu79xbBtycSf87i19OarfaxF6Njbrl4Vrfix1OT+7udAxvCuQPtDbvf3sAQIy
 vs7SpFuDm2q7JhJ8Vk1oEAOLxam+4oI5GwNhSm8bOe2EPd7OGZ9Rx+qR3K1MvDDgfbS7/gfo+
 weyppQ73i0mmS9i0govUctgra/MuZ4NB3uUFrc8RvQMK7b1m+O5A0uqmkvAUVrmvOP6aWZxel
 tMNtFgE6WS3JeaDAHakvBn3HYzp8u3uRJvf12k6EGUga8oDEyVheoDMsvBmdo6xN4FlocLaR/
 CIE7j5pYH6ETEAFu+v+jx72puvKP76rSNjZLnQWQKRKU/GQr+j9YQU05kOlocXB+bLjivJxso
 hSGWGbTYHtFAXbNPWHddpJwYTLEl8HIQKavL/cPvcT/MQZs7PZBglgc6IZlSSlyf3jcWyhzET
 Vo/7vXixTIMOZFiOZzgKwkay026JHUhavw84HyA0n2zfJHM9nZFO8TykM99EsPS+G8jOCcRO4
 h9cM1XGs8a6nHfVLcis9EMrzXxBjuYuR8PaxCMU9Jwnp/J5pzHZAtsDUGPydqISwyA41XzUFn
 kHmWcSSiial8kyCCdHsVszKOsKr2mAB9sm84uxJZoWU7gSoRRBKW3mKGISPh6jPFjkt9DhOdR
 P5oY5pHlOFQ2VJIS9tY6tg89m5vdmrGo8wReGDKpYEkw009XLToA/Rua/jVCqtw4ovL5+TXZM
 caGyF2OtUzxjxFU9RDHqX1VSzz+CDRc2QuAlI7f4jUW700mETulz+kbWfolMw79r4nd+inkxD
 CUXEuo4d6QDwh38lvk1cEeWZ7/LQmMz/MVBdux5frd0kbeXLFZrl7rKO7IRZ/6Qvqer8+5sxr
 1a6138Qtm42I+vWjK8pr/DPDZ2JgktwmJ89iyMSJ2urvqyNV6oknJQxRnEoEXvP+peHHo0m1u
 7Pp2ww==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1332
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/ee749bea-9fdc-40c6-818f-7c14cb705586%40web.de>

> Test result:
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch test-ex=
ample-20231124.cocci example-Julia_Lawall-20231124.c
> =E2=80=A6
> (<coccilib.elems.Location instance at 0x7ffbc3d2b910>,
>  <coccilib.elems.Location instance at 0x7ffbc3d2e500>)

This test case shows that the script rule =E2=80=9Cdisplay=E2=80=9D was ex=
ecuted only once.
The found source code places were accordingly passed in a single data stru=
cture.


Please compare the software behaviour once more also according to followin=
g
test files.


@initialize:python@
@@
import pprint

@find@
identifier target;
position pos;
@@
 goto target@pos;

@script:python display@
places << find.pos;
@@
pprint.pprint(places)



void my_test(void)
{
 if (1)
    goto x;

 if (2)
    goto y;

 if (3)
    goto z;

 x:
 y:
 z:
 test =3D 0;
}



Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch ../janito=
r/use_common_code17.cocci three_questionable_gotos.c
=E2=80=A6
(<coccilib.elems.Location instance at 0x7f8bd82e6050>,)
(<coccilib.elems.Location instance at 0x7f8bd82e6730>,)
(<coccilib.elems.Location instance at 0x7f8bd82e8640>,)


Would you ever similarly like to receive position information in one seque=
nce
instead of separate record sets?

Can a more consistent data grouping be achieved for such use cases?

Regards,
Markus
