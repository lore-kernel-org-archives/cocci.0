Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC6EC5AD4C
	for <cocci@archiver.kernel.org>; Thu, 23 Nov 2023 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MWxI3aMaVbseR2H9KyLmPS6s4AU12G1ut7XpoLvzPbk=;
  b=LSeFPP/2RvI/RyHfRVnsOdFSb8nX5wuhEdapPbQFsxK2CLsrZiSGb7tB
   pTfjCQEJfMOQqMAvOfd8gkRAzVcGQAfsJaOF41+f6ewYH8Wp2JrhfILOI
   /OfMYSOqGCXeew2KH3ugmttj4TJBVw80WdIj8EAnDaCPouzjk8Mn+DGqn
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138195058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Nov 2023 19:05:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3B3FE0CCE; Thu, 23 Nov 2023 19:05:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C847E004E
	for <cocci@sympa.inria.fr>; Thu, 23 Nov 2023 19:05:45 +0100 (CET)
IronPort-SDR: 655f947a_9DG9HxlUCi29jX6PfFo6WhuHLm1QJEWK7De5RjqAKwsQGDP
 a3v2mTipzKP6hrZuMP/6Fv4DF21dnKTYJCe+clQ==
X-IPAS-Result: =?us-ascii?q?A0GYBACek19l/wsR49RaHgEBCxIMQIFEC4I5B4FJMAQLS?=
 =?us-ascii?q?IRTjz2BdTCEO4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIR/AocpAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQQBIx0BAREnDwsaAiYCAlcGARQBA?=
 =?us-ascii?q?YJ8gioBAw4jB7E4gTKBAYIJAQEGr1UfLCJWgV8JgRouiA0BhVmENScPgVVEg?=
 =?us-ascii?q?TyCUjE+hEODW4JonlBdIgVCcBsDBwN/DysHBC0bBwYJFBgVIwZRBCghCRMSP?=
 =?us-ascii?q?gSBYIFRCn8/Dw4Rgj8rNjYZSIJbFQw0SnYQKgQUF4ESBGobEh43ERIXDQMId?=
 =?us-ascii?q?B0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEgTYFDR4CEBoGDCcDAxJNA?=
 =?us-ascii?q?hAUAzsDAwYDCzEDMFVEDE8Dbh82CTwPDB8CGx4NJyUCMkIDEQUSAhYDJBYEO?=
 =?us-ascii?q?BEJCysDLwY4AhMOBgYJHQQOAxkrHUACAQttPTUJCxsGPgInpxzFBzQHgjGBX?=
 =?us-ascii?q?4FgDJ8jBhMvg26TNA4Gkk+YQCCoNIFqBjCBWTMaJIM2TwMZD44gDBaECY9HQ?=
 =?us-ascii?q?DU7AgcLAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 YZIVbJRElA4RKty4qFNA9EIZpt6DGtMrA==
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:kTyypqNW8GWfvMBcTh+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:7rlJrm9t0igRYA3jlv+Vv3JTCusbVy2E9W7RGneUE3RPUZ7PZFDFrQ==
X-Talos-MUID: 9a23:NKmPXgbwTGfu7OBT6CXUqRw6CsBSpKGlDlkKnoQGq8ygKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,222,1695679200"; 
   d="scan'208";a="138195047"
X-MGA-submission: =?us-ascii?q?MDFjWW1G0Ej3jw9zPyykShYI+t0o7ozSVEsuXo?=
 =?us-ascii?q?WqSfgZEjsmg9VHTBexSxpqKZOcYafYZvoaCy7DBeR24N3DACj6i1WavH?=
 =?us-ascii?q?ULYNsvWcKx2EqhADKc7U3DFKRBIa73inyZXq0+5johYphAsSdXU8p/NW?=
 =?us-ascii?q?4ycC+uaTZABK60V13eD6EyKg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 19:05:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700762734; x=1701367534; i=markus.elfring@web.de;
	bh=rZv8j7z197kFEAP68EwfflVhbppGcYaiLMaIkzgiXAQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=q4ivMbJZCGJqbo+fn6is+GLnL3t/pznXid2wqwXCzwzk35bzxLcNuCE9URl4mK3e
	 yOPJO2Ls55g8Dv5PNGcGhGuZwBjt3rXxKtCTzkXE1B8SZS9k4YFhpGO7fltrrQrAX
	 tW8qiaN61rrYe7GPE2vgH7XigY4kfu9nnICopQKUyh8hkPPbX/KFAlKNWWnA7nKsG
	 4HlX2t39lwu4R46isGJ+AXgqY5XAvZRP2bKuACYJ+9R4UK1F2t6oSEQ9tZf3Uhyk5
	 AqhcW4dh+ZKbFPJUQ8OLENpR3MMNcC2K2ROEohEcPQMslOD5kUUV5+0GXeMTzT4Ne
	 rvcS8+SgHlIV0uCOoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovjQ-1rfrP62uvW-00qhqq; Thu, 23
 Nov 2023 19:05:34 +0100
