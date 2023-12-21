Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB7C35274
	for <cocci@archiver.kernel.org>; Thu, 21 Dec 2023 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jhKhu1UvORMqQ9VSDe8/nRQe0vFmjIK3SQz7sJOm4P4=;
  b=dxOGuFVRZK+ePMVGGURIhOITC8taCuqeXF2kJ3O+le9sr/8tujy4Mtp6
   FcZgV22R5aWacssx/ujyoMN0svvGp2eW83LzB27GFz/9OsYncZ2NG4iED
   BchpdXQh9Jt28uVoAvOC6O5o3eSkx9LaCZFbsm3fBVHSVrbnmIde2Mrdn
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143522722"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Dec 2023 12:16:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C063EE0AF1; Thu, 21 Dec 2023 12:16:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C3478E004E
	for <cocci@sympa.inria.fr>; Thu, 21 Dec 2023 12:16:51 +0100 (CET)
IronPort-SDR: 65841ea3_n9XQlgdFYV1AezPN46R5nUKWF49dLS0muAA6SCvHtGPXTf4
 pY8q9uA1f2uSWJGESmM7+19wDk2ET2WHzOWKh/g==
X-IPAS-Result: =?us-ascii?q?A0HlAgC4HYRl/w4P49RagQmBT4I5B3UDUzIEC0iEU49Bg?=
 =?us-ascii?q?XUwhDuPAYpFgUA+DwEDAQ09BAECBAEBAwMBOIRHAoc0Ah4HAQQwCQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkIBBAEjB?=
 =?us-ascii?q?BkBAREnBAsLGgImAgJWBgEUAQGCfAGCKgEDDiMHDQauHn8zgQGCCQEBBq9YH?=
 =?us-ascii?q?ywiVoFgAwaBGi6IGwGKIicPgVVEgTwLgkcxPoJhAQMBgV2DW4JoiR0Hhh6RY?=
 =?us-ascii?q?lsiBUFwGwMHA38PKwcEMBsHBgkUGBUjBlAEKCEJExJAgV2BUgp+Pw8OEYI+K?=
 =?us-ascii?q?zY2GUiCWBUMNEp1ECoEFBeBDgRqGxIeNxEQFw0DCHQdAjI8AwUDBDMKHQshB?=
 =?us-ascii?q?VYDQgZJCwMCGgUDAwSBMAUNGgIQGgYMJwMDEkkCEBQDOwMDBgMKMQMwVUQMT?=
 =?us-ascii?q?wNpHxgaCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJX?=
 =?us-ascii?q?SYHDwkEJQMIBAMrKQMjdhEDBAoDFAcLB14DGSsdQAIBC209NQkLGwY+AieiP?=
 =?us-ascii?q?YE2AYNyV4FmxQo0B4I0gWCBYQyKGJUTBhMvlyYOBpJSHpgvII1KlQaFc4FjP?=
 =?us-ascii?q?YFZMxokgzZPAxkPjiwWg1YzgQuOPEA1AgkwAgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hiqmzKzudnS/rmBt8ZOdKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:4fXbPmMjP5+h3+5DQyYk5V47BPweU2T67XuKCmqUM2FPYejA
X-Talos-MUID: 9a23:dR6PsAkclnUS1FeSuIkSdnpELOMzzYGLC3oMvptYvpKhHDxzPTG02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,293,1695679200"; 
   d="scan'208";a="143522710"
X-MGA-submission: =?us-ascii?q?MDH5FWnNiODh61xlo2M7v27/Cy50KPitGlOgmH?=
 =?us-ascii?q?NPW0tFLjtiTiCmn/ty1G8y5xb0sM8Y9BbE5RQbNzYq31M1GxwM46oy5/?=
 =?us-ascii?q?kC2zoXQHh87SQgPQxlwjgB17JTDTI8MAEx4OnzsIzvYbbfZ84ILpevr4?=
 =?us-ascii?q?0idPFlKNEZt+cVVYPxWQVnsg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 12:16:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703157398; x=1703762198; i=markus.elfring@web.de;
	bh=Nk165+eaqn39G/02St1MR9JIYKDpnRrJ996jzIj9KLE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=lDqhF2hmqTohF0VqnA4r+AU3/Sez1J5ZjmPj3CXsUzEybosF8rYpcYRKMxeKl9l0
	 xU+dbrN5fLC23Il8Q3MiJS2iGYPhdn5Hvaw0z1CrvcxMCxJDV8t68ADRw2rt41Yuq
	 usuo8YiROZlnlu5iQmspkuApeSx5S64lnZLP0v0CDCiqzxFkC0nNnxGKsMo9LenXP
	 nkiqn4LqipMDDtYU17Ah0lNWtd4DLfyq2pcDNq9jAwyQXho5zWUd6tdfWDBeZuh4h
	 wQu66veUbBysKhdMubYdAzUbQvb/5GImqVgUqRnr9yjS24aYXvzJ2MS69Qx22j/aD
	 z3pTdO6fFEZmeKtLtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1rPei42ViE-009olx; Thu, 21
 Dec 2023 12:16:38 +0100
