Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1620C02182
	for <cocci@archiver.kernel.org>; Thu, 23 Jan 2025 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KFNIpb3LX/gw5QgbKaaYJVhRc2F16Y+OqeC6JbKaf4I=;
  b=OhMdNbAypXAaJYUCC0cyvVer7fKW8XAn7Wj5LBzqIZF7eIHP4w5mYjNd
   Fe085269mDDWIeUpGp8zBaWB+YE2bI8IDSS9UbolAcakCR9yZUGZbnDZ9
   wr2ZXKY48XYPxdKGPGK9zept7C9nKl+GUlTDF20hR8SwRUVjztz0lvBgV
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204658025"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 14:26:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3FDEE0077; Thu, 23 Jan 2025 14:26:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F68BE0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:26:05 +0100 (CET)
IronPort-SDR: 6792436c_b5ky4dpZk/TdDRnQNTjlbQ38C5HejHQ7mXMVYj0gcqbUo2S
 xdG2AuPS2a/fKJbldqInqqFDLUpkH0B817n0YWg==
X-IPAS-Result: =?us-ascii?q?A0HKGQAiQpJngAwR49RagQmBU4JEYhtaMwQLSAiETo9Og?=
 =?us-ascii?q?XQwhDuYB4FWgX4PAQMBDT0EAQIEAQEDAwGFAAKKdAIeBwEEMQgOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR0QBAQECA?=
 =?us-ascii?q?SMdAQERJwQLCxoCJgICVgYBFAEBgn0Bgi8BAw4jBw0GtmOBMoEBggwBAQaBW?=
 =?us-ascii?q?EHYQh8sIleBZAMGgRouhWuCYwGGJoQ8Jw+BVUSBPAuCeD6CYQEDgV6DW4Jpg?=
 =?us-ascii?q?jOETWeXRYhEUnscA1ksAVUTFwsHBYEpSAMtNjEjgSYFNUE6gg1pSToCDQI1g?=
 =?us-ascii?q?h4kWIIrawQFgS2CPYRFhFGFW4IUgWgDAxYQAYI1cnkfgQIdQAIBC209NwkLG?=
 =?us-ascii?q?wY9nQw9gwSBVBoTLMhTNAeCOIFmgWMMiimVMwYTL5dEDgaSe5h8Io1ilgyFH?=
 =?us-ascii?q?YFoATiBXDMaJIM2TwMZD5JOgQu/OkI1AgkxAgcBCgEBAwmFRgEBik6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:DUy7waw42VJ2GN7YVFp6t+cJwirEfRIJ4+MujC+fZmUNrF6WrkUDz
 GUeXG6Eb6nbYTT1fdp1b4m39UwPupLSmNIwGQA5rlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmUc3l48sfrZ9Us25q+q41v0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPN4ORjDBA2LbEcoOJPLVpu8
 fAHdhQkO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyVo4YCtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QA9wvL9fZouQA/yiRD7ZvKadnSQ+fQbvoEg2Cx+
 z7N7n/AV0Ry2Nu3kmbVqin82YcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZvjeThC48X6UghpGX+J8KM0+5B7T7oOBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7+f9pZW1qe78kN+iBRX5O1PucgcoYGM4DzTLpYYuklTQQ9wlHKPdYjzJ9dPYk
 mjiQMsW3ut7YSs3O0OTowuvb9WE+MKhc+LNzl+LNl9JFysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpfFs7xQVs3WynzTGY3h+Y1FAd7aYVUwZnYwT/EcG8iFpiXyI+i8HRklfxkyYppslcHBO
 RWI51s5CGBv0IuCNvMnO9nhVKzGPIDhEtLiTbjPY7JzjmtZJGe6ENVVTRfIhQjFyRBy+YlmY
 MvzWZj2UR4yV/45pBLoHL11+eFwmUgDKZb7H8CTI+KPi+rGPCb9pHZsGAfmU93VG4va+16Nq
 I0HbJviJtc2eLSWXxQ7OLU7dTgiRUXXz7ivwyCOXr/TeFhVCys6BuXPwLgsXYVgku4H3q3L5
 3yxEAsQglb2mXSNe03AZ2FBeYHfe891jUs6GigwYneu+XwoOri04IklKpAYQLgA9c5Y98BSc
 cUrQcu7L8pqdiXm4BUYNJn0k5xjfk+khCWIJCuUXwI8dJ9BGS3Mo8HoTjLy+HMwDw6yj88fo
 qKh5CzfU5EsVwRvN+eISfONnnean2kRp/J2ZGTMeuJsQUTL9JN4DgDAldk1KNEoBTDc4ACFx
 iCqARs8jsvckb8fqdXmq/iNkNa0LrFYAEFfIVj+0Z+3EivrpkyY3o5KVbezTwD3DW/b1v2rW
 rRI8qvaLvYCoVdttrh8GZZNyYYVxYPmh51e/zReMET7VXaZIZI+HSDexuhKjLNH+ZFBswjvW
 k6vxMhTCY/UBOzbSmwuNCgXRcXd88oLmwviz+U/e2T7wy5VwICpc2tvOzu0tSgMC4ctba0Ex
 786td80+j6PrEMgEuy7gxB+80WOKX09UJsbiKwKPb+ziicWzgBtXJ+NLA73/5CFVPtUOGYIP
 DK/pfTPlpZc9GX4YlsxEnnBh9RcoZE0vDFL014wCFCbkfXVhvIM/UNw8BZmai933xl4w+ZIF
 WwzDHJMJIKK5G1OluVYenKFQiVtJUS+1BTq6l0rkGb5cRGZZlbVJjdgBdfXrVErzW1MWxN6o
 pea8T/BehT3dpjT2iASZxZUm8b7R4YsyjyYydGVJOXbLZwUejG/v7SPY1APoB7ZAc8cok3Li
 O1p3eRoY53AKi8ijPwnOraeyIgvZkiIFE5aTdFl2ZE5L2XWVTWx+DqJcmSaWMdGId7U+k6ZV
 e1qAO9yVCqF6SXflQBDWJYwIIJ1ksU5u/sEWLfgflAdv5Wl8zFGjZP39wrFvlENfelAq8gHF
 97uR2qwKVDI3XpwsE3RnfZAIVu9MIUlZhWj/eWb89cpNpMkscM3Q34Tz4mbgnSxGylk9iKyo
 wnsSfL3zetj6II0hKrqMPxJKDuVIOPJdtaj0V6MoeUVSOjQI+LiihgwqGS7Dz9JPLAUZct7p
 Y6NvPHzwknBmrQ8CELdpLWsCIhL4p+UcNdME8eqMkRfozSOaPXs7zQH5Wq8D55Dy/FZx8u/Q
 jqHeNmCTsEUV/hd1U9qRXBnSThFMJvOb4DkuS+ZhNaPAEJE0QX4cfWWxUWwZmRfLiI1K5nyD
 zHvgMmX5/dakZ9tASEVDPQ3Er56J17eAZEdTePTjgXBLGeUgQKlgIDAxCoQsWSBTjHOFcvh+
 pvKSyTvbBn46umC0NhdtJc0pRENSmp0he4rZE8G5tpqkHaAAXUbKfgGe4AzYn2OfvceCLmjD
 N0MUIcjNck5dTFDbAm6/9npGAuSbgDL1hEVORRxl354qQ/vbG9DPFel3jht6TF6d1MPCcm5f
 MoG9CSY0geZm/lUqCV62hB/qfhqzLXWyxrkPKw7f9PaW34jPFnB6JCt8Mehm8AK/wEhWXgn/
 VQIeF0=
