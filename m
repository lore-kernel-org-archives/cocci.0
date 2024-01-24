Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3106EC47422
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=htO4WfDJhaQSuN7KH3dIhAUZM5mH6paUvwSUVy32nSg=;
  b=mdAkRz364vc6SemQqrZdHwO5gIVwrTBpPDQvGaysFBVru92y1tKBGXsD
   sBsq/CFtpWpHiIanXTTw/8+bzUiIY3tDlFcgdT7tCxnt4FjrK9oP7CHa8
   ztrbDVo6MYP2M0k7P6ti9Iw4YukVnLVkSt1Em75hw0sG8C1AFAPpTNQBd
   0=;
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
   d="scan'208";a="148479771"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 22:06:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D6EAE0CD7; Wed, 24 Jan 2024 22:06:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B648E0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 22:06:13 +0100 (CET)
IronPort-SDR: 65b17bc3_tbERsrkakNposEDmxujnV85Km3GZnIvsNKOrg8OhsmRxGbN
 EYmN3aRRUn1hJ5yBBi63HmsN/jVazs9mep9fcHA==
X-IPAS-Result: =?us-ascii?q?A0EUAwCTerFl/07ASNlaHgEBCxIMQIFEC4I5B3VWMgQLS?=
 =?us-ascii?q?IRTj0GBdTBVg2aPBIhvgVaBQD4PAQMBDTsGAQIEAQEDAwGCC4JqAQkCh0oCH?=
 =?us-ascii?q?gcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFbA2CX?=
 =?us-ascii?q?AEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAkdCAQQBIx0BAREnDwsaAiYCAlYGARQBAYJ8AYIqAQMOIwcNtneBMoEBg?=
 =?us-ascii?q?goBAQavWR8sIlaBYQMGgRouiCIBhEWBIoQ7Jw+BVUSBPIJSMT6EQ4NbgmiFW?=
 =?us-ascii?q?5JUVH8dA4EFBFwPGxAeNxEQEw0DCG4dAjE8AwUDBDIKEgwLIQVVA0AGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEHKVVBDFADZR8yCTwLB?=
 =?us-ascii?q?AwaAhsbDScjAixAAxESAhYDJBYENhEJCyYDKgY3AhIMBgYJXQkdBw8JBCUDC?=
 =?us-ascii?q?AQDKykDIzNBEQMECgMUBwsHeIIQgT4EE0cDEIE2AxkrHUACAQttPTUJCxsGP?=
 =?us-ascii?q?QKXfwGDOT+CDhHFOjQHgjSBYIFhDIoZlRYGEy+DcgGTOg4GklmYVCCNTZsAg?=
 =?us-ascii?q?WM9gVkzGiSDNk8DGQ+OIIQtgQuOPEA1CzACBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 XmwXAbL4X74
IronPort-HdrOrdr: A9a23:HHU5YKiW4eb4tFrhc0zG/SfGUXBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AjzEAV2rb6fuU0iaISXxJ94TmUdgLVnTvzFPtGFO?=
 =?us-ascii?q?1IyVEcKOyVwKe4Lwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AB/9TAg/pSlIE63lXGa6PeziQf8dPwZy/N2ovqI0?=
 =?us-ascii?q?DoNLZbCVrPWrepTviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148479764"
X-MGA-submission: =?us-ascii?q?MDFfQpzTr6qkfokHvW2vTboTbi96RKMQv+Gtmv?=
 =?us-ascii?q?XK74b8eCz+YBaHWKNXkXmhkqsF8g3xpxY6tOegFdPaUuiPXYQ2xWNKJ4?=
 =?us-ascii?q?6/3txajSxOBn+NNGbVfQrEZlyp+Z+zeGbi6nMTgTgmV+GrYIg0RCyJVJ?=
 =?us-ascii?q?Lv9grtopOYAMJAGo/6IivUoA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:06:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706130363; x=1706735163; i=markus.elfring@web.de;
	bh=htO4WfDJhaQSuN7KH3dIhAUZM5mH6paUvwSUVy32nSg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EAzhKrnVtelcgyX2FFoJAUs4h654V7Lty4ko2ut+JplEXGNn8FfOdR6nLfWZgeQV
	 rK/Fmrwjqqr6GLLn9BCPWaz2z69Jva7fLzevDZPvEYh9jM6uVUUz2xASMoLgga4Mg
	 0KjRVLA3Z362rTczNy6KNBUuOdPd8mUrHY7I7lFMqpzwVxTVddIyyjj70wpX64MrT
	 6p9vFPL2dYdo7wSAEq/oirMVF1UOcPvzKcpHSS7wI/wtY/cdBZbcbE4tuvX2Q3n3Q
	 9/3EF0HG4nygGJPWszsPcGn+eJ8CvSVP6S89GW5jZnDEnDm7Uhqta8Prb+wC9fBMZ
	 m2KwOhNctNJWU23wWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1rbiTQ2ceh-00RRmr; Wed, 24
 Jan 2024 22:06:03 +0100
