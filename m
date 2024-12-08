Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6EE77173
	for <cocci@archiver.kernel.org>; Sun,  8 Dec 2024 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=upOpjnFv0skIJTQmdur7A7QfOzj//Naa/OMZvnPhmGw=;
  b=AMN7zAoRWwwIKQy3JwJfcsBR+63PIlz2DLMrjHl7mak+y/rVw6gQWm2o
   AcaP3tlszw7G1g3azpb5wRKDiOcjH0Cv6vYTwvrQ433OLQKPhceEOtZzI
   SEAWMZwxBfSsZLbcznncg2Tj8bv1W6DZ1bj6Ow477w9WLrQfmhA7v0yWA
   U=;
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
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197938405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Dec 2024 11:30:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E334EE0D1C; Sun,  8 Dec 2024 11:30:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9DA9DE00B6
	for <cocci@sympa.inria.fr>; Sun,  8 Dec 2024 11:30:18 +0100 (CET)
IronPort-SDR: 6755753a_zcwzrA/7+7c76U/C6re4NRIVRe2F6upko832gegV+D+ifXN
 qsbI55AhakAYtiq6clu5o3zKlnTtHLJSZ45WH8g==
X-IPAS-Result: =?us-ascii?q?A0HvCAA7dFVngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIEDVDMEC0iEVo9NgXQwhDuHO4dWiHaDVA8BAwENQQECBAEBAwSCDIJ0A?=
 =?us-ascii?q?oppAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7B?=
 =?us-ascii?q?w4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfYIwAQMOIwevPIEygQGCDAEBBtpbHywiV4FkCYEaLoVrg?=
 =?us-ascii?q?mMBhiaDQnonD4FVRIE8C4J4PoRDg1uCaYJAhgloimyJMYd8UnscA1kyAVUTF?=
 =?us-ascii?q?wsHBYEpISwDMDszgguBWwU3R4JKaUs3Ag0CNoIkfYJNgSUEBYNpgQuDXoRYh?=
 =?us-ascii?q?iWCGhUdQAIBC209NwkLGwY9nCmEZgFLgX/GLjQHgjiBZYFjDJ9aBhMvhASNB?=
 =?us-ascii?q?YY6DgaSeph7IqkIgX4jgVwzGiSDNk8DGQ+OIQwWhAu+dEI1PAIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYsMgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IeOa3K/MAkPKKE2+PF5uk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AbAYOtWmID251b//qDJAzY69mlejXOVf79niXeFG?=
 =?us-ascii?q?zMHQ3Wv6qdWGvyf5mysU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ASyiN6A+171Y7vbsmnhaGz1yQf5hmu+esKxspqqV?=
 =?us-ascii?q?cpdDVMBZqYiiHzx3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,217,1728943200"; 
   d="scan'208";a="197938400"
X-MGA-submission: =?us-ascii?q?MDGVoWyY6TxYRS29cq0Oc3ctzxtwxbA2fMX+x0?=
 =?us-ascii?q?mCJU/6M2VlG/zko5/6f2cKVIECmbZN60bj9yjMYXLPKP8kr14BbQA+HG?=
 =?us-ascii?q?4Hvs/Tva7eCwnga3zXAfAKslfOVhi2LNUU6Kg5Aiy/0rWwxf5s+vSt7n?=
 =?us-ascii?q?UmtfBx7jTsxj5+jg0+gd4Agg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 11:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733653817; x=1734258617; i=markus.elfring@web.de;
	bh=upOpjnFv0skIJTQmdur7A7QfOzj//Naa/OMZvnPhmGw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SccBkJX9d3JUskUkFH3Lqvf+QXWpV+x9jXwEAXap0L1A8YNaamwQfWHDeNrQDVQ5
	 xagntHQzdnbCqwX0zxxuF4x9k63o8OCayEtFSjsSuoWuBpy1iabuUedMuvFlmfZqb
	 FaF5ERJCVBM5rd0ydl8ExFrnwPBUQ5JiL9oJvaN1XdQhutKNhPWSAKbr+9wgTLexv
	 brS9SjeKCwbYvk4/pEs3YrcfJUfu2qcxcLCMDFM3LqZzTIi1C4PP6yebvPoRC/rX4
	 fU+S+Pz+U+PHXKD4p07YrnGr4yj1pcuiPnCTQg61cpPoUutP9K9C5YZdRlMPegeGp
	 EW2JD6t8ay3Dwrqr7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1tobHz1X0Q-00bjZy; Sun, 08
 Dec 2024 11:30:17 +0100
