Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B8DCFD313
	for <cocci@archiver.kernel.org>; Mon, 24 Nov 2025 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FhQgIdmKbTQxoKI+nq85UeEN0e9sut2QP9anR5RMr8E=;
  b=p+sdf2iTkQ9VfvV28xY/k8QezbQOEpsN8fGV01GQZF5H/jX9yFfCnrZr
   zhmOA+lHVJLquMBXyK/bWjHK8qyrtEhjh+3pSY7iUs15e46dGDW9zpFNb
   wlz1EP4kXbDXD8msJYixU80J/t1UecFPwMDEaxg62U3RjEeWKOhgOGJjc
   Q=;
X-CSE-ConnectionGUID: Nt7xhxvTQNm+rgDheXus8A==
X-CSE-MsgGUID: zvmctYe6TxO9fY360W190A==
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
X-IronPort-AV: E=Sophos;i="6.20,222,1758578400"; 
   d="scan'208";a="250852047"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2025 13:51:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94FC7E0BE9; Mon, 24 Nov 2025 13:51:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 84A2FE0264
	for <cocci@sympa.inria.fr>; Mon, 24 Nov 2025 13:51:43 +0100 (CET)
X-CSE-ConnectionGUID: QJQQflr0SaORzkoHQE5xwQ==
X-CSE-MsgGUID: BZ+iyCt/SQKCZpAPXhVJWQ==
IronPort-SDR: 692454d8_dwQZ7HReMFDQIsvp1k/dJyzc3207xlkKfketzvpL+HDNeo7
 1DWi+nR1AKUM4p+3vuEiW6vEw0N0MQMbnqLdB6A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GMAAB8VCRpgAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwMBAQELAYI/ZR0GWDMEC0kDhFKPU4IkaYNSjxGIeYNSAg8BAwENS?=
 =?us-ascii?q?gQBAgQBAQMEhDpGAoxgAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBOwcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06R?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4BgiIBBhABAw8nBw2yOoEyg?=
 =?us-ascii?q?QGCDAEBBtpfHywiWYFkAwaBHC4BhW2CZQGFbjuDQ3onD4FVRIE8gRSBbz6CS?=
 =?us-ascii?q?hcEGIFGg1uCaYImgQ6GJ5MoUngcA1ksAVUTFwsHBYEgEDMDIAo0LQIUDRASD?=
 =?us-ascii?q?wQWBS0dcAwoEg8dEAgTYD0XQINJHQZoDwaBEhlJAgICBQIrFTqBZgUBHAYcE?=
 =?us-ascii?q?gIDAQICOlUMgXcCAgSCFn2BbxsPiCmBCQUuXgIBC209NwYDCxsGPZUGUYE7g?=
 =?us-ascii?q?i2BTZNwFIM9AYxwons0B4I4gWeBZAyKLpU+BhMvhASNE4Y7DgaTBS6YWCKNZ?=
 =?us-ascii?q?pVahV+BfiSBXDMaJIM2TwMZD44hhDOEYMILQjUCAQEMLAIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 xmVBFYf5e7BsfiovPkyDBkPnutSOwDWBurEGw==
IronPort-HdrOrdr: A9a23:crgQ4asDn6JCbDIxWWpCH9NT7skDotV00zEX/kB9WHVpmwKj5q
 OTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BkWyF+rgboOWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:EMThhmPx9Ux1bO5DYQtezUAQAJgee1rn3nTXA3aVVHZ2cejA
X-Talos-MUID: =?us-ascii?q?9a23=3A4JQcdA3c7hCHDeVM36IZoDO12jUjyZbtCVEmjdI?=
 =?us-ascii?q?9guqvBzRZAwedshaIe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,222,1758578400"; 
   d="scan'208";a="131740173"
