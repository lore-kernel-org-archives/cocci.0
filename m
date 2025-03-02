Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C8C19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jj/0Jp74HaYgPB6pwV+b0EdLyfYAlb+Exe7ygdDEuqg=;
  b=ne1BGkWOc3qtbEg2F39pcf8crUwhMMDGuedk9pJw//BjBwF/VbxQlgLD
   QmtH2acqpL7geSfuSIEiE9R9Di2h8PeJm19YHx8SHFQDNx71UqNGpWxXB
   RqxAskbBgOT5oybqQDrmVHzFUYevVe+6w+zrtdk/UMdmuWXbEzHMkxaA5
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210736141"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 14:18:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0A5BE0D1E; Sun,  2 Mar 2025 14:18:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A19EFE0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 14:18:26 +0100 (CET)
IronPort-SDR: 67c45aa2_1Y/CKYTbbr9xAKoDNS7yWO3KRj2NwMxVhHnuvQL+k4SqQiO
 UkGjcXDMr/KILXXq6ScIV7mf/NtL5rC6z/eGe2g==
X-IPAS-Result: =?us-ascii?q?A0EREQBmWcRngAMP49RagQmBU4JEYhtaMwQLSAiETo9Pg?=
 =?us-ascii?q?XSEa48OiHWBVoF+DwEDAQ09BAECBAEBAwMBhHYKAosVAh4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpEA?=
 =?us-ascii?q?gEDIx0BAREmAQ8LGgImAgJLCwYBFAEBgn4Bgi8BAzEHDQavI4EyE26CDAEBB?=
 =?us-ascii?q?oFGBQ1B2EMfLCJXgWUDBoEaLoVsgmMBhVtLg0J6Jw+BVUSBPIMDPoJhAQMBg?=
 =?us-ascii?q?V2DW4JpgjOEQGeaDo5XUnscA1ksAVUTFwsHBYEpSAMqNDEjgSMFNEE6ggtpS?=
 =?us-ascii?q?ToCDQI1gh4kWIIragQFgSqCN4RChEKFUoIRgV0DAxYPAYIwb3ccg0yBLYRtH?=
 =?us-ascii?q?UACAQttPTcJCxsGPaFyPYUjWYFaLsZUNAeCOIFmgWMMiimVNQYTL5dFDgaSf?=
 =?us-ascii?q?R6GBJJbIo1jmyw1gTI6gVwzGiSDNk8DGQ+SGzOBC8cVQjUCCTECBwEKAQEDC?=
 =?us-ascii?q?QGBVYNwAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:Qsd6dquu8WJ9g8lFcPVhhPPI7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3AMSaX1GjHpnWBeH64cj9qTH+WsTJud0fU1G3PfGq?=
 =?us-ascii?q?EJF05UIzFVlKI2IUnup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AXLYKCw1mg2NfUjGH64gDKIVVKjUj2oenGWE2z5M?=
 =?us-ascii?q?8sPaoNiJZYAWjiiyUTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210736140"
X-MGA-submission: =?us-ascii?q?MDG5HQlFqWxh/lYsoo5IpIUg7nxjo9wJVhY6Lk?=
 =?us-ascii?q?pVHWpuGAfvVsvO2x+2ut1w5lXrVHqDxfh4Tza9KeXzKfqjIIVV6mqG2n?=
 =?us-ascii?q?QdiNkYQgMbNyL4TnE5/iCi4PzlGfW/TL/dtXMC4LBI3nuAVp3Ai0/yMc?=
 =?us-ascii?q?Atpl9CTgMR11q2XPKO9SckjA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 14:18:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740921504; x=1741526304; i=markus.elfring@web.de;
	bh=Jj/0Jp74HaYgPB6pwV+b0EdLyfYAlb+Exe7ygdDEuqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fu5bvAmcaTskD8txj5Ryqf+HMqzPTY01B4q0pgenXiq+bwjcUkHPhHxf+QIdyJeB
	 SxJT4y1MGc4H9qIp87vwfYusK6+hdo+a8JLY9XutIozzpBKRYGr0hDNz20Z6NK+zB
	 QkqqEhR75TBpSunSzvyEWdk+K5e+2ZoGk7Z+7TAgc+8AuGLy68BmwKjZlJIMwxfjZ
	 wtj6qIl2yu39+qakMzv4rhlw6SfffLfvZEcYX+r+fb64GWG+O8f9c8cdBzalT/9/u
	 u9M3R86mWnV4yRknKCJe708D+T/tRCVIktvBSiqz2LgO+VjI5LUaCMjb2ladcqwCZ
	 kV6Y0XCsfugrkjnNyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1u0Iiw0BGU-001ais; Sun, 02
 Mar 2025 14:18:24 +0100
Message-ID: <1a2befa4-60e9-48b7-bcc3-587422c01c35@web.de>
Date: Sun, 2 Mar 2025 14:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <Z7zjkyOeoPNYeOR3@blossom>
 <alpine.DEB.2.22.394.2502252132540.3444@hadrien>
 <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
 <fcdad933-12c3-66bf-c39d-bee193371fb3@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fcdad933-12c3-66bf-c39d-bee193371fb3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:855QKuWyPpModkaQS06+Id44ykMP1y1c55EMwJ8Jo4JC7V+znx2
 JC4lyYNXHSy0kzcQ52DBIWInrqUk4f7kZY5COPu9DW1CKzXRFtjn+eQuNFyt8yIamQz36hQ
 rMBs/t838f86zoiLM99PHwZFN9uwcbjk8Bxe3XySvnPr5HsH8KGg35ixBfzW1isfr9HEK2g
 /aT0BTEky88gL+UnQ7uMA==
