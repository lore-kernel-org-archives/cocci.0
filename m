Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECDFC25B10
	for <cocci@archiver.kernel.org>; Mon, 13 May 2024 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zX8F76ghIY8F8waVCkIRWYz1QVkeYofKjH627qhm/h4=;
  b=X1hBMzyn3c3UbNTwhTlbrqQV+6MbcHq3PTYFgr9/aOZtT6KQTlkrY3u/
   Zy4YUWTsOCxIFKDJ0+vyxKs29E8eD+2W3L0bgg+ywGOzvqbUDbmuekfem
   phC+iohLbptmrelScahBGGvI+oz+Xb1tRkwFur1q9cjk4ShD73X+PY2th
   A=;
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
X-IronPort-AV: E=Sophos;i="6.08,158,1712613600"; 
   d="scan'208";a="165361434"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 May 2024 11:34:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 714CFE0CCC; Mon, 13 May 2024 11:34:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 87210E004E
	for <cocci@sympa.inria.fr>; Mon, 13 May 2024 11:34:35 +0200 (CEST)
IronPort-SDR: 6641deab_QdHIML2z1VSaEZqLXb7xO41hYuSFknPK1zUJglPe2j3wTYk
 ROZFaTIUUSwbUpqnbkKLLJY0tDhh0bBRSpLXmoA==
X-IPAS-Result: =?us-ascii?q?A0GpAwDr3UFmhwQP49RaHgEBCxIMQIFEC4JEgQBUMwQLS?=
 =?us-ascii?q?IRWj0iBdTCEO4c5h0+IcYFWgUA+DwEDAQ1BAQIEAQEDBIR1AQkCiD0CHgcBB?=
 =?us-ascii?q?DIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnh?=
 =?us-ascii?q?XQNgmcBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjHQEBEScPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgnyCMAEDDiMHsUKBMoEBggwBAQbaWR8sIleBYwmBGi6IL?=
 =?us-ascii?q?gGFfIRAJw+BVUSBPIJSMT6IHoJpmhqICogUVH0cA1khEwFVExcLPgkWAhYDG?=
 =?us-ascii?q?xQEMA8JCyYqBjYCEgwGBgZZIBYJBCMDCAQDEDQDIHERAwQaBAsHdYF2gTUEE?=
 =?us-ascii?q?0QDgTiJdQyDL4F1KYQfCENsFYNzgXYOYYNRhExjgSUdQAIBC209NQkLGwYiA?=
 =?us-ascii?q?R3wEDQHgjaBYIFhDJ9EBhMvg3IBk0UOBpJomGIgqGeBbAMwgVwzGiRPgmdPA?=
 =?us-ascii?q?xkPjiEZhBTLXEE1OwIHAQoBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:WiNTWKFaw315ABh0pLqEBMeALOsnbusQ8zAXPiBKIiC9E/bo9f
 xG885w6faZslsssTQb9+xoW5PwIk80l6Qb3WB5B97LYOClggqVxepZjbcKtgeQfBEWgdQtsZ
 uIHZITNDSJNykese/KpDKjCt4lzZ2u+r2pg+C29QYUcShaL5p79g98B0KiDkFrSE1nCPMCZf
 yhz/sCnCC4cXAbKv62HWYIRIH41qb2fYjdEGQ7Li9i0hCHiT7t07LhDx2Ety1uKg9y/Q==
X-Talos-CUID: 9a23:ujKhhmGt6WlEqNLCqmJK7HAlBu0ETETbzSuLMWWpD195Y+asHAo=
X-Talos-MUID: 9a23:QYfUggkVydnluZUHeqUFdnpNCppP5/SyUHkNmLcIl5OlHgpKZRi02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,158,1712613600"; 
   d="scan'208";a="165361409"
