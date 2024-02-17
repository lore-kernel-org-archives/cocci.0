Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D2DC48BC4
	for <cocci@archiver.kernel.org>; Sat, 17 Feb 2024 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v8t4fAKOLGwEN38gNb0Mq4s9axWHK2Rukg7ctNd67/8=;
  b=WnFfUTWil6A3X5lpJn0Fiea9mx+x+XWGVAKZyYZ46y3sRbMmnc5Z/tFt
   zrioqsCv8FdTrmvva0Lrb1dDpopFWkAh41Wn2BgTrqW/17400Ejn9573i
   27zSSNc7mKtws2nPCZHYgbi0DaSutD/0De1uvtMww2l0bjCICYOoR8tqa
   E=;
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
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="152443897"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2024 17:38:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F173BE00B7; Sat, 17 Feb 2024 17:38:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32956E008A
	for <cocci@sympa.inria.fr>; Sat, 17 Feb 2024 17:38:48 +0100 (CET)
IronPort-SDR: 65d0e117_+KXl6xTWc4CLGWUigXuh7wNeOlsu6VQRKAL4K01uBv7ytL/
 YZHjXUz++wmxfgRzGDCbzlth5zX6fBYe+HOT2+A==
X-IPAS-Result: =?us-ascii?q?A0FTBACQ4NBlhwMP49RaHgEBCxIMQIFEC4I5fANTMgQLS?=
 =?us-ascii?q?IRTj0SBdYRrjwWIcIMWPg8BAwENOwYBAgQBAQMDAYQ5RgKHZAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CX?=
 =?us-ascii?q?AEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06QQMDIx0BAREnDwsaAiYCAlYGARQBAYJ8AYIqAQMxBw2xR4EygQGCC?=
 =?us-ascii?q?gEBBq9bHywiVoFhAwaBGi6IJgGFb4Q8Jw+BVUSBPAuCRzE+gmECgWCDW4Joh?=
 =?us-ascii?q?VGaCFSBAh0DgQUEWg0bER43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQwZJC?=
 =?us-ascii?q?wMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfGBoJP?=
 =?us-ascii?q?AsEDBoCGxsNJCMCLEADERACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlA?=
 =?us-ascii?q?wgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0hTiEbAyBUgMZKx1AAgELb?=
 =?us-ascii?q?T01CQsbBiIBHQKfEQGECSBxxlY0B4I0gWCBYQyKG5UdBhMvlzAOBpJfmFggj?=
 =?us-ascii?q?U+VQ4VFgXokgVwzGiSDNk8DGQ+OIBmDYTOBC448QjULMAIHCwEBAwmFRgEBg?=
 =?us-ascii?q?1qBRgEB?=
IronPort-PHdr: A9a23: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
 chXIle+fEM4HLUWBxY9dOE=
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:DYp3ga+SojUfJxwmN9tuk+AGI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtsJ
 uIGJIfNDSfNykZse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3Arhc6VGj6j3cyIb7psQrdq66urjJueVnx4F7tKn6?=
 =?us-ascii?q?CNU0wWJOYRGCN5ps8up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOtCDTw89rFN0ch+x6DlG5BeQf+I37K6vWAMrrYd?=
 =?us-ascii?q?FuseJZC1eNCidoCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="79912289"
X-MGA-submission: =?us-ascii?q?MDFey22Paa2inCUawmzYttWV2Uihv3Al94IN0w?=
 =?us-ascii?q?6Fd8o6HscWK2jIs8MAcYZ7x/uNuPn/z1/p1U1mzROPw4UZombCjI/tUP?=
 =?us-ascii?q?lZm6VVJz7Oz6hvdcw0E3mDfeFKbYr1onp0jjsq0UuRUOuNI5MQ9vk4fI?=
 =?us-ascii?q?9XYbut287UWOg0JcayBYYDNA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 17:38:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708187926; x=1708792726; i=markus.elfring@web.de;
	bh=jP9S3KxZ6bqsoWvdrG3Bm3b1PtG7limcOJ4WgNLHtEg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=XppEnAMKW0RSnpTSVZ0aeNeJZafjRtCscnisgNYlb3DA5lKgfWvAolo3BglEWYHE
	 omGN1V7Pikzg6Lhesl23DrB7004kjDDleuwJns6YZjgjX0TYAnyZGjMosZh5sM08c
	 ynfbghVS3Ygo1Bv6sdmdLwFoxHirPEwTx+BNykveZoGrGiKn49r1XWHmrNxYPMw3v
	 wIc44Jq/kzlSfIdsVJTkdLuU9mAR8A8hEPvop11PLxMQ9N9o4oaXhmIG/oImP0ZWi
	 4s1HkyAmX7tmcv78sx1x9i0xtP8zeKIwgFx8tx8Xf5zP3RYTT+03TWnh3QZNVWctr
	 1l2gkZSPKPQDjs1lNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1qjJFa0qCa-00yldB; Sat, 17
 Feb 2024 17:38:46 +0100
