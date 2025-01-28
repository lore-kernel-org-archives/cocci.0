Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74EC0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=quxVfOigM9b43OCfrgBliPVFPOYtduXSsi9lTYPt+QI=;
  b=leBCT+chg5NNMGFYWX6HHEfQtt9Y62m7lDx9N5+PSek5xrE2D7Jg8aMn
   Bw8/sLP4AzFF5i1fNrikLKc4HHxgiS3nGSGtUCEPdclcdiYkOeQ/8ixI/
   VDk3FHF17bC/+pJITN5WgZmlrdG6o76XWFLjAEEbn9S2/u/opcEaKcnbl
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205453536"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 20:00:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 299FEE0D1D; Tue, 28 Jan 2025 20:00:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B4173E00A5
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 20:00:25 +0100 (CET)
IronPort-SDR: 67992949_nU0lDEZ728oz5gqGf9I9LlT9GS/PSPo5yyOtX8xHTR7sVVg
 sN1CJxUT1GPRANkKYxTMJaZ3KCEtthGDfRp+0Sw==
X-IPAS-Result: =?us-ascii?q?A0FWBgDKJ5lngAwR49RagQmBU4JEYhtaMwQLSIRWj0+Bd?=
 =?us-ascii?q?C0DhDuPEYh2gVaBfg8BAwENPQQBAgQBAQMEggyCdAKKdQIeBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjHQEBESYBBAsJAhoCJgICVgYBFAEBg?=
 =?us-ascii?q?n4Bgi8BAw4jBw2YR5tLeoEygQGCDAEBBtpbHywiV4FkAwaBGi6Fa4JjAYYmh?=
 =?us-ascii?q?DwnD4FVRIE8gwM+aYFhFwQYgUaDW4JpgjNLg10lZ4xPhEGEZ4smUnscA1ksA?=
 =?us-ascii?q?VUTFwsHBYEpSAMrNjEjgSYFNUE6gg1pSTcCDQI1gh4kWIIrawQFgS2CO4RFh?=
 =?us-ascii?q?FOFXYIUgWUDAxYQAYMneRyCCR1AAgELbT03CQsbBj2dVj2Efj8ggX9JsQ6UX?=
 =?us-ascii?q?TQHgjiBZoFjDIoplTMGEy+XRA4GknuYfCKNYpspgWc6gVwzGiSDNk8DGQ+ST?=
 =?us-ascii?q?oRgxEJCNQIBATgCBwEKAQEDCYVGAQGKUYFLAQE?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpvy5Wx6EdZELJolB1sZ
