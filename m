Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908AEB64DA
	for <cocci@archiver.kernel.org>; Tue, 13 Jun 2023 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+9TGMHRkYcwOUn6b12wQObb7LMht9G/5plDB9KWWNvs=;
  b=P985icYhZwrMyi8Jyg1AmgB5ESWAun9MgoZWtwLoE3k6gVVClnrEdra4
   Eyl38rg0zGmi5IxJn+QKhjMOrUUmJ3brpZXnkIIGsGa/O2b9hZCMvYRyJ
   C+whXh3pGf4xiyOEdy4jM+vqwy642og/r24kgl5b8+yscSOfPmNbrQXnZ
   w=;
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
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="112722142"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2023 22:12:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6950DE00BA; Tue, 13 Jun 2023 22:12:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 49D7CE00BA
	for <cocci@sympa.inria.fr>; Tue, 13 Jun 2023 22:12:51 +0200 (CEST)
IronPort-SDR: 6488cdc1_x5OF++ogBjO+174CW7AWfp6+Fhi99tC1woQYwUzm/JdF9bo
 0xFb+L50jKKY5SE+Je0FJMKRq/dYHCLtmn0U5XA==
X-IPAS-Result: =?us-ascii?q?A0ERAACIzIhkh07ASNlaDgwBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCLnhTMAQLR4RSiB2JAzGENocxh0WEaIQEg?=
 =?us-ascii?q?VaBQD4PAQMBDUEBAgQBAQMEOIRHAoV1Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBASMXBw4FCyeFaA2CNykBEWSBCAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBEgJHPwMDIx0BAREmAQ8fAQUCJgICVwYBDAYCA?=
 =?us-ascii?q?QGCeoIoAQMxB653gTKBAYIIAQEGnA4fLCJVgV8JgRUtAY0ugzd6Jw+BVUSBF?=
 =?us-ascii?q?ScMgkdvgQUBgwWEFIJniRaFB5AzgShvgR6BIn8CCQIRZ4EICF6BckACDVQLC?=
 =?us-ascii?q?2WBHFI8gUYCAhE8FQVKex0DBwQCgQUQLwcEMgkfBgkYLycGUQctJAkTFUIEg?=
 =?us-ascii?q?1kKgQ0/FQ4RglwkAj1BG1pBJQQOAxkrHUACAQtwPTUGAwsfBiYfAoIAgQh0J?=
 =?us-ascii?q?CSiRnsTgnbEADUHgjCBW4FdDJ8cBhMvlxQOBpItAS6XaSCiZYUygWM6gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIBcChA6PAQgBPj80OwIHAQoBAQMJhUYBAYMmgloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:7WDEJasiw7Kq/V8mLAkCFex+d+fnVAtaMUV32f8akzHdYApBsoF/q
 tZmKWrSaPuDMWKmedBzaN6y8BtSvJ7QyYRiSFFvpSo1EXtBgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRMs8pvlDs15K6p4G1B5QRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJG8YepYmo7d8O25p/
 MMBOiIXdB3buf3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PNtvDKJlVAouFTrGNvKItmOGs4FpxmFp
 Gabzk6oLDY3ZPXKnFJp9Vr127ORxHqlMG4IL5Wz8fVhgXWI12kLAVsXU0G6qL+3kCaDt8l3L
 ksJ5mwxoKJ0+EHDosTBswOQjlDDpSBFCtFqHMoz1xif2LDO7l6nGT1RJtJeU+AOuMgzTD0s8
 1aGmdL1GDBi2IGopWKhGqS88GroaHlORYMWTX5YHFJdizX2iNtr1nryosBf/LmdovCdJN0d6
 zWNsTR4mLgZy8IGv0lawbwlq2L8znQqZlRtjukyYo5Dxl0gDGJCT9H4gWU3Fd4acO6koqCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/bYGOC0Qc3Q8J7r2jFF5ufkWZ4v2EWyKBBbZZsRNMVS
 BSC0e+szMINZyf3MMebnarrUZ53ncAM6ugJptiNM4YQO8EvHON21HggPAaR2Xzgik4hjek2N
 v+mnTWEXR4n5VBc5GPuHY81iOd1rghnnD+7bc6hknyPj+HEDFbLEuhtDbd7RrtkhE9yiF6Jq
 Ik32grj40k3bdASlQGJqtZJfQ5TdiRT6FKfg5U/S9Nv6zFOQAkJY8I9C5t4E2C8t/QKzrX77
 TumV1VGyVHyo3TCJE/YIjpgcb7jF9I3534yISVmbx7i1mkBcLSfyv4VV6I2Wr07q81l7/p/F
 Mced+u6X/9gdzXg+hYmV6fbkrBMThqRuF+xD3KXWwRnJ59EbC7Vy+DgZTrqpXUvDDLolM4Qo
 I+A9wL8QLhYdTtDEfT5VfOL5HGytEg7h+hdcRbpIN5SWUO066lsCXX7ocEWKvE2Cyfo52Wlx
 SOJJywHtM/xo4MR2/vYt5Cu9ouGPbN3IRtHIjP9872zCxj/wkOi5o1xCMCzYjHXUTLPypWIP
 Ol64an1D6waoQxsrYF5LrdMyJA+7fvJo5tx7FxtPFfPXmSRJoJQGFu09ugRifQV3Z5cgxW8Z
 WyX8NoDObmpBtLsIGRMGCUbNNa8xdMmsRiMy8RtO0jrxj5FzJzeW2VoAhS8oih8Lrx0DYAb/
 dkcqPMmswyRtjd6M/KtrDxlyGCXH3lRD4Qlrs47BaHouCoKy3ZDQ4DWURGuxJeDb+RNb0oYG
 R6Ppa/4n78H7FHzQ3kyMnns3ORmmpUFvi5R/mICP1ikntnkhOc9+Q94qxAbaxtz9QpW9d5zN
 kxAFVxHFY/X8xhG3MF8Dn2RQSdfDxiny2nN4loullyBaXK3V2bIfVYPCczU8G83q2tjLyVmp
 peGw2PYUBHvTsH7/g02fWVH8/XDb9hAxjfuqfCdPfauPscFOGL+o6qUe2A3hQPtApoxiG35t
 OBaxrtMRpOhBxEAgZ8QKte85ewLRQGmNV5yZ6hr3Jk0EFH2fBCw3jmzKH6NRP5dGsyS8WKFD
 51BG8EecTW/yyeEkR4DD4EuPbJfvaAk9fgCSJzRNE8EtLqT9ARolJfq8gn/m24ZbNF8muktK
 o7qVmyjE07BoVB2imPyvM1/FW7gWuY9ZSr4x/KQ3NgSMpA+7NFXbkA514Wrs0WvMAdI+wyeu
 CXBbfT0y9NO5JtNnYy2NIl+HCSxdM3OUdqX/DCJs9hhac3FNeHMvVg3rnjlJwFnAqsDae9ol
 LiisM/F422dhewYC1vmopimE7VFwe6QX+ANa8L+EyR8rBu4AcTp50MOxnC8JZl3i+hi38iAR
 TXpWPvoIJRRE51YyWZOYidTLwcFBu6lJu38rCe6tLKXBgJbzQXDK8i9+GT0aX1AMBUFIID6F
 hS+rsPGCgq0d2iQLERs6zBa755EzJvLXKw7a5vuuDPeAmTAbpZufFf9vUJI1N0JIiDs/AXGD
 VbtWRX0Mhi/0E0N5M8MqJR853X7E14k6dTdvSshFxpelD2wSmILRQjY3VPqFbkM+hHPOFrEi
 P0hoYfs5egRndiJTPkk3OneYw==
