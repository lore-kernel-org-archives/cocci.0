Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53303C38142
	for <cocci@archiver.kernel.org>; Sat, 28 Jan 2023 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AmfGI29/BhlC/ZYNXgYzWHBdNX16yhCz0XyE3iM1M9E=;
  b=Hf44ny2kPQRbx6TWwwhcxyfDDj7L/eY7Q6TSjAslj1V0wculRFgzorPm
   +nigFjWFfQaF1JH3L/8dYYGx//SWP5yVx+10aoLGgGlGfGQ0QFnCVdvx3
   yWzBrXJ93Bvq82IB3S4pogDv5b7r/5FsULTAwJOQx4dFc8vRgWmsLkLna
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89860142"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2023 10:46:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3BFD6E02CF; Sat, 28 Jan 2023 10:46:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 24D88E027E
	for <cocci@sympa.inria.fr>; Sat, 28 Jan 2023 10:46:43 +0100 (CET)
IronPort-SDR: 63d4ef02_8mosTg3RRUVHZ9b+ZEo579tHwDDrNgz4VKr5JadEac267Ge
 y8S5FYKeltz7ul3/36c614OH59MBJGsqJzBBvfQ==
X-IPAS-Result: =?us-ascii?q?A0E3BgC/7dRjhwQP49RagQmBT4ItgV4uBAtFhE+OeoF3M?=
 =?us-ascii?q?YQrhyeHMoo5gUA+DwEDAQ1BAQIEAQEDBIUAAoUlAh0HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZ?=
 =?us-ascii?q?IEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJXBg0IAQGCeoJuAQMOIwepMYEygQGCCAEBBpwJHywiU4FeCYEULJEmJ?=
 =?us-ascii?q?xCBVUSBPIMDPogcgmeQZYsOCoE5d4ElDoFGgQ8CCQIRdEIlBA4DGSsdQAIBC?=
 =?us-ascii?q?zsyCj81CQILShAbGhsHgQYqKBUDBAQDAgYTAyACDSgxFAQpEw0nJmkJAgMiX?=
 =?us-ascii?q?wUDAwQoLQkgHwcVESQ8B1Y3AQUCDx83BgMJAwIfUHACLhETBQMLFSpHBAg2B?=
 =?us-ascii?q?QYcNhICCA8SDwYmQw5CNzQTBlwBKQsOEQNQgU0EL15/CgYpJuYzNAeCJYFSg?=
 =?us-ascii?q?VIMnncGEy6DZgGTGA4GkhyXT6gQgWkCMYFcMxokgzZPAxkPjjmEDI8/QDQ7A?=
 =?us-ascii?q?gcBCgEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:SFrU+662V62ZulYd1wPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWYtKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,253,1669071600"; 
   d="scan'208";a="89860141"
X-MGA-submission: =?us-ascii?q?MDG785wPeTm4S3NgcgALIX2unK8x4pxctjOTyM?=
 =?us-ascii?q?03yDCzesSJ1swnhNDvdbDpTGy3A5HqZ38yR7tmK2QXEfxoi5pHjxgs+v?=
 =?us-ascii?q?XQaWm1WtB0nww2BSItEXyebwmlk8EbrP9a1BZh5NvT0l1VrV0drFM7Rv?=
 =?us-ascii?q?gBNtl5Dk05xtigS99MU2vlRw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:46:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1674899201; bh=Whf/EIabSPecSPmQ/V7BfUjcV8TmYZFV6fTUJUchCfQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=sq8N8ipdGSIY5wRMftdzoYbKvqFrkSffqOBjL9ioHxgFSdiT7s03bAUy5L5eW0h3O
	 QI70IJxXdgZMhDp87FDvd47dB5/ZFFYPVd6w6ibp1QUm1NNp/jK6mTmvDsFqGNP2Dk
	 7r8FRrSrI1hJw4esVcJ4kC2n2NaKFlKzB2EL+p/wSwVL5BUN39z6vtW5c2Cmcj5HgC
	 o+sF1ykLKO/kLvvQzHnvhJ2RzonMdV8b5f6CQHJPoOcc2/5YvSCwVw9R+DbwczhCTo
	 MlwfE9dd6NcQ2jUqnx15xhOmlGY8cGkYEM8aBj9+zEwpyoCI4aakoJOWbOpovb1N4i
	 QSnP/caNX7wKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1pRit43f2s-00H6QI; Sat, 28
 Jan 2023 10:46:40 +0100
