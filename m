Return-Path: <SRS0=IB/k=PT=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AB5C433EF
	for <cocci@archiver.kernel.org>; Sun, 31 Oct 2021 07:48:38 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09A060EB8
	for <cocci@archiver.kernel.org>; Sun, 31 Oct 2021 07:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C09A060EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AhPhu4ajo/eOOROheFlrrBEz/X161cREKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVUx2dKX2iHP6yIamb9KtklbI3loUIFvsXWzd5hGwRtr3w8FHgiR?=
 =?us-ascii?q?ejtVY3IdB+oV8+xBpSeFxw/t512huEtnanYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYXkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYsWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WlYbR6bbewmIkHtfHaa46vRAjnVoguBqb7xFNx0R0mvR9zxy4IwlWZiYQ?=
 =?us-ascii?q?gAiNayJn/sbXgNwEidkPKQA9qWvzX2X6JfIkhCXLhMAxN0rVinaJ7Yw8eF8CmB?=
 =?us-ascii?q?m/OYTKDETYwrFhO+sxr+/DO52iawLJsjwJ5IRtFlvyDjYCbAtRpWra67N6NlV2?=
 =?us-ascii?q?h8/g8lPGbDVYM9xQTZmalLCJQJOPlMWAZcltOitj3j7NTZfrTq9qaMp4mTIywp?=
 =?us-ascii?q?93rfpGNXQc92OA85Smy6wqm+A5GPkEBhcP9uFxDyZ83SEierGnCe9U4UXfJWz7?=
 =?us-ascii?q?eNuhEy7yWsUBxkbE1C8pJGRgEO4Vt5eKFA8+icvq6V07kugTcKVdxa8p3mflhw?=
 =?us-ascii?q?cUN5XFPZ84waIooLY6gCYC2xCSjNTY9Ugs+cyRDojzFjPmMnmbRRksKeUUm6a7?=
 =?us-ascii?q?rfSpzS/OS0KJGsOaDUsSQoD6dj/5oo0i3ryonxLeEKupsXvHj21xzGRsCUlmux?=
 =?us-ascii?q?Dy88NzaSyu17d6w9Ab6PhFmYdjjg7lEr8hu+hWLOYWg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631570400"; 
   d="scan'208";a="1335595"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Oct 2021 08:48:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD1D1E01BF; Sun, 31 Oct 2021 08:48:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E6017E0072
	for <cocci@sympa.inria.fr>; Sun, 31 Oct 2021 08:48:32 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AMtj+9R950ot9c/9uWVm7ngc9DxPPW53KNwIYoqA?=
 =?us-ascii?q?ql6hJOvz6uci4ZAqOvL4w0xfgZsby07p8ke3YsqTtCyQrwK2qlzQ8SqFKTAIPk?=
 =?us-ascii?q?s4MngYtU4avAEz/K+P2PWRhRJwRHFBq8GumPkdLBc3we0PdomGo7T4VBx7zKRd?=
 =?us-ascii?q?5Kv76F4LMk8i7zeS/94DcbwhIhje2fK9/IgixoQjNrMcdnJFsKrw2yhvHo3tIf?=
 =?us-ascii?q?/pZyGZ1Ll+NnBjy+9m98od7/ytfp/wu+chAUb7nf6sjVrxXEC4mM2Eu68L1sxT?=
 =?us-ascii?q?IUBaC6WEdUmUSlRpIHhTF4RTnVZr/rif2quxw0zSBMMboUb47Ryit76ZzSB/pl?=
 =?us-ascii?q?igHMSI58HrKgcB0la5XvQ6tqwB6z4PSfYqbNudxfrnFcN0ZS2ROUcheWTFfDIO?=
 =?us-ascii?q?yb4UADfYOM+lDoonhvlsDtweyCRWiCe7tzDJDm3/43bc90+QkCQzI2xYvH8gNs?=
 =?us-ascii?q?HTJt9X+KagcUeS7zKnSzDXDafxW0ir65YbPaB8hu/KMXa9rccbLxkcvEw3Fjk+?=
 =?us-ascii?q?RqYzjMDOYzeoMvHaA4OZ6SO2glXcqpgdsqTeg2skikJPGhp4Jyl/a7yV5xp44K?=
 =?us-ascii?q?cC2RkB0btCpFJtdujyUOYZrXM4sQ29mtSI1xLAEt5C2cycHxYg7yhLDdvCKcZa?=
 =?us-ascii?q?E7xD+WeuRPTp0mnxodKyhihu07EOuxOr8Vsyu31ZLqCpIitbMtnER1xzT98iIU?=
 =?us-ascii?q?eFx8Vum2TaK0Q3Y9+JKIVgsmKbFNpIt3KQ8moQNvUnBBCP6hUf7gLWLekk64uS?=
 =?us-ascii?q?k9f7rbqvpq5KSLYN4lAHzPr4tl8CiB+kzLxIAUHKB+eum0b3u5U35T6tOjv0xi?=
 =?us-ascii?q?qTZtZfaJdkHpqKjDQ5azJ0s5wyiADi4yNgYnH8HI0xZeB+fkYTlJk/CLOrmAfu?=
 =?us-ascii?q?hgVmgiipnyvLcMrH8HJnBNn3Dn63gfbZ55U5c0g0zzdVH6pxTEL4BOvHzWlLqt?=
 =?us-ascii?q?NDCARE5NwK0w/zmCNV72YMTQmyODbGCP6/IrFCH+PojI/OQa48NpDb9N/8l6ub?=
 =?us-ascii?q?qjXAjl14SZ62p3Z8MZXG5H/RmJl6WYWD2jdsbEGcKuBA+TO3wh1GYXz5TfW64X?=
 =?us-ascii?q?7gg6TEjFIKmEYDDS5ixj7yGwCi0ApxWa3tdClGMFHfob5+LV+0NaCKUOM9hkyY?=
 =?us-ascii?q?LWaKvS487hlmSs1rY1r5mJ6Lw8zIRsZargNpo4+za0xU76jVwC+yc1XuMRid6h?=
 =?us-ascii?q?DVMDxo/2rt4vFY171Ce36l0y6hdHNpI4O5TVwAnO5/Q5+N/AtH2HAnGe4HaZky?=
 =?us-ascii?q?hR4CDCCsyU8l57tsAeUd7FJ32qxnZ3DexRZIRmaaKApMc7a/WmXT8cZUug03a3?=
 =?us-ascii?q?bUs2gF1CvBEMner0+smr1C772/hlkKEi+C1eK5a0COfrA9rKEKRsUseXAMiCc0?=
 =?us-ascii?q?tslgAa0GQodmrvyv/?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3At89Ex6h966AhVEfaKYXcZui+WHBQX4Z13DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre6cjzsCWE7Qr5N0tQ4uxoUpPsfZrjz+8A3WB8B8bQYOCEgh?=
 =?us-ascii?q?rREGgB1/qZ/9S6IVyPygc1784JGMQQeb6Ab2SS6/yKkjVQPOxQt+Vvm5rY+ts2?=
 =?us-ascii?q?oU0dMD2DqslbnnlE48WgYypLrct9dP4E/Vanl6x6jgvlXXwWa8CyAT0sRvHZoc?=
 =?us-ascii?q?LGmdbPfHc9dmIaAIbnt0LY1FeWKXKlN94lIkpy6IZnzkT/rizSzoDmk8j+8gPV?=
 =?us-ascii?q?zGfV8pRQlJ/A57J4avCku4wrBg7QqiyBQcBAYvm5lhgTh82DgWxKrPD85ygNBP?=
 =?us-ascii?q?lSwVv1OkGN5SH10w2l6jwp8HOK8z+lvUc=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BBAAASaxphhwwR49RaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUgEAQELAYMMFVc6MYRHj0mBdy0DhBiNRowGCwEDAQ01CQECBAE?=
 =?us-ascii?q?BhBxFAoJrAh0HAQQzBg4BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1K?=
 =?us-ascii?q?QGDZAECAgEjFQgBAREmAQ8LGgImAgJXBgEMCAEBgm0BglQBAw4lC6dsgTGBAYI?=
 =?us-ascii?q?HAQEGhGsfLCJQgVoDBoEQKgGNcicQgVVEgTyCRwcwPoJiAoFggxeCZIQXPlEsI?=
 =?us-ascii?q?jSBW5Fdq24tB4IAgSuBNwuIe5QABhQmlUkOBpEYlgoHjD6ZB4F2gX4zGiSDBAE?=
 =?us-ascii?q?zUBkOjiAZg1kziixAMjgCBgsBAQMJbAEBhkAsghsBAQ?=