IronPort-HdrOrdr: A9a23:m2H49ag3UNvkEI1SIDUQD0TClHBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3ArRTPOGmAxCFki/nuMvxz8lKJohjXOVz+3XrQck+?=
 =?us-ascii?q?oNWIzTIW5cn+U9Lw6t+M7zg=3D=3D?=
X-Talos-MUID: 9a23:CKZY5gohogge/FiVb4kezwNfF+Ax4KOXMxomrsQbneDZaSdhIA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="107168472"
X-MGA-submission: =?us-ascii?q?MDG+mx394ziJFFYo3NeLBH5Z5+Awv7vkzKMsfX?=
 =?us-ascii?q?QPrafhu/WQY8SfXGa5PUr4xLToGkDI846TDWEc1cgzZQ2z5q2oft5Kzb?=
 =?us-ascii?q?vk5GC/5H3ZJ7utAOk6LrTT7fmXK1S89rrSZKIj5akb0BOuwfdYvL3pFB?=
 =?us-ascii?q?swNiRPbGQooSqd+4hKZwwv6Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:26:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737638763; x=1738243563; i=markus.elfring@web.de;
	bh=KFNIpb3LX/gw5QgbKaaYJVhRc2F16Y+OqeC6JbKaf4I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZmrjTdHZrWvk97xCPaKB27SVbNvSMM49cGLW8csz+gToi0zP9OnUsPjN6irO+rCm
	 aSn5p2zIMT1ZL8gJc5ISiYJL2YCUajU/LZmmtNybtH+bhwHhalAC9mdIHZi5TIYwU
	 9MnVD3PbhIJVeQk+XrmtLvdsdhoCTkrZEY2j/FYr1jV3P/qhCKaMZdjWTVMC9c1e+
	 toiYVwix1AEa38mdMzIplqZkhhqa8+PctDT9bKHOMdI99df+SYObaCPLLl8Ola/Lp
	 534U9AORttCCdZ9Js++LnXQydWtJ2QyZj7OcsYeVkBfDaCH3P5LJ+RQD974/De/Th
	 sfZsT0Md3boqzG9Fkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQC7-1tizYs0hdV-00AdXQ; Thu, 23
 Jan 2025 14:26:03 +0100