IronPort-HdrOrdr: A9a23:+f605qmq4vi1VFLdJ50C38Gb/a7pDfL43DAbv31ZSRFFG/FwWf
 re/8jzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPIdurIruPmzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A26jOAGkkFtEHIV/rz2VUaxfTJADXOVPzi2zueh6?=
 =?us-ascii?q?zM2lOQYKMW02K4q48rdU7zg=3D=3D?=
X-Talos-MUID: 9a23:wPKhOAtWUHdwIMPNV82nhS46McM36PSXV10Plcg3kZiqEgEgEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="112722141"
X-MGA-submission: =?us-ascii?q?MDEq5liAoDLlCchVnEgOQ/TmGr9GHX0Ofkhuzd?=
 =?us-ascii?q?BqsG0pKQ9KbJnWiuICF00zjSiZwX3/JkeU1BWFcSpfOY7qkUy/f/8ZxB?=
 =?us-ascii?q?xW3M1kOZNdeT8DlsqRof0O/V7qD6PFskugcTZJpaMqhbka5uCK+o9bGH?=
 =?us-ascii?q?df+Q/6SFlcFeJV4FG4oIh/Fw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 22:12:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686687162; x=1687291962; i=markus.elfring@web.de;
 bh=EyW6S7JGnyaFI7AqEskScW2AasmCX45kbWOiDgIVsaA=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=wnw6zACgvYMRuv582ZVo7CznQG7prGSjhfBw99boUDSZAiDDSknSPfEwaLiIWh3q2OTGFUL
 MkGy3mTHJQwtSSEsTwxWDeTAmWLWZoEEtk0JUfCjr+XtonRVPOD8ephU4RxO5tKEdZdAMu9F1
 zq540SGa4A/lEE9hyCDtVCShPcBb7Jqe2Vy4CU3PyoSG6ALFRyUylxHEanmj2uPzH+CKJ6hBZ
 ZGb8dMY9ObZvYI0BjB+0bFnJZe4paMtjMaS2QwppDmkOIo/GC7spfDCtoLDp6VR/Ld77BKTOn
 6gMzEhVZVT77Gpt7u6mk+316++GKQqz9pXRk2VrnKc+bWLTtuV3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJRl-1qbS623FTz-00SJHC; Tue, 13
 Jun 2023 22:12:41 +0200
