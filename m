Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3686AC00140
	for <cocci@archiver.kernel.org>; Thu, 18 Aug 2022 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j5lfIu/PRylKcJv0osqHVgjssubSu76L+4rE/zMLCXc=;
  b=GhAITLgo8zbkijj4oiwFYP0sQStJ+q3x0+uauWNeF86GaX1pV+U0+40d
   DOp8nc9uswEq5SC+1O0WaQv0RL7aNy9lwO5f7z9ZqzefT8FThUzTkGzPu
   JbpDyYVP5EwiMQ4GvFEvSP1cUqCSeRatuG3WB10kz3wmwwCJiUKtLfPhR
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49155488"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Aug 2022 19:42:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1C212E0380; Thu, 18 Aug 2022 19:42:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA3D9E0380
	for <cocci@sympa.inria.fr>; Thu, 18 Aug 2022 19:42:51 +0200 (CEST)
IronPort-SDR: HzoU8CLslihWnClH44jMKVhbrRCFeTraMvs5yUZyUjq3RaFnnBSdsmRDyZ94mBS5rnDhxJbXvx
 1+b1v/9RSy7fi4dz3hFf2HkdYtSqfOlck3caUNAqn4WJT7D+w7o2K7MdqClsHja+7PlRmywvZx
 2iGb0+BmPh+G0vDWfGOwYOyyabsOovfyDrs2ZQBcahsGkNxkUrDH5sKl2hoUtJkZujTaHo9MeP
 1nsgPFLXJKuW+nNMX+K7RiPJYG9X3UgeVgUcZkVW6CCP8whzss/aHuTFiEsNxYIFGknxE9Qg1w
 +9Tr0pJeBgFWW4h6aLP/MmJe
X-IPAS-Result: =?us-ascii?q?A0ClAgDZef5ihk7ASNlagQmDc4FYLgQLRYROkQ+EJYcRh?=
 =?us-ascii?q?x+MJgsBAwENPwECBAEBghOCdAKEegIdBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBDAsJBwgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpA?=
 =?us-ascii?q?YNkAQICASMdAQERJgEECwsODAImAgJXBg0IAQGCeYJtAQMNJQeoc4ExgQGCC?=
 =?us-ascii?q?AEBBoROHywiUoFcCYERLI5OeicQgVVEgTwMgnc+iBqCZZlPJgQOAxorHkICA?=
 =?us-ascii?q?QtNBQgJFxIQEAIEERoLBgMWPQkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDF?=
 =?us-ascii?q?AwBBgMGBQMBAxsDFAMFGAwHAxkPIw0NBBgHHQMDBSUDAgIbBwICAwIGFQYCA?=
 =?us-ascii?q?k45CAQIBCsjDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggnFwcTGBsZA?=
 =?us-ascii?q?QUyJxAJIRwKBBoKBgUGEwMgbwUKOw8oMzU8Kx8bCoESKikVAwQEAwIGEwMDI?=
 =?us-ascii?q?gIQLjEDFQYpExItByt1CQIDImkFAwMEKCwDCR8fBwkiJj0FBVs6AQQDAxMiP?=
 =?us-ascii?q?QYDFwKaDIQmwU00B4IWgT+BRAyePgYTLpZjDgaRepYiYKdagXiBfjMaJIM2T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjjaEDIotPzQ7AgYBCgEBAwmFRwEBhSgBAQ?=
IronPort-PHdr: A9a23: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
 /DKk7/vbihP+ZTY8JlEb/U=
