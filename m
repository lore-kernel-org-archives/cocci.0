Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E6C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jwx6RUu0T4aaPWwRQRpFEsh34I/+eQWkne2OrHPvH8A=;
  b=RpOuLfgKP3Sr1DHxIS22izBE0IQaMZUgJEAiA551aEp5ni6U8NFziBti
   zePegV1S0qknQ2iRuVl3VjLI0RMoIbmrHKB/Y2He/qUoXekltVcq6iX0C
   j3EkrY/SJbKlmPVQGfkk/r8NIl95AHdFnRoSObpuGHcc6tPi/M5MCATIb
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145894325"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 15:00:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D7FEBE0CCE; Wed, 10 Jan 2024 15:00:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2E84E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 15:00:22 +0100 (CET)
IronPort-SDR: 659ea2f7_QVAdYDMxJWFzaPYTDZkwNYhrAaerkDkZ7R6J64ozU+gGXEt
 68XF0oQKrcVFhL5RPYA5qY+nZp3PPdrd9EYeavQ==
X-IPAS-Result: =?us-ascii?q?A0FrCACyoZ5l/wMP49RaHgEBCxIMQIFRgjcHgUsyBAtIh?=
 =?us-ascii?q?FORNjBVg2aHNYdMhGuEBIMWPg8BAwENQQECBAEBAwSEfwKHPQIeBwEENQUNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJVGIEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCAQQBIx0BAREmAQ8LDgwCJgICVgYBFAEBg?=
 =?us-ascii?q?nyCKwEDDiMHtWGBMoEBggoBAQavWB8sIlaBYAmBGi+IGgGERYEig0F6Jw+BV?=
 =?us-ascii?q?USBPAuCeD6IHoJohVyQIlJ/HQOBBQRcDxsPHjcREBMNAwhuHQIxPAMFAwQyC?=
 =?us-ascii?q?hwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVCDFADZR8yCTwLBAwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsmAyoGOAISD?=
 =?us-ascii?q?AYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd7gRcDGSsdQAIBC209NQYDC?=
 =?us-ascii?q?xsGPQKbIcVJNAeCNIFggWEMnysGEAMvg24BEpMlDgYxkiMuh1CQTyCjHoUog?=
 =?us-ascii?q?XslgVkzGiSDNk8DGQ+OIAwWhAmPR0A1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 /DQmai1JDoQq7o8EuMDCsKSJM/VaRIc