UI-OutboundReport: notjunk:1;M01:P0:nzYg/fceQt4=;r+ClbWkgnHtJ1IUJBGB2nleMuKK
 nIwX0T9DBlVnNSWwRrhMssvuUtWvXZ8wXRE+LnjoH5Kc2UZ6/3R3BbcGgiUnXcixWdoiaNzQa
 XCvSi3RN9NdXwjlPx3q6RryWrQ4GdCjqmq2s4fzH9XFo7HQzgJHFLX2F5EzskwTWgo72Yw+Hb
 DWuaEXHZOEWM6gigK3fSD5bMlxoPb4Ctk4IvRUG3pVWpXWACIq3SbPNs636bVW8wBlyM9U7+t
 ldhS723y9PrD+bLt1dSIFZXuVNvfpytoqL4UVgtAlW563TYGmySp5ElHrDb5pgC+fevMFaena
 7/+cXT9bb1UqNgnOOzMyAscUAqP60d1efjbIVDdPEZ2p6x5u+86y9K2gYFf6QYzdbcjv/4MwC
 Cqv0UBIRTh2jBwMF2UI/87Wx0hPx7K/niE8z2uSqqKB8O5JL2FWqV3MPy9cWXq5gbM8guEAv0
 dEIgeTeW5Ro9/Gc70w13uuoFY3zVaBC2yhASPgkEH99s1iAJkpyv0QTjSNDixjBZ96hTbqVlV
 zk300Em4xqkl0ByRm8UO4g3uccgDbXHD3BC9Z1I+oCh/ydRKGjbvuiMszXvhXzo4D3jwleL2U
 t3eNZygk4NycVDOJMzrM5fNdiFbiLZGK/MQsw6CQRP8oBlwQkptWGkJuo8xArPkrF8nK0a0fz
 qmiXEXDwBvD+XQVLS0+exiUkc3n1toSz/SWMfr0ZQBpvYMAoa5zvBBUGXR63viDCyvgyD9c8Z
 F/d6aEfQwzA7IUQ99DocK5v2xp7EXIpY86eHq9lyrTEYbtPyI/ld+FQ3OraoS35m23IOSpOad
 TWVsf/XntpoTTz69kwrSpwjYGE78lQ0gx3cCGVXGPJ2IbJxK+HcZH0AGbCkmp0mM6LHpRksBY
 bm3t2yLFauIfM849ZaIP2QZFLk6fWSFu/PfnMqX4SLFygLS7FnwZWL6Lmgz4+z6qkdbYR7K5r
 jYCUoK7Hz560wtB1lTgZOQ9sTej5Gmbo5FW3frNJ6DXvlpxhE+xz4FyaQl0PDa4jtThkEdl4v
 8xwb7yX9RE8KliMulLigIeV6Wm//qpDbbfDjFFX1hdtLO+u0Kot7EpNi/eKMA1IOoGFZh7sO2
 pxkYXEcb3hjl9VtsmqymreFEf0rccUoxqNV5hJ2cek7fQEvQYpECxfzIPLpHHlxPF3adGmMMr
 +nX3UsOXI/Dg7MRnU8d/wAw60JJmxjV1zBunp+amqySQak95l+LVtmA9o3AZ8ZTEPgmZQaOy9
 Jr9g2X4QF15SjtNGI8iWKEI2LAghHhv1JsaywoJmUGa0SqIbCzaFBIYKmf8w1WQM5dR0ZnMcQ
 TYWahWRJwz+1pVEP261ajJr0w/T0LadMnbnPaZDY7h07dN166+D4w/oVLSuqUWYR1rI1XUr3d
 lV4FCuwPlPxR45hNK9S2NjG5KM9R2P6C/x24S8hK4K47H0Q2fTB+JWoYZT7rTIyYHvyqb+YgW
 AlmTlzA==
Subject: Re: [cocci] Data processing challenges with =?UTF-8?Q?=E2=80=9Cco?=
 =?UTF-8?Q?mpound?= assignment =?UTF-8?Q?operators=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2468
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/1a2befa4-60e9-48b7-bcc3-587422c01c35%40web.de>

>> @adjustment@
>> expression lhs, rhs;
>> @@
>>  lhs
>> -=3D
>
> Actually, it is the above line that doesn't parse, because -=3D is an
> operator in C.
Does such an SmPL script example provide opportunities to resolve
the handling of such a =E2=80=9Ccompound assignment operator=E2=80=9D in o=
ther ways?
https://en.cppreference.com/w/c/language/operator_assignment#Compound_assi=
gnment

May I expect that the minus character in the first text column gets usuall=
y
a special meaning according to the semantic patch language?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/1c46296c6aa9415c3e333=
88c83f8529ee7b049da/docs/manual/cocci_syntax.tex#L1028-1032

Regards,
Markus
