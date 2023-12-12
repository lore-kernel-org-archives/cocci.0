Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D45FC4332F
	for <cocci@archiver.kernel.org>; Tue, 12 Dec 2023 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=P2IwC3j0g6V7kYHfmhdzUCIHVCttEIF11z7WVyirm2Y=;
  b=YEmxBDn+kMGpFWYz4IzJyc5WQFclEXf5zfUf3x1JM2uBNiTih5mNJpSX
   DBztP8s3Cw9q6NCIscN0y1tJIcT/bcbWu0adI0orAR2BxMFSPJlaJOaMv
   2HlcfxvrgYqwqunWhZEb9n2sBU1cTnuj/j5cdzuhDL43/BqzDYdW0ogZC
   s=;
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
X-IronPort-AV: E=Sophos;i="6.04,269,1695679200"; 
   d="scan'208";a="141759575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Dec 2023 10:26:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC2F4E0CCA; Tue, 12 Dec 2023 10:26:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BB63EE0AF1;
	Tue, 12 Dec 2023 10:25:57 +0100 (CET)
IronPort-SDR: 65782726_k4G2U1sA1wg1nybcUG6Rz1TCoaXd4q8+q1+AYrmzM6POEOl
 dhq+yxNPx8iWbZJktTItFpkXikCY+lowIiZsF/g==
X-IPAS-Result: =?us-ascii?q?A0ETBQC2JXhl/wsR49RaHgEBCxIMQIQIB3QDVDAEC0iEU?=
 =?us-ascii?q?5E2LQOEO45+iG+DFj4PAQMBDTsGAQIEAQEDAwE4hEcChy8CHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAUBAoEGE4VoDYJcARCBDIEeAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpCAQQBI?=
 =?us-ascii?q?x0BAREbCwEECwsaAiYCAlcGARICAQGCfAGCKQEDDiMHDQauHoEygQGCCQEBB?=
 =?us-ascii?q?oFFAgwCQ60+HywiVoFgAwaBGi6IEgGFZINBeicPgVVEgTyCUjE+gkoXA4Ffg?=
 =?us-ascii?q?1uCaIkbB4JTgykpkQtbIgVBcBsDBwN/DysHBDAbBwYJFBgVIwZRBCghCRMSQ?=
 =?us-ascii?q?IFdP4ETCoEBPw8OEYI+KDY2GUiCWhUMNAQ1EXUQKgQUF4ERBGobEx43ERIXD?=
 =?us-ascii?q?QMIdB0CMjwDBQMEMwoSDQshBVYDRQZJCwMCGgUDAwSBMwUNHgIQGgYMJwMDE?=
 =?us-ascii?q?kkCEBQDOwMDBgMKMQMwVUQMTwNpHzYJPAsEDB0CGx4NJyMCLEIDEQUSAhYDJ?=
 =?us-ascii?q?BYENhEJCygDLwY4AhMMBgYJXiYHDwkEJwMIBAMQGykDI28DGSsdQAIBC209N?=
 =?us-ascii?q?QYDCxsGPgInoWCBNgGBaIEuVwKCPcRzNAeCM4FfgWAMihaVEAYTL5cjDgaSU?=
 =?us-ascii?q?JhDIItTgXWVSIFmg0KBeiaBWTMaJE+CMwEBMhIBPAMZD44ghCuBC4NWimZAN?=
 =?us-ascii?q?QIBOAIHAQoBAQMJhUYBAYNagUABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YmwjQ==
IronPort-HdrOrdr: A9a23:0nkwLakQ6SUsc1gvk9PpKFqBcg/pDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AdEdkDGmisClSTRLG+r42qF6eDqjXOVrcwW7KYBK?=
 =?us-ascii?q?TMnh0Vu2SaU7JopxPiPM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AzLu7Iw429OLLrTNiyEWnHTPKxow0w/31VkcSs6w?=
 =?us-ascii?q?bsvjba3NAa2u/ghuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,269,1695679200"; 
   d="scan'208";a="141759561"
X-MGA-submission: =?us-ascii?q?MDGH1jkDSktggrh1H5m3Wn7hdVp6BdbLlfUP+1?=
 =?us-ascii?q?C5IefFw9g998Tpt1hkFzqZKe9gRCrFerhuJ3SXtKij2JT1xsJFnB0snj?=
 =?us-ascii?q?MGsj3VRN0dVGeBX9U5UCDU0/orjSdOEt5nWhPNl466baX958ivG/XB3l?=
 =?us-ascii?q?Pq0cuADBpAMyc2VETVllnQRA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:25:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702373147; x=1702977947; i=markus.elfring@web.de;
	bh=P2IwC3j0g6V7kYHfmhdzUCIHVCttEIF11z7WVyirm2Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=W9vHje4RPFGFBqFOA7JqsRBKV17lC47DybUQiBW5jSko0gxvu4XdFwndmdK6x20s
	 jWJNqv+Zp2/2TLU3Q5P86j+flg3DoqAaNPlLPpeGXCgYV7vzoGEvCPWhxUDJwbZQI
	 ypDxz6ZMRgkluN8cVptakzP7hCQJk8hit7D34se1ptajvRMlmM+QLJ4WHzK0GSs38
	 BajEJREjx+a4IZCwIkFtpaVVmf+k6EuL3GsGSkBrpdU5ZG2FCi6JRKmJXV8hRrfz3
	 J+l5LHg5KjNZi+HwpV49znJUygqFCFCSfhNiQjBsjkLyDTKuVSVncSL+aWne6j7Y7
	 2TX6F0Hpu/vVIVm75w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1rVbw00A6d-00rPCn; Tue, 12
 Dec 2023 10:25:47 +0100