Message-ID: <1974acbf-e116-4c6c-8402-e0a5786f81a5@web.de>
Date: Thu, 23 Jan 2025 14:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Christian A. Ehrhardt" <lk@c--e.de>, cocci@inria.fr
References: <Z4re766p6mujr7h4@cae.in-ulm.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z4re766p6mujr7h4@cae.in-ulm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P1EG2AguzCOm3Y4dwNLgVu8iEQiKe12ekgtGCmENZ8dlodloQzw
 tePfzIJlr7d6AHnPl+jbYIw4vVnQmcLaTOQCSQoePPR+OMHE5TkjXSkUvXVh/1qw9SvU+xV
 8kFMZH6PA6ykUuMPrUJru6Fx1Npb5x9DY2VkiURV4YTzS8KU2qW383P3nIOyr6kiBnbWWaK
 IgXQDlyZjCAfID+/HhZnQ==
UI-OutboundReport: notjunk:1;M01:P0:6rmA7RlTdhE=;YpPZ+ENBUv8h2Oyj7Ol69ONPen8
 yhMJn87kpQZteVHWWeLkEcYd/UH4BBkt3PCd15SxOqLcBK39bDGqwZVzTTDrxSdkGMNBNqWcC
 x8nevgKOwcLkrFaYTH2AQ2HgxekcVEn4rH1mkm3gAmtb5cXWe0tZMv9dw1Yun0oGOXVyveUwx
 povK/7DqJacfhYvg26ma7Wu7HP3CjCEIQx7WfwPiMaW/10o1TfQGm4nArPfhaiC4V/wotJi6s
 qSm1htrcTRbuJbJQ3VCp1WkKsbD7kqtA25YSnmn2i3EL0JgqDOBc65lGEA2xfA52qv+Jb+kDg
 GSDNlOuUZ/HvquHktlcpIenZ3dwkLYsBwkLjZ2FksBQZrqNGo9woF4HNRJKk0R96H0CI6AGor
 eiGow/HEZNkAR35UjB+0REHPgrdNkqatB8aYa9aZcrFiiBIU3V0ruVujBB+SZt7AlP6kJE+HC
 XvIwYsAMq7UW7vbrN1QsJWEK2QhMlJFf2KB9Ae0JDSFAn+sFcEacJOUdLN9uy/o1AfkdTMJud
 O1wvtFkjMh+sPWbA/VSqdPYEVtVWy+/Mmxqw8AT3TK42eCLW/4w5voVbsKba2pZTISdeq5bX/
 JbtxYxeopy/j2u+TybX5BZKDx/n2s1+09WhUMjIzlsxPXkLokJuFqGxe+revQjBvSYzBJe6Ja
 ujg7/BXKpozehA6dkOJtS4PHnARTIrv9exXgRn1bB+zNvQrDlHe9uEfVculJgTsJzJXl6S6GE
 KFdYIZdZaT8rt1gcKea8i6ZvbuSqv+LDxzxknofOXAJsYnWT16nJB7dwyIHHlZUdKBDVsmGcF
 5PUyOkn3aZcbpIZs6FDl1Ye3Jf/rxYyOMIsdpaQVdcD+3hgx/I843q4MEw4FRqPKKEVDAa0Sy
 BBeF78oz3eNPKZv2CGfjs36X4nEUFVSrRPTKR4vMmYkGg1H1Rc/TxNtxfMEhgESTm0wH2dvvP
 D8IQKrJuJJnLAK4YxysQT76nHbPh5DII70z/cJiG8LcWPaCoN8lw6RqU0cSECMkOZz0LwfoMs
 RahsQpZcozl+kO/uao6tfBBICqEMtiivqo3jRyTEcRkyAB3l23wCAOA7J2DdWa1HSTKbY99ao
 BKHOoERwiYdCBExnqDCpLjriaOtAsqZt5iMX6AIU3N+nH9tHLL/wQcCNq6LLLqT0ANcNnuzQH
 f1dk0ZLQIo2VgiXDT1A+t0xL4tPUrzq4dx4ByOIL8yQ==