IronPort-Data: A9a23:xwsEUKDQnlGmhhVW//rnw5YqxClBgxIJ4kV8jS/XYbTApGki0GRVn
 zdJXmrUOPjZNmL1edlxat/g/RkEvp/SxtRjOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYzdJ5xYuajhJs/vZ+Esz1BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc51HaTkq9/stfNUY3FoAbq9t5O3tw6
 uNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM+FGv+iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yGgLmwA8QnNzUYxyzHM4FB//6jgCoDURtOIf+purhi6i
 22TqgwVBTlBaIzHkmramp62vcfEmijwWaoJBbig/7hrhkeSzyodEnU+S1SypPO4h1SWSdNaI
 VYdvCsot6k7skKxJuQRRDW9p2OY+AERUZxcHoXW9T1h1ILI/zuoV1U6fwdGafcrt54LSwYw6
 ECWyoaB6SNUjJWZTneU97GxpDy0ODQIIWJqWcPiZVRfizUEiN5q5i8jXupe/LiJYsrdNRyY/
 txnhC05mqlVksMBkam2lbwmv95OjsiZJuLWzlyJNo5A0u+fTND+D2BPwQaBhcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSD2g43R8N+qWnxpiXLkWVsDNdWexcB3iEsJm+BX
 aMvkVgAvM470IaCNvQpONLtYyjU5fG6RI26PhwrUja+SsMtJFfcrH4Gib+43mfrl1NkiqxXB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuNH8yT50r9j9K2OiXPIZ9bawTmUwzMxPnUyOkj2
 4wPb5PSo/ieOcWiChTqHXk7dABQfSJhXs+v8qS6tIere2JbJY3oMNeJqZtJRmCvt/49ej7gr
 yHnCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRGIWgMPJ6xbe1SR+/vPXBfeyy0VPy/m6eo8u
 +KB0y3Yc7oiRiNjLp3kV9Oy/XyMvFw2uuF7b23XKPZ9JWTu94lLLXTqr/kVessjFzTK9gG45
 S23XygKlLLomJAn1fX0noWGktuZKPR/FU9kAGXr17a6Gi3E9G6Fw4UbcuK3UR3CdWHzooOOW
 P50yqziDfg5g1p6iYpwPLJ1x6YY5dG0hbt7zBxhLUrbfWaQFbJsDXmX7/Zh7pQX6OdihjK3f
 UaT9v1xG7aDYprlGWFMAjsVVL2I0PVMlwTC6fgwHl7B2xZ227i6SmRXAQiHjX1MDblyMb59+
 9wbhuwt11WdhCYpY/G8tQIF00SXL3cFbbcriYFCPq/vlTgQ6w9jZb7yN3bIxa+hOvR2D1kSA
 z6LhaD9qaxW6WjcflESS3Xc/+pvqq4fmRJNzVU9dg2FsYeetMAWwS9+zDUTZSZWxyVhzOhcF
 DVKNUp0BKPW5BZuppFJcF6NEjF7Ji+y2xLO2X4WsmzGFW+6e3foPkRkHcqspWc3q3l9eBpf9
 5GmkFfVay7gJpzN73FjSHxbpOzGZv0v0A/7weSMPdmPRrs+ahrb2p6eX3IC8UbbMJlglX/8h
 LdY+chrYvfGLg8WmaowDrea2Zk2SBypIG9jQ+lrzJgWHFPzKS2D5jyTF3+fIs99BeTG0UudO
 fxcIshiUxef1iHXihs5AaUKAaF/nd93xd4kV47oG1U7sOqknmI0iK7Tyynwv390YtNMlc1mF
 JjdWQjfGUOthFxVuVT3ku96BkSCb+M5OTLMhNKOzL1RFrYokv1dTkUp477l41SXKFRG+jyXj
 iPiZojX7bdQ9qVxraTRE4FoJQa9GfXsXsumrSGxtNVva4vUEMHs7gk6lHjuDz50D5AwBetlp
 O+oi8Hl+W/4p5M0bjzpoIaAHKx3+smCZupbHcbpJn18nyHZesvTzzYc2mK/c7plrch845S5e
 g6Gd8eAT94ZdNNDznlzaSIFMRI8CbzyX5jwtxGGsPWAJRgM4zPpdOr92yfSUlhaUSsUN7nVK
 Az+4a+u7+8FirV8PkYPAvU+DqJoJFPmZ7AdSOTwkjulFUitvEKJv+rztBgn6AyTMEK+LuTB3
 cvnSCT9JTOIg4OZ/OEB5sY29lcSAW1miOY9QlMF9pQkw3qmBWoBNqIGPY9AFphQlTfo2YrlY
 C3WKlEvEjj5QS8OZCCUDA4PhetDLrdm1hbFyj0VE4e8biCrGMWfDbEn+ioID7KavNf85LnPF
 D3c0iSY0tuNLlVBWusZoPC26Qui7u2P3WoGoCgRjOSrayvzwtw2OLhJAwdHEyDKey0IeIMnO
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:gcHZ7a9LqMzi1esjpFVuk+Ggdb1zdoMgy1knxilNoH1uA7Wlfq
 WV98jzuiWZtN98YhwdcKm7Scu9qCrnhPtICOoqTNGftXfd1ldARbsKheHfKlvbehEW2dQ86U
 4KScdD4bPLfDtHpPe/ywmqG9EvyLC8gdGVbJ/lvhNQpeoGUdAG0y5JTiCBEkN3QwFCQaA+CI
 GX6o5mnlObCA4qR/X+PXUDV/XOvJnwmIn4bQUgDxoqgTP+8w+A2frAHx+RwxsEFwlXybNny3
 XMjhDij5/Ty82T+1vm22ja8phM3OH5wt9oDNCXhqEuW0rRozftX4hnU6CPp3QOuemq0lwti9
 WkmWZdA+1Dr0jceWmprQCo4RDp1Awy42LvoGXo/EfLkIjHf3YBMuJkwbhyVCD0gnBQx+1B7A
 ==
