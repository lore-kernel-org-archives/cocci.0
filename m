Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E46FC00140
	for <cocci@archiver.kernel.org>; Sun, 21 Aug 2022 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=giZbQX8XxNoVyiRym/incm3bdb2dIMUrBIV1WAdTp/M=;
  b=ps98HSRJKgzQ7z1dXcUTBlgRvr0A+R4AxDxYxsl5Ob/fW5bvmuca+7ZB
   PqlnvhJZKQO1UAivdRISFTXXVSix68s3NNggGQxZLQ8rcxVRPJDjmrozw
   QPq/TIeR8JloP60BZGA4zUlXC5+KVnWww2jILG0lrtSbHFlt3Rf+DFa4D
   g=;
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
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49377844"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Aug 2022 13:34:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43980E0382; Sun, 21 Aug 2022 13:34:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D083E00F6
	for <cocci@sympa.inria.fr>; Sun, 21 Aug 2022 13:34:01 +0200 (CEST)
IronPort-SDR: jUih8KlcPIb5aD9/o1HWY52Y8Ut5X3O/4Nag9O0cef+7QAAw83zsldnFKIg9NjXnHqJS2F6pP4
 LnNpHT3D+fdIQthzlWZPk5lbl0Y7yxcw4SFiDdjd9Harh1/jeRWHU1amyYz/BYfe+orPXgx8sO
 rE22ZtreaqUXz6PCwt/Gi4CTDSMXQhQSs7/C+++7wyZf0yHeZUVyCCiI24FK+pOwGAPVeMjNLN
 Gv0Uvj/1od/JEoYf3r5wqfqDsC2Bfp8uKKon9ibEhm6gKRVXPRlZeI4b5Psx8k8JJr3vQEllMi
 jiu16EjgsT2/aZulM7wJd5KJ
X-IPAS-Result: =?us-ascii?q?A0DKAgBMFwJjhwwR49RagQmDc4EBVy4EC0UDhEuOZ4F/K?=
 =?us-ascii?q?YQlhn+HM4woCwEDAQ05BgECBAEBghOCdAKEYQIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0C?=
 =?us-ascii?q?zQNgjUpAYNkAQICASMdAQERJgEECwkCGgImAgIhNgYNBgIBAYJ5AYJsAQMNJ?=
 =?us-ascii?q?QcMjGycFIExgQGCCAEBBoFAAQMCDAJDgjcfLCJSgVwDBoERLIZYiAN6JxCBV?=
 =?us-ascii?q?USBPAyCdz6CIEIDgV+DVoJlhxSSWiYEDgMaKx5CAgELQwUICRcSEBACBBEaC?=
 =?us-ascii?q?wYDFj4JAgQOA0AIDQMRBAMPGAkSCBAEBgMxDCULAxQMAQYDBgUDAQMbAxQDB?=
 =?us-ascii?q?RgMBwMZDyMNDQQYBwwDAwUlAwICGwcCAgMCBhUGAgJOOQgECAQrIw8FAgcvB?=
 =?us-ascii?q?QQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJxcHExgbGQEFMicQCSEcCgQaCgYFB?=
 =?us-ascii?q?hMDIG8FCjsPKDM1OSsdGwqBEiopFQMEBAMCBhMDAyICEC4xAxUGKRMSLQcrd?=
 =?us-ascii?q?QkCAyJpBQMDBCgsAwkfHwcJIiY9BQVbOgEEAwMQIj0GAwkDAik7Aph/ggaBP?=
 =?us-ascii?q?wKYJKsYODQHghaBP4FFDIlalGQGEy6WZQ4GkXuXB404mieBeIF+MxokgzZOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKONoQMgQuDVoVMPzQCOQIGAQoBAQMJhUcBAYUTA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23:OSJjSayQmDV4APFJL2F6t+cuwCrEfRIJ4+MujC+fZmUNrF6WrkVWx
 zNMWmzQaP2JNGChftlybd6xoU0EsJ+DzN41SgZpqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrVRbrJA24DjWVvd4
 4qq+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhek
 opvi7iWEzszJ+rdhus5XUZAIXxhaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlXBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/mbvoAHjGtp7ixINdrRX
 MVeUAIsVzTFf0N9YnMmI509md790xETdBUB9Q7L/PNpi4TJ9yR12afkNN79aN2PT99c2Eeev
 GPPuWrjajkRM9eUyBKe43e0j6nOmzn6UcQcDtWFGuVChVqO2ioMBRdQWVbTTeSFZlCWdIgAC
 XIw3HASt7F15VKkateiRy/lvyvR1vIDYOZ4H+o/4QCL76Pb5QeFG2QJJgJ8hMwaWNweGWx7h
 wPU9z/9LWw07+DFIZ6I3urM9VuP1T4pwXgqSQJsoeEtwND5pJopkxLCJjqIOPHr14aocd0c6
 xqDoCU4wooOl9IX2qCx8ErI6w9AS7DMSRMpoBraVCSp42uVhbJJhaT4uDA3Dt4Zfe51q2VtW
 lBawqByC8hQVPmweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBknehkwapxcI2W0P
 R6C0e+02HO1FCT6BUOQS93hY/nGMYC7RLwJq9iJMosQOcIZmPGvpXAwNRL4M5/RfLgEyPxjZ
 87CL65A/F5DR/0vzTyqSv0b3KNjzy9W+I8gbcCT8vhT6pLHPCT9Ye5dbjOmN7llhIvZ/lm92
 4sBZqOilkQHOMWjM3K/2dNCfTgicyJnbbio8JY/XrDYfWJb9JQJUKK5LUUJINA+wMy4V47go
 hmAZ6Ov4Aen1SSWdl/aNxiOqtrHBP5CkJ7yBgR0VX7A5pTpSd/HAH43e8RlcL852vZkyPIoH
 fAJd9/eUOtCQHLL9m1FP5X6qYVjcjWthB6PZnb0PmJgIsQ4HwGZqMX5egbP9TUVCnTlv8UJo
 4qmilHRT60FSlkwF83Rcv+ukwi8sCFFyuJ/VkfFOPdJf0Do/NQ4IiD9lKFlPMwGbxnOn2PI2
 wGTCBYehO/Mv45srIiX3//Z9d/xHrInTERAHmTd4bKnDgXg/zKukd1aTeKFXTHBT2eqqq+sU
 uViya2uOvMwmlsX4ZF3FKxmzP5l6tbi++1awwBjECmZZlinEOo5cHyBwNUJqaBHgLNU4FPkV
 kWK89hcGLOIJMK8TA9PflV4NLzb2KFGgCTW4NQ0PF7+un198o2HZkMObROCvypQceluO4Q/z
 OZ948Mbt16lhhwxPorUhyxY7T3VfHkHTrlhqZwQRoPm01J5xlZHaJ3aKyn3/JDWN4QSaBZ3e
 GfMifqQnalYy2rDb2E3SyrH091dspJS6hpE+1kPegaSkd3fi/5rhxBc/FzblOiOIsmrDg6yB
 oRqC6GxDaCJ4isum8VJGWyhc+2E6Nt15WSpo2blVkWAJ6VraoAJBHIwM6CB8Sj1NkpCKyND8
 ujwJHnNCF7XkQKY4sf2cVFoobrvQLSdM+EEdN+PR6y4InXxXdYpbmJCq4bFR9sLzP7dXHH6m
 NQ=
