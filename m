Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B55C433F5
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:35:56 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CDF61288
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9CDF61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2625905"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 18:35:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F34DDE02C9; Mon,  8 Nov 2021 18:35:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 998D4E004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 18:35:50 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3Afxpo6xyYoajR4MTXCzKvzVBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhWZvK8m0gGBHd2Cra4e06yO6+GocFdDyK7JiGoFfp1IWk1No?=
 =?us-ascii?q?uQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZ?=
 =?us-ascii?q?rKeTpAI7SiNm82/yv95HJbAhEmiexbalvIBmoognct8gbipZmJqot1xfFuHRFd?=
 =?us-ascii?q?/pKyW9yOV6fgxPw7dqs8ZB+9Chdp+gv/NNaX6XgeKQ4Q71YDDA4PG0w+cbmqxr?=
 =?us-ascii?q?NQxaR63UFSmkZnQZGDAbD7BHhQ5f+qTD6ufZn2CmbJsL5U7Y5Uim/4qhxSR/oj?=
 =?us-ascii?q?CAHNyMl8GzSl8d9gr5XrA6nqhdi2IPffp2bO+RicaPcZdMaRHROXsBNVyxaH4i?=
 =?us-ascii?q?wa5IDA/cdMepEqoXwoUYFoxmjCgm2HO7hyTFGiXD40qMnzeohHwHI0w48ENwBq?=
 =?us-ascii?q?3nUsMz1Ob0OXeypwqTFzzPOZO5W1zfn74jIdwgsr/aWUrJqcsrR1FIvHB7KgFW?=
 =?us-ascii?q?Up4zlJTKV1uICs2OG6OduUvigi3QkqwFsuTij3Mgiio3HhoIPy1DE8yp5zZ07J?=
 =?us-ascii?q?NKmU0F3e8OrH4VJuiycKoB5Td8sTXtytyYm1r0Jp4S7fC4SxZko2hPSZP+Kfoq?=
 =?us-ascii?q?V7h/9W+icPzd1iWxrdb6hiRu/8FSsx+7yW8WpzFpHsCVLn9nRun0J1RHe9siJR?=
 =?us-ascii?q?uZ980qv1zuC0R3Y5OJcIU0si6bXNoAtzqQumpYNs0nPBDL6lUXsgKKYbkkp+Ou?=
 =?us-ascii?q?l5/7ob7jlvJOQKoF5hwXkPqgzlcGyDuI1ORUUUWeB4+Szzrjj8FX5QLpUiv02l?=
 =?us-ascii?q?bHUsJXdJcQGuq61GQFU3Zg45BqlEjipzswUnXgBLF1bZBKKl5blN0zQLPziE/u?=
 =?us-ascii?q?znVahnC12y/3GJLHsDI3BLn3Zn7fgebZ95VRcyA02zd1H4JxbEKsBIPHuWk/qr?=
 =?us-ascii?q?tDWARs5MwKuw+bmDtV92ZgTWGyRDaCCKq/drEGH6vo1I+aQfI8VpCr9K/896vH?=
 =?us-ascii?q?yin82hUMSfaiy0JsMaHG4G+xmLF+DbXrthNcBC2YKsRAkQOzkkl2ISSRTaGqqX?=
 =?us-ascii?q?6Ig+jE7D5qrDYPZSYGjmrOB2CO7E4ZXZ2BHD1CDCm3oeJ+eV/cNbiKSOM5hnSY?=
 =?us-ascii?q?eWbivUY9ynS2p4S3nz7tuZs7d5SQcsdq31sVx5uSVkRgt/DhwJ8WbyWCECW9uy?=
 =?us-ascii?q?CdAeTs/x7x+pE15gn2K26txy6hGH9VZ5PphSRohONjX3bopJcr1X1fkd82KVU3?=
 =?us-ascii?q?ub9GoGzA3QZpl5tYUYFtmXfimgArC2SWCHLIf0bCGUs9nupnA1mT8cp4ug03N0?=
 =?us-ascii?q?7Ms2hx/GpMn3YKOmaN1sQTeVdehe6SxkqG3aeID0SSL+GrRlQJmWWlHXQQ2Xai?=
 =?us-ascii?q?XBRgi?=