X-Talos-CUID: 9a23:aR7Gp2MR1Lj09O5DRDVaxR8pJPEcdXz2wXSBHkGCE1h2V+jA
X-Talos-MUID: 9a23:r9NORAhZ6FtukhOyn3sCFMMpbdhEv6qBGE03y5Q6tMu+GhdAZRWwg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107590130"
X-MGA-submission: =?us-ascii?q?MDHCt/iUatIeoaMNFtEQpPn2yQCHbFq7Q+4dtV?=
 =?us-ascii?q?eG4BBHBaQPxfQmHAr0SwqJqgAccpz932vSWzvu6+phDjGO6E/YGsVGsP?=
 =?us-ascii?q?OHMJ+udPyzARP1ygBZnr0FBki4MHXWczodh7PAkdNW96kFMQsaF6wuYY?=
 =?us-ascii?q?VS/ktP0W/Ych1GU7x43mN2DQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 20:00:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738090823; x=1738695623; i=markus.elfring@web.de;
	bh=quxVfOigM9b43OCfrgBliPVFPOYtduXSsi9lTYPt+QI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G5JtdMaFTIlPTkDk7BR0XmGxl2+BJw5vbyvI8RO9G1I9EK+o4hHockY3gNg1/hh7
	 hjDMN8SESt1zgbTyBFxUvxzqeqXVOwgDSHfk9iusd4DXigkDPp3dLK28BBYkoolDz
	 7dYpCeLVfrd9BFhXClHDvgIVXZs1HY3Z+L7SyVhe0M/BEe0VA0RBaB+VfOpu2Ojds
	 wSim0KIlPwSn4OFHNFamQXUS24aWdsGiOmEVlM3GNmUVgLGnebwIqqN4J7Euw/Htz
	 l6Pj3LbuPH1F9wccwELrWo7xb0CPAGvT/leHN/SzXiEkl0si+TC33+S/kMTERuj3Y
	 /Ke9coPm/nyiDy8PsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1t8Aqd2n8C-00l3g0; Tue, 28
 Jan 2025 20:00:23 +0100
Message-ID: <397f2508-ba10-44f3-885e-edf537e9efb1@web.de>
Date: Tue, 28 Jan 2025 20:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com>
 <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
 <CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com>
 <f8d227a6-848d-4857-9857-2ae279e1f8b4@inria.fr>
Content-Language: en-GB
Cc: Ricardo Ribalda <ribalda@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f8d227a6-848d-4857-9857-2ae279e1f8b4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wCbuRPL6HFtTTMN+BmWpVrVGn4sLlZE9rSfiLA+7n3w43mf+HsZ
 IGHEig4zKNmd0hbcAtXYfPvjiebPVUVnQKqejxfL2VmjbapDh0fZyk3milF37Iszm+EgIUh
 /gGzxFTdB0zrUb9b6L8OCmv3mM7eDqRq53cnoWJgmUVCzCvc8guGohD9aqcYVeU7QR/t18x
 PjVIB7u4D1b7C5gT2yEaA==