IronPort-HdrOrdr: A9a23:5GJjIKAR56mzqmDlHemC55DYdb4zR+YMi2TDj3oBLiC8cqSj+P
 xG785rsyMc6QxhIk3I9urwW5VoLUmwyXcx2/h0AV7AZniahILLFvAB0WKK+VSJcEfDH6xmpM
 JdmsNFZuEYeGIbsS+M2miF+rgbrOVvu5rY/Ns2h00dNT2CRZsQlDtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,252,1654552800"; 
   d="scan'208";a="49377841"
X-MGA-submission: =?us-ascii?q?MDHZwHjmy4gLYLMRy8bmNmGQSmqV/tJUJh6BKR?=
 =?us-ascii?q?tNuI+BD8jb3qRGlkjJl0Z5hI8QRQj/a7UZQ0pHl0Br2K5ubzhphZYhVC?=
 =?us-ascii?q?+xVhJHq7s0mUf2eGCg5n3wa5ae/ZPifo8tICifZK8dcZZOC6W97wN80s?=
 =?us-ascii?q?tmpKXBdjBMpQTaTOA4mV/33Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 13:34:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1661081639;
	bh=/R/qnhDIDeWxYWfYPuJqwHfWPXq0KIZzssjmikyoLgM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kKr1WhrGhSlNHHtjvLH+HGhAWxbOleGNa2rvLTopR/itwT1HKXM0l+346dvoPFIcY
	 b/TuCfjCtr1C8wmdU10vBEcebfeR1JpQCUUpZbdPBflZTLNantiCXZD64f+OnizZGC
	 Rr5Opc+i2lJNvp4Ie1OGtW2EZVwsCouAiojGzdZk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.59.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1otnkQ1qJB-00TiDy; Sun, 21
 Aug 2022 13:33:59 +0200
