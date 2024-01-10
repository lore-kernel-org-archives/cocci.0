Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42915C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yFNCJQ/Mp/+dDUc0P1zWye+aU9uD/m6ulmcOYsaBr0A=;
  b=euXs+v6Hmy6aVjMvF/yYUH7EEW7gw5+PP7l6UiwyXa2FfDyk9JA0rSTE
   FjUnHaUtTtQ/LwHwA4s9byg3+Glu14ukrQVpcwNuQxigmbitVnaoV3YEh
   8INPvLV3/dgWu/nyWK49sGK66SwhAXbxayi7I9A6pVjRN/YHZbsgLQIrd
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145870424"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 13:44:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FF67E0DF2; Wed, 10 Jan 2024 13:44:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 80183E0D5A
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 13:44:06 +0100 (CET)
IronPort-SDR: 659e9115_1xEY2VNn+5fedSsZB387KRDHRXI3TOZkQ+rUc1IRBAs0TlP
 6TwV+zzAvKaIyWPUJU6gQ3cGCZt3YYTfkEpBzxQ==
X-IPAS-Result: =?us-ascii?q?A0HeBgAzkJ5lewwR49RaHgEBCxIMQIFEC4I5fFYyBAtIh?=
 =?us-ascii?q?FORNjCEO48BhGuEBIMWPg8BAwENOwYBAgQBAQMDAYR/Aoc9Ah4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJBgGDgULJ4VsDYJVG?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkIBAgIBIx0BAREbCwEECwsODAImAgJWBgESAgEBgnwBgioBAw4jBw0Gt?=
 =?us-ascii?q?WWBMoEBggoBAQaBRQIMAkOtQB8sIlaBYAMGgRouiBsBhWeDQXonD4FVRIE8g?=
 =?us-ascii?q?wM+gmEDgV+DW4JohVyQIlJ/HQOBBQRcDxsPHjcREBMNAwhuHQIxPAMFAwQyC?=
 =?us-ascii?q?hwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDM?=
 =?us-ascii?q?FVCDFADZR8yCTwLBAwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsmAyoGOAISD?=
 =?us-ascii?q?AYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd7gRcDGSsdQAIBC209NQkLG?=
 =?us-ascii?q?wY9ApUqAYFtggUCghPFODQHgjSBYIFhDIoYlRMGEy+DbpM4DgaSVC6HUJBPI?=
 =?us-ascii?q?ItUgXaafIF5JIFcMxokT4JnTwMZD44ghCuBC4NWimZANQI5AgcLAQEDCYVGA?=
 =?us-ascii?q?QGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:c6PSlKwRaauqaytTkoRSKrPwF71zdoMgy1knxilNoERuA66lfr
 OV7ZEmPH7P+U8ssR4b+exoVJPsfZq+z+8M3WByB8bAYOCOggLBR+tfBODZrAEIbheeygcr78
 ldmsZFZOEYRmIK6foSqDPIdOrI7uP3lpyVuQ==
X-Talos-CUID: 9a23:dvF8C22FjivQg/SYNYFCpLxfCOskIkXkxUrsKWydEV8qS7O/F1ah0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AroRFiw8tn0oxR/WvQsLQd6OQf9hZwb+XIUICrY4?=
 =?us-ascii?q?licWUHAshHwuPriviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76376630"
X-MGA-submission: =?us-ascii?q?MDHf3m7TWSUXkhEG60BaQ/FUKUAf3A9fhCP/Iy?=
 =?us-ascii?q?jGHEW82P23ByjNAfrNh28UQajzVWRAVSmD3O4vKkcSOcYJgD8ZIk3nvi?=
 =?us-ascii?q?dS1IFlM+/MJVB7xVmH4LK0G+Gua3mhiGyhcaWFz5FrO9HOYnrW6FWchv?=
 =?us-ascii?q?mVEeHXpA93PZ58LBC2Yyeykw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704890642; x=1705495442; i=markus.elfring@web.de;
	bh=la73kn+TFTFDaF+8Q3UYpU2TqjBC/104wbhwQuU4dVA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=r6wNb2QLlvgzanAylRuVIUnrnIhoQHCghVrgE0np/3FuNwDKHeXAdtQy8FLFx7id
	 RWlL1xR/Etldcu55AikeqKyJq4cXTtWAk15hIhpx0m69fkfjRur/edlcXl/biHlNn
	 cPIlstKwno5OkxSFwkbVaZaGl+jgByLS0aYNj6qAFliaxcp2UxvDcC7JOwPCdtvbP
	 DxJqJKsC3keKNNTzoS+2fZN0jewnuvm56CNw8yzxHNUvPpScoe4cryv3O2pB1JRRG
	 NlU4lYTPchb2vQfvRhkinoPDPjKnWvwsitdWvhahSrqC/XckxjtaFHkFkECKpTiyZ
	 i7M0XDdSGq/h30pHmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1r8NZb2ynx-016YEe; Wed, 10
 Jan 2024 13:44:02 +0100
