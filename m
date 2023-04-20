Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48481C77B72
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=et1Lg3geFDWa7HOyWCh4eCMLoWu2++AN1/TAzMzsMQw=;
  b=BVsErlF35GYt+4VKBaWX60JMa7tvuQoOfE2qJ/5nRsXsuD2pMmyILyl6
   iD9yFwfo0wy2Dk6bfJy45u4gFd+a2xV9iMPgNevisbEwP0BsAcIiU+rY+
   UUa/3RjUd0RgdMASzOQhQ+MolSKAc+Pr50nENlW3TWXb9LbHr3valcIih
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
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103965925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 13:00:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4D633E0269; Thu, 20 Apr 2023 13:00:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BFD92E019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 13:00:20 +0200 (CEST)
IronPort-SDR: 64411b44_VH69hGloJRYRGYSIfZcTIdsi5j5bfvvFCW+Sk8an61j7f8v
 5sILFbzoAhXm3kekpHc8Mvqyw5kRbHQrKFF51SQ==
X-IPAS-Result: =?us-ascii?q?A0EeAAB6GkFkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYkWA4Qwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChT0CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPHwYCJgICTAsGAQwGAgEBgnqCKAEDMQerG?=
 =?us-ascii?q?X8zgQGCCAEBBpwMHywiVIFeCYEULQGMXjaDNnonD4FVRIE8DIM2hAuEFIJnm?=
 =?us-ascii?q?waBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTIF7BAIURA4YBiglB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PTUGAwsfBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sR?=
 =?us-ascii?q?AxCNzMTBlwBKQsOEQNOgUcEgQt8CgYBJiSfKiCBDoIYXiuSNrBdNAeCK4FWg?=
 =?us-ascii?q?VkMnw0GEy+XCQ4GkiUuhVOBX5AXIKd/NYEuOoFcMxokgzZPAxkPjiAMDQkVg?=
 =?us-ascii?q?26PSD80PQIHAQoBAQMJAYFVg3ABAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:UTkqqquMY6jPOohPSnNk/mtx7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:rAkOqmEzpW+sppmbqmJBy2QbJe4uXUTwySfwLGGTFGVyQZCKHAo=
X-Talos-MUID: 9a23:RtAxyQpRbR1j2TsUOtIezy0ya8Vi4ae/Mh42uJgHke+oayguKSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="53855289"
X-MGA-submission: =?us-ascii?q?MDG+AuHVzxhp9oxZTi5n8OM5gBvr8kyB4oyVIT?=
 =?us-ascii?q?KoC1iAqGIbJQxNM/Y18nUYose67IWVFnVym4b62lXp82rvKwW4AWFuuI?=
 =?us-ascii?q?qkrKk+lwN9lLbhWUfWx6y80OjpLYP32khoNeEtBhpbRe+tj0cFDWgfEz?=
 =?us-ascii?q?umaz8hrIsQLnBYodqll+CLTA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 13:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681988418; i=markus.elfring@web.de;
	bh=yVNz0zRUFaBIjw6ncsDIy6LUCEBNHWGuhGpsmQOM59U=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=MvCAyKPvCb3XTbAxs7PXPRWsed7ZKZAzxAzgnQI0QlBEt3LU2N7HszzGXTe5dgnip
	 HGDvAwlUs73DIBTzH4Mi5WxvyXPc6azLEwTjPMcShOz3C7YpravtNl37Wsk/iKYTBx
	 48gRoSopMDFvZq04JcGQxRPqUVVIVwj2Uvbik1cG+5fTDIecGJ9kDMuwyvrGI28HVa
	 xEI1I3u5EQsvxnhV+rulYvO3GQXXo4Mb2r9x8tafXoBpgC4kaGpJVwTMWu1L5JyLPv
	 NjxO6E4Rng0h4uJoV4PEchKGs6cNpNpKjF0FXKQ+bN5mxY3pQCuZNpyMXwZSa6DlnN
	 YhRoNjSLDK9jw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbms-1q8uNo1Xss-00sosX; Thu, 20
 Apr 2023 13:00:18 +0200
