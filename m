Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BEC46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=w/zTmmMbiFi/oSHO21i29YIO1DFRy9plBG1QzBF/0Q0=;
  b=mutyPIIroKSPckJdsdNXf2lgqJ5E17vjdJTUs/d0mu6UHMTeJuqqWSB3
   2U2E8yg6ZgIu5zCn3yPUA6sYzHnKoopXqdYIUGSdvH1+r5yyQfUCxby+3
   wx8OVEGiytV5LR5f19Z+JGuA1Dlah8Uf3GeT6wXel6eA56JwkZcLHw136
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148462353"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 18:52:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E481CE0CD7; Wed, 24 Jan 2024 18:52:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 13E5FE0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 18:52:45 +0100 (CET)
IronPort-SDR: 65b14e6a_cvsuKFiUiE1GDR6px1t+vKf4adrad//JGw2e53922YcJMFo
 9EwIX57P+XlgwQAxkl/AS7bO/022hyOG4QGoToA==
X-IPAS-Result: =?us-ascii?q?A0G/BADyTLFl/wwR49RaHgEBCxIMQIFEC4I5B3hTMgQLS?=
 =?us-ascii?q?IRTkTYwVYNmhzaHTohvgVaBQD4PAQMBDUEBAgQBAQMEhHUBCQKHSgIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcARCBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEASMdAQERJw8LGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfIIrAQMOIwe2ZYEygQGCCgEBBq9ZHywiVoFhCYEaLogcAYRFgSKEOycPg?=
 =?us-ascii?q?VVEgTwLgkcxPoRDg1uCaJgTVH8dA4EFBFwPGxAeNxEQEw0DCG4dAjE8AwUDB?=
 =?us-ascii?q?DIKEgwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDC?=
 =?us-ascii?q?jEHKVVBDFADZR8yCTwLBAwaAhsbDScjAixAAxESAhYDJBYENhEJCyYDKgY3A?=
 =?us-ascii?q?hIMBgYJXQkdBw8JBCUDCAQDKykDIzNBEQMECgMUBwsHeIIQgT4EE0cDEIERA?=
 =?us-ascii?q?xkrHUACAQttPTUJCxsGPQKaLXWCXsU6NAeCNIFggWEMny8GEy+DcgGTOg4Gk?=
 =?us-ascii?q?lmYVCCoTYFqATWBWTMaJIM2TwMZD44ghC2PR0A1OwIHCwEBAwmFRgEBg1qBR?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:7o/W/K1XWG1O7n7D/SvPNgqjBf9yeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5OEtPpTngAtjxfZqyz+8P3WB6B8bBYOCLghrTEGgA1/qS/9SfIVyHygcH79
 YYT0EWMrSZYTcb/KWKhXjdLzs5+ri6GciT9JrjJhxWPGdXgs9bnmBE4zKgYzFLrUR9dO4EPa
 vZwvACiyureHwRYMj+LGICRfL/q9rCk4+jSQIaBjY8gTP+wA+A2frfKVy1zx0eWzRAzfMJ6m
 7eiTH04a2lrrWS1gLc7WnO9J5b8eGRgOerPPb8xvT9Fw+cwjpAJb4REoFqhQpF1t1HPWxa2+
 Uk7S1QcPib0EmhDV1dkSGdpDUI7wxelUMK6WXo80cL8vaJMQ7STfAx8r5kTg==
X-Talos-CUID: =?us-ascii?q?9a23=3A0mtE0mmcqcKFa6YWYKJgddblqb3XOXPW73PLIle?=
 =?us-ascii?q?TM2lgC5CUFGGx+fNUycU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AoFGI+Qw2MKoOIf7ssU13Nuwjvt+aqJ+EU1AOzK0?=
 =?us-ascii?q?+ge6ZKAtcOz6jrQiHTpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148462341"
