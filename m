Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EBEB64D7
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EUFTkXc4Lko91rPmsr4tu96UuE9dXpGqHGDv3T6H6fg=;
  b=XSWINm5M3RdtPzAlOKiDmwHsQG8VDp46fSe7zImK5q7QyozHlOL7nz4v
   bBPjgZY6S4v9zscSx+8drdGArn3LBzU8jo1pjskcp3X+WHX7WHXHoPP8i
   W2W6wNT/P9dtw93AVCv3Kb48L3mfUKo3mtnMVjqaLKbOsZ5DsAnzE0rfh
   I=;
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
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114430150"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 18:56:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39292E03AC; Fri, 23 Jun 2023 18:56:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4CCC9E0157
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 18:56:33 +0200 (CEST)
IronPort-SDR: 6495cebc_Zl6ScCGHYNdvDjKTOXuqfZ6qYhSNESGC2gMnQEdMlUj+4ko
 RH9Nylu7tYbjQ+kCw4Id+1f0J/2LutWGKvrJpnQ==
X-IPAS-Result: =?us-ascii?q?A0G+AAAozpVkh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydQNTMAQLRwOET4gdiQeEZ453hGiEBIFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwSBSwGCbUYChgYCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQFAQIQAQEBIxcHDgULJ4VoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBEgINOj8DAyMdAQERJgEPCxoCJgICVwYBDAgBAYJ6AYInAQMxB?=
 =?us-ascii?q?w2vcYEygQGCCAEBBq9SHywiVYFfAwaBFS0BjTCEMycPgVVEgTyDBD6CSxcEG?=
 =?us-ascii?q?IFGg1uCZ4ssDgyCZ4Mzgi8HjAGBKG+BHoEgegIJAhFngQgIYIFxQAINVAsLY?=
 =?us-ascii?q?4EcUjqBRgICEScTFAVOeBsDBwOBBRAvBwQyCRYJBgkYGBclBlEHLSQJExVBB?=
 =?us-ascii?q?INYCoEMPxUOEYJYKzY/G1GCXSUEDgMZKx1AAgELcD01BgMLHwYmAR4CKYFXM?=
 =?us-ascii?q?FZwCiQkoEoDhF6BRQjFBTUHgjCBW4FdDIoTlQkGEy+DbgGTJg4Gki8uhzqQM?=
 =?us-ascii?q?iCNO5VShQyBYzqBXDMaJIM2TwMZD44gGYQOhGGKKAE+PzQCAQELLAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:XROG0qDXjITFO//lHel455DYdb4zR+YMi2TDGXoBLiC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO0s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEJSWY+eAb2SS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3A75EvpGuotIENYMOu15WG000P6IsnXHOHlXnbIHP?=
 =?us-ascii?q?lIn9vceTEW2aQ0o5rxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AwktaZAwnDMpMPLFOm/kyKNF/9bGaqLupEHsmwaw?=
 =?us-ascii?q?tgJe/CXJPBxaG1DmQYZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114430139"
X-MGA-submission: =?us-ascii?q?MDGh8Xaabl7ggEAeHFpQTiYkNnxX+mimlgFZXM?=
 =?us-ascii?q?VafbWVJ/bvhpJDIz98uZFZHLNgiChB1nef//+gV1C9UV7EDjx7oJH1a7?=
 =?us-ascii?q?oPTjOGExE+4e7YcdM609Tv+ci3vFrHl4bbO7/cZaYGkmO6MBIUDG9AWC?=
 =?us-ascii?q?h3e+KkHuXX/7pcYT5NF1HfRA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:56:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687539373; x=1688144173; i=markus.elfring@web.de;
 bh=EUFTkXc4Lko91rPmsr4tu96UuE9dXpGqHGDv3T6H6fg=;
 h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:In-Reply-To;
 b=flEWMgyDK6gN58A/B3EUzoqpsqB7rsjVSkZUZIAlpCxgsLcRrqk21B7RcZJazxPPhIOIywW
 AvewagvsPZuH90xaTxsuTxcijMCXXB21A+oLbdnu+qWMfJoA88N5TSA3l0G+QHwyzLrhjC6Fq
 KoKvTaN2f4MVngFzzsJpoJN5Ttl6JDjpkQ5LBWwKvrZIivV4hquMf9XS88C0JRrm9p42NzKQz
 Vc7DKjKahi/rYIizNLTyB/cV7eizuHb7ZzGp8GXMSGIW1IKqoGA4dlusD5pU6fmd7bJj7HXJK
 1WGlyOzdDx22yGlJ8Lokps4BSc1CZQzH2TY9U61DtuQYk2YM5DBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MftBr-1pawQG0KU5-00fnrt; Fri, 23
 Jun 2023 18:56:13 +0200