X-MGA-submission: =?us-ascii?q?MDEmaE2zckmsZn0tmQMBg/AUjvLtKPaCZcHh5g?=
 =?us-ascii?q?TzhlWc0zHe1/y/v50ZcF0hBb2IV0hMgiVFE9HAfQllNeAEm5Xi2JwLH/?=
 =?us-ascii?q?9C8sF1jJE7LcLo2T22+KKKTgAC06NzGL1A7eiT9jXFFGrMwPHxYoFFz5?=
 =?us-ascii?q?nxO1bzIVA+a417OTGpP5g50w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 11:34:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715592874; x=1716197674; i=markus.elfring@web.de;
	bh=zX8F76ghIY8F8waVCkIRWYz1QVkeYofKjH627qhm/h4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NH+ayuHDtigYbWvJ9QdVIapzX2AHBh/QnCfYQ7qZII3wFmnL1x5ICy8TrQFvrwaf
	 voYrHVwXCu1NOcwqBCgEMfB3+mUiWK1ScM/zJoRcZJ7T8n4ZSIJBse6LXXzajwvWc
	 sMGHuGbVNOJW/q0y/d3mOAygIm5y8STKPmkMRF3Xz8Akr6hcW2oZnYQ4nPac4M9g/
	 /OL1FfUS1iI6f3nvwN6BycpQfMXvsQNWGZCVEANnP/YG9I+cAgYL0CtcKepgeMMqW
	 zqXeDDtugktE7bhIIxP9qVcLRJzS1FP3U4R12NwMosGwSRIB/lvi2dlOTlWqBfYv8
	 LnXyYKpT5OL2ofutjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1rsLTC3jJP-00SxY2; Mon, 13
 May 2024 11:34:33 +0200
Message-ID: <4f61a067-ccd2-4ef3-94ff-6c57c6a709d2@web.de>
Date: Mon, 13 May 2024 11:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <bac7cb07-aac0-4fb2-b524-3f53f8109a68@web.de>
 <alpine.DEB.2.22.394.2405121009430.6747@hadrien>
 <3db2d501-d95d-40c7-8ac1-1ce8c3bd9340@web.de>
 <alpine.DEB.2.22.394.2405121114580.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121114580.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5PCbEve4nIZyeeDlhoui+5QlmvZs60FnpzLurGX9k5djsqbUrH
 icsfmbMkoCdhrXDAn0Illc/w7IIe2AAcCBysfSBoi2nAvF9phapL+9MYTaMxAsBSwA153nq
 hSp+H06LszwFuOx9iHwBLLwAoTiY37jpfyl6ntxN2sVB1IKCn5mtXB1x4R97UPMjO0Az1QG
 lm45B3BtYUFElZh602zGg==
UI-OutboundReport: notjunk:1;M01:P0:1KCbiBIV2cA=;Wiv5wcqlkxX/2Y64C5nT+SwfTgs
 aZ9RLjV754X9PfTQV3d1nC77dmx5JwXHCsbdsZqR2940M/EqRMad0fR9561/pDBvTJooXdLjd
 ohjKdf7PnY5rsHVUTAgAO9mLOZjlnNdAJOOR7tVgWH5lw7D0UQlHHaz110AvJYDPXzHlCl0lc
 9agXfasMGyMeR5t+KN4nR0sS1X8krFQgewlACbgXcjFgY1bwIhcw/e24jfm/MNGudG9W2SaQn
 djHCxsr+m1jxwX0S6PNnxoo9rlyXFsXwkpWPiojOPgsoAQSmcgwvVZAkflMQDquapDBvqoSEE
 obt+JEHJLYuJvGOtPIfsbX5VHpVaLFursM8QvMJsEzb93xJ8hOaf6WKHTO72sqmE7L07SdUSn
 C2XWSMdkDzC1iPbg3xmEhYG9qPzX70Izj7EGbNzIPqPW1CyMs+HhbdIrfFaXoDS0LaKS1W+/E
 xRavsvzjDTArud8lKPTMxHSh3Q9qoaphVokV25sO/A4V2nyY7XJwGtDTkNf7z2hCgrZ1Otxba
 6zkffrnueQEETtxcZAtVHy+dSlmcjuduXFDLowusBCFsy+c68vnlCooFVOSFOfvmN2U9ImxMi
 p2mxlyMW+ePnYj6MFPE/5s8U2WRQ8p16IuSxQB/gmLkhOnirVAGhQvsCYWClHJA4vPbb+4tZd
 +1HH7Zvrd2BB0Sx7oPLcu6pYHB4In5DB7pPdGredGMng9WmTBLAhCwBmLi9pskwv+zvPru7Ja
 tG/LR19HgzH14L9pochK3zlw5LRyecv7vJJlxnCaxMK047C3Nt0dFabslVzHtYQJjWvlqZQdI
 36sv7wTBNRl3kEzz64V0tyXrB36Ze4NvfE1fYDag4WwGc=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1736
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/4f61a067-ccd2-4ef3-94ff-6c57c6a709d2%40web.de>

>> I expect here that specific source code starts a known statement list.
>
> Coccinelle takes a pattern expressed as a CTL formula and every node in
> the control flow graph and tries to match the pattern at each node.
=E2=80=A6

Which filter criteria does the applied computation tree logic variant need
to recognise an item as the beginning of a sequence?

Regards,
Markus
