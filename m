Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FBCC77B72
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DTSnDgfJJ8cNRoIhLhbfanC0LtuCwkuXG2JtuGBk/zA=;
  b=GA9CMUviB+06NlxhGBrcy65Sm3l1f6MI2poP1mOZ/GzvOJUOxuY0BqST
   YKOC+JRRPukDSIA/g21PYW9Lnh8gEcjmofSHoGva5rnB52R62BgSPnwdy
   qY5o//h/JJKx63lKnY0LtoUKVMV0TJHbvRAz/YevH0R4VFW+LLU8avkwc
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103964924"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 12:56:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3EF7E0269; Thu, 20 Apr 2023 12:56:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id ECF44E019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 12:55:59 +0200 (CEST)
IronPort-SDR: 64411a40_L18bQCnFvNdsMkhCzz99MNU2AMmmeIkdLAhDOW8Kf9PRi2c
 POiIcfLu7GxNIxE6cJ7PEjqG6a3KJNY08/JWUNg==
X-IPAS-Result: =?us-ascii?q?A0EHAADsGUFkhwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItUXovBAtGhFOIHYkZhDCHLoc+hGeEA4FWg?=
 =?us-ascii?q?UA+DwEDAQ1BAQIEAQEDBDiERwKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJ6ghAYAQMxB6sYfzOBAYIIAQEGgmSZKB8sIlSBXgmBFC0BjRSDNnonD4FVR?=
 =?us-ascii?q?IE8g0KIH4JnmwaBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5xgUljTB+BX?=
 =?us-ascii?q?AQCFEQOGAYoJQQOAxkrHUACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4B?=
 =?us-ascii?q?hs0EQIIDxIPLEQMQjczEwZcASkLDhEDToFHBIELfAoGASYkn0qBDoJ2BJJds?=
 =?us-ascii?q?F00B4IrgVaBWQyfDQYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwNCYQDj0g/ND0CBwEKAQEDCYVGAQGBAYIlLYIqAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:yllyB65YLXTv4xswiwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:PfDgPmGfe0Mxcc2NqmJ50UILF/0rQkbX1SzUKGyRC09lC5uaHAo=
X-Talos-MUID: 9a23:w155MApXc6NKl4HPskUezzpwPcEr6KasMkQQrYwfgJmVGHZAZA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="103964918"
X-MGA-submission: =?us-ascii?q?MDGl+spdemBr2VAWoIYGyX/SLH3Oj+Ez+XgJmg?=
 =?us-ascii?q?JHcisyyZE8xDSHLqJCFly8S9odE5wQx6Qcgt37qrAfTf7hwbREb+DXOv?=
 =?us-ascii?q?YkF3YVWD1KEGEbYPyMlgec6PSCEU5TWeYR2kjtN6liqNWcW07zlvN5lN?=
 =?us-ascii?q?QYT/FDjHJsJjIyDx9yi7Qoog=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 12:55:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681988158; i=markus.elfring@web.de;
	bh=4gvbu9uBE2LJtc7zzGzEmB1piY0xjV0di6DkC4cnuB8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=RJ7hyD7jNZJMSGZE6XqTzxoGc494xPugUN2pgZME5m4N5iFnHeBbAOsSzXgUuUy1F
	 /fulv6FK+dnOZ3Ip6WvbNh/L9kXFfqyBVIvPBpNEfQixifMfAoXeojqjy8hFfEvYD6
	 Enpoz40iH6w17dxdlDxoCRa5ewo3pslXY6Rhr4N0aqgcrH4Z+iKaZG3gkZkvf/Y6rU
	 h1KEu2pAGrrMkcgPqoyF0P+5af1mOCRp5LT5WgXRPhviWD1k9C750EDvNXOISSfJVs
	 vy08Vp//PQ0LbPCO/wOU3ZaYoEIVh3JkzQ2zI8mCcg21AsDxAAB1kaeXhUNmt42bT5
	 M2/do+RAwnflg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1pk36o0bWO-00Tl8m; Thu, 20
 Apr 2023 12:55:58 +0200