IronPort-Data: A9a23:DWwBrKhobtDurXIIO+5SPqNgX161CBYKZh0ujC45NGQN5FlHY01je
 htvWG3QOayIYGaketlyPo239RgEsMXVyNVjGlBupX0xRi9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8z6TSFK1nV4
 4mq85SPYATNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplibuLVj5yb+r3ouUUQz4JFi0iIo5a0eqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgRs
 6NCbmlcNFbc14paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcChWls35seQJ4yY
 eIbditKSkTlbSR2J3gYS6NnjPn011/GJmgwRFW9/PdrvTGKkmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 3AzwTUX9vl1z3aqR8naDhi0/GGnojdJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gLQxYK4XlSDpJXEFSPErt94uBvoYXB9EIMUWcMTZScoi+QPTak2iQ/TCMluGui5g7UZ+A0cI
 Rja80DSZJ1J1abnMplXG3iZ2lpAQbCXF2YICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsr5WUs/UzHfWEL5VdF1M2xpjGGKM6bKIN8ZxnwlBB1b4LOi8HRkjeBY3aZxslcHBO
 R6D4Fo5CGBv0IuCNPIrPdvoVazGPIC5W42tV/bIY8BIb4Q5fQDvwc2dTR744owZq2B1yftXE
 c7DL66EVC9GYYw6kmbeb7pCidcDm3FmrUuOFMuT50n2gdK2OiXOIZ9bawTmUwzMxPjYyOkj2
 40Cb5fiJtQ2eLGWXxQ7BqZJfQ9bdyFlXsGuwyGVH8baSjdb9KgaI6e56dscl0ZNxsy5T8/Eo
 SOwXFF20l36iSGVIAmGcC4xd77lG5py9CppMSspNFeu+n4ifYf2sPZBLcRqJ+F/+bwx1+NwQ
 tkEZ96EXKZFRAPHzDJBP5Pzm4pvKUawjgWUMiv5OzUyJsYyRwHA9tL+UBHo8S0CUni+ucck/
 e+/2wmdTZdaH1ZuC8PfafSOyVKtvCFBybwoABaSeoFeIRy+/pJrJir9iu4MD/sNcRiTlCGH0
 wu2AAsDobefqYEC8O7P2fKOobCvHrYsBUFdBWTase27OCSGrGquxYhMDLSBcTzHDTqm/aK/e
 aNKwvu6PPBexARGtI91ErBKy6Mi5oKz9uEAkVk+RC3GPwaxF7dtAniaxs0R5KdD8b9uv1fkU
 Ey4/NQHa66CP9noEQJKKQd5PP6P0+oYxmvb4fgveRyo4Shq4PyYXE8UMxTV0H5RK758MYUEx
 +Y9uZdKulLl1Udwao6L3nJO6mCBDn0cSKF55JsUN4/cjFZ5wF91Z5GBWDT954uCaokXP0QnS
 tNOaHEuW1iBKov+n3sP+bzl2O1AmdIRtRoMwFJqy5FlXDbarqdf4fGT2W1fosdpItFvzO95f
 GRmX6GwDbvb5C9m3aCvQEj1czysx3SlFojZ1FYD0mHUJ6VtuqohM0VlUduwEIslH66ws9SVE
 Hx0CIoobNoyQPzM4w==
IronPort-HdrOrdr: A9a23:BjoHwqDMilwPxnvlHemI55DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3OD1KbcdKMLsytHSuQ4y9QYWcelSAZsQkjuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="21641385"
X-MGA-submission: =?us-ascii?q?MDFk/O01Lak5yFANzi/t3yAgh5aW2oyy7H7hfA?=
 =?us-ascii?q?AMoWMA+vGpWWf9z/Mog6QrOEBytZo/+am3gRD9sve2jMmqxf1JnRufUu?=
 =?us-ascii?q?RISF/MOiD0Pbkq1xHaPGLyB+oivietycWTjlp9hJwlSBI9sgj3VfyG2l?=
 =?us-ascii?q?GlzNn81LwwlxDn/L+zxbBVHQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660844567;
	bh=ns02nIcAR4ZWPoah8LUwNnrf6y3f79tpwYsEV/k2GiI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LDeNDDSm96NhTfWlE6NV5jJEkH/fYsQxhrmjL/3bSrxlWmckCuos0bosFXcVTrnpb
	 IAdP+omTyWtHHrmFQ7STBTWXoXwDvNJfNkl+zwnfAwEu6rSOsN9eYV/pLHdmj2669l
	 E2vbKD3qfFqWu73RZtu60J4nykyMOzWuqXJdjlkM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.17.173]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1o3D570UaU-00Llkz; Thu, 18
 Aug 2022 19:42:47 +0200