X-IPAS-Result: =?us-ascii?q?A0BBAAASaxphhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAgUg?=
 =?us-ascii?q?EAQELAYMMFVc6MYRHj0mBdy0DhBiNRowGCwEDAQ01CQECBAEBhBxFAoJrAh0HA?=
 =?us-ascii?q?QQzBg4BAgQVAQEFAQEBAgEDAwQBEwEBAQwNDgg6JIVoDYI1KQGDZAECAgEjFQg?=
 =?us-ascii?q?BAREmAQ8LGgImAgJXBgEMCAEBgm0BglQBAw4lC6dsgTGBAYIHAQEGhGsfLCJQg?=
 =?us-ascii?q?VoDBoEQKgGNcicQgVVEgTyCRwcwPoJiAoFggxeCZIQXPlEsIjSBW5Fdq24tB4I?=
 =?us-ascii?q?AgSuBNwuIe5QABhQmlUkOBpEYlgoHjD6ZB4F2gX4zGiSDBAEzUBkOjiAZg1kzi?=
 =?us-ascii?q?ixAMjgCBgsBAQMJbAEBhkAsghsBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397855627"
X-MGA-submission: =?us-ascii?q?MDHWnUo3TmhfSmIQSun+rmFZLyQLAFgXlzRIyo?=
 =?us-ascii?q?CGqrTsJRMaLKsFK1gzQWeaImPAZfBW3tlEuiEreDQKC1Xi+9KfsLny/s?=
 =?us-ascii?q?o3aUIG6m4Hr8sZ+nIumTD2FRGk7BlQf8Xtzuo4XZLUBB3lPiPyZVtQJD?=
 =?us-ascii?q?+FV5vwgL0tCMTi+slvnzsXuA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 08:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1635666510;
	bh=nk8L66nEgQWrMsCksTollnqz2gsoeDU1eg1F7oSxUwk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ZFcB6SXq2C7plmwupgDzbUpdKDVMSULEJksAHHUEf9NA7C6ifjRi0/1nvhcLmHry4
	 3YQ/14P+vxJfb4jIb+eb0CJ/7PfICzNObTPUly6EZkKKlHIE1Z41UMLmS+lzVfezmg
	 qHbxUmt3eL+YOdxH2X47Z90hiJCRvXgRicixMk34=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.25.81]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVcZf-1m8h3h1NPT-00Yxxy; Sun, 31
 Oct 2021 08:48:30 +0100
