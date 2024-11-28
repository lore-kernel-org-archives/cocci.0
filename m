Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE305D690ED
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2024 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TWBUkhwgImoQ2cktHCo0QBuK1XWlibVs28UM5Fbdi9M=;
  b=qdIM+Of/N3TA2wZDKOYFlOlQRrVtM3s0EGGTQHKswfF3LG0nJwE03Uyy
   MsKE3YTEq6P0WZye+8UDDgpV3nJW94/z/7WqzysxfGTa+cQTkeNPw6Czm
   5b4r0egmLcxgD6NsESa+J/yZTPYnz44hf5CTHa6yvTdcu9NM8EqlMQoiR
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,192,1728943200"; 
   d="scan'208";a="196254270"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Nov 2024 11:00:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72065E0D1C; Thu, 28 Nov 2024 11:00:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EF739E00B6
	for <cocci@sympa.inria.fr>; Thu, 28 Nov 2024 11:00:26 +0100 (CET)
IronPort-SDR: 67483f2c_pl5UYGDUwt6HnA3HvF/pnDewb07pRXjR0dZcgDAiJMAG1+u
 w9MGNUvI2x7C8s/6YqBkGoC6QR86Y+HbJjne/YQ==
X-IPAS-Result: =?us-ascii?q?A0E3AADVPkhng07ASNlaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDYhsGVDMEC0iEVogdhzCBdDCEO48RiHWBVoF+DwEDAQ09BAECBAEBAwMBh?=
 =?us-ascii?q?QACimMCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBOgcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfQGCL?=
 =?us-ascii?q?wEDDiMHDQaxcIEygQGCDAEBBoFYQdhCHywiV4FkAwaBGi4BhWmCYgGGJIQ8J?=
 =?us-ascii?q?w+BVUSBPAuCeD6CYQEDgV6DW4JpgkR5hBaIPWicGFJ7HANZMgFVExcLBwWBK?=
 =?us-ascii?q?SEsA4F5Tn+BNoFRAUKCTkqDLoFeBTdHgkppSzcCDQI2giQkWYJNgSUEBYNrg?=
 =?us-ascii?q?QuDXoRchjBEHUACAQttPTcJCxsGPaFRR4QtWYFFxwY0B4I4gWWBYwyKKJUyB?=
 =?us-ascii?q?hMvl0MOBpJ6mHsijWCbKIFnOoFcMxokgzZPAxkPjiEZhBSBC8ckQjUCCTECB?=
 =?us-ascii?q?wsBAQMJhUYBAYtXgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Iavcoa1yc9CF2avHQW15bgqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:GOqqW21HsEx7s4EPNCM0lrxfEPonS03EwXLpDFaXNX95euWeeGS5wfYx
X-Talos-MUID: 9a23:J4HKRAhc4sz6rnUXWbmmDMMpO9143/ueOBs0jNY6leS4OhBUPTmvpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,192,1728943200"; 
   d="scan'208";a="196254192"
X-MGA-submission: =?us-ascii?q?MDEk832X2gjx3qn0lXdrUzUCGc8JIr4xI55o4r?=
 =?us-ascii?q?KRxZoQxAluzzZrpUBj6g4MJIQwvXYYIeOHY8wLdxaVPYXfs6+mJtCFua?=
 =?us-ascii?q?b8Zc0Kcehe0NSpUh2A0GP5aiCdrPAqktgFMdlpec0Z/wLFSOuad9F3xx?=
 =?us-ascii?q?GawvDnY4l8vT4qEQbjYR18tw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 11:00:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732788011; x=1733392811; i=markus.elfring@web.de;
	bh=TWBUkhwgImoQ2cktHCo0QBuK1XWlibVs28UM5Fbdi9M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bf+eOhbYg7Rb7kTtbne+K9yPb6aSMJX1usKWIhx9agZyGJep5u866eFI7NreGKK1
	 qWXFfd8nDnjVkdhJB9ahZ4eunMlMar7jpn/rNww10jbrQWA23QCSfH2ua7SPZ1baj
	 5/yoM2RjjIcNSDQtdk7zrn8yXj1Y1yl3bv3bGZiHyR6pJDkknDWxcwFSbqvfX/0hf
	 svNO1Dha+LdY+jcyzVs/vNQbExbzQjS9EOWinPhsIOUynm1dmiVSdGfu4WJDnyLAn
	 YXvacQZC5hryQ11tZo81g5YJEWgkoMGxhAbny95eqwRj59OBybUP/50wjdan8VGPs
	 Cmzqg12TeNNrsp1PRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QmF-1tHyEI35Gf-008PMR; Thu, 28
 Nov 2024 11:00:11 +0100
