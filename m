Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15D8C3DA6E
	for <cocci@archiver.kernel.org>; Fri,  5 Jan 2024 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dbP2WVII3kewsx3+qfAiHA2PFRrBQ5DPMQnJ6GzPKZc=;
  b=ZPkzOHRN7gN5t7u/3Xuuu6McgCyFBn8A7z+zISWpN6GnSGbKhyjExACv
   R9xRrpZkUQ0GNf8r2XQwXoDDZbaMYyEeExN5RSXNt5eWwLgHngP32a+tT
   8c6fogzrJZ0rh7PcrjMNJ4YChgxTiZmW12exBsku+NDcWvE91VmXGA010
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145141532"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jan 2024 21:32:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CDF82E0CCA; Fri,  5 Jan 2024 21:32:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E1C98E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jan 2024 21:32:06 +0100 (CET)
IronPort-SDR: 65986746_neB2DhEewsOJ9g6wTEmYhy4thF7d9VPwQjOaViqQphV35pz
 D4jsaJSSgpjfbzGEo88dREVo4kn+qgK6oQQCw3A==
X-IPAS-Result: =?us-ascii?q?A0FgAAB0ZphlhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4fFYyBAtIhFORNi0DhDuTbIQEgVaBQD4PAQMBDTsGAQIEAQEDA?=
 =?us-ascii?q?wE4gVOCdAKHOgIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEjFwcOBQsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkIBAgIBIwQZAQERJgEECwsUBgImA?=
 =?us-ascii?q?gJWBgESAgEBgnwBgioBAw4jBw0GsQ5/M4EBggoBAQaBRQIMAkNOrHIfLCJWg?=
 =?us-ascii?q?WADBoEaLgGIGgGFZ4NBeicPgVVEgRUnC4J4PoJhA4Ffg1uCaIIcg0KPP1J/H?=
 =?us-ascii?q?wOBBQRcDxsPHjcREBMNAwhuHQIxPAMFAwQyChIMCyEFVQNABkkLAwIaBQMDB?=
 =?us-ascii?q?IEwBQ0aAhAaBgwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2UfGBoJPA8MGgIbH?=
 =?us-ascii?q?g0nIwIsQgMRBRACFgMkFgQ0EQkLKAMsBjgCEgwGBgldJgcPCQQlAwgEAyspA?=
 =?us-ascii?q?yN0EQMECgMUBwsHaQMZKx1AAgELbT01CQsbBj0ClEoBgjdTOyoCICaBTTeSc?=
 =?us-ascii?q?pMdnnI0B4I0gWCBYQyKGJUTBhMvlyYOBpJULodQkE8gi1SBdpp8gWkBM4FcM?=
 =?us-ascii?q?xokT4JnTwMZD44gDA0JFoNzgQuDVopmQDUCOQIHAQoBAQMJhUYBAYNagUYBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:EckPRKOfGWloscBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A3ygVBGgSyp2/w5YyWe+tZXwx1TJuSSPNy1f9f1S?=
 =?us-ascii?q?BLX9ATqC/EnyOu79eup87?=
X-Talos-MUID: 9a23:kj/LlgYXJrtPruBT6mTr3SFPaf1U3YOkB2wLks86o+PYOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="75984365"
X-MGA-submission: =?us-ascii?q?MDG1QpLQTtpv/6emT9bEf5PtcI6C2E9Q/LPrf/?=
 =?us-ascii?q?PwERuknmD5+z9I7moRFbLkHjLeTpVDxig8AB0YFBVl7xw9uZ8j13Q6of?=
 =?us-ascii?q?OitxzjV+TYg4xzjfA0MyXIHmIngfikonuoDH0IH4lfezFXX2HiIOMyZE?=
 =?us-ascii?q?Lfcqc0YslKuWwSMpC1jzJidg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 21:32:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704486725; x=1705091525; i=markus.elfring@web.de;
	bh=XGJHY7BedW17ZVM0oJStSYNJNEGaJoAYc7/aRbjvsHk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nZhuiscruCjRi7o9uQUzT7emYJry3MpX8LYVmegrvIMK9eUKV8PQnO1tjibz6A5T
	 qmTUdVb3Q8zrGHA5TqIY3JEFGHTekMk8TPPEGvix0SIifr31K0dtkzk+DISGzGI0H
	 YkIoS0NvOJAH8n2U58hh0XyE3GYYH+5lEr44zA5jkIkbFh0oAZRCY2Hf4OZyxqnD+
	 VOpM2TEQUjUvLFiqyVdzWAo6hyYxxs/zIgqnjoVdzmqELX9igW5M3dcBVM/Js5Hs/
	 9k2nf8XUYp8gtiVuETI/6Cz+YbHqEwRRSDIqeIk+8B/5fHuvDp314xi/d5E+O+6pc
	 umhbXxM6ws/ijYVomg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1r9nfM3ug0-015UC2; Fri, 05
 Jan 2024 21:32:04 +0100
Message-ID: <71892e93-1545-4d04-9570-a15672f60e81@web.de>
Date: Fri, 5 Jan 2024 21:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de>
In-Reply-To: <f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Da2fsFoH9DyjyKLEhNG5crxXXvNF9eQ324haxaVQO6ouX0qrq4p
 FoNEhMV+Ywrn993YlIs6lVdmca+/cViI2F9a6pXEf+MEGmOh1FmuYN0LM3mw4ote1T8siDU
 PCjwfOXktl9gL3xQ2tMl/PXTYuXmv5lluB5LdlSYmPYtzeDddRsACp+HkvL78bc3AkBMofj
 PU29q75GXd8fRwwwaLsOg==