IronPort-Data: A9a23:dLN6N6CuPB+pnhVW/3Pmw5YqxClBgxIJ4kV8jS/XYbTApDwq0WYBz
 GsYW27QOfyJMTakL9AgYY/n/U0GsZSGyYMwOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHZDdJ5xYuajhIs/va8Es21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc5wqFViLz0dwzNmQ/LdUZwdlRW39yq
 ONNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGM0m5vcAtNs0ruVHB/XDf
 Iw0bTR1bRLPSwJCMBEbBfrSmc/x2iSvImED8Q79Sawf3zLUxi9+8YHUPt/SauzVRuZFhHnCu
 TeTl4j+KlRAXDCF8hKO9Xmnh8fUjCbjUcQTEqe5/7hkmjWuKnc7DRoLSR2krPP/hkPWt89jF
 nH4MxEG9cAanHFHhPGkN/FhiC/a4EwvSJBLHvck6QqA7KPR7kzLTiIHVzNNIphu/sM/WTVgh
 BfDksLLFA5fluSfaUuc0bOI8hK0GywedlEZaQE+EAAq3tjEoaMItCzpcOpNKqCOo+PQJSDR2
 BGP9Sg3uKUSh5UE1oK95lH2vAivrZnoEC8wvxvbblu44llHZaqgXYiJ6Efa39lEPo22XlmMh
 1lausm8vcQlL4CBqzyJe8oJRIqW3veiNCbOpHJeBLwjymiJ11u8W74I+xB4BkNiEvhcSA/Te
 EWJ5D9gvs5CDkWlfYpcQtyXCf1z6YPCCN68dPTfTuQWU6hLbAXdoR1fPx+B7VvMznopv7o0Y
 6qAUMCWCn0fN6Rr4Ry2S8oZ0p4p3ioO/nzSd7+q0yWY1aeiW1DNRYcnKFeuasUL3JGAqijR8
 PddMJKu4DdbW+vcfCLW0NAyKXYnEHsFPq31+vdnLrO7HglbGW8aG6Dwx5ElcNdbhKh7rLrD0
 Uy8fU5682DBo0P7Bz+EUV1ZU4O3b61D9So6GQcOIWeX32MSZNfzzaUHKLoyU7oV1M1i6v9WF
 Ms6WtiyLclObh/l+D0tS4b3g6I/VRashCOIZzGEZhpmdbFeZgX5wP3WVSqxyzsvVw2cqtkbj
 4Os8ij5UKgzbV1uI+iOYc3+0m7rm2YWndxDenfhI/5RSR3Ky5drISmgtc0HCZgABjubzwTLy
 jvMJwkToNTMhIoH8NPpo6SghKXxGstcGntqJUXq3YyUBwL7oFX6mZRhVdyWdw/zTGn3oaWuR
 dtExsHGbcEoogx4jJpeIZ1Kk4QF+Nrdl51LxF9FHVLKTWiRJJFOH32k5fRL54pxnuJ3mA3uQ
 U+e2MhoCZPQMuPfLVMhDg4EbOOC6PIqpgfv/ckFeHvd2ism04eEAGNzPgaNghNzNLFaEp0o6
 sZ/td806z6QsAsLMNGHgnpq9kCJFHghUromhL4eEoTEmgom8XAcQJ3+WwvdwoCDVMVICWYue
 gSrvavlg69N4HbNaF8hPCH95vVcjpEwpxx69l8OCFCXkN7jhPVs/hlu3RkobwZSlDNr7vlSP
 zV1CkhLOqm+xTdkq8xdVWSKGQsaJhm4+FT0+mQZhl/iUEikeWzcHlITYd/X0hgizFtdWTxH8
 JWz6mXvC2/qdf6s+BoCYxdurvi7QOFh8gHHptucIP2EOJsHehvgvL6lYDsZihngAP5pvnb9m
 8tRwL9SZ5H4ZAkqmI9qO7nCgP5UAFqBKXdZSP5swLIRECuOMHuu0DyJMAaqdtkLO/XO9lSiB
 tdzIt5UES6zzzuKsitREJtkz2WYRxL1zIFqlnLXyW86X3+3qz10rNTP+yK4iGJDrxCCVyoiA
 tu5St5AOjX4abhod6vls8ROfGa1CTXBTBOpx/i7qY3lCLpa2NyBsigOPn+coHifdgdql/5RU
 MUveIeOp9FfJU9Qc0cA30mN68hY6T8+aQhQzD2Ojg==
IronPort-HdrOrdr: A9a23:OQy1nKDrGDsZmsLlHegQsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U4ssQIb6Ku90ci7MDvhHPtOjbX5Uo3SODUO1FHIEGgm1/qa/9SCIVy0ygc+79
 YGT0EWMrSZYjZHZITBkW+F+r0bsbq6GdWT9ILjJgBWPGNXgs9bjztRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayHqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD29vac7R6d031loqqh9jJxPr3NtiHTEESutu+cXvUuZ1RFhkF2nAjg0idurD
 CGmWZbAy060QKtQojym2qm5+Co6kdT11byjVeSij/k+5OkADQnFsFGmYVVGyGpm3YIrZVy1r
 lG0HmesIcSBRTcnD7l79yNTB1ykFGoyEBS5tL7okYvJLf2UoUh2bA37QdQCtMNDSj64IcoHK
 1nC9zd/u9fdRefY2rCtmdizdSwVjBrdy32C3Qqq4iQyXxbjXp5x0wXyIgWmWoB7os0T91B6/
 7fOqplmblSRosdbL57Bu0GXcyrY1a9Ny7kISaXOxDqBasHM3XCp9r+56g0/vijfNgSwJ47iP
 36ISFlXK4JCjHT4OG1rex2G0r2MRqAtBzWu79j26Q=
X-Talos-CUID: 9a23:iHcZR23AisozdZ1A4ucCmbxfXYMAK2LP5SrqBkaoUWdSd5vPV2PN5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A/5nnQwyiyrKvaehliKcwLS8U4MGaqJj0D0ounrQ?=
 =?us-ascii?q?/gseBMjxAZDS+nC6IGJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145894314"
