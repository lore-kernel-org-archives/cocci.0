Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADD5C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W7Q3jnM6Zd2jltZzXA98rHm42wpa4zu+yPZuMpINjLo=;
  b=cMU+zy9LsMmq/DwVf/K2HehcGYrsLHp/s1PJMzY6M7eniRBOzv4YHXs+
   YKibzpDkum50dKFJ5xRdyveLiK7bme4OqCfgdbguH6sER5HWNxAu8dAsR
   /xbXRD/QxdlKKbisMsihr5N/jkLS55U9/JaenBs/60em3vyr0yUOSJ8Jc
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99576177"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 19:16:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA59EE0D44; Tue, 28 Mar 2023 19:16:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FA63E0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 19:15:59 +0200 (CEST)
IronPort-SDR: 642320ce_jg8XApkhUlXhdIzm9DuppVaI3Odk065ijVAlD3lJhQki7a/
 0MVzlQ2Q+S4YKisyeHT2So/esOFvLCzXLNuc9WA==
X-IPAS-Result: =?us-ascii?q?A0EHAADMHyNkhwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItgUsvBAtGhFORATGEL4cshzqEZ4QCgVaBQ?=
 =?us-ascii?q?D4PAQMBDUEBAgQBAQMEOIQ8CgKFOQIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2CNyIZZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkdTPQMDIx0BAREmAQ8fBgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJ6gigBAzEHrz+BMoEBgggBAQacCh8sIlOBXgmBFC0BjQSDNnonD4FVRIE8g?=
 =?us-ascii?q?lNuiByCZ4IplxsKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMH?=
 =?us-ascii?q?4EBJQQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIID?=
 =?us-ascii?q?xIPLEQOQjc0EwZcASkLDhEDUIFHBIENfAoGASYknVN7CQqCdpJYkkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBZQI2gVwzGiSDNk8DGQ+OIAwNC?=
 =?us-ascii?q?RWDbo9IPzQ7AgcLAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:EmJiqKAOQqHB0RVW/yXnw5YqxClBgxIJ4kV8jS/XYbTApDJ202cEm
 GYYXG/Sb/aKMTbzKot/Ot7i8B8Ou5eGmN9iOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/ouOaDdJ5xYuajhPs/nZ+Es01BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc51/DWXvsnq4/N0odL70528FyBUxJ5
 8VNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGM0m5vcAtNs0ruVHB/XDf
 Iw0bTR1bRLPSwJCMBEbBfrSmc/13ySmLWAC8Dp5o4Io+Eb40FdLiYPyc4OJY4Kab8ZWpVih8
 zeuE2PRW0xGaoXGl1Jp6EmEjejEliLTQ5MXDLT+9/hwgVTVyHZ7NfENfV68vOX/lUO0Hd5SQ
 6AJxsYwhbo33kyrE4KsZBaTsk6lnzkZX/dXAdRvvWlh1ZHoywqeA2EFSBtIZ9onqNI6SFQW6
 7OZoz/6LWE27ubEGBpx4p/I82roZED5OEdfPXdscOcT3zX0iKcX5v4lZuRuDqOzhNDvFjz2q
 9xhhHRh2e97YSIj8aKh4VCPqSilrJHPUmYICuj/W2W48kVmaYTja4HABbnnARRofNbxorqp5
 Slsdy2iAAYmUMDleMulHbRlIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGG2M
 R6P4FMLucACZRNGiJObharuW6zGKoC/SrzYugz8NYUmjmVZKVLYp3g3DaJu9zm9yBNz+U3AB
 XtrWZ/xUShDUPoPIMueHqlEmb4t2i0kw27PDZn0pylLIpLODEN5vYwtaQPUBshgtP3siFyMr
 753apXWoz0CDryWSneNreY7cwtQRVBlXs+eliCiXrXeSuaQMDp9UKC5LHJIU9ANopm5Yc+Sp
 S3gAh8GkwCm7ZAFQC3TAk1ehHrUdc4XhRoG0eYEZD5EAlBzPt7937RVbJYtY7gs+cpqyPM+H
 bFPeNyNDr4LAn7L8igUJ8u15oFzVgWZtSTXNQqcYR87Y8FBQS7N8YTaZQfBznQFIRe2ksocm
 Iee8D3nb6ANfClYN/aOWsmTlwuwmVM/hNNNW1D5J4gPWUf0r6lvBS/Drt42BMAucif85yao+
 DuXJTw6puD9hZA/3/eUpKKDrqavS/BfGGgDFUblzL+GDwvo1Uv9/p1lT8CzYiH7aGP43I6Ad
 Ndl5ajwH9NflWkbrrcmNahgyJwPwufGpphY/1xCJ2rKZVH6MYFQCCCK8ucXv5Ic24IDnxW9X
 3+O3dxoOb+pHsfBO3xJLSoHatWz790lqgPw398UfnqjvDRW+YCZW3p8JxOP0SxRDIVkObMfn
 NsOhpQk1ByduDELbPC21jtZ5kadHEwmCq8HjKwXMKXvqwgsy2xBX6DiNz/L0MmPRelhYkgOC
 R2ItZXGnIVZlxbjcWJsNH3j3th9pJUpuTJWxgQ8f3CPlt70h6I07iZw6hUydBxelT9c4tJwO
 09qFkx7HrqP9DFWn/p+X3igNgVCJR+B8Gnj4gEtuEjGaXK3R0rxLGEZEsScznAzqm5zUGBSw
 +CF9TzDTz3vQvDU4gIzfkxU89rYUt1781z5qvCNRsiqMcEzXmv4v/WIe2ENlhrABPExjm3ho
 c1B3r55SY//BB4qj5wLMauo/pVOd0ncP01He+9rw40RF2KFeD2S5ymHG3rsRuxzfc714W2KI
 O0wAPIXTBmv9je8nhZCD442HrJEtvoI5t0DR7DVGVA7o4av9gROjpaB2RX91UkKQspvm/kTM
 on+VSyPOU3OiGp2m13ilthlOG25bYM6ZSn55uSU8foIJb0HoupDYUE/6ZrqnnS3YS9M3QOYg
 xPHXIDSl9dd8IVLm5D+N4l+HCC2FI/Db/uJ+wWNrNh+V9PDHsPQvQczqFO8HQBpEZYOetZwz
 5KhjcXW2R7bgbMITGzpoZmNOK1X78GUXuAMEMbWLmFfrBSSSv3X/BoP1GCpG6NnyOoHyJGce
 DK5T8+sefo+edRXniRVYhcDNSctMf38a6O4qB6tq/iJNAMm7jXGC9GZpE/ZNTQRMmdCPpDlE
 Qb7tsq//t0S/swGGBYAAOogGJNiZkPqXaw9bdDqqD2EFS+Sj0ifvqf53w8Vgd0R5qJozO6hi
 X4EevT/SPh2kKTP0c0frIF4+BEaZJq4bS/cYWpFk+OaSRjjZILFEQjZGYoLANdYn0QeEbnmM
 SrVYjJK5TrVBFx5nNaV3DgndhiSDKoCN78V49DvE1y8M0+LOW9LPFetGuqMLZu7lvsPAdxL8
 e0jx0A=