Message-ID: <2b1cec46-52a9-21f1-bfcd-fbb4298f072a@web.de>
Date: Fri, 23 Jun 2023 18:56:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 spoorts2@in.ibm.com, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ian Rogers
 <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20230622101809.2431897-1-james.clark@arm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <20230622101809.2431897-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BrekUSIMuD8aFBfeWVx2vUik0YFQph3Ha9JAGJ6QlBbY6oeWDcB
 vPhUg9FA4xanm0/8TkLRJd3HKq38lb3Sr9JvlMysoGsbA7B6eozX8UtL4mI/fviaYm3Bt2r
 Hk0ZciQePwama+c39RzDzyq7DXBw5u19v0/BbJ/jEQdC8JICbgcAD0WMF7bemmJ7NkUQ8it
 fbhVRegNPTopMTCtdUdHA==
UI-OutboundReport: notjunk:1;M01:P0:fPl+R2RbXEA=;CSCq087IFi6voIYVBImtsu61NdK
 6i48FLNC7Vr1qdu6T69Yf49TrQ36mubndL+KRCIhEmw/XO0/XBC1NYi1F2yes/A9x5ionCS4f
 UjY8mOKPO3QzLRtlu+d5qp0Me0/M6ilfKAGqRDtRvGYjHNHn2YyE44JNqdkQFkqzTeoQiTi5A
 QIaqJgedqrZNCK2MMF1zIINkcsG7bnd7YT1ozwXUIl6hrgRwoFcNtIeu46UaDFTlqYmxb3+7N
 5oGUWmUXi6se+KhDqvs+dfXE5RXYIcITm3p9JKaOBQxxtKAlU7zIxJNS0ujot8jYB15vD7QyK
 r7dspz1qxojnvpVdONKiLJwokumIYaUVSjbrNp7dk6gK2q5/eQJTcK02pfdxR9uSFYQn+rNVI
 9V6LPQE711KY27tdt3fi2pM/t5zgXvNdfDPwV/F67Vo/4LGWK6RNE+nr1QduSoLglby+hHrsS
 DfT0ZJiw/MFlqdQJMF0Ijr5IuIAzDLLadWbRQYlxu7GGddlfbOL7B1xFasQ6WyNBMvAun+tVp
 Ej5qBi3oaB4wobj+iM9354VXQN4wwTs9UgdDEWvruyHRuJSjZpqqFf3RQaN21rg6Sk3jHv8oF
 q9MOj0OGGQzKZgPwQgWXnU9hLt5mcUUeOem4NxDajIDH6x7CYVgdNeUtkUGH6WgiO5kvdeob/
 AV0aclmzf3Auwcw2L/2P9snPZ2t2CdqddaTqGciAU0bczfNUxiL51iV2oKz3Yz+iLOdRE+BQy
 L+LuzlJuVbTAlLXcegVHLUn8nAfJiCzTKXtueUXuF71TN+GZLFp9hVDJZzCVUoJy0Dfgx1iA6
 vcIO257KT70joO46L52MJXr/5EQc+Fev8e21A/IFCUUxQmi0JRNrJIC2u2YFM6Xmag4GRshWS
 4wqlGFM/lSVD0m44FbOpnZY8bOLpQVEvigSuFyWjfEo8/BpwVvgaXVdoaDo8sdbLBjRz2ptis
 Vd25MHugGUbREFShAoXj7gs3rxM=
Subject: Re: [cocci] [PATCH] perf tests: Fix test_arm_callgraph_fp variable
 expansion
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1211
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/2b1cec46-52a9-21f1-bfcd-fbb4298f072a%40web.de>

=E2=80=A6
> At the same time silence the shellcheck warning for that line and fix
> two more shellcheck errors at the end of the script.

Does such a wording really fit to the known requirement =E2=80=9CSolve onl=
y one problem per patch.=E2=80=9D?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n81


Regards,
Markus
