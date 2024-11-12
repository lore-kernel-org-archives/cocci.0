Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFEDD41D5E
	for <cocci@archiver.kernel.org>; Tue, 12 Nov 2024 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Rtj6VHvnjPHiHa3WE28Beaj13OsEIyCoPbk13h2lqh0=;
  b=GU+CEw4xziRiD7u29Qwp+bAaekJ8VKer1j8TK84vZZMoiJMYsDuqyegH
   5iJiYQgYaF0QgNJIDXH8oI9PWGdMvfEt/gFAylkNZoWmRCnQ/EQDzkdTm
   EH5FLCpE4dbOUR9RC083KGEniUcKaidAyGQsxvvGU36FBLZ2rAL6YIYIW
   s=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,147,1728943200"; 
   d="scan'208";a="193241654"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2024 07:37:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3A6E2E0D1E; Tue, 12 Nov 2024 07:37:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0E14FE00B7
	for <cocci@sympa.inria.fr>; Tue, 12 Nov 2024 07:37:04 +0100 (CET)
IronPort-SDR: 6732f78f_5qXGL43bJyZv0efCCmCPzYgZBum08b5g0Tkn/WHUH2EjM+B
 zj81k1x2w4xW0nCbrV9PUjGBSuM+MdHd08Juyrw==
X-IPAS-Result: =?us-ascii?q?A0HGAABK9jJngwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYiFUMwQLSIRWj02BdDCEO4c6h1WIdYFqgWoPAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhQACijsCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBOgcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REnDwsaAiYCAlYGARQBAYJ9gjABAw4jB7EagTKBAYIMAQEG2lsfLCJXgWQJg?=
 =?us-ascii?q?RouAYVpgmIBhiSEPCcPgVVEgRUngwM+hA4BEgEhg1uCRyKCRYUcJYgtaJhRU?=
 =?us-ascii?q?nscA1kyAVUTFwsHBYEpISwDgXpXf4E5gVEBQoJdSoM8gV4FN0mCSmlNNwINA?=
 =?us-ascii?q?jaCJCRZgk+BJQQFg2qBC4NihGaCIR1AAgELbT01CQsbBj2fboJogVOVYLMNN?=
 =?us-ascii?q?AeCOIFlgWMMn1UGEy+DcQGTTQ4GknqYdyKpAYF9JGxwMxokgzZPAxkPjiEZh?=
 =?us-ascii?q?BTFKkI1OwIHAQoBAQMJhUYBAYlcgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:4a2Fcq7wlO5vm3jFeQPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:q2JncmyHPq33VtmPq55eBgUpC8x+UmLe7E70Kl+0OE9ldaKQEmOprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3APFrD3Q75G0p9Y+P9Vp5jdnkwxoxM3pS1E1IJuK8?=
 =?us-ascii?q?BuvmIaQJqajKEnB+eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,147,1728943200"; 
   d="scan'208";a="193241650"
X-MGA-submission: =?us-ascii?q?MDEa1vPHsW0Zg6aE5tipzWtAuFY7uyHIMGLn2i?=
 =?us-ascii?q?w6Knjc5Yr35oqIxMCxStlDJDg5Yt8iaZO+OU6VhyPEZi/j2sxcv6TGT4?=
 =?us-ascii?q?HI0sG3ldTefqUb5/OEAYoag6gY8O813ztduSmt53LV92nKKNnmmKlWuE?=
 =?us-ascii?q?q1pvRRF6Y5Vg1jifS+MpRJ5A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731393422; x=1731998222; i=markus.elfring@web.de;
	bh=Rtj6VHvnjPHiHa3WE28Beaj13OsEIyCoPbk13h2lqh0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PLqEGQ7c7eUWRlkQ4yRfN8FWpRPGBDiB8KyLUlNT7C+QWt3yKDU3tJe9G/DG9liy
	 TGfSrt7+/VsgIQ7Ffq4T4GMr6quT0jwuZnCAM71VgSPAiYKyDV3Lgm5XZY6nzD1W1
	 aKjUGaK7MdWRqrNxs3YTAJCgoaTFeoKlkCw7u3w1pYAEpimXs9lXQWBF/Nv4XlGvO
	 DICauM2jwXeIwvlbWeuolqOsa0iS8e1Mz15WFkD7SFKUZk+0qREWmmhF9Bv89LugX
	 7W7rpHlvprrglYUr7CC+7JdRhILLDRq31pNkCETz/vHhpN5lHLj5S345epnKKT6b6
	 XvYeCwLBHuJVfwXWvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1u45j62m8k-011B28; Tue, 12
 Nov 2024 07:37:02 +0100