Message-ID: <f3d572fc-c385-44f3-a4cd-97dc73f4668e@web.de>
Date: Thu, 23 Nov 2023 19:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
 <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
 <alpine.DEB.2.22.394.2311222131120.3262@hadrien>
 <471b38f1-fc2d-482b-ba0a-8c7982ba9618@web.de>
 <alpine.DEB.2.22.394.2311222158000.3262@hadrien>
 <09a9b132-5cbc-44df-b445-d8adcac7571e@web.de>
 <alpine.DEB.2.22.394.2311231845210.3125@hadrien>
 <5f1930b8-8249-4158-b76c-c888d36387f2@web.de>
 <alpine.DEB.2.22.394.2311231857030.3125@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311231857030.3125@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XhYGoxs14qkzYwhPaZIIWfr7aalFAtuut3HPn/wmIzUoihEjvg5
 POLarCb5FogZELe36gBjuBAc97LnxMRMvokUF0d8Vfxthj/dvDeFlZSmU0rK7/sa/lbGnF5
 Q/381PWwQIhTNaNqiYqtTffee8GtZC036Wej596tvMK2KxG/+pS6NHpbJL4QbcoWHrOpppI
 s0t65dN304CoNVi8JmNiQ==
UI-OutboundReport: notjunk:1;M01:P0:oejhVS0yBFg=;LL3V4DszdV6xRNyXexvkTyfFf+/
 InQAyg5Ns5GHF4v06AbUcU3/S0eJq1O9o46hutK7g9wqy+//1LWj7YhB8R2S3lN0hTKyMZHQC
 Clb6dis2+k5vdlTdTfPw+Xanq+Bl7ncaUo6EveEXpyllZ/FTzlXKBlifXLX0/lxuPVZZM1ntY
 ukS42UpfShpv6Li9wU0Ll09Miy3cc7kg5UhuDY5+Met1SU0jsCQo+Fme+2AP07N0SrANeEFlf
 hgYRjjQ5RvDVRpVX2UJ7CAc4j3jVjUH8rr3RfN3M2jaY3ZAmf/Veb+7AUmegQgMqn0A9QHpwR
 l8pTFEuqhHcJp99/kbgLbcomCEHNjS9oIe8BJkcddzBtC1LfMU9cO5TvIl3C07e2XVHeVz1+o
 TzmID4h5XWSSiOHAtSWB/zKWicMCtciIHxGUdSpxaVGu2nGxLBw59Peec+vMtcxaSsWftsGqj
 JUIFjfiWxYwwEZU6W1y2QOcJDZZD/hmMXfZ0xA4gItJixEJuLa93vTXMiwnkNGCIyyco9b1Dm
 Ql8keD1MIi0BVKb+c+2AtSN1yE1UiXdoFrsS5s61JMC3A9NmpXsEcXr4OqHDFtNY373BS2AP+
 AZmh8PWvrpFktMrnF6Zvd61yoK1PAXLqGvoDzEM2ltu/ggWkxCj0cmoKfAEslwmVRQdzLLXBY
 DuqYY9lWdNQkeokwdOfTgDEm/t/CTjKNdQPZ2FiHQXozJ9POXpziB+b39ofRvK+Gbw75Xo4rq
 fS243aVfqq778lPZ/pjXUSYshibkd2GVIPJcIGNakQ/K6zpI7TWZgjNbze4EjkiAcUTkg2VFN
 Nz23doF6c3TIhd6n2g8AJ3rbW9iafTZuto1W1qniwjC7M8O6K6Ld3tdJkJrUzxxdgjN6yFk7R
 XHPXIuF/v8PNOwhyDYasAwshsKypgr++2hSONuteFzQruY4iU6xgt14yBTF/SMS3FNbiFTyM6
 Ei9SeQ==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1321
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/f3d572fc-c385-44f3-a4cd-97dc73f4668e%40web.de>

>>> Script rules are executed once per unique match.
>>
>> Does such an information mean also that each script rule can not know
>> that it would be executed several times because of repeatedly matched s=
ource code?
>
> I said once per unique match.  If all of the values of the metavariables
> imported by the scrip are repeated by a second match, the script code is
> not executed again.

It seems that script rules can not determine the repetition incidence
for matched source code by themselves.

Regards,
Markus