Message-ID: <0ecaecf0-6a50-43b1-8458-59d41bc5fd37@web.de>
Date: Thu, 21 Dec 2023 12:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 cocci@inria.fr
References: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <db0e2b-9ddd-542d-5a59-ed15ffd594b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pLHBhm5g0DL9ZqPuy6iCPkjpXb8Dk/gVlIXmaDbBmCHUWNoIxzN
 Y2beSahiqJr7QkQs0IrHl8E577kgs4JpphWM0Ou1yox6owOQoODZyfkN87oMzoPIj102rwS
 mpDRASxqxLqaWUYqu6kVZWU7ZEWjwchU/JlCJagGA99saDd9MLNSomVRMQtZ7n2pPysPblj
 zXm66oCtYZaPM4P2BlJWg==
UI-OutboundReport: notjunk:1;M01:P0:LVJuNTFRLq4=;u+2cgo4SmzK8nrlcLWE49rcF2lB
 aw+Md4wCgVFpetwxjm60H8RLpULAGep2+D+dxG0IXxGYao0Yvi/ZNInTJmfhxCya4jiE1059y
 PbKyDSNnJ+GaD5PQeAyxBm6b6ENfY+LLr569V+kUJ5td4ZjBspomCBYGS9kXsPH1iiN5Y9aVA
 paRlyJRSYJW+oslEUA/fUYxXlIAaBhf2+KWKZHCgcp7GVyZHbXHfuEoccuL52kJ9aqiW0eW3c
 eCtzD1EuIScAv9wKC6qhBda7hG0M0Pme9IazWlSNTcdAmkMI2CpTn9uNLdUfp8dVPrRXCuMc/
 vpTRdtyUgKrqcL3cAJQK4cZQMNnPCaV01Bf/yH0HvHzaWO04lvPpCsuCu1uCmDcrJii02zpB9
 NAq8TtsG0DacAVIYAqcuSey/OrsTzRFLhRlCBwyJvPfQZcPv4fw0i0C2zdxOr0U6jfgqMB0Yk
 iy9WzQ8x47XVJlbudg3Mlp9SoWlFmDCye6cUpHoqM5h+6oAPAxnfhBxENKN9AZg7ae2PO1S7A
 4gnRsfQQmKCq0fLP4iRN1s472GuZ+f7oiIAoUzedSRtQ2P8K76FxgBPAyREka2zaya/rNX8ly
 CF5YGwnLhF83gPrZES8Zy2fZfQa3yUmQZ8oqakBMapWKkJYN4QZR/evcV7rAiBubYP3H/UTkJ
 5n54OBb6CZOk73nXFaGXyx9e3OP0v/FmmQ81HYrnRUPUORmKAzL+1grnoBvBfZu77e035W4aP
 CU++hIpomVHOhc33et33yzBXn9mFoUPXhGGEr/qBKJobY5HVL/9hqCN31HqAw4l97ZYQkKcgY
 6IIdop9rWPysHorw42aBDyP8IAOUEC/r45p8Ii4xnDSmHkRVMG33FDU109RJbWOumSGbqgOkI
 42seXKuyLf6ugOMLQ/5TWxN4jfsi78PDsCazeuCR87wfANVYF8sgXOTTCyuuPdUbLnrL3qmsJ
 Y+Vb/g==
Subject: Re: [cocci] Transforming data structure accesses with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1355
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/0ecaecf0-6a50-43b1-8458-59d41bc5fd37%40web.de>

> I'm at total loss what coccinelle/spatch is trying to do here:
>
> @@
> struct resource *res;
> expression size;
> @@
> - res->end =3D res->start + size - 1;
> + resource_set_size(res, size);

I suggest to take another look at possibilities for increasing the precisi=
on
for your source code transformation approach.
Would you like to restrict the usage of member access expressions on
non-pointer types anyhow?
https://en.cppreference.com/w/c/language/operator_member_access#Member_acc=
ess


See also:
Extend support for data processing with member identifications
2020-09-25


=E2=80=A6
> -               regions[i].end =3D regions[i].start + region_desc.size -=
 1;
> +               resource_set_size(regions, region_desc.size);
=E2=80=A6
> How did that [i] vanish from regions? Why spatch thought . and -> are eq=
ual?
You might be interested in further background information for the applicat=
ion
of the isomorphism =E2=80=9Cptr_to_array=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/db9431856ae32e21a3c66=
cfa119a64170242406e/standard.iso#L557

Regards,
Markus