IronPort-HdrOrdr: A9a23:gVr7xKoAvtfEatzTCsmCsGEaV5oOeYIsimQD101hICG9Kvbo8/
 xG785rsiMc6QxhJU3I9urhBEDtex7hHNtOkOws1NSZLXXbUQmTXeJfBOLZqlWKcREWtNQtt5
 uIGJIQNDSENzlHZLHBjjVQfexN/DDNytHPuQ6X9QYVcemoBpsQlTuQmm6gYzVLrSd9dOEEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="51516520"
X-MGA-submission: =?us-ascii?q?MDF1Ct57qOmkAOjM02HxxoZhsz2bPQf0vbE0y3?=
 =?us-ascii?q?YY8Q6p8gjYf9APkUjB60ijLyd7yRxG6IZqo5O45rb8Psg4TZB20e+dBn?=
 =?us-ascii?q?qaZDXlqvPlcs18qYnysKtCSjbIHH23Yg3Bs7LqpTLu+0FDLYWrrQXOQK?=
 =?us-ascii?q?U8MmoIlbd8MZejyMZBsHcDfQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:15:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680023757; i=markus.elfring@web.de;
	bh=33JYSqjO1O4ZsfD0PRTh7myLsgyYBwnolU4IU2fN9dY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SwGEhC7gdF8QpH4cRbg5DCBb1coF8UQ5Bi2KR+BdC5Fc4LIJxiZ/gx1pHhES3jjI6
	 aJyV3ueHrtBiJlWxkdw7iNBM7VUtXCRqW6BF8Wf/RvaQt4Rfm6459g58gQZujMNJzi
	 L5nAZSkCs+027BcrRKN5A7el671+2b115Na+i6/WkHuNDmlKNtx43Q8VgP+4msBL4r
	 gT74jJdoYKDPzdUknucJhrd/qqEJvjcqY3rdXP9i/DXYFbxSmejdP5jOPFcJDqibbB
	 n1JaoIlMWbeG73yDcJZwGai3KuWYLqSkMEHwa0Lq0GrD9KQx9O6ed62fB+GL6oVFz+
	 Xt8Vsqj5t8U+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1pdLaN2gJ4-00EvIY; Tue, 28
 Mar 2023 19:15:57 +0200