Message-ID: <808cd549-f96d-872d-a4db-30ea33095207@web.de>
Date: Sat, 28 Jan 2023 10:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Luca Coelho <luca@coelho.fi>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dNmthqKl45TWcr5WdBfZy2us5eQO/m0Ny4BqJRXQ1iskzTmqYns
 4BwgCHX8nxmywFXXK56iKMJfd7V1hClagYYz01iXJW+KiPiB1p1j07J1PZERzA2ReTRfX1G
 6CXjFbWqqCrRbkIOqqOTrPl+X+yOWXrCl3q9XovZsx1F4RxmdmqALrBtpDkc5UeuDtmpht5
 +uiwX1WzjSRrZ7r+TxgNg==
UI-OutboundReport: notjunk:1;M01:P0:PKftfAMhVIM=;n3Ih/vvlhl91SOnSOLThl+Pn8vd
 ivlrtkA+Uzr8xT26X038EnmKwQjPrFNbtRVuAbVAkBjrBVyXYIHX3oDBqgrpkuySztNpNAvPa
 erXW3TbPHNW8zLS4WU14RttpsQt9ewLZ5EDO++s5evz4rhd5eOT1C9nXMK2HtJbg4xIKmmAPU
 xbRIK5X5ubVweEwpzectz/hm9oC2jaRyXsLQ+jPjlrxRT7Bm8EsEu350mC2h0uSr7kdThm3BV
 He8sZxtdHHBcgrdKwy+lRzlWII3PYyN+caRPVEXGBX9Q0jFrKBS9TldG/nfsVOuUW2ODev9nb
 R04D8BFkrDfDDcsDFPt3lEKEk1lZwHa62Hp5jvuhKtmi3WCtNQZQ28lNDRPw2WFM5IiYdFVTI
 t6bbWJgfc/hK7lsUG9PD3ay4kEaQmAZK57mjlcDFkhnnDtl6brSkPVME+rUJxi3ezp1iJh78T
 keEToKSODC0md1DjwpY0Tkk3kOQ8NtZhxurJCGXy+rLFxFmREdmaBcYInrK+06f1h7JI16zCZ
 j8nazTlOJ3l+Cn4EX0zL/6CEqTNUzbxrsWLYKB+0iSXjNFFocyl9j7mAxLITkpKoV55DMzED4
 XDdIS1FoX0wZBYJfk2/Ofpxa7vyOEh8IXtzFw3kfc0QWXlMgLgQhspQgIKZMeoobf2qWq4HT9
 2gLtsuuzTQ5tVzGjnNk10JFVvSgMbyFqD9EQP/7eEYfjAP1LsUN1IWh9jAMQryZ5ENQpcvAsx
 aLu44x9w3Cd4V0KUeYL2V2Zr/zdlu24DCIcz/jlywNw14kY2j/DlODhbRoHQIqcDQUM96bUrr
 0YCXRDIbvUqk182908k3EpbZqv9fYA04+Cu6Du6fSNrubmCLqZAEVlAV2gs4F0X7LQwoYPZnk
 xOgD1hfjRoqt3AOcBrRW/64snZdElHxeIjmlszhZROO6Yco4Jxf6hTdob2rpCMJgccRwHJwxb
 Q+cefQ==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 825
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/808cd549-f96d-872d-a4db-30ea33095207%40web.de>

> @@
> identifier nested_macros.nm;
> function f;
> identifier dev_priv;


How do you think about to use the following SmPL code variant instead of
the metavariable type =E2=80=9Cfunction=E2=80=9D?


identifier dev_priv, f;



> expression e;
> @@
> f(...) {
> 	...
> -	struct drm_i915_private *dev_priv =3D e;
> +	struct drm_i915_private *i915 =3D e;
>
> 	<+...nm(...)...+>
> }

Regards,
Markus