Message-ID: <f3e032b9-ee6f-46fc-b686-ce50085bdf3f@web.de>
Date: Tue, 12 Dec 2023 10:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, cfr@inria.fr,
 cocci@inria.fr
Cc: rust-for-linux@vger.kernel.org
References: <dbcff3ca-a7ac-4bd8-92cb-02a8821e2257@web.de>
 <20231211-economic-seahorse-of-reverence-ad90fb@meerkat>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231211-economic-seahorse-of-reverence-ad90fb@meerkat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pAqyeJXoq/hFx++gmsTTEZde5d0CyljLH+gN8aqJmCIKOXWaW7V
 YaXFR0GUXhDbGEIDd5WJ8hfZO+alRYG3g5r+Y9K2eF1NzUMZVHknF/FXwa+7ubmaM6cFFR+
 dkzLn4qUAtBjG7CufqyVaQlycYF54XyIWPwKzAosFTNBG1zYrxB1+1WLIg5YFUBn/CUMexH
 L1gOeilGgfpL85m3vtrew==
UI-OutboundReport: notjunk:1;M01:P0:9l0bKdw/CpQ=;61BXNLWMoHQ+6khJdAdSLcONnqb
 BUBW5qnsjv0dMF805nmy2AOR7hblcmZ/3x2eoBo1npXkFmIa8LJ5ZIEVW49sJgq4NWw37Zs/i
 D7JRFwA7doxawH0JsJkNCqGclvkiynpto07BYx978q8GoT4QoBQGVoBxawm86q5RUkji4W9Y8
 9aJvVK/v9hGF3m43//bXPJr4wjAk4AW4Ch/zyryW/J4wzDnFMrlRAqKtXQgovIBY7C71QRr9k
 o72Xmw/IUzjA0Bl9/aDxVi7lGHHbf+3XdQhaFzDhd4t0cXfsUCopYQj4GtABkN/AUwnx5NA+A
 qRwIcJ1NpDCrv/n+0xaF0Qaxz0GB5bj11BlX1N1VSvWopbxutvuQ4ckz97Xe7oDT+GwLfFUnA
 XZtrrCl88VWfQ9iY3Ev+dKh1b5OFdc5xxsa7yJ6TRWcxEo03XP3xIhosQgxw4gDJG76ElMftf
 9XjdsaNAr4zMhMOJjWKOjGzA6MJSt7zH59zsl1i8yJvDH9RAOmgXDRWtGzoyr9u/5aqoqdChz
 upKbd25Q/NZ6KzMgWf1MFrJoRpIi/tRWLa0BjO9NGLgYSrBZnhjkfjfmT4Wu+AuPumqDsV3tB
 fWsBpw98mgOCexOjoOhZgJEObzwQ1AmmoLEYQDgsozOrxvCPy6FJf6rqL0CVufZp8tD+HhiMR
 535dRDxqINRfgTZaW9AZkx21ei1L0iJw+q0Gy+nfcijMgTVqZhrzey+8mp8n/iU4HkQD5hJmj
 m9On3gGdzgpw+hETrhS5fv1H6fNFD8JbfKtpL38yK8Tke28JUuGPcF7fv1HP7LyfahiBAGGyQ
 N74/N3gQC2tH7MjqXW9BrF/y/AJroSAKq1pDZn5I5is65E2fWjbYNMZHykOiYyEzJSM6TqG+q
 qGMqDLTxFax4zKODR6TLXAT4uCR5hP8N7GxsmWkXhLGsK2AHWGV4HT/9yF41C8v5/EId8tXUg
 nv8QYA==
Subject: Re: [cocci] Extending support for mailing list archives?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1347
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/f3e032b9-ee6f-46fc-b686-ce50085bdf3f%40web.de>

>> How do you think about to support another mailing list archive
>> on the platform =E2=80=9Chttps://korg.docs.kernel.org/lore.html=E2=80=
=9D?
>> Or:
>> Would you like to forward any messages between existing mailing lists?
>
> Sorry, I'm not sure what you're asking me. Is this a new list request,

Probably, yes.

https://sympa.inria.fr/sympa/arc/cfr/2023-12/


> a request to archive an existing list,

No.


> or something else altogether?

I remember your response for the clarification approach =E2=80=9CChecking =
time dimension
for the migrated message archive=E2=80=9D (from 2021-08-25).
https://lore.kernel.org/cocci/20210825162917.jv6jxmgjbyror6vs@nitro.local/

Thus I imagine that Julia Lawall could trigger the addition of some data
for such information systems.

See also her constructive response from yesterday.
https://sympa.inria.fr/sympa/arc/cfr/2023-12/msg00018.html

Regards,
Markus