Message-ID: <909c3901-c414-b600-388c-c4b06cde3847@web.de>
Date: Thu, 20 Apr 2023 12:55:57 +0200
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
X-Provags-ID: V03:K1:38DtJfAfoeuph+b/0A9v+OT0epFNQvTacrFXvf5nzl01pAG7qYX
 u3E+ecmXGvNDWss4dAoyQ7FGM7ZvKpTxwmxtdiUC3wufEXqd0h+31OpilTvSM+5Qg+SGIM+
 zU07HKm/7lzmpxAuXseeXfd1Jp/gKJV7UuoisxuoBYqwypRFOPQdHZQOPnQxOKsgMgMqY0o
 /mF93d4lvC0SGbyfAriEg==
UI-OutboundReport: notjunk:1;M01:P0:/42JqFFAoFo=;w5XSQJKinwf0/ug4YncKUZyEcxn
 KR8Xv2fJTeG0llQPApUrIvw/q5kBPsbsnJU3H8QEosTiQofkVciw9PN52w80IsKKxFCRQk6di
 7C//0rappcNnVi9I0vgRGEFiw72t1m4Y7OVfzGkbVI+tlhOqefx9qokKJa4QWa768m0fGP/IA
 O+LjVrfTp+NHS//yDyIbT2CJ7kFjsNJkebh8PIvh3FQAPchOyteHxzRy7Dap1Umsh+3r0iDQT
 2j26hv08GsueCs+sT90HEAQ2i5EfXDkeJyVMbDBJq9Iz50MIwOh3PyDhOq7/hlh6oOLxVtgk4
 C6RhxC3ULWWeSsugKY7EVkkbrFj33lWqijJo4xhu4sJONGQv2VpM61RrAntuB/LUT9UvGBlSs
 ZMfpAwqnfZeaww5h3P9HZMXbulhteZcq2+3u2fSAxBS5z3LRt84yDuC1p9AQKFLh1ltq0gDDP
 FVwcccDrcDoEE2yjQX7r9+QOxpMXs7B/buImemKVGDQmqZudS2BPEkjaOD13krdKtAngI4zs+
 U/KXzPxA293pC+a6+PplwPDWEN2BLiE0pvyk0iE1Z+SsGJDMc8QQHzY7h+d/1p1YZhZle7dY7
 VfpS7tjkh4RWeAv0YjVpf9Fj6bZkzTpPbGpzjbxqLLcYVoDmUezVd9cZszRZWTh7fvcuH0b/K
 Cc6X48HB1YMP14nUVi0JgUG52sILXSxrn56nTCFgVv/a5/P+HoEAEnkSz2AQCMefoEykPBLx4
 jWnSR7BpgCYvAxY5a4oj0XJ1w4vKd1TEtbydaJQlbRlRLjS1qPrdQ8xjbpXqFyGQ0ripmGq7q
 YGakUIBViAFXeUQa0NWffDV/sNe4UsO0sr4idqNujvH/yUMxbl9aYbJsfn4hlYTarp0RWzLHV
 v2nZnqiCullzBRBCejkBQ6mojQ0X5vKC9nlxgX3TWUyxNBgbvb1nKp6sC
Subject: [cocci] [PATCH 1/4] staging: rtl8712: Delete null pointer checks in
 process_link_qual()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1100
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/909c3901-c414-b600-388c-c4b06cde3847%40web.de>

Date: Thu, 20 Apr 2023 09:54:06 +0200

Omit extra null pointer checks for the input parameter validation
in the implementation of the function =E2=80=9Cprocess_link_qual=E2=80=9D =
because
it should be called only with valid pointers.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8712/rtl8712_recv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8=
712/rtl8712_recv.c
index 7da014ab0723..f0789b5ef59b 100644
=2D-- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -866,8 +866,6 @@ static void process_link_qual(struct _adapter *padapte=
r,
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;

-	if (!prframe || !padapter)
-		return;
 	pattrib =3D &prframe->u.hdr.attrib;
 	if (pattrib->signal_qual !=3D 0) {
 		/*
=2D-
2.40.0