UI-OutboundReport: notjunk:1;M01:P0:PrI7ZW5BXWo=;rKRQjP/bvgnDb+9M7QFvxNffpeG
 3nLrZqmPUGvofAN6ogHB8IeUxhRwGYW54sjhYh6qn33T9LW4At0WBlA4qsTc1hFOcQEJiKe46
 o87JoNVJGg7FcGuzxyallP8ypIdzNV4BL4v0yo2yepmoC9sndWGRpXKa8WSPWMKWRC/XLiHmS
 5A2vWqm0oHqHh+t/YJYbUbquHYxv4Z9jF4u4OkyboXz3P/kWyMoONQKPp74CqCv6imOS4nQEI
 /Th+80fPjtTrNK0CtE6APy0ZUx1v/rhji04Mt43an2a5E3fYNWUJQJHqppztkP+H3N4q7vrNh
 sAFzqVoqEzhftCB0xNk+DUbjiSo+cotgO8fuPgeWL6/AGLFkCr8ZBHHAYKUsS2W8y6lonvwF7
 k0jKB3vQxU/p/vG2Tve4ck2FuLVv1RvYnxPsRZ/5uyAgG7XBcCGh5zMzyyJUekHY66iVkgfBz
 Ez9Luy0acgWcTnT8HEOHhAbjEapcOaNldgpeKk+HcyBVmLF3O5uSC7uJjyv9Xh5S+aTvKSMqm
 G4+2tfBcMjMjCBR9eC2+HQwk7cSFW9+GlHgwF9goJO3uBpUP+bc+ErETWi5URwktt0OOhMp/q
 00GaBNbabX7z6pokXZlJkNUwH0PNRi74xvHinQ1pOscvsv/b9Tu7tPrC8f4fPmOyktKtVVD0D
 mtMCul58YjzqrQ8LepEcd8aPaK2q9EI/oqYZqHrDe3CqVjDRrkDKwzaeaK4hFmRNi3S9rMUBx
 Tg9N5ZnmCIcQDFULcG7TQFgOe4ue6SGC+6n1CphwvmqRBwAri97wV4lZMGt9YJCtZpTJPFk4U
 kIvAc9rLTe6Zj9sMmOHMIwvWbqUg3gtaVouf43zeylfNZz0wPy6mzXNKGa/7Tqmg7daiqFmw6
 CuEXaKkw3XXIn8xQt4GUEGLWBKAywj5QVO9EMgLxLKu2d+0gf3DzvGuVr1gtHPwNpt+/vj5tr
 rhbIBgNcAApLfOAeUAsIEsP1wEs=
Subject: Re: [cocci] [PATCH] squashfs: Improve exception handling in
 squashfs_decompressor_create()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1436
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/71892e93-1545-4d04-9570-a15672f60e81%40web.de>

> Date: Thu, 30 Mar 2023 18:03:47 +0200
>
> The label =E2=80=9Cout=E2=80=9D was used to jump to a kfree() call despi=
te of
> the detail in the implementation of the function
> =E2=80=9Csquashfs_decompressor_create=E2=80=9D that it was determined al=
ready
> that a corresponding variable contained a null pointer because of
> a failed memory allocation.
>
> Thus perform the following adjustments:
>
> 1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
>    at the beginning.
>
> 2. Use more appropriate labels instead.
>
> 3. Omit extra initialisations (for the variables =E2=80=9Cdecomp_strm=E2=
=80=9D and =E2=80=9Cerr=E2=80=9D)
>    which became unnecessary with this refactoring.
>
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/squashfs/decompressor_multi.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor=
_multi.c
> index 416c53eedbd1..0a054ba4c541 100644
> --- a/fs/squashfs/decompressor_multi.c
> +++ b/fs/squashfs/decompressor_multi.c
> @@ -62,12 +62,12 @@ static void *squashfs_decompressor_create(struct squ=
ashfs_sb_info *msblk,
>  				void *comp_opts)
>  {
>  	struct squashfs_stream *stream;
> -	struct decomp_stream *decomp_strm =3D NULL;
> -	int err =3D -ENOMEM;
> +	struct decomp_stream *decomp_strm;
> +	int err;
>
>  	stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
>  	if (!stream)
> -		goto out;
> +		return ERR_PTR(-ENOMEM);
>
>  	stream->comp_opts =3D comp_opts;
>  	mutex_init(&stream->mutex);
> @@ -81,22 +81,25 @@ static void *squashfs_decompressor_create(struct squ=
ashfs_sb_info *msblk,
>  	 * file system works.
>  	 */
>  	decomp_strm =3D kmalloc(sizeof(*decomp_strm), GFP_KERNEL);
> -	if (!decomp_strm)
> -		goto out;
> +	if (!decomp_strm) {
> +		err =3D -ENOMEM;
> +		goto free_stream;
> +	}
>
>  	decomp_strm->stream =3D msblk->decompressor->init(msblk,
>  						stream->comp_opts);
>  	if (IS_ERR(decomp_strm->stream)) {
>  		err =3D PTR_ERR(decomp_strm->stream);
> -		goto out;
> +		goto free_decomp_stream;
>  	}
>
>  	list_add(&decomp_strm->list, &stream->strm_list);
>  	stream->avail_decomp =3D 1;
>  	return stream;
>
> -out:
> +free_decomp_stream:
>  	kfree(decomp_strm);
> +free_stream:
>  	kfree(stream);
>  	return ERR_PTR(err);
>  }

Is this patch still in review queues?

See also:
https://lore.kernel.org/cocci/f1712777-97ff-d89c-0bdd-d72faed9a7f1@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00120.html

Regards,
Markus