X-MGA-submission: =?us-ascii?q?MDFlsV9Bqh4zlRSrBv5hbKH0Q6F1YdzOZgUwkN?=
 =?us-ascii?q?bCK59hnRhYCVqovDw1jeCLWZgryJHAl6+94quUSJ0LyBuNsSP0Bi7cXS?=
 =?us-ascii?q?Z6Wr+jtRgixAN+kyeMN3pr1lPojQb0bFGtbE33G2YaH3xjrg9LSG1QXj?=
 =?us-ascii?q?f47zgYjTh2WFfV8Vfevhvmlg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 13:51:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763988628; x=1764593428; i=markus.elfring@web.de;
	bh=FhQgIdmKbTQxoKI+nq85UeEN0e9sut2QP9anR5RMr8E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HG1Eed+iGkLo16kbTvJK/fO14URJ29t01j8kdnXmZRixq7u14EbHNThSdodLu/FE
	 s1psod1fZwGk6+TkQwCZVSywKPEPfR89BbR7031Nn6VNs3kYNveT+yX6+lTqiY0VR
	 acAUREN0HFGomC2AdTHSBFsAYET1BaFT5UNYw2ClnBg3QCAVIUmf7w6I0shmXrJ30
	 idvGtjC+tjnyFLZgr8zIb//Rri9hasLKjn5i1+BjUx0C3JAhYVPKV8YRm+UiBcl7N
	 +iDtGfQV0S/HtD/fEDH+m5mENOCoUftXPMSJE7cN35UR9HMN0pdzxKr5O/v7NX4zL
	 j923h8XNCqfejx03ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1vfb8g1ZNi-00Rj9L; Mon, 24
 Nov 2025 13:50:28 +0100
Message-ID: <71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de>
Date: Mon, 24 Nov 2025 13:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bill Wendling <morbo@google.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Harry Yoo <harry.yoo@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Justin Stitt <justinstitt@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Marco Elver <elver@google.com>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sasha Levin <sashal@kernel.org>,
 Tony Ambardar <tony.ambardar@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20251122014304.3417954-4-kees@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251122014304.3417954-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:amsw7UHqOOQu1W5nt8hwneDl1fOvyTGxaKbM/EvmWg36soK67jd
 NVzD/JFRQsE0ej5GzqAq1hrGR1oQ8nlsAf72fRjlHkFo7IftOxVdsV0XQ9BRvbDDGDe7KyK
 i4HOZGwF3BFySJvKFKdQ9UVTYA6ylOHAlIcJ8JNlgNFxheFoVetTSLKXum3Hirf9fGX9OSx
 JNfJAONi4B9Exo5tB2Ihw==
UI-OutboundReport: notjunk:1;M01:P0:gFNAj9rDq0E=;O0N9q9zOXIeNoPvY7WCp5zB7aZw
 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
 R7dzVIYFj5JrZ0+My9hvasRPbIDNUTdNye/8iK
Subject: Re: [cocci] [PATCH v5 4/4] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3197
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/71d406fb-9fb1-44a9-912a-7a0d270b9577%40web.de>

> Finds and converts sized kmalloc-family of allocations into the
> typed kmalloc_obj-family of allocations.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc7#n94


=E2=80=A6
> +++ b/scripts/coccinelle/api/kmalloc_objs.cocci
> @@ -0,0 +1,168 @@
=E2=80=A6
> +// Comments:
=E2=80=A6

* Please omit such an empty information line.

* Would a field like =E2=80=9CKeywords=E2=80=9D become helpful?


> +virtual patch

Will additional operation modes become relevant after clarification of imp=
lementation details?


=E2=80=A6
> +def alloc_array(name):
> +	func =3D "FAILED_RENAME"
> +	if name =3D=3D "kmalloc_array":
> +		func =3D "kmalloc_objs"
=E2=80=A6

* I suggest to avoid duplicate variable assignments.

* How do you think about to collaborate with the Python data structure =E2=
=80=9Cdictionary=E2=80=9D?


=E2=80=A6
> +type TYPE;
> +TYPE *P;
> +TYPE INST;
> +expression VAR;
> +expression GFP;
=E2=80=A6

Such repetition of SmPL key words can eventually be also avoided.

Regards,
Markus