Message-ID: <0f57acbf-73c0-e789-cb85-f9f94dd4f1e6@web.de>
Date: Sun, 31 Oct 2021 08:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 Mansour Moufid <mansourmoufid@gmail.com>
References: <CALogXGULuKk=g58WyH4hBXeRr=epbnJ_n7pHeCbuoq_Q7h28-w@mail.gmail.com>
 <alpine.DEB.2.22.394.2110301135390.2946@hadrien>
 <CALogXGWJKs9TjoTxpGn_yQBsa2e4GhhhqyDFa4+VEFqzuzh+iQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2110301837520.2946@hadrien>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2110301837520.2946@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OosXwigBeTeVmbBNJMrk9P7HspCgTVB1YB3eyTFAL/GQEVCid6p
 fzxl8dz1HS8Io3aqB71DaOlkoE/t4tKmPT3i9ZzXso92wju6k9PT+9xURd+b2BszrhAOObm
 LeiKhmBK6wrVzaMwqXr/chgVm6OGsREokuNzr+l2nIckmea/MDmYOCTJsJ1O0b86ZUPYX71
 2onjabEZHtfJ9QT82WfcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kdFbcqNmd4U=:pGst8aTx0BodpmABWy3jv+
 fsUA0/II1JUt3brMrLpEiZGba0+8w+gVdIsqm8MM9c3PFO1zOQYYQh/hJI41e2/Mp0tvNyzAY
 gjlutoMGu97SGNFzZl43rnQAzkvQEznNdEBsArnSP+oth0zMaTQI3+WXzhBlfIBjXjACJGaMB
 VdoD5ASzXL/XgOAGCxzoZ7XoZaEHzOj8bbWD4yMeTzfUNxon3v9MTPHrcbh5RFiLCd1442P2K
 KMpKEPBDaZZ7c/uCa/mJNZQwKMUzuJ8GuZzFp2v8yiggLqwMZffn2Hq4WVB998VCOzYxSaeVD
 xK/W5uzI6NGCBf7SC1/AAhlLuN3nESbNr92ZReKYxYL18bn1l/ZiDacAPH/VifKsf+nEAcvE0
 ng3Qgh0sPhfzgddvSdwLSxKAqNIztZC2hmNGw6AglggXHywXcNHrNMJLEK7b+VdbbPl+kXLx3
 Onnu3LAFO5BrKGApkDi/nKnz5H8bXwooTkqMpo92s8qlG9vg+VD3pmmHQ4XaWNaNkcKDkyR5M
 n1E0umZ+hOB7MDzIMpqSZyJaklFvStMUHKQXqoxG9nWQvB+jV1BZqB6SoIpk8w/ewfZ8VyqFC
 YuHQKVYHueXbzF2ChnHJQ8Rv6gZpNxCRNWu5AlthAxiSeT/nDam2y0xKEr2hxZ+dXslmOx7F1
 reGXYg3VSgl9+/jPxOI0jhmv/SGBRaWebS51Tr+sU2dqaNhQI6OO9e2cDcd6AgtC2mz2Y0m2p
 7t25QeO8n41ydZqnqa/mhZY3Xvf2qAoYZR7md4WZUIw14ywryp0FPvQ1jRt2hylcSKPOiIpUi
 xiFZeDdXw++k6Yr5MsXUU5M4tcegTQ6+9ZLuRHuH0ea2z+t75wSmMeNEuEWP6gT51rgRkijEL
 H2vuHQB9GTcj5Rt2iiG7v9+AnBL40TNipdzA7ehz0ZA0Gh8+rfi1ki187mZtR9ksL7XSv1JnW
 9GmrkDoZBIxL/ImfXOVCjao6sGVW7I7mB1ZgNV91Uv8KsOgzbPLSL87T4JnumUmCmqD+RcpOd
 ZwdaUEq0LhWxJYCjuO9UKv60OX4qvOjwGGIZWzeX+1oCloASJe0gj9KJpSUsAJAsh//bG8gpC
 LvEnPJFXpsftfU=
Subject: Re: [cocci] Print selected status messages to an other output
 target?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 56
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/0f57acbf-73c0-e789-cb85-f9f94dd4f1e6%40web.de>

>> Sorry I didn't explain it well. I am using spatch in a script and
>> logging stderr to a temporary file to catch any errors. I just didn't
>> want the status messages to appear there because there are so many.
>> But I've worked around this by ignoring those lines. I don't think
>> anything on stdout should change. The current behaviour is fine, I
>> don't mind it that much.
>
> OK, I think I will leave things as is, to avoid adding another option an=
d
> more dependencies.

Will any related data processing requirements trigger the collateral evolu=
tion
to filter log output any more by their severity (or other categories)?
https://github.com/coccinelle/coccinelle/issues/

Regards,
Markus