Message-ID: <604bd13f-71ee-4d82-9eb9-ebe42d53c06e@web.de>
Date: Wed, 24 Jan 2024 22:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de>
 <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr>
 <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
 <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr>
 <c41c9f8e-acdd-4e04-8c2a-8f1589e50785@web.de>
 <fcfa187e-5dbd-177d-bcf3-fd42c8b6bd46@inria.fr>
 <d74c2c33-e64c-4f91-baf2-20a4f31b925b@web.de>
 <alpine.DEB.2.22.394.2401242126120.6377@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401242126120.6377@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XGQ8iR4mpHnGI7ShEMXLzQSlLMI+GU+6BgGVURhVpSerAyMoPSN
 /8FBCQUrIwRC9YAy9EZcpdCoidjxt5cROjJJxQUcsmmE4U0VVYWVYv2mNcoibvYp3baupao
 ZE2PxDtGzcICaB7E3WrC42eNGX8EH28KoC3ODUHHjcen2W9xwakBMnouKAAa3wntnowH4eX
 li9VArtQbRQ6JAGwVxZ6Q==
UI-OutboundReport: notjunk:1;M01:P0:m2fgkgm21aw=;gBfXm/3TiIxKVFBlxhVukAmHouP
 UZeuk170J0I0sLnotW4a/EsxsWJIbrSXGJdbjDt4iSXquJDurM0cWGtMomzIrLNyGPCvAkVCc
 /LmA8sazxrXEXR/tbxjp9vQUzzccrfdrBtna7w8StqnpulZn+Henqzh40iJvaVMyY3VVzzyWJ
 5RKpJAKOhLZq0yUBXMEWVuU54fhp5bEm4Fj97ODxl47xSqbgNkY2VWyHpMtpxvIYE5tZ1kj2M
 NEFcrAAaDcCozMoel/JTPGw7QTlDruwP/ZKrbabTj2n9gmZnJN4isF1IvuDFKGpb2UHQoUjRi
 d/aPIdttdgUwkSHbADm3GiQD3se2AzclCqgbgD5VYscKCo85cI+E/4mi3GlfyyafKpn6LimAh
 +1+4kyN4JirkXNSenDsjG5bemf8ObBldaMekDUG8KlcQ3tBzs2HnzFC91h6Hcp2WsmYXKx/x7
 T/mkLlTE+JuWtbXoyK+aJPG5RbvqEUPviN4urRvPhpqsE5hjXZAuS0D8B96Qyy5lqL3RXdbiD
 d71YS8492oE0smjjYtZsPFBgjv/O/qY2XBrEWN4Se4EomLINXk5fFyZ7JhVc/C0AWEWetPWyL
 2lSpVAjgksYd5C98D+oW4epuw3DcONd9c9B2+N0dHLIVNrA0hZhevIGcuTGr+vJF1cBRd6emc
 pi4pJ489SZ/UwEqWnc1oO4uwwxqoZEei/r9gI7uHV/CHvBAFC+u/AVM73HJ+dQONLbytdyUAZ
 UvrS3wL1WjiOONzmnUpriJ2eCKHgmirF2vcHsfB22fDSBhldyb20GyZDSsKLjB1ApK8rLdHrM
 ivQZ7dhhEY77HyEgGzeFxoWvoUJnqj9Rv2O5E/WknvngmI4h602APV0efd34YjCEwhHkDuU2p
 DS2/QOtrv5qd7FNJnt6N/MR06LmMDaHK+v5slDWBlOwBGrWvSwCyFNMsASPTIkMHjCgmRrYlA
 rhdvhSdbh62attHyf48U4vJqbnI=
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1485
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/604bd13f-71ee-4d82-9eb9-ebe42d53c06e%40web.de>

>> With which commit was the observed restriction introduced?
>
> Probably =E2=80=A6

I am curious then how the software evolution will be reconsidered
also according to this contribution.

https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/e9facdc383d75bc2910=
762d166810ea6f858e8e5
completing alternative names; supported for both C and C++
2023-12-17

Regards,
Markus