Message-ID: <7e25cfae-fd08-4b82-8c66-f73e0450a1dc@web.de>
Date: Tue, 12 Nov 2024 07:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michele Martone <michelemartone@users.sourceforge.net>, cocci@inria.fr
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
 <20241111171232.GE10291@localhost>
 <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
 <20241111173137.GB32356@localhost>
 <3e4d1941-40c5-43f6-aba3-c400b0828ae7@web.de>
 <20241111175940.GC32356@localhost>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111175940.GC32356@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vMWaQ0567LSO2vbiShOKemZQo2YzHiBx24J/Zd9Vx2zipEf8ki
 0UdkvFl8k23D7iFLDp5rFhpKcx4eQoBh7U+7DhMjdE3Cy34GP3kHsmu5NcBAlgHDN0RPxlK
 rL2xDKMkGPyumPoM0w2Gw7u2EhcvgQuPX5OA8mYap3YTUatouRy5J3FsfhSTD89/gKSE9jH
 6rELwsZLjIcMwFbhS1J5w==
UI-OutboundReport: notjunk:1;M01:P0:cOLmi4HSC+Q=;t/P18WVRefpUQS+lmC3bqFWVJQH
 4JXM7nWEycXM1N5vCFDf9rm7KO2+2NF4uYHkdKGdMzvPCyZ07kzBGIxL1LUjLvRldabv6+mDu
 pMq0JAMAyZNnMOF/F6QAlyu2YkLeG0YSzVpfYYwiG5SCoEgjJyP4qYjlzz+s1Au+dAbElgHmR
 NtWPcyvJCAkXaG5vljmDjp9W7L0cVWossfZm9Hs15zjnrYZ8BHDcOilEYWDoNVlrHkVvviaZq
 zYR2U2g/cyGGTJdLeL0L7PWc9hScCrzikCLoXXA98LDwoV2RGIVapvKRVXCtdNnSPnXO7zHNj
 1L9nIRHRDeb1eHqJSYuSp1r9Qiwbd3BPC4FuM6K25P8BwRPmMpvwJCigjA2KpLWDM7nVWKH2x
 HpE31HCi7i35fQd6nn13DWex0PYftXAxhFk+X8Mb+Ci6RQTcV/xbPQrrGgA7n6bmMO8Tsdyxn
 ujUj2nVd6oI0eqbdz5gax/ib84Mwost1nZ42yiYad3mXRbKVTqjYFV/DMrSHxolEGN63aDY/B
 Zw3ZfDPe9IupBK/RC4ZaYOFg6igqneGL5qByCxvBG1kvHLsK5kKgIQsC6q11kXeyuD60pvzz5
 SLwpqa1EqGI5a73nFujPoKc/6UoDC/l8KQIPZtu8Y0lBI0gLtsFbNwIZi6hZTkA/4gIu+TbbA
 ezic1hpoyBw2Ud/VstNnvunrKD9tokuQiYFIkc9OdFmgJpxVfC0ETuDZePDO+bQ+H5A77FhHM
 TmUKea9D+OkJW15kgmVYPoseLEr54W17qD57orqIwT5q8WRDYsYhFbgkwFFhR4SmH5r+O/O0v
 IOhvwwHYWn8VXMGzL5sJJxNvNuv2AZ40CYQ9xM9pLbNi9mXh4fHIbdb1VQlSFSvnV2pBVURIV
 zde0ZAY1iKDLssA4eGiL3EGI7uo8H3uukQHOuLj4iWKTas4LxsxeJdk8x
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1997
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/7e25cfae-fd08-4b82-8c66-f73e0450a1dc%40web.de>

>> Has EBNF the potential for more succinct grammar descriptions
>> in comparison to ocamlyacc?
> I think no.
>
> How do you find the grammar description attached to this email?

I see a possibility (in the example file =E2=80=9Cparser_c.txt=E2=80=9D) t=
o avoid duplicate code
by marking some parts as optional.

Regards,
Markus
