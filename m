Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2248C61D97
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=46/jwZwWgkWXN2+1iizi1Te5MOxTJr8sDtjnnsW7DkM=;
  b=blOnjgWWIQBPGn//fgNNBNtJthZvkfIXP4Cw6Z+4myBHQhQiijq/ML8o
   42wzbelyDzO1BbzHzldagtYqj59kreymMbzs7ca+qQtVc6i73rM1tRpy9
   nfyZDdvS/VXp/RGUNil8RFEN6tAS0O7L5wzoWwqS5Ls0+OIH7sOMhcpiT
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138253599"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 08:42:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B85C3E0AF1; Fri, 24 Nov 2023 08:42:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 488E0E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 08:42:41 +0100 (CET)
IronPort-SDR: 656053f2_IHvVEQ32Ua83NZs1/5v8CajZP4tvDAO/wa+FTxgaWbbLgeh
 56YNNw67eYeJ2VEMJ5NGSL9Usk36pKXLGsizpHQ==
X-IPAS-Result: =?us-ascii?q?A0EzAAACU2Bl/wwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4B3NWMAQLSIRTiB2HIIF1LQOEO45+iG+BVhSBLD4PAQMBDT0EAQIEAQEDA?=
 =?us-ascii?q?wGEfwKHKQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?oEGE4VoDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQECDTpCAQQBIx0BAREnBAsLGgIRFQICVwYBFAEBgnwBgikBA?=
 =?us-ascii?q?w4jBw0GsCSBMoEBggkBAQaBV0GtPR8sIlaBXwMGgRouAYgMAYVZhDUnD4FVR?=
 =?us-ascii?q?IE8glIxPoJhAQOBF0c/gxyCaIknB4YlhHh1iRBdIgVCcBsDBwN/DysHBC0bB?=
 =?us-ascii?q?wYJFBgVIwZRBCghCRMSPgSBYIFRCn8/Dw4Rgj8rNjYZSIJbFQw0SnYQKgQUF?=
 =?us-ascii?q?4ESBGobEh43ERIXDQMIdB0CESM8AwUDBDMKEg0LIQVWA0IGSQsDAhoFAwMEg?=
 =?us-ascii?q?TYFDR4CEBoGDCcDAxJNAhAUAzsDAwYDCzEDBylVRAxPA24fNgk8CwQMHwIbH?=
 =?us-ascii?q?g0nJQIyQgMRBRICFgMkFgQ4EQkLKwMvBjgCEw4GBgkeBA4DGSsdQAIBC209N?=
 =?us-ascii?q?QkLGwY+AiefX4NfaFcCgQVZQUmSMJ1YlDY0B4IxgV+BYAyKFpUNBhMvlyIOB?=
 =?us-ascii?q?pJPiBmQJyCNR5ptgWM9gVkzGiRPgmdPAxkPjiAMFoQJgQuDVopmQDUCAQgwA?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Ik=
IronPort-HdrOrdr: A9a23:XlD+PajVhYMxhxoo+b2VTMUoqnBQXgQji2hC6mlwRA09TyXqrb
 HMoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:V7072m82XiyWvchEsNeVv2cdAusYbGzE907BMWO0LmR5D4ynRUDFrQ==
X-Talos-MUID: 9a23:BWsKpAmAkES2OF1V0qqvdnpzOeFsybyFN3wojMQItpOYHHR9YgiC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138253590"
X-MGA-submission: =?us-ascii?q?MDEIbxznWWPg7xH/vsMH++bY+NnWvTLa7m6L39?=
 =?us-ascii?q?J6r/FXc1FAwrX+fwU4WBK4tzOrFAYE/01VEgNT/bi+BuHzkxXBGBKnti?=
 =?us-ascii?q?ujvk3Y9yWT9I1EoJvznAGuhPlWMkZjG5WgCqSmg6AgpmZ9Xjz5p7SNYy?=
 =?us-ascii?q?Jxg8PgOYxSRAo32+39kYDOgw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 08:42:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700811752; x=1701416552; i=markus.elfring@web.de;
	bh=47knmy28lzRs/0An4qDWqq/BvRGwX218z3E3yQfaX2U=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=NQa7i1umbjIxvTpt69Iszf+H5+0mhjJ+FE//cQtzqxRAUmQkuncYYDTqZKz64nWq
	 CqZVbKh3p7rS4ny+wqAc6ZIaSb171FlcZUNQ9v1y7U2FlY1iCKGASYQf5IkLQhdry
	 oTFNQzJok6tGYJpdYzG+kLDvaYyQtL7BNkj2jiIlRCn87r4NTvgtC4uQsJnz2pgX7
	 Js2aGMBACNPcVtv9E1knVeciignsmf/x1fiSAZixxlcOvJ/FKibdDC1RD78Tvxtx9
	 rfH6Wr9XNzS9GwGyiiP7vKfSnWz7XfViAUx3RyC9AVteOT+hQEVMSNBk+NtfC56qc
	 zKsc/XFfK2TGhJ2p+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4fI-1r0QHC0M3O-00Bb2Y; Fri, 24
 Nov 2023 08:42:32 +0100