Message-ID: <df41e295-2786-470a-9183-7016fb551e00@web.de>
Date: Thu, 28 Nov 2024 11:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <81d0c6e4-0d7e-4f40-99e5-d4229613348d@web.de>
 <CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS=nf=7r9sz+wCDopA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS=nf=7r9sz+wCDopA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTMjim4MZh2uMFOLNyt2NBS+t0vQ785GnYDBYPzdQnYDehaLDvU
 /W0hhwR/0CHANyQ40SOsy1kZpwAfHhmPD2eko/gGI+Y7hZbWAlo6VbxxoviSQqjV67KDu7a
 nYsytB844adrtmuZNZd4xYPGEfovw3/61fqQHs/y3N1SZ9+I1UDuvXRWisdB5zEyGCqBxwH
 CYxxrGrAyqaSXSO4now7g==
UI-OutboundReport: notjunk:1;M01:P0:hbLgRrSBEl4=;n4b92rU4HlZ7ltiWq358w2eBS1A
 VRfOmHlFyZmmuJk8ZmoQsfCTVO6mjO3ibs0nUxxW3HfzRMOEr+hnWmEjIOCb4ak1Y4oKoIKAp
 tczlx4YZc7rk7hqvxUfF5DfXcOHFtdgdLHNIljtQfYyCUrwH66hV/T/a/pPm5ngUPTTFsQC0B
 NhRrBMLe/KlwJvthJOb9Bjf1+eP82o3MUi/zY2ZD1hdPQRUku9si2Df7YLcbi8cAGSoezlKni
 WgWW70bcL35dOtTIRKefPNb6CcaKF7TaVctnWNS+0HFsJ/fp3zUjzu/7dshvt4/FolRo44XVi
 LbVb13CAXnmHULnp7opRanSJ5YzGzVsx6ohoW3G/5iiYeokQ1W7gW0rQ+DZ0aiUv5mND5W/zf
 wWodHYi5dvM5w5RpqlF9uiY7q44+aPHZNAaXF0wQmioRhZuCWqQSDVUmnB8kFk/b4QgNU6Xsz
 /Y43lO1yQ3jJXVTrfdrRk7WupurQZWukvhCqeEHf44U8W8EI2aKFJu1YIwB4wz78vk7d8fj+I
 8EZ61d+Rhw8UF9ShEJeg+A22fFViSv6JmWmpo/vuHnZB0GjxJDmfBWQFOnC+V3abu7zPn6c2+
 3xklQpZzRKJ0NZu2P0q/FeytqkbUD2gDrqW8OQ9jFm08lVyIXg99WstJogVMRYAQRC0waZGcb
 wgSwkqWo5S3d8dltt/2aDRZ0KKULXeV5D0LRW/acmwmklvR8qmaHkLn/9WCWxqzRtMHn6V+Gv
 RPMLR7XUtcqhMAj9FziQYLNvtKETgpffS9e66AjiT4ZdYFpmcT1wu3qzwSppD1Hg6NKJ8D8mc
 L3VUhrvKk2NfGhg2RviodxV4XMtjl/QTbexFxkw5bsobKxCdeGGbFb3jkR6VEqZoD+FBNUaRL
 qPI+v9vPjjymIDThQx7iRHdWbQ1BNqxK1DsXgD/tdyrGUYkqgH9J5o+cPUgr/pBj/6/p/o9eX
 pLL/qIZeIFdrVmdv8rHiA4WuCxXDsjyZo2JuNNCxni9GSPz2xTMKgb18vqsUGqvk9O1xL+yQ/
 G85wCuDNLCZIsZAjHBnUWJM66gJbfGieP16tNrae9KMm/rZDaaJN8qWo77jhGYM9RgC3eNgdJ
 ipdeEegeI=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2138
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/df41e295-2786-470a-9183-7016fb551e00%40web.de>

> I think in general I'm just wondering whether it's currently possible
> and your thoughts on doing this. In general it would seem like if we
> could get "fresh" modifier on type and function that would solve the
> problem, i.e.:
> @replace_types@
> type t;
> fresh type renamed =3D script:python(t) { camel_to_snake(t) };
> position p : script:python(t) { needs_rename(t) };
> @@
>
> -t@p
> +renamed

Will you get further development ideas from corresponding information sour=
ces?

Examples:
* https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99=
dabfdfa337b34cbaa9ef1/demos/pythontococci.cocci#L1
* https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99=
dabfdfa337b34cbaa9ef1/demos/camltococci.cocci#L1
* https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99=
dabfdfa337b34cbaa9ef1/docs/manual/cocci_syntax.tex#L655

Regards,
Markus