Message-ID: <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
Date: Wed, 10 Jan 2024 13:44:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdzX4zLJRKZiTncQNCOSQvc+4e103tCDmLiHfON4OVsvsJodBn4
 Y+SFuLIXC2xvnz5QfL2UL3MBVukgf+QqUMavAu0AbyULgt/T/FIqEY/kCTz7zZGeV27Svj7
 sSc2Jxbr/q/e5kCNJvcKuY0zWpJqxed9bKExbGIxcki165O5urwF3HvrStTtBvlc4mTQGjO
 9LbqwN09hU9l17l7QxhUw==
UI-OutboundReport: notjunk:1;M01:P0:uIIKa0+Co88=;a0o93Pace7y+DJpz4dPP0YadH7y
 kUAmPkvK54GswrVaj/QWwAYFmpKrhZaw56a8e3J3J9eGXx+/SiN69tNuFKO3V6VIcYGH42sqi
 yra5mmX+Xk5K2bYbetfYshKXYUM02QA4TPXh4JipPrlklWXq5heYcS45ngb92kV2o6k/Hp+oO
 OpdKhsfk4xHnv7RJ1P3hRujSnrqyO7WTutJIHXqXLE1BQ4/DhBE9cD/BxT6Lzigs3LklUjDyE
 poBfln4jtmJ8LK7hVe0snKplnG65nrWbJ+NTQfGs9NtwvqGaqebjPQ5e71Rq5CUzA7gzt19jQ
 FWlUKCVkZ+yg4KOyQAIUM0gMzholkrjqLHgHH9xgAy8bqIhfUCNRm5Sc0nIA7fygfU3aPakBM
 3I7c3BW98RuMI4DlxkvuIBfpS2fn99nx9BTXCwUuSe8ZyBnX48cPwByM1dzChAViaLHBM1GqR
 ES9zie1ufpdEGX5T0k8R4Hp0Pqzv0wQyePNsnkn5PMLZRmWoRWgPsYmNow5l53fFSp0sFplWk
 sTT0wMPt3ODH3xaTOCgBSv8EB36KDVZw6JzFfz5MAXx7kX1C86UGfV2PMJQqoIQpE5ztWI4N0
 1GtW4I/8QE2laovyTVmX40EYaf41EsWFZAd7/hUzJMIVSeCSH4TaTfbnPJBRYsVK/vKFWFE78
 vwlu045mF2Vu+Os5Svy4iGP5z+d+EAoU+qIQ9EC211AK6bfn4691MfOOsSqlXBeyzG3n9LtwA
 +LZIYY1HoVBuLZEhgudwKEj4G2fRFKZFAsG/ZiEuIgQNvNwV6xdztfY/IJnYKH5hWSLVUkG5c
 ZQTFl6KqehppMJv8yT4FSBFBtoHTHgjuYA4V1dtO1iyWlr5/81lqjvolsEK01pq1RCiZmFPcU
 ymdH8yIXvIgrXKgyT0U6Hh8h/3qFoq7d56vGUcNokjHXad2HlEVzfLMmtaqSRwC3+3QUXlOqB
 J7GFpQ==
Subject: Re: [cocci] [0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1450
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/1c38e495-5c9c-4ff8-b453-93b882dd2c4c%40web.de>

>>> Is this patch series still in review queues?
>>
>> See also:
>> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
>
> I suspect no one looked at it, sorry.

Special mailing list settings probably influenced this situation.


>                                       I don't catch everything that is
> on the mailing list. Looks fine to me but it needs to end up in the
> patch system to be applied.

Can you collaborate also with mentioned mailing list archive interfaces?

Regards,
Markus
