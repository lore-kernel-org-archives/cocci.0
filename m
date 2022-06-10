Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05AAC433EF
	for <cocci@archiver.kernel.org>; Fri, 10 Jun 2022 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4etRiQmrWDAyHde1G8k4WNkTlZi0v2vaHkAXnbOdb/E=;
  b=i/oKiBSjHboNIDC7tZtQWDT5ahHOSTSPCy28WG0Xlb8AHIjdK075d2aK
   NYGBKjGZQl4yQLZnFixmeLuYYfH3ffcFZmx5lIjELCMxAqu+COjnApl6x
   bSXjY1cEHRcT1jRV9Wij4urusIvFgtwjSEazoKmWpQbKu6yhkraVtr/Iu
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,291,1647298800"; 
   d="scan'208";a="40471812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2022 19:37:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A29F3E0269; Fri, 10 Jun 2022 19:37:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AAA85E0038
	for <cocci@sympa.inria.fr>; Fri, 10 Jun 2022 19:37:06 +0200 (CEST)
IronPort-SDR: iplE+7t3++ESEvRWrKnXxU6Bw8mtCDCl3GBvPFuRn5fAVHemLuIKelaF5HAq6VFUYDAKPTrH0b
 FJgYeWo1oFeV9EU+a+VXWTUEy98YuyR3HD+Jo8AuU+fl4qNKGymUtFBV1mS26eyNuIeco0bfy0
 NlFbE7NtWGh2K4uZuiPEmxDjtp3Su4bHpW9dhnk3GmDzgqjnaupAAysHGQEJimtzI8mi4iiWhc
 kBO3w8a/91ubCz+G2txSawp7AjbFUOD6GzrChOLb/GNnWx0VwI3BEnbKfAC+KvIF+P+xM3SSGZ
 0y51jZgdlBp6lDcK9e9M2urs
X-IPAS-Result: =?us-ascii?q?A0BPAACbgKNih07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgiSBAVYuBAtEhBE9kQ4DaYM4mkILAQMBDTkGAQIEAQE9g?=
 =?us-ascii?q?VGCagoChUcCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBE?=
 =?us-ascii?q?wEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEMFwQZAQERJ?=
 =?us-ascii?q?gEECwkCGgImAgJXBgEMBgIBAReCYgGCZAEDDSMHC5BbnBR/MoEBgggBAQaBP?=
 =?us-ascii?q?wEDAgwCQ4I0HywiUoFcAwaBESyKUoMieicQgVVEgTyBFYE+MD6BD4FTAwGBX?=
 =?us-ascii?q?oNWgmWWE4IZJwQPAxotNBKBIXEBCAYDAwcKBTIGAgwYFAQCExJNBh0CEgUHC?=
 =?us-ascii?q?gYWDhQcEhIZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMXCQcKAx0IChwSE?=
 =?us-ascii?q?BQCBBMeCwgDGR8sCQIEDgNFCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGA?=
 =?us-ascii?q?wYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICAwIGFwYCAhlWC?=
 =?us-ascii?q?iYNCAQIBBgEHSQQBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHF?=
 =?us-ascii?q?hkdGQEFNicGCwkhFgYKHwsGBQYWAyNKJwUKPg8pNTY8LyEcCksGIgEbApkgU?=
 =?us-ascii?q?hkGAQGBDSoCoyegGDQHghSBPYFEDIlOlF8GEy2WUQ4GkXaWaiCNDZoGgXiBf?=
 =?us-ascii?q?jMaJIM3TgECAQINAQICAwECAQIJAQECjh0MDQkVg26BC4NWhUw/NAI5AgYBC?=
 =?us-ascii?q?gEBAwmFRwEBiRMBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:CmYQWat4Zi7eXJG5Sw1f+83zR+fnVD5YMUV32f8akzHdYApBsoF/q
 tZmKWiDMvfeNGH9eNAgPYqz9BkC75aByIc3HApu+yBgRXlDgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52LBVPyvX4
 Ymo+5OGYAf+s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnbaJWBkiAY/po/omAgReTBNbeoxkoaCSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXq
 rpHcnZUP0rF2LLeLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwhWls25wRRq62i
 8wxLgUzYjnBTFp0C046B8gAvf+4olfnSmgNwL6SjfNqvzaKlVIZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXPSbwCWM9naElO7KlznyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQ+wzswppcQ0Xe1dYjgWUKKhTmlnEcDDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiPLaVQDGx
 XfUxom4VGcHXKm9GC7Mr+/8QSaaY3BNRVLucxPoWiMpzrHeTGwbixXSUpB8HaTzgtCd9dDML
 9Ki/HZWa1Y715ZjO0CHEbbv3WrESn/hEFRd2+kvdjj5hj6Vnab8D2BS1XDV7OxbMKGSRUSbs
 X4PlqC2tb5TUc7cxXDWGLpXQtlFAspp1hWD0TaD+LF+plyQF4KLIdk4DMxWeRs4bJ1eEdMXS
 BWJ4FkLjHOsAJdaRfYqP9zoUppCIVnITJq8HvHSctdUZJVtPAaIlByClmbAt10BZHMEyPllU
 b/CKZjEJS9DVcxPkWTqL89Aj+5D7n1vnQv7GMGgpzz6gOr2TCDOE98tbgDRBt3VGYvf/W05B
 f4Ea5DVo/ieOcWiChTqHXk7dwxTcSdlWMio8qS6tIere2JbJY3oMNeJqZtJRmCvt/09ej7g8
 i7vV0lG5kD4gHGbewyGZmo9OqziV9BzoCtjbyArOF+p3VklYJqutftOKcFoION/rOEzn+RpS
 /QletmbBqodQDrw+wMbMcv3ortkeUn5ngmJJSekPGMycsc4FQzE89PpZCX18ywKAnblvMcyu
 ePyyQ7RB5YOHlwwAMHTYfOp7lWwoXlExLMsBRSVeIELdRy1ooZwKiH3gvsmGO02KE3OlmmAy
 gKbIRYEvu2T8YU7x9n+g/zWpYmeFeYjTFFRGHPW7OrtOCTXojijzItHXLradDzRTjqtqqCle
 PkT0Pz2dvEKxQ4Yv415Grdt7KQ/+9q2++4ElFs5Ri2TYgT5EK5kL1mHwdJL6P9HyIhZjg3qC
 EiBzd9XZOeSM8T/HV9NfwcoMraZ2fcPlmWA5Pg5Ohyjtipw4abBTkhYeRWB0XQPILxwOYIj4
 OEgpM9Pt13h0EV3aI7eg3AG7XmII1wBT74j6MMQDrjrvQx3mFtMVprRV33t65aVZtQQaUQnL
 1d4XkYZa2iwG6YDT5YyKZQJ9e9amIhIpx1AilMPT7hMdhwpmddvtCC9MxxuJuiW8vmD+/1+M
 C5nOiWZ4I2QqixwipErs3+EQml86d7wxqA140QEnivVQiFEk4ALwHIVYY6wwazSz46QkvW3M
 l1VJKYJnAsGpP3M4xY=