X-MGA-submission: =?us-ascii?q?MDEL972q65S4G9TW6XX7rZXgTQDEv9zeXyjrlN?=
 =?us-ascii?q?cDVxqMsUOti1BuvjdRVGvhBjItRqYb6hONKbB9M0c4tOQn7R3/qzPdU+?=
 =?us-ascii?q?Cu1o/aP0l0lguFUDgz5WSiq2SdZGIamsFaXql0sISIaPiUS+lDtR4Joh?=
 =?us-ascii?q?P/hBGBu4jyr9bfhUtHNf3mCg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 18:52:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706118754; x=1706723554; i=markus.elfring@web.de;
	bh=w/zTmmMbiFi/oSHO21i29YIO1DFRy9plBG1QzBF/0Q0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=n3tLyfi+iBkoY2YCLdzB4eU+BGrVvih0AX+9nLOai+JCmg6vjzPDTf6rITmhK9D5
	 +DBrUFfprqRgeJ/IGBR1Z1WSgu4a0YYFhZQgFT3HOJo9ti8hxs+3ovEPKBUM1OGha
	 j5nl1Qkd5ERzXVuUs38azPJA1jYKcb0qG6O9Ap7h2YEWZE+hJqlUI3WxOuP52dSOC
	 qse6OhmIlybZtRSTp3h0ZPf6eW7a8ORfoKE3UeBKkgPXXDB9n7GNhnM9Pf0lwKscN
	 y50x2d5FVtq1Zn6yrvW6iPxmFknohKefp8Eev2XEyTPvlCaeuRnEJjbAIKTXtqN38
	 EQftZjpoUgNqzm2jYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CUp-1r3E511sw9-010izM; Wed, 24
 Jan 2024 18:52:34 +0100
Message-ID: <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
Date: Wed, 24 Jan 2024 18:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
 <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QnhEIf1AQF0cnW9u1kS+GsNP1dhmBpVUPoO/9TpCmqX8H9jxSUL
 39defgxUUqFGfGThcUXOFWnwETOrLmKqI5ei6ZI13kpk7aPDcroFAQQy3I+eN/TY9GAbRe+
 1CWscpDmKLX/AfX7b6bR7Cuaon2k9rebm7ml8CI4oA42UU48WAOZkfXnitpeIn76z8Xoze9
 q38IqExhLGYqfyQwm2TwQ==
UI-OutboundReport: notjunk:1;M01:P0:xfblX6Nb+YQ=;xcxUN9nJx1IPJhtwIZFlWPuY15y
 HJmeDHvWTNziLN3Uzhz69vRJJlKNMPudyzOirr/C15GZGIVBCZyfpPwHDlpBVaUcJ/8k+/FM/
 y+CXZQOfz2fk3932i4dpQVYWghob5Ydl6UqqyulcHn59cch8s9gDOjCU8+/P3+EeWGdf4GjI1
 dm5vQ851tMheoX1yT+OGoC7N0olljjrbjTjxWNUEMEoWvqqI5070v6sG9bdX+vmLUSsf07ukd
 TPEREZVIr7pSoBvSaT9dSbuMejnPdmz+DNbpy6r1TVAiIfMY6gDSEkRo1LHEJT+yHqTSb4O8r
 rfKjo9NL9+vQG4H2me9GED+H2jiNWvWkE7mzu1OuPVkWkfsrWDh7jy+qLBQSz37tWLSisqrAS
 vzD1qOOVChP0Ats8qhSCU7Pb+MSUKLhypjTEt40XCzYpW23cXT8kFIMCnHrmP8MpFi/GzmNcr
 tAG3ajpOb4or1VWRAN4mn5HZkcHVoORInMIlm5DK0DnY6cXQY6DvDjx16ZeRChx2BXrgrygrC
 +syLTnMOS9Uy7RQNIOk5SVi3HAlr55f3OJOJhj81aZGZVEeOUwGbWmxbzNvYNOI1LvaNhpcfU
 DRAIs9gvJyJ7tk4UK+wClzMjgTfyGz3LlGgtCZjvAwhC02nGVyQnzw0koGSQMJ8UpZIHPOiDU
 7oK5wE2zD2DDuO+m4AP1Yn+eDV7887pcHGHii9A//eSL7wHPQswqMe0LcqpKI7JyvVKk2W71z
 GhUu7c2t9KgH7yCvYHB8ilwCE7ZGtOzcVuHnBxwu4OGiCs13xf8r4M62LzQyMdtCvzugstnIa
 WJ6o+9jGZZYsqu8OL3jO9aaZ4YanO7sLLkopaV+LvYSNzZOc1MXJLfpXwHqU+zlZdiIknFjzQ
 uDdFdxjdJjDYFlgxWFrjbJjqjkV52/9O2HGr1d1ZZVq6S3j+e5J1+BvK0OAmucljEnmwa87yj
 52j5Iw==
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1478
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/23ff96d1-8cf2-4736-be84-c00600b15a73%40web.de>

>> May SmPL rule identifiers be chosen freely?
>
> It seems that they should not be keywords.

Should such SmPL identifiers be independent from an applied programming la=
nguage
like OCaml?

Regards,
Markus