Message-ID: <2c62caa7-56ad-b1dc-4045-84f008aff6be@web.de>
Date: Sun, 21 Aug 2022 13:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Jakob Koschel <jkl820.git@gmail.com>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
 <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
 <d9e428c2-f4d2-13bb-bf42-447a1f0ffa73@web.de>
 <5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.com>
 <26cfb01d-0d74-1c34-ac60-664c61931f07@web.de>
 <alpine.DEB.2.22.394.2208211108400.3263@hadrien>
 <8049e567-0aca-ada9-54f2-557dc1083ee3@web.de>
 <alpine.DEB.2.22.394.2208211200120.3263@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2208211200120.3263@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JbQDKgJeiPHIQ/WZZwvkrlNUlCN/D1zdrmvbPlfbnsWj2UmqAg4
 y3SWv3kMQVDRZfc3JIj8N798K/PH6ghhNYfDkFfWMnE4Ya60oiGDKhAaDznyevrHCXYzEvX
 tqRmo65IZd7UkSZJw8SuIspev31hr35lcNHmq9NGKPQhps6jJzyxFajJHEknLt9Hd088yCJ
 TyWgTlqA9tscQ3kj2EUpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3w+aUfaLVY=:74FuGyCmMPi3u9jJuUe6V4
 nAR9C91pJ2MZqR1Qnxvvt7+iLiYRUXUUs1NvmQrZOkNo0fN/oCeaiWUMg0I5usPXNQ2NBKbVK
 bAv9sqbopzwhO/f6XzXFNM8QIz3juGR9SWRt8vdWdwaTwsML2IN/FHB90m7FUxPMYYc6EFQ3J
 KVB6prwGDwOsUiQQb2ti4B7EVtDvVcqS52sor+NcQaa6rXVIxHo92e9f9uoD6RSaQdezScfXA
 ptrZLF2M8fyADagMtWHJDdaTdA7spBhaHgrIhEgkQL6Dtp8yYbuFXbh6S+00osry2F7q1KMvu
 jnYw2jFY+NzFHz9DRlKEiJGNpGqyk+RRehsuMmdEdRO+85Rtbqd1vBzJXwhu7vVFmohOBSlTh
 tgdI8p3PIrlQ6xoiDuA6dgfWcLfm0vFK9/AomWkHXLmZgX717A8uwMDSlO1DBTdHbfpPkG4LX
 W1EKN1WPBmPAnvTCV5p0pPMOI3kidESlUcaKeEIwUjPWrJr266UJF2MLKH8/8rBraTNKQCjrU
 xZ8tKhDKTSpJ/FaGqeNoRT+5kAbddv1Gmz0kQp9EMYzv883wQkIf2AJWdErFzPvHKaAW6OSHC
 Ui7rHi4Id18jN0mGZnJCCGGfgMVOMaQwjuiBGov5QdWrxwDJGQIherxNzgxfOVCvKkrNiL9iC
 gOMRMp/SmaYfmusckED8D1SBUcOpzRylQoOYmd5cHUeQUhqjCj/eM0+Gu9RaCHLnCS2w+v4X6
 BpKEmUJOt7tNKVGdBSCwQmr3FcH/Xsq99hlSAvP7zp21PmE5PTBbOlt4A1CsnuPlDQExFQbIy
 dogkg65N6cmUj2Oljk27v5BlF04cIdVnrCvu+q3BrK7B9Hj8jCtV31iT0a5ikGbKuvx+CWbqQ
 15Ueg5Oi8WGgi0wrsaIabD5XkqeJZwGX8pRB1FuZmfDFeQY2lrkmJPDy1qiHIR/lut5UKNv5Q
 TEkuwIoNUCsf28vlfG2fJsqlJHrJVRAMOfD6bhuo9u+wWsYNCpDDUE8zumd34tVqqnonUeSTu
 l39kyvmSPx9/vnP8xwQQ4Sadxo7gsuCx9v+VXor4E5rGbBaSjhWEVjD2FNeqZLTwSaaQuYHrJ
 QzW+ObZzkgNPLz5Ezx+/DoEPQbugo5VeH9+GtqkqZg0YSs2qyUt+d/XhA==
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 530
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/2c62caa7-56ad-b1dc-4045-84f008aff6be%40web.de>

>>> Could you repost your semantic patch and test code?
>>
>> I imagine that a semantic match (with the application of SmPL asterisks=
)
>> could be also helpful for the desired understanding of the discussed
>> transformation approach.
> I don't see why.  I'm only concerned about why a // comment was added at
> the front of a line containing real code.


Jakob Koschel provided the following information yesterday.
https://sympa.inria.fr/sympa/arc/cocci/2022-08/msg00025.html
https://lore.kernel.org/cocci/5369B40D-9EA4-401F-A9CB-2CA1C0E3332E@gmail.c=
om/

=E2=80=9C=E2=80=A6
I've only used adding the comment to see if the matching works correctly,
I'm not intending to do anything with comments in the final version.
=E2=80=A6=E2=80=9D



> Perhaps the pretty printer treats all comments the same...

How do you think about increasing case distinctions also for further impro=
vements
of the Coccinelle software?

* Under which circumstances may comment additions influence the control fl=
ow?

* Should the addition of a C++-style comment (before an SmPL ellipsis)
=C2=A0 eventually trigger the appending of a line break?

* Would you like to extend the test case collection accordingly?

Regards,
Markus