Message-ID: <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
Date: Fri, 24 Nov 2023 08:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vs05Q2r3OAB3PFxVYEGoj3rSr+6XwOHcDOb6N/SG5TL/8aOs9hj
 nTdEdpTjf+HCNsQtsi7wh2Y7Mc2E0XUgs5EWyC345khmb46w2gZiiRpd0fwiOnLLF+W2GOp
 X1NRhwnKCORcuOy+/XMzpUJi6ISmrkp0zFqk4Patr9QlrVX9eZrPsXtPl0IA3a3vtv/NT0g
 Jb6TAvxXwAz3SJ/azj65Q==
UI-OutboundReport: notjunk:1;M01:P0:hLyVUTDZq84=;W86ttPeKIltOuQ/b9Mj3rMqTTjI
 MT+oCni22fDvsGc+AvgAxsF+ZpiqoP2Eb7A0VSNVvto3yE7fQx/wxftDuo2ysZ+KGXMO6s2mY
 UPpx/AzcVmBEw4uOPrXBYqjwWe8nIp3RKvm3et8mNZwfm/X+1yIEHdMBWKm5ABYeSveOyKpoJ
 MQcGUjC1vRDkpOlwag7Gglgo3z7fkm2fd7BnhAqkqmLqNbOvKQWFAgikF/7rIEwrlKniTv9aw
 xHsa7hmjr6/EKJNInveprZYjf3+ejTD7Uq2vVjFCOu0pD8iHSh3gpIiiBY0aHOCxkxknqQooQ
 M/n0vmhHBDLSDRQ762u7grzCKuLXChIq3AmrQpqz7EL4UtiF1uJbdFgHmRcg6yZ+wB0Et7tN8
 z1TD2j77KhXIiYHA7P7qh9hvhAn2kLOvWM3joLslKEuEt0u+6PLa/RZy2nvGiUCZekmEuAMLg
 omvD2b9zjjwdzlx015RmyaG9R07pAi1dfuYDzbCLnBIoHjfuKpuzvHwFknuU2F6f0LrXn2/LX
 BhLgicc8v35UyA1kx7ZEy76sI5/4sgIJzOJ0/K9PFHSnj91Gr0McHAxm8d5a0qPnPOerEeLFQ
 7VxVxOdveNYiHNY1TdyKzzvJsQSolk91neLPFS7FERJTWp/oU1ORQ3xUSZJVuAir8GvDWgmxJ
 MH/E0rMqU78lIwhTg+G93HXDLp30NQZITw2yDuaShlaiYr5QnxfNBrIlJWnr6dPNdudwg11kb
 H/OsaxbBabbPdWoLCTKEvxAEVF8Y7HUBBzv7ivdh1idxNBI/RdQCL31ggnYB27FiszBq1GkE3
 WWfHx6tM4A0+qsSAdbqBS2nFHIKthLPef80bv3KgyXodZp0dsTaE5dxaApm3KpnFki+J3YqJU
 NeGRVr0yQV6z/9J4o9AmFglw19Ic+0jDFOGLRWlXiXxtmO4uQKIeQkHUEuW04RnHmo7qz4n+j
 TLJF1Q==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1327
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/05cc07d3-385d-48ea-9e4d-be32c3e863fa%40web.de>

>> Test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch displa=
y_position_information_for_one_return.cocci only_return_from_main.c
>> =E2=80=A6
>> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)
>
> The type of a position variable in python is an array.

It seems that the output from a call of the function =E2=80=9Cpprint=E2=80=
=9D did not indicate this.
https://docs.python.org/3/library/pprint.html#pprint.pprint


> In OCaml it is a list.

Will any more clarifications become helpful for the involved data structur=
es?


> This is completely independent of the number of element involved.

Will further case distinctions be taken into account?


>> Why was a tuple constructed for a single source code place?
>> https://docs.python.org/3/reference/datamodel.html#immutable-sequences
>>
>> Can a =E2=80=9CLocation=E2=80=9D object be provided directly according =
to a metavariable type
>> like =E2=80=9Cposition=E2=80=9D?
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e=
5c21b60d41938d32321b1a/python/coccilib/elems.py
>
> I don't understand the question.  I guess that a position variable is
> mapped to an array of locations.

This view can be reasonable.


> So if you want a location, you would take the first element of the array=
.

How do you think about the possibility to avoid such data processing?

May it be expected that only a single source code place will be passed to
the shown script rule?

Regards,
Markus