IronPort-Data: =?us-ascii?q?A9a23=3ASZ0tc60VY8GkcuEVu/bD5YNwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1G523zRRzzBMW2rXM/+La2XzeYonOYu+8x9X6JHUx9ISHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9bdANkVEmjfvRH+OkWLa?=
 =?us-ascii?q?dUsxMbVYMpBkJ2UoLd9ER2dYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Nl7HmbgsVT7SUMQXmZnh+AfH4xEIY+Wprj+BgXBYfQR8/ZzGhutlry8hW87G0R?=
 =?us-ascii?q?x0oOKLkh+kXFRVVe817FfcYouKXcCjXXcu7lhCaLSK1nZ2CFnoeNooT8edfGnB?=
 =?us-ascii?q?L7fVeKTYXbxnFifje6LayVeBoguwxLczhJopZu3d6zDifA+xOfHxpa7GSsIQeg?=
 =?us-ascii?q?SNp05gIReKEMpJfM2cxMgCbNkUJZ0NIXbsguMytoFX/VxxRjmmQqZYtxVbS6Rg?=
 =?us-ascii?q?oiO21dIPBEjCRbcBSg1reuW/MuWj0aiz2/ee3kVKtmk9ATMeV9c86ZG4TKFF83?=
 =?us-ascii?q?vttnUHV2WEZThEbPbd+iZFVlWbmM++z6WRNksbtkUT23FOmRJ/xUnVUZVaa6wU?=
 =?us-ascii?q?EVYM4//ISsWmwJ2m93+pdLncJRHhNZbTKcedeqSMCjje0oj8iOdCjXHB5h55QG?=
 =?us-ascii?q?nd4YA5e4RQoEFI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ARH8xOa/qJ5iUav4gGZxuk+D8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZhyYlF/Bw5Pre/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ?=
 =?us-ascii?q?2VxeJZg7cKoQeNJ8SWzIc0uJuIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak?=
 =?us-ascii?q?856Bd3ARV0lYhT0JdzpymSBNLjV7OQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CpAABkX4lhhwMP49RaGwEBAQEBAQEBB?=
 =?us-ascii?q?QEBARIBAQEDAwEBAUCBWYMMbDoxhEeOb4F3i0OHCIwSCwEDAQ0+AQIEAQGFAgK?=
 =?us-ascii?q?CVgIdBwEENBMBAgQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg2QDA?=
 =?us-ascii?q?yMVCAEBESYBDwsaAiYCAlcGAQwIAQGCbYJVAQMzrCqBMYEBgggBAQaERx8sIlG?=
 =?us-ascii?q?BWgmBECoBiiKDDHonEIFVRIE8gwM+h12CZY8hgjyBfL4KMweCC4EwgTkLnSUGF?=
 =?us-ascii?q?C2DWgGSCQ4GkTCWEB+mDYF4gX0zGiSDOFEZD44gGYQMiixAMzgCBgsBAQMJhUc?=
 =?us-ascii?q?BAYssAQE?=
X-IPAS-Result: =?us-ascii?q?A0CpAABkX4lhhwMP49RaGwEBAQEBAQEBBQEBARIBAQEDAwE?=
 =?us-ascii?q?BAUCBWYMMbDoxhEeOb4F3i0OHCIwSCwEDAQ0+AQIEAQGFAgKCVgIdBwEENBMBA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBAQwNDggnEySFaA2CNSkBg2QDAyMVCAEBESYBDws?=
 =?us-ascii?q?aAiYCAlcGAQwIAQGCbYJVAQMzrCqBMYEBgggBAQaERx8sIlGBWgmBECoBiiKDD?=
 =?us-ascii?q?HonEIFVRIE8gwM+h12CZY8hgjyBfL4KMweCC4EwgTkLnSUGFC2DWgGSCQ4GkTC?=
 =?us-ascii?q?WEB+mDYF4gX0zGiSDOFEZD44gGYQMiixAMzgCBgsBAQMJhUcBAYssAQE?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2625898"
X-MGA-submission: =?us-ascii?q?MDE4U10RauFV6FLrXFKTK/1VakWOabuCNOVmZz?=
 =?us-ascii?q?rSCYQSYS40jHK/8A3Rv+//ULm/mQbfTjSbewCTuB+n0oNKgOihZczh0s?=
 =?us-ascii?q?j+M7hchm0jig4DeLbDs6ianoWTsxE7XFQ9R9gKQH3YMD03m0VvAiO5yR?=
 =?us-ascii?q?GWKKxAHqq6l0iwyjl0R8ZdlA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 18:35:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636392948;
	bh=/TFNuSL5wbq9vhlAkDgFSxs67A8eCLZNfk3BOtLFmmg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hFY4ufSXYykeo8hoeqe5j0dUqm11mOedWR4WLItAcEeaTC8tEmJYtuWqhRoMFRYwf
	 0SGwds02OYG5Nj/q51bHqFG4XFr07HPCck4FI6pVPOaYvCDSu+Duwx2UdiUVRE3R6a
	 dB2VNUqsMDoMNt7c+ajP+W8EiU22e4LaBJycutG8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.139.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1mvPt12dRb-00GMqJ; Mon, 08
 Nov 2021 18:35:48 +0100