UI-OutboundReport: notjunk:1;M01:P0:lgSR/RX1ONI=;Qc5NtMleHFs6ttW4+lyfkf+UmAz
 PQ2/3+Hoi/PY9KBf5d6omWsoL9RHrCMAgvuPNR/KRN+fvCcaAal7TDcd0S5jpI4Via0jZMYeo
 Gh/Bh9YMu2GbqnGq9AXE8j8XM/vexLYOGB7dScbaYzB2xwmMk7TlemypKi29Rbfg1d18kaRq0
 VvGX9Z7smn0p1NYUkWVBv2MmjQMfpo06NNPp4Q3fMm/n5KUbIB6NeVJ2bEZO1iaYZDpUAfd3K
 ZOPG/7SVYzgZxxd0Ftn2dkfIeyOfELH+X6u/+Vod4/0NfhKJyfZprC0Rt6aJzyxT6LQ4Ye/bD
 I9AXOQGAHek+k10mTIeXM7dsQHVR5EWT8ztsUHVDgBfftoQ3JKjKfduqeeO9zSfJOcbK+oLXQ
 FuoexfL8RlQI+ZY7yKd0euCrSgvh6yeQJz1lx4ugVSc58vm6t/Nv91xmt5oFCLt73PIcwq9F5
 EF1jVPF7kxZHcU/bG72awAVKGguKvgV6eq6s6quD73dmxPoPTcusMnFuCn180M/QimUZ+IOs1
 ewflCcpY0B0tUFmIngv5rBHugjTobO3xB4iXHvHZ2VLNOp/lEuD87nhQqPFoF+8FY07frscaA
 zo5pGMNDb5e0//u4J1zHJWMBLl3kG0pkvKcmf1ge6S0QtXbcX42ykSme8SxVrbFPlgD4hMQW6
 pg7nXWBhfX2lcz9Oe1LXJLDvsbGhxTFsLbm1igU2O+yqAaNPDLZCrUZ6wBnFy/yKWcei/S+ZX
 ylWEoplx3SCFqLSumZrvk3KonkY2EGiKKgGswIABii63V1KehrrsNVZqWbqmsBuwg3UIIBdpW
 Pe34ePqmV/4iDZqwuLMNmWpMwftmSuOThEJSjJthWObJmqxL6La9VMR/ZimmLbJohl8/SXh6J
 UQ94I+87bU+6nVnXK2EnTcr8ii2FV+tuGFnEMIU/e7Bb2M2hcj0/QmSu04yvkd49VvgxZy9nR
 tBkpDHBOMZmPGo+iHgXC+/g1SSSm3FrroKv+drQxJZN+bzf4z0q5NROfyzzPh0CYJ7Ti2PuVA
 Hp9YReq3JtiSQKoXOYJH2OFlJIc5ve0X4C4+ODF5ENAfAGL6HNnacMkoBwY9QfGzjoIxkHaMj
 KXjIZnHlHrOIWsXZjNBTPjhrDrDvsr5ud9KXXdpWkxuHNxO6dK7bro7UWKSDYxTu3NHQraTy9
 hyv2XclXi7ra3IGWHVl7M3Wk2tM43tH8e7eRVOrm4jw==
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2290
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/397f2508-ba10-44f3-885e-edf537e9efb1%40web.de>

> Thanks for the info, I can now easily reproduce the error. I can also co=
nfirm it's not just linux-next, the same issue occurs on the regular linux=
 tree (9c5968db9). The issue has been present ever since secs_to_jiffies.c=
occi was added.

Thanks for such feedback.


> I also misspoke, since your patch is on the Linux kernel side and not on=
 the Coccinelle, I can't merge it...

Circumstances can evolve further.


> But it looks to me like that's the right approach. If the script never w=
orked, it's not Coccinelle's fault.

I propose to reconsider this view once more.

The discussed message seems to fit to the following information in a corre=
sponding software documentation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.13#n92
=E2=80=9C=E2=80=A6
Note that not all semantic patches implement all modes.
=E2=80=A6=E2=80=9D


> Do you want to submit the patch to the Linux kernel, or should I do it?

I imagine that more collateral evolution can happen then.

Regards,
Markus