Message-ID: <7a9ea69a-2699-4fb3-9863-2eddadb5670b@web.de>
Date: Sat, 17 Feb 2024 17:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
 <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
 <alpine.DEB.2.22.394.2402171623280.3095@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402171623280.3095@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVXgB59EdBg7FznNBTD8K9FOx5crnb50ymHnX4GvYCon4E36PV5
 Pr1zhhi6/+XtmiGSqj76OZFLcasNglFGt1P+PTpTtRmMECeYsLSr878TLyZcHQn5WCeY2h6
 mI+AsYTK2V/sO66P3tXc9JgKU0qQYVHZcnJl4LWKAW7nWn6F2AVZGKpAT1kbo5cXgv0+tGi
 QOcXISom4u4A15pMAEUsA==
UI-OutboundReport: notjunk:1;M01:P0:rrZau0r8JYk=;OWbLzW8YfQOkBgGVZxrfjlvYQWb
 n8A+bIMUJGlKSSlc1e/iRgUwMvG0AnleM7WC3Qs0ezWEG5vPCr4MHd3tB4jeoA5oRWeGk+buI
 I5jlY5OHyxMDNQzpLF6CGlp3zneRWqVoRThctfgttRcOUoZpjRpmpAS3ryWQ64b4RdQd3rIrH
 Y9v1mcDPRQt2TlkLM9x/Hlfg2BZ+t7MXNm6l1t4nnIvUoCJwBYaDN9Czk1pQutolOsMOC1P+E
 SR9sfuSUGrHpVaNqmmKKhvI9yw1rDmh5ERGegIe39pdzM2bO45CSwafKuYuIfMh4kldfl+qCi
 POUGxtDowgSwOqxc20w5BqpBhLCwRrbvmiQK2QlvFFCu5wFMjCcYOB6+zMg0tYiq/Mv16/Ycw
 7o0by5Y9kBjptXkTzGSab0YXS40P1KQp6apUo8o+i88M1WHRlJSwNVISFNECewa5lcReZawvl
 Fj2C6+fWs391ToSoNBp4GPvOH7pqrJdLruoyeUstF5go1cvnM+zRuXpRb9rKXmGNOwltoPQZT
 3mWKKLZD4kdRlvp8PxnkfCeJh7yi23BI8sLZiVjUMtDk422wRcgdwvYCL6j8Vps2OrkRYeYLQ
 T/kKWnqVqv//v4GQ+PLCQPp75l4JsPnCHqmHGBjGH6/cFwuqSvHWNVCqJiaaLCukldt4h2feo
 G9ZTLB+RlOsXU2IWMajabfCI7lG4JAAvFgJMBH7hnBA/fQXcXwFfLaxbifIp+aQ4I1GVZPCj1
 zr9VgqbIX75Z3Tp3/9a01qtgJYoS57GRSlZzBIsb8Uh1YD++c3JDhcT/1uVrQUIK/OawTEzx4
 LKemqitilRnZIccXYQkcJiEbTUt/I4eJJV4z0hCndeixQ=
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1572
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/7a9ea69a-2699-4fb3-9863-2eddadb5670b%40web.de>

>> @deletion2@
>> binary operator bo;
>> constant c;
>> identifier var;
>> @@
>>  if (var bo c)
>>     return var;
>>  ... when !=3D var
>> -if (var bo c)
>> -   return var;
>
> Fixed incorrect handing of binary operators.

Is it interesting that such an open issue was not tackled before?

Thanks for your corresponding contribution.

binops and assignops need to be stripped before being put into metavariabl=
es
2024-02-17
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/cf3ea16c48751708ab4=
68919c736acb06f7e1ff7
https://github.com/coccinelle/coccinelle/commit/cf3ea16c48751708ab468919c7=
36acb06f7e1ff7


Will any collateral evolution become more appealing accordingly?

Regards,
Markus