IronPort-HdrOrdr: A9a23:CJnUWqNj78M0AsBcTuWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,291,1647298800"; 
   d="scan'208";a="16454730"
X-MGA-submission: =?us-ascii?q?MDFkFFmFnS9lWEL8u6I8x3el4l7A0RQPZ0LFlb?=
 =?us-ascii?q?B6k6XlMXdrSXuziLbbUst/Mt5nbfCJJzQGIWKKMuHt6h7z3n1xqjiHfH?=
 =?us-ascii?q?2jqUZYAxK8LGqs8cHLRz3Ama9D/B3leNGGtYlmebITbGxGRhgz8LqsqA?=
 =?us-ascii?q?7/foYKoCDQAir2fClWfkRZ4w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 19:37:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654882623;
	bh=yHLJIrufEFqJ+w1lJswOwJz19emNBrKTaHTL3oHKXGg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fYiIad/ZKt6x2lTW3atcW+iNBay+LKBfetjdDC6i9gcxTDYfvBDu1tb5kSU99H93A
	 raq2oNhSVcQPcD0sVjdsG2NAPPs0gVYkokUG+0ltWmkzsW3H4dybjZhoeWIQuDHyl2
	 EGAmRzHmM14PAiY4e06DbiBM29WkAfHMnW3Xd1zg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.185.55]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1ntA2x2sDw-00BUr1; Fri, 10
 Jun 2022 19:37:03 +0200