Subject: Re: [cocci] Replacing cast in nested initializers
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2221
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/1974acbf-e116-4c6c-8402-e0a5786f81a5%40web.de>

> I am trying to replace casts in nested struct initialisers.
> My patch attempt looks like this:
>
> @@
> identifier __type;
> identifier __name;
> expression __data;
> @@
>
> | struct __type __name[...] =3D {
> | 	...,
> | 	{
> | 		...,
> | -		(del_t)
> | +		(add_t)
> | 		&__data
> | 		,...
> | 	}
> | 	,...
> | };
>
> Running this on this .c file
>
> | struct foo foos[] =3D {
> | 	{ (del_t)&x1 },
> | 	{ (del_t)0 },
> | 	{ (del_t)&x2 }
> | };

I find your usage of pipe characters confusing here.


> I would expect the first and the third cast (in front of "&x1" and "&x2)
> to be replaced.
>
> However, only the first cast (in front of "&x1") is replaced and
> I get a warning the del_t might have to be meta variable. If I add
>
> | typedef del_t;
>
> to the patch only the last cast (in front of "&x2") is replaced.
>
> What am I doing wrong?

I suggest to take another look at applications of SmPL dot variants.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8aa44ca0ff45be70f1248=
02696ea58c75843e2a9/docs/manual/cocci_syntax.tex#L793


Will you get further development ideas from additional information
for the semantic patch language like the following?


@casting@
identifier my_name, my_type;
expression data;
@@
 struct my_type my_name[...]
 =3D
 {
 ...,
 <+...
 {
 ...,
 (
-del_t
+add_t
 )
 &data
 , ...
 }
 ,
 ...+>
 };


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi suggestion_for_Christian_Ehrhardt.cocci
=E2=80=A6
minus: parse error:
  File "suggestion_for_Christian_Ehrhardt.cocci", line 14, column 1, charp=
os =3D 291
  around =3D '{',
  whole content =3D  {


Regards,
Markus