Message-ID: <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
Date: Tue, 13 Jun 2023 22:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Zhanhao Hu <zero12113@hust.edu.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230601033825.336558-1-zero12113@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vxi5b0bX3XtM7aSE30b/Ooalxa+P0rORHLYyAb6FkqjiwSvsi/h
 q6rHn0Xkskec2UhC560snPTMjcDWnd1BvhMkL4U7qWms3/NlKNwdevxpmPibAaz96vbOKJM
 Y+AgmF02ykyLpvNH85i/f0dTuLZzkwuFGTLFOeoCK3BvacZnrHH6EDpYw7mizvZeXK0ScXq
 Xs62kIs5Ht39bf5wcjh7g==
UI-OutboundReport: notjunk:1;M01:P0:0ulTzr/17S8=;/AIQtiXwwLKEExMR0Lbk155vaM0
 Z3GHn1sQgB1XdaXq/h4F5NmyZCunP5HP9yYOeqYqFZmfKZcXUcvPYWmfNQK+73jIfphfVUd+u
 g7WPv4YvN7voLrSzpKkg2JvPv6YAwQRGNOMchu7jAcH/b4dy3gpYmpdkbXVla+RsLRbsSE3u6
 N1ZxDJ5LgHD/uEdwblCAdIbxhBXGwR/MZVMidhpmdUyEYm7YCXhvqWy37MfoGuk5jWDZRat9h
 Di4Q4qXaLRIkBNUG7l5VjfgpxDxQOpj1igIjiG00K/Du6N+5DTgqkxLY1eHsBXxgaHDeeiIZF
 w38+nRK3gaQfH6p9WTwUajZmAFA2fSIIAcZnDn6HNPCOo1frBqqQ3sUWvqbEaS/+87ZBGJ5jR
 X4ZTIOMPjThurRVw3yporDGM8YDeEIEpD1pVl3dciXqDJEUcoXgTDoLQc+94cm5grknuT0cm5
 XzZXAOYiPExQc05sdHHX5+H/fvYFsyL1X/hygMfiFnsjJ4NBNny1kuXoI188za6+nprJM3AIS
 wAZsIAFJ01XLa6z5Xvtf+HH5WRZJyC8WB5ghP/ByFYi1QZqvcV7GiiXYjG795ZqQOoy/Deetv
 U074CMkCKy+MQjeQR+fpv0EWFIe9AZHZsgGK+igVPZOBDCsjtq5Mi0nLTYdIHXlH6HEpHb7bd
 o78Z1hDFNAwp4XHaK+ZNLNN6XxuKsdNlWSey41lwV7r0BlQ4OdybAoccd7r7PB9L4rHQAS0c5
 wdjOpUrP4FclkKlOhPD5eNEu7s8vB094MsCH1nVN+BwfWe7FfEWm8u++HSPlmSUlkhlmqwmW9
 NQR3y6LFCzSvzvd5ZpB0juOTD8qSr5BfNCXOzVVdCND3Y6OUMLgnPoqsbOwy9eWaGhiQIxruk
 2RYulEN5Mkn6fafjSyqkS+ZhXBhRqENZLmujAX8I4LiMdGuQo6ajFZkqcl3QstbN1O5PvHH5i
 aZ7kmA==
Subject: [cocci] [PATCH] clk: imx93: Fix an error code assignment in
 imx93_clocks_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1182
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/cf7b69f4-c4b2-5160-e19a-14c272b0dc6e%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Jun 2023 21:50:50 +0200

The variable =E2=80=9Cbase=E2=80=9D was passed to a call of the function =
=E2=80=9CPTR_ERR=E2=80=9D
in the implementation of the function =E2=80=9Cimx93_clocks_probe=E2=80=9D=
.
Unfortunately, the variable was not assigned to an error pointer
before this if branch.
Thus use the variable =E2=80=9Canatop_base=E2=80=9D for an error code assi=
gnment instead.

Fixes: e02ba11b4576 ("clk: imx93: fix memory leak and missing unwind goto =
in imx93_clocks_probe")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index b6c7c2725906..44f435103c65 100644
=2D-- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -291,7 +291,7 @@ static int imx93_clocks_probe(struct platform_device *=
pdev)
 	anatop_base =3D devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
 	if (WARN_ON(IS_ERR(anatop_base))) {
-		ret =3D PTR_ERR(base);
+		ret =3D PTR_ERR(anatop_base);
 		goto unregister_hws;
 	}

=2D-
2.41.0