X-MGA-submission: =?us-ascii?q?MDHBd8TrW8LmQgRFcdwHpO7dt6ZGQ06EVTkJuY?=
 =?us-ascii?q?FJxmAkyGzI47ql2XpfScrFWG0ZdeWbr9kX2HuOXfJ1TMi/v+dNsyhjTA?=
 =?us-ascii?q?MTZ/rDprl7mvsoDFg5vjfBgA1p74V/MxhZlP5FFHejFVkDxxmbUoQHPQ?=
 =?us-ascii?q?t1fUGAy+0NqNME9rmSNpdMGQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 15:00:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704895214; x=1705500014; i=markus.elfring@web.de;
	bh=Jwx6RUu0T4aaPWwRQRpFEsh34I/+eQWkne2OrHPvH8A=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pMvWtcyGLZRQyDLBKtYNUuolMrAqMV0MsgAlNo+N8eVNIyXwHkfn2SaCJ4Wp7Q+E
	 Hr7kUmchb3DgUxkcMRAACrnRb5m4Y3ZHlqYqW2tjmbP2h6zDKHt8M0SdsRhpCKDZn
	 UNoOGqK//xgzaZPl/mhGuJXOSt4GqKbc/hrYm6Mxf+f98nddrL81DlwYWNxUnF982
	 vWvMZIKvWz78xytHWSw0salqkGN5KYNYmILcv/rQ+acL+pVrqmKsIAjuY96HwBq3L
	 B2a/03hL0atFaH2gEymD4lo4HLmqfzy+UTDqArod/HHAF2nNyWGR6SRNexSt95J6X
	 uyxgqhzeXVQAUEkrhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1rm5BM48pF-00SiOD; Wed, 10
 Jan 2024 15:00:14 +0100
Message-ID: <89406360-b6ee-455c-a575-031b87cf41ae@web.de>
Date: Wed, 10 Jan 2024 15:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
 <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2I0WKPnqw99G/fiSpEwxcqFTU+W9/ORe+BYTH/Q764foAz/ZINn
 oBtBSGopdJnv1BH5wUHRTiNU3k4od0zS4xYO5SV67fOV0dNfVkyACGIBwqAyOFKV/EQCDsY
 XUQyKIvPBswczhMFNQQ1vDeYU7lybo05TJ3OAGyRGRDvb9eSqwnK7kDlgjqdOBssNQmXY16
 mPpMhn13UuZ6KgvSaqWjw==
UI-OutboundReport: notjunk:1;M01:P0:CVYO9yQsxSg=;8xUQMGmY8Aqw6326Or0c0/bHD7A
 gCBeLl+VSwEKp9s6Ug77VuURafOpZVQr+X6yfdQCHwf0GlIcv0zju0BdwB5QbbavYi38XO2F3
 YU7WHCEFnYDReauxAl/Fci0OxoICtyCWC7OCNZDsz7ObRw/EXGcH6vMIguQfanI+ASKiaKlfQ
 GNx31eo2dcdlSdoDF5FUm2b1IWOGjUky+9uRWeVv/MU38xfsqVhBfrWr3kehMwmeeQ9K2F9Fg
 5RFiBinMzF0+FcxzBNhji6QbK//hMo4OzqFE1+eeR3HIDVdc/g2OQWlowK/5DCHe1imIRvhQ3
 V/kvf3ZgF9yDKIM7ID2Mg7mA2OjN1aoAZZj6GLxcA81A7pZK0A1r789g6NJKlaUNjdGcSeIMT
 zJs2sYFNN3mDKVUU+Xyw9Glg+CfJTF5uUCnH2xr71zfpxrXO2VpC3YDQlDFtjPJ4j5GE1Kot6
 Ubh+7ZOW3ZIuiJrL6q5veZzrnS36+u8/txU6SDD4iMzekBXdEdzCxaqd04Szq6z8b2rWk3VNy
 eQoQgEzw9m+31ZCj+gPrZvpqNuMIoTnYfRw6R8TApbEMSSAcf7brdBzIOZVzbB4tCJg7lnu1A
 cKYGocyCNMZSd8UKCqpCJ9r0WBzGWNROU6YD3jjM1xvIANZHSQH0mWcosCaGDD6QoDBxivaKN
 RDNKuT2vf7XnO94j46NSsOiI304Pi8ND+rjIeipltTtmqS0vt0ZHlioZov32bkxMNegJqOL9B
 nm8aZXKBh5MI+u+o0zJlc8OqpVlZsGp+izAlgzTnTHFxjrMVAG+HHWYWNjpu7QTFAI6aAA+XG
 AE5B3UrawuPEUaR5gXLg/pAT75jqNz6/hOyGbwMoi1wXgFF54Nv3PwqEwiI6ZEhxIdDx4IK59
 PnznidfxCeYdfBwAle4QhqkbdoRenXL2ShJbHl7lnPxlVlHobXP13M7T+89E+Wk0dIEjJxYxb
 rKIN+A==
Subject: Re: [cocci] [0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1455
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/89406360-b6ee-455c-a575-031b87cf41ae%40web.de>

>> Are you going to pick any patches up from linked information sources?
>
> No. Did you read my first reply which told you how patches get applied
> to arch/arm? If you didn't, your patch won't get applied.

Do you request a resend of affected patches here?

Regards,
Markus