Message-ID: <96c0476d-beef-ed62-26d3-5f754cec0f45@web.de>
Date: Mon, 8 Nov 2021 18:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, Vlastimil Babka <vbabka@suse.cz>
Cc: cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
 <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
 <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
 <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
 <alpine.DEB.2.22.394.2111071908410.2988@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2111071908410.2988@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1RSmfHmy4BxKvJ00VnFQoXIcGyIMiSe6zMrhE7vu5JBwK0uSXFH
 X21qoBBn13Pejk2y0YBJy5hWKXhMVQOQHLS8d7q32R2zkpD1+1WA1uIZLhh7TZRHZd91l3X
 YJA2HWeV4vRoEK4vgsjOwYnOAiLP0PDdmdh6/TlLatlf6qXDe9LDoGMXW8+MBZSB0L01k1P
 R4veQcQKxpNN+9YKKdjaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKP1ZSju3ZU=:wbvO6ORHqWNuyjKJg9LpEx
 H0RzrMtdB43aWvNjFTeZnNCNt8GQ+lFInoPGkW92AXpHWO7SiNKlry6LQ6MO5Zco6DV2bYcHW
 +N+hpyxqSTcpS0/kQSsi/7XJmk6/t1Tcz2eK3hDb9w9eqjCmv2EuEfgCFS9rAZxs2S9aOoWi6
 moVinkehlNd6fAUege+DEo933h70vOnDoG0MqDugosiv4kzgfEnGD9DC/2W66Y8yMy0iPr6EW
 +HOdduBgD2n5xdGFqKT1l9EMpaZ0o92LNJ7bQupg13GUi2u+OAtMySlJwfnYym73p57PTCO9A
 /xpdZ1F0rMFgYYuhpvfY/YHWSfejPQdWUK3C5G/OTLGvTuKl1s9VMMAY0TJ+oV/xJDBFjgcR2
 hFoC95EjU00HfA3eGJ0wNb8E54xP0f49bNgqdbGAjtl4RoArlxH+DaNCaVcejv38VaRie+S36
 miG8P2eQpIPZGpfX/ho655yG7xmw4v2tXKjoCviqXBLThxOPwcCXfXxwd8itNiDzyFCnjn1UV
 qWVYmmGGpqWXQoJWueKeXLHv9T37rGcSsHjVzpq+vBtcZVKLLjK67pXzpXcAS3Kpba0HAWcGf
 7pZcxWLNfVqmXm+CGHlO1gUgt/W4t4Ek619ezOqIWb/vUxI9iOBUOnz3H5mmOq2xy2dlXgg4U
 su8iyblEn0ehXfyNN4oYrumOgHyvFsh8e/EwMucIoEQ0XaED5t92wS5dg5QIUpA9hf3oV8n47
 uGijZG8feTG9wYKtTpisK/Li1Sd9tvfm8PkgyzCPUd2G7npICtf/XTO7Xet8dUQ+Kltoo5yH0
 gCoazC/7zDzdktR5gC5/9ewxL9g5bFsQ2zQUzP8PtiBOsdgPeoWqgMJXnPrS6igqLi8Y7kS2b
 SqvgRuXVI0Y1Jymh99jdcyQc8EjvYu5AIldKCREkuyK1bB3dCmQzZYNi1y73D3g9ZPIes0+Jx
 Vgufl03YwC8BWMQLO4irADMJBPVCrOK0W09UhMgf6vrYyJXz6YLjyqmQa9WnpS4DP1hGzbRvW
 ulYoU0I+M49iC2uE8DSGh3p+POnHyFH1T0hnZTWXE14n8Xn3PoizZIndJqxId+AB2q9CVxYTz
 e3FmJdBWdwdtKs=
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 99
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/96c0476d-beef-ed62-26d3-5f754cec0f45%40web.de>

>> - struct page *page;
>> + struct slab *slab;
>
> If you first rename struct page as strict slab and then do
>
> struct slab *
> - page
> + slab
>   ;
>
> it might work even for the multiple declaration case.

Will there are need occur to adjust any more variable names?
(Would different suffixes matter for corresponding identifiers?)

Regards,
Markus