Message-ID: <7058c19a-a220-4734-89f4-b58ec646cac5@web.de>
Date: Sun, 8 Dec 2024 11:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr>
 <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com>
 <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
 <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
 <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QOb9C4G3Kejo_ght3Dgo0qxHW5A6it4GB6TdgoU0Bo7sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tm5uv6abrujyyBmcWBSjtb/cmY8vPWVjCSCGvIWkDCeyy1C7Nbv
 7nkcKaZk86bWyeEj1UxRKwbrAoWf5v0y/OSiICxEtmmtcIUcu5yytofhiZJmunlxdwGiLsR
 h3fFMJX7UHB0YFDztbjEg5zWkbTp4+n4WZjKXYi4hYE6pCX1EVeoScXSXHOselS0ao2hQUN
 a1t7YvjNqqIEnXlox3NNQ==
UI-OutboundReport: notjunk:1;M01:P0:1dw6aHhGlbg=;+UUAVUY3TQReFT3zautZDONaf/g
 gqHHR/ebObCPm4WEU7dsa2x0yBLuXHjdw/2vy5PA2VJudCf0dGxJd9BBqB7CFDKfAiuEGBPMD
 9VqmgZ8SC74K352o0+j9cPGlxEfoQb79hmBOFfNOglxvKfGHf6w2BmGzwTKngByjtj4vT7U64
 2vF5yGUpIDarP6iYJs422nGclwbU0MH/ytaO0mvUxYlx3C6EJ4DBKErejJVF6gi1I/ewk+e6U
 0WYTBNyjT50P+Lgztc0ltOPK4k2lbd1xHDa/CRdRbnTnsQlEwqe+Mn86UdeeAWEhK1QwUd8nx
 4vsLUb21A9wFu0/lDKHDzz9qgW4gbd/aaBkdGecJLBwO/jsqJqSXWc/ylmLQlhhIJmIJ2QcI0
 DRC1GXcWq9mzl7KjbyEFxaTfOuqpTQhrgL1cKPOGgevFhmtrNYCsQThmBE6pAzl+d5+aMdC25
 bSr0XinQLZXL8Do+gPtjBg71CEZ7k+NsdYc8IKJUJNH20qTZ9eOzpfJS5fIsJG7AWfrq7lmot
 +GfLMLp5mwnZ7zV38Vcir2HhBETK6AnvkEnx5M2HzRxAnHColo76rVpw6VNFhfENViYiU2Xj6
 PQeDAcxrutlKoQcOEYDvnxgcrR9nMJDlQ0RsJEa7f1hDdqGi0Kv7IkCW65LoBZ8OsjcqH5OGH
 PBtNXPrQY3H/NwLiONs9arDc7q6DS6TrAaheZZALHmf1PMohkiGzOJkQ4WrJeAq2viPQctxj0
 dah3DWokyyFj1m4SeN780b2UyDi1c7Fd3FId9cVd953ymx28r9fdwJqK83+7uaVTcKz5ZkGjU
 9Uw8QfgqdxmkwSWamHSyXOinldA8Z19pIEEy5yHkQxPbABxuD2WvTx8WUBW4/jccot6G7ZXnm
 O5SSggcDOlURguyKydMoS16RbnNgGICsxMG0HgHK9lwXFWUU9gRUZO0f8NxjJdMq+drD3fk9F
 t8rFtxgu6RLOb8zxo0jaJLhyCxbIkAOpaMvoNMLvNiimo9mbHek6I/0A6wQciNdOqRq6oFyKI
 J/CdnphXH+YKMdrjpwKQC9W8bDp1Qr7lKHQzOXqTj7P/aQlyBwON+suT7SdDqru8l1QuAdPm+
 8EEUtp+Ig=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2166
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/7058c19a-a220-4734-89f4-b58ec646cac5%40web.de>

> No worries, like I said, it's not a big issue.

I got an other impression also according to coding style adjustments.


>                                                I don't quite
> understand what you mean by "match the function definition".

Please take another look at metavariable types which are supported
by the semantic patch language so far.


>                                                              I need to
> match basically every non-keyword in a c file, because everything
> needs to be renamed: types (i.e. struct names and typedefs), variables
> (global, local, static, const...), struct members, function names
> (both in the definition and declaration) plus all parameters (types
> and variable names) in signatures of those files. Every one of them
> needs to be renamed.
>
> With:
> @types@
> type t;
> position p : script:python(t) { needs_rename(t) };
> @@
>
> t@p

You are trying to achieve something with a very generic source code search=
 approach.
It seems that you stumbled on special data processing challenges according=
ly.
Further software design options can become more interesting then.

Examples:

* How do you think about to omit a position variable here?

* You got the impression that a scripted SmPL constraint would be relevant=
.
  Such SmPL constraints can not offer a new value.
  This can be achieved with a corresponding script rule.
  Do you find any information helpful for the software component =E2=80=9C=
Coccilib=E2=80=9D?


Regards,
Markus