Message-ID: <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de>
Date: Fri, 10 Jun 2022 19:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0DyhNVFtnEmQhLVdM1864rQvF0vl6S1YAxxLtDaTRENxosRI+Ke
 EPqusRc9s9F3XC5Gua3Z2WQ/sqxp2fSMmv0BcT+zO/yWdnwoWeD8/ovrL+ijxFcesjWO6wU
 2SAfSiud4dLNWfDm48IWMQPqPKzA6lthxePQZFLFECu/qKZ+lXqPLALKudSHQt3O7/vC048
 cy3zI90PtzNCdiFAe2/7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fY++sSQxw8=:PXmuD06yVq+BchO5fahxLa
 AYIZsTZxvR3GrAhhygEga2MfKR+FZJHBNR6wpobDTab2ZgGkG3C6llfnrRRnHNWOHW3KUWbfW
 u6hDvieuUn8qV64pTtrN2M1DEcITmRxD5Fr6W17AjipLPDNKGwfncoARs0dg6jwBBAAvyH0Qx
 a3P00Q1JYRm9vT4/LOiyxBbH4SLZfHwGh2YIFN6vdDjlUr2tMJaDK3GHyFrQ/K6G80Z6eOVGL
 iBc9L+fGMG37SjemjCcSNLl1GskKPfe1puw2ASoJgizhvc+458FvB6DgY5RvrEibdjHl73iOh
 78KcM5J2L9L83UfYyJ1o/zqqCi7HF9t+J14Spf5ZOiJkOdeMZaMbwfTN8YSj+6zfa2QZMiSsl
 17s9c3xwjM7CEVpsXb1u9jIOG3q9MeLqXLgukI4JxdcwU4peu//qOXT+giTBqcyAdi8mssVIx
 H97tKiialhnnYXu0nJ2tmP44OqD6oHkKPlxEz5LmHzbj9rrFn4KbzAJnw3XrP569hcRH4oe5R
 I9JRj9kmCGLa4+FMxnqxRnVAtAvIRaw23g2E+mVQjfnFsYyNmqkcxUj1N8xGjAnk2DjTF/hJ7
 VCvdVlftDIE9fgLZldwlwK7o/YGm0LG4Tbl91U4hlrgmBn9Vim9M1SZn1UJgH3nrxb+jrz2kd
 cZKHK3upU2Lw4LA5sPdaqvZ+YNOsGAWdwgX3fDoNjQB2bHepnJqQMHKOgd2NYP4Xudeo+TNoI
 7YIlWh+ufo7GfUYxwlpmCtSHMCrTkuNaX2YewTfQlBG2i27as2J/mZn260U4kLLR7FG8z4prJ
 hZxGf4mwVfcS1YoFpXTYukLBaFkaS09XDquijrCSS0fpbnX8bOCmufVSQyq3z9eJpK0fN3PKQ
 8YQR6/X6ALoq3MchLTnmq93Mo0L8acR/4kQz0AD0BvB5Ia+PlT6ILhVg26MJ9qrXhRaR5AC9j
 A/XDDkl2sjH2BRXywx/ZlaEW038N41UjyX8mzUBfCVZNiDQdWKctKEQLsVLUUkRk1iR4tZrvL
 lnl1lRFmPyfYxeCEVFqj4bWkA7+s49eTwFhpYr8NP9/E4DoYEhieNmAkhdsv3Z58yhqXAXWd1
 qxg4xkGBSiS6pMQw5YtGUPA1LpANKBPbzfWzg7an491WOOU9uiX7+10AQ==
Subject: Re: [cocci] [PATCH v3] coccinelle: Extend address test from ifaddr
 to every test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 434
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/a8c3479c-c8f1-da57-23fe-657c2f13872b%40web.de>


> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it. Also, an expression's
> address is likely to be non-zero in every test expression, not only in
> if statements.
>
> This change aims at detecting an address test in more complex conditions
> for every test expression.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
> v2 -> v3: Apply Julia's suggestion to have a more generic solution + ada=
pt commit message and file
>           name to this new solution.
> v1 -> v2: Moved disjunction on the condition itself instead of being on =
the
>           if statements.
>
>  scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>  rename scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} (94%=
)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/m=
isc/test_addr.cocci
> similarity index 94%
> rename from scripts/coccinelle/misc/ifaddr.cocci
> rename to scripts/coccinelle/misc/test_addr.cocci
> index fc92e8fcbfcb..2d0ec86d1701 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/test_addr.cocci
> @@ -14,12 +14,10 @@ virtual context
>
>  @r@
>  expression x;
> -statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> - S1 else S2
> +*&x@p || ...
>
>  @script:python depends on org@
>  p << r.p;

A)
I would like to point out once more that no questionable places were marke=
d
by the software =E2=80=9CCoccinelle 1.1.1=E2=80=9D (OCaml 4.14.0) in the f=
ollowing source code.
https://lore.kernel.org/cocci/da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2022-06/msg00017.html


void check(void)
{
int s =3D 1;
bool t =3D (&s);
}


Thus I propose to add another case distinction by the means of
a SmPL disjunction.


*\( &x || ... \| &x \)


Will any more adjustments become helpful for the handling of optional code
according to SmPL ellipses?



B)
I imagine that generated diff output should be wrapped by a source block
for the operation mode =E2=80=9Corg=E2=80=9D.
https://orgmode.org/quickstart.html#blocks


Regards,
Markus