Message-ID: <3930048b-ea3c-6053-5500-151e87ca390e@web.de>
Date: Thu, 20 Apr 2023 13:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>, Nam Cao <namcaov@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
In-Reply-To: <93913f0c-4699-cf9a-0f10-8edd478fd2b3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ix1NfPSREvnT10t0sLjbzWq70+AYtZ0oonh/2D2GafAbOoGBapa
 j0xQKt5z9dm+5bqR7VUqAiWS2bnW+xsucCFeisORtV/+R/LXna6waUYEZ5Bolnvg1aqNY/V
 kj6KU6n1XjhbdXap0haPuPmzz7yNwCGIBaHcSfSOCD6TV5Nnkcz53g1U6uhzaBbQFcFBdMp
 2EBVtLVLmFhGpnp2L2KzQ==
UI-OutboundReport: notjunk:1;M01:P0:P3kV3W0LZwI=;Tq+ZhVhLYW1cPXWNM0UzWEW4wxu
 Exvjlha+DKOSsPfkpzSJ+0s+J/MavbHGog4H7/86ebi9udgg9X+ecRAEYIEMhYxgBX0N379E1
 mJhNSWikP7XkbHKGxsFscXE9ZNHsm4nIgDEa5cdkAW8Bqd8KzjyxWIIvyROAsIOP1UOUB74+g
 3ygWdUP5LIt+E0soRYJm13mZHw5PLKr6r4NK2+MP2FU1WSERNQ0Tf+7bwOsmyjeRFE5X2ypqY
 MXlDg/TwC7G0lHkv1z7pNvIZqqJdsaooa9bd6nCNYnqg1Z2ezDbx2/fAx8Uz/BArJTucUGH1S
 /ikUt/ONrttcZ1Fs8moBia7FiLp8X2VR4cqvUpmHYsb5ambYEAdGSmbflQU7flMd2zy3x0YE1
 9yhAyU61am1eXt1kQxTPEHDR1HmCsW5pBFolZlCTqKUaQkJnQvIVna8pGYa1Xhq/KZXYnrE06
 CUvRP3oESepEqJb/ndePWw2PQMgyTu12nJEvR2JwWOui7X5MaWvO9QvTBgc8icra3qMiQ79Mq
 QRYbZVHwbMZFtJwUZ9kw9KMq3toCIlcwzDJjb6iHy3+qrrtDS62Kfk8+GApdnbnh68u7mm+V7
 HrlbdKy8Zpxs0kwVhjJw/gl3HInEUE8gfbT+P5oGd+sjm5X/ACjYBGdmw6l7g/z4uTE17Px1e
 0mWMOdxpCK3czvgdWeMer3ENRAtNaJim3o4RqHtd2W6bG1K2UcSZJHuwp+9qvwSjRHCRgTDLJ
 kKtmzR8jpBT1I4qnM1jyZoaqZ2Fmqi2giGmKjonS5pZadZ2NvJkY5dC+P/dXDUPMid1m71gnM
 AoHXUf0Q/C6Jja/KaG/OX3hjnY6ZWA3BP3bUE9vFtha/wpSklgNpsOUUe24j3wFmGHlieFao7
 YqYzBbWgfGxv83VZyk2j7Rkg/W4OrFYOQYgFTLy4zWcRyxOQ3H8KwUcB1
Subject: [cocci] [PATCH 3/4] staging: rtl8712: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Csqd=E2=80=9D?= in process_link_qual()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1102
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/3930048b-ea3c-6053-5500-151e87ca390e%40web.de>

Date: Thu, 20 Apr 2023 11:00:11 +0200

A local variable was used only within an if branch.
Thus move the definition for the variable =E2=80=9Csqd=E2=80=9D into
the corresponding code block.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8712/rtl8712_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8=
712/rtl8712_recv.c
index 3a72d0601dc0..9135c92906ac 100644
=2D-- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -863,10 +863,11 @@ static void process_link_qual(struct _adapter *padap=
ter,
 			      union recv_frame *prframe)
 {
 	struct rx_pkt_attrib *pattrib;
-	struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;

 	pattrib =3D &prframe->u.hdr.attrib;
 	if (pattrib->signal_qual !=3D 0) {
+		struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;
+
 		/*
 		 * 1. Record the general EVM to the sliding window.
 		 */
=2D-
2.40.0