Message-ID: <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
Date: Thu, 18 Aug 2022 19:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u485MYVd7XkVfN8KcO7jWfpHlMtzq2QzmKsMqG9qgppq8S1iH6Z
 FJnRIp3/LkPPs+bd8P9/mFLGnUB9kKxarl9+4ceDfgrGNB5guRa3cjH4voo2UkEaAUMoJQw
 qHbKDJW0EIZrQIgo7odFz7wkMsv3s88pqCCEwzBZTVXhShGRRtG87a9h/HITOyImwNCEuc+
 6YU8xJGTxq+1sskz1jV4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zeiTTDIxZu8=:k1EkgFZu+mg6yfh6MpHjMk
 jAP1xejBLV0m2R3+SzRp+4JaAEGBRrl/vTnJwCdXo0dGGmtXp5K9VbmFsEBvx3wibyj12Ypfb
 iKgB0W6DgQKh0J7W+jZTIVYhf8p04+fOsefsSGMYoCt7y7Ny7dDf8blLZ74XUYN39ntrQ15eg
 VMdcnrkamOkm6q/+gAMAhdrHQL4AZYR/OEGclanqMrvMeydWL2fVpgbcaEpZGj8Ve6CIPbvXd
 SEZrmLSWzYaaP+kOSpl5ZOyK1wZocAL4ptFJ8GnsGEnOOD5byv0nbj7Jo9c7aBNmg9LqXtAzI
 yeECYP48RkiVEvCbmHgP+xlxFCrT5f7J822B347WItWOfpaK8kK7RLnOkqDusXFPCwar3wRqD
 csAb0TtokKNITSBu5ewgs/tbR9KS0hmqUhmy2RCljkc0iVW2vIo+f0oRILjB02Cq5Qm1EU3sG
 UcGeK4PMIfShV17ze3Zt/QQh+9U9eVIIBrLK0j+b4vVAE8MAUeUN53Xh88q0GdILpqpVXah8H
 sET0hSITE+i/dMb1I6E81T6jaJ4ln1pY+86btQznyVy+4XufHHtH9PNLIGYK/ivkZSTwE335p
 8L3xWs6MVUj1m8pxnzkhed2pPCJJAEyAwlyc5pZL17azerHLRKF0nMH/vqb/a6j67Kq4MYO8V
 d2Ef8rplazjPGiTmDuwrkvzLQpSRNoFeZi0/JxFTjPegzOMLZU8bgZISm7TACAPj7IrCSdbhP
 c4lIhu85xO5lEr1dBy91E4/zHk18BS3MkV6siIlLeaR3IcPyo1FUOynXO677OAaDFeeau6Eq6
 ntZ+C6xCCcbqr7vwWiy4KT7G8U/hH0sUXgHulSjbkpU2oh/3Eam/pcS10m55dlePFT+xJKDD8
 Dcl/rfjddKNcFwoOkptAQoHZ8rVfZIm6UtQqyb7mOVULLYPlnriRrfCb3NgiFqldWdIygplHo
 J6ZwFmY2kLBXhS/1oqzI7AsVkU5Hk17jZKGxJh9usY5aGw0bJkYnyub/RhU97Dcih1M7Xc52q
 FyfJYjLvak3rzpmUMOqSG0IFwy6j0tRUZBu9IPIGgDzHu/SF6UqA0ZQwYrX74Zrv3palTiMLL
 QEOJ9PXKJzG/hNvksSgw/eSpB410baIn3eqHxlDdAb9sL1w1WtTc+cSJQ==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 519
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/cf4058d8-13ca-0637-fe0c-d9d8582c5673%40web.de>

> Let me show what I was trying to archive and how I solved it:


How do you think about to achieve further software adjustments?


=E2=80=A6

>     interesting_func@p(..., i, ...)
=E2=80=A6

I interpret such SmPL code in the way that the specified position variable
could be omitted because it was not used by another subsequent SmPL rule.


=E2=80=A6

>     e =3D e1
>     + // here the argument to interesting_func was assigned
=E2=80=A6
> +++ /tmp/cocci-output-test1.c
> @@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
>  }
>
>  int main(int argc, char *argv[]) {
> -  int x =3D 0;
> +  int x =3D 0
> +    // test;
>
>    func1(x, "asdf");
>  }


Do you vary comment additions for your test results?

Regards,
Markus