Message-ID: <52ec07cb-82bf-9a04-da79-62d19015212d@web.de>
Date: Tue, 28 Mar 2023 19:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
In-Reply-To: <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fuyB2ITDQsf7Gof7u5S1puc/4xtNnK2aa2KF4CkTug0NYiKjcNy
 z5Wu6rq7BRr/98ImhF4JGznugAsZOmY0f6L7HgoDETKBTWrH2R+6Pxae4nwNV3GOz/Mq6/V
 +YI3iQ72iNYDBVFWpkAarGQL6REngnefcVDj5gFRqkEpUyak6RNPbjZJPozcdqy18wKuBmT
 7VVxLY5keugI0CDqsMJFg==
UI-OutboundReport: notjunk:1;M01:P0:2NyYn4xURlY=;CqKGXHCk9QFvMu7gOIg2Ef2wU6k
 d0Y1z3V4SzrwXnwfUfDT53Cp0iYwicvYikDUG7OWg3iTYspt1cwT9JDbP5jGLcujxXXugOKYs
 lipBDFWoFV2fpEH03c5JF/4eTsgrENpmj1ACcqfsCawJJ1VGZHvkG2/EXQYTuyUZvoBqGyrmW
 /IEFsD3lVtpI5oK8Muh1Qrg+WJ7pZmGItSL/G/2qxvM4fdF8bV6hsrSoFK36y9lyp/HCQoRX2
 QeVKrwf7/28z6NVDJZNXvFx57xMvRHzxJotOE4ZZL1fVQ9RnIAFsFnCx/9zHID4SkPUOCyPt8
 Ua/0Hihxjh9YG5eSJLtG+2uD9DcCzhmwpVYlIP37dk3cmsIRXDzV14PdnHW2QUJiiT8F/kHot
 fEIbuTozQnijzWEn0t1Qw6xK+59x/C/pHtrrJKhjTRnqFPn7H6iURtX0Z9iqoHqnIBqYaNvk0
 //Do6IuYIDaIYUWVOG00U2HTtJ02SOiZRDBFPgD6Amshsy9a+hVwzzhHs7PlaHLF0Sc3lpvvF
 R9Z7aIonGFv/QazYst78HWonCT+0TtLPdSIs5NIQcSaZ4vFA6lYm+fXt0NWl70ELxiTRpgulG
 tvp3d7R3/iW8UhobCek47KNond2ig2ZXR+1BSFDt6zCVR6wZIE1S8NItRuUgZqtWWPcNOhgza
 cDRwoNDZPKqfMv7izSSvXRIWiCjg9NrJgJlTyDOUaYbvSLc/ez+n9Qi9LXko7eDAeBJ9LXwby
 fqiTSt5R+5ANE+lMaUda5n8M+HYQoKytoi6e/Jy/PV2hd4AA9/P7whJD7PqBCR7Vw0UNKx2Mz
 k3pKgqIv0n5fgqb3X/3cszw3eIf5Xdk67PEq1dutwyvAhQVdvlYvR/jydpKfJazpa9SKvqcsA
 5WbFWCFAb5HEi63Rw/NrksBZHUW+CN5rZkLmAgvLem0vqq3998lYMVaNO
Subject: [cocci] [PATCH 1/2] ARM: Delete an error message for a failed
 memory allocation in init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 972
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/52ec07cb-82bf-9a04-da79-62d19015212d%40web.de>

Date: Tue, 28 Mar 2023 18:40:26 +0200

Omit an extra message for a memory allocation failure in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/kernel/atags_proc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 3ec2afe78423..2f08ab08e68f 100644
=2D-- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -69,8 +69,6 @@ static int __init init_atags_procfs(void)

 nomem:
 	kfree(b);
-	pr_err("Exporting ATAGs: not enough memory\n");
-
 	return -ENOMEM;
 }
 arch_initcall(init_atags_procfs);
=2D-
2.40.0

