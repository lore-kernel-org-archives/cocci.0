Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77F0CCA482
	for <cocci@archiver.kernel.org>; Sat, 25 Jun 2022 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=x4wbdnxAg9IQfvLXt0JnRMgyxywI8bO2mXS6K1R4n6A=;
  b=ciENpbDqHxsqf8D4lYeiOJ6sCh65sufuP3MZPRpBe5DZz0ETfy81dvRY
   E80Wh+ZJ+T1R4OePNnMez/zod6AR6pEkjc5baucdQXr67X8MLy/N+xsnR
   ozmYAq7WqE+QhbEOvzXzpOrQXPy1csv64BUfF6jxIPmTG7EpjoSJmZiDc
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@lwn.net
X-IronPort-AV: E=Sophos;i="5.92,222,1650924000"; 
   d="scan'208";a="42838466"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2022 14:33:54 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0BB8E00CA; Sat, 25 Jun 2022 14:33:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5521BE00A1
	for <cocci@sympa.inria.fr>; Fri, 24 Jun 2022 21:37:11 +0200 (CEST)
IronPort-SDR: 30uFfIQddt8341s0mfbmGwFUrzRvLVP1sCky9+I0KO3VQF1CSIWwLqIgSNPq/3GWV9IdqSWWVO
 xG2HPfjhQ2faeuJd5MUVlOjVKpLSLr+UwI5NcGO/A+Ye8qiVIbMqkTOK0YHlc1dOb9KrNoowWz
 J+Nvuh7qW8BkNihcAge4jhweivcBRYWE8+UjUF8G77qHJLjR30blknXsy5+Z44hBvS00FquXyd
 oGHg2B9+tFaCKxc1OdzgfxS5LGn5p+LcWwRbwEPH21VZyZez+QRlWy9HM1A+m7WF5tYil3vrXG
 LyDY1cWhvOvwWOxbYS2MbXLw
X-IPAS-Result: =?us-ascii?q?A0BfAAAhEbZimBxYTy1aHAEBAQEBAQcBARIBAQQEAQGCD?=
 =?us-ascii?q?4FSUoFXLgQLRJVeMIpqk1ILAQMBDUACBAEBhQMChUoCHQcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEBAQEBCQsJBwYMBR4FPGRnA?=
 =?us-ascii?q?YFOAYF5BgQwDYI1KQGDYwEBAQECAUABATcBBAsLFQMJJQ8BETYGARKCfYJmA?=
 =?us-ascii?q?w0jAwEEqmSCK4EBgggBAQaFFg2CQwmBPYYehD2DI3onHIINgUuCdD6CIIhfj?=
 =?us-ascii?q?ROMHzkDRy8SgSBuAQgGBgcKBTAGAgwYFAQCExJTHAISDAobDlQXDA8DEgMRA?=
 =?us-ascii?q?QcCCRIIFSsIAwIDCAMCAyALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIED?=
 =?us-ascii?q?gNACAsKAxEEAxMYCRYIEAQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDI?=
 =?us-ascii?q?Q8mDQ0EGwcdAwMFJQMCAhsHAgIDAgYVBgICbi4NCAQIBDckDwUCBy8FBC8CH?=
 =?us-ascii?q?gQFBhEIAhYCBgQFAgQEFgIQCAIIJxcHEzMZAQVZEAkhHCkKBgUGFgMjbgVFD?=
 =?us-ascii?q?yg0NjwsHxsKgRosKxYDBAQDAgYcAwMlAhI2KAGbXYFSgQGXBY0inVNrg1iEG?=
 =?us-ascii?q?pV9hX4xlmKSApZwIJBrljGBeIF+MxoIJgoagwlOAQIBAg0BAgIDAQIBAgEIA?=
 =?us-ascii?q?QECAY4cGYgyhiQiNDsCBgsBAQMJhUQmE4kEAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:+sVjOKjM1z1hG/IMaqJ/xKqiX161aRYKZh0ujC45NGQN5FlHY01je
 htvCzqPPv/ZZzSkLtkiOYS29koP6J/Rz95nSAA+rihnQS1jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/ZeDYATNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplq7iraAR1Fa/2ktsPUxp0Q3wgLfBK5+qSSZS/mZT7I0zudmCqx+poSkc7IeX0+M4rXCcRp
 LpIeHZXPnhvhMruqF6/YuJrnM4uMOHvI4VZvHx8pd3cJa95HsqcGvmSjTNe9BYbj+1zL8qHX
 Zc6eSdNRw3sbhdBYkhCXfrSm8/z1iOmL2YwREiujaEw6GPS5Bdg1aDkdtvTYN2DA8tP9m6cr
 33P+2DREBAfPsaWjzuD6HOlwOHV9R4XQ6oXD/u86fgshlCProAONPEIfUWfuti61mW8YdhgO
 UwX1npz87hv+FP+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8LoD+CxWDhsotlpNoJOiSMmedA5/
 gTWwo2zWFSDpJXQECjHru/M9lteLABPdQc/iTk4oRzpCjUJiK8pgxfISMoL/EWd34GoQm+YL
 9xnqkEDa1g7iNVN07q9u1bKn1pAR6QlrCZot207vUr8sWuVgbJJgaTzszA3Ct4bcO6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QcR/r2XwpyX6J9gMiN2bGKuPGplfEdMOS
 BCK0T69GLcPVJdXRfImM9roUKzGM4C6TYm1CJg4keaikrAqJFXeoHoGib+422Hrl0Qh+ZzTy
 r/EGftA+U0yUPw9pBLvHr91+eJ1mkgWmD2CLbimn0XP+efPPxa9FOZaWHPQNbpRxP3f/23oH
 yN3apHiJ+N3CrOuO0E6MOc7cDg3EJTMLcuu8ZMLLrLYfFoO9aNII6a5/I7NsrdNx8x9/tokN
 FnkMqOB4Fag13DBNyuQbXVvNOHmUZpl8iA/IipqO1u0giBxbYGq5aYZVp02Ybh3pbEzla8qF
 6EIK5eaH/BCajXb4DBBP5Pzm4pvKUawjgWUMiv5PTUyJsYyRwHA9tL+UBHo8S0CUni+ucck/
 O+kyQWdR5cfHlwwAMHTYfOp7lWwoXlNyb8iBxqWeoFeIRy+/pJrJir9iu4MD/sNcRiTlCGH0
 wu2AAsDobWfqYEC9tSU17uPqJ2kErcjE0dXQzvb4LKxOXWI92av29YYAuOTOzTCUiXy9bn7P
 bdZyPT1MfsmmldWstotTuYznPxmv9a/9aVHyglEHWnQawr5AL1XIk6ZgZtFuJpLy+ILogCxQ
 E+Op4dXYO3bJMP/HVcNDwM5deDfh+oMkzzf4KhnOkn8/yMrrrOLXV8LZ0uJk2pZM70zNo45m
 L9ztMkT4g25qxwrLtfW330ErzXSdiQNA/c9q5UXII73kQ51mFtMVpzrFXOk6p+4bdgRYFIhJ
 SWZhfeciu0ElFbCaXc6CVPEwfFZ2cYVoBlPwVIPT7hTdgEpWhPjMNxtHTULosB9yw4B1/11f
 G5mKyWZ4ElIEyhA3KB+s6KEQmmtxyF1PmT11F1PkmDFJ6VtfnKYN3UzYI5h42hAm1+xvVFnE
 HWwzHnjFzDnYKkdG8f0tVFN85TecDC6yuEOdA1L0ShI81nWrAcJWpOTWFc=
IronPort-HdrOrdr: A9a23:xaIJCK2W+blsfWNkgqTzfQqjBLwkLtp133Aq2lEZdPWaSKKlfq
 GV7ZMmPX2dslwssRQb9OxoV5PwI080maQY3WBVB9eftWrdyQ+VxeNZnO7fKlTbckWUygce79
 YCT0EUMrzN5DZB4vrH3A==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,220,1650924000"; 
   d="scan'208";a="17727140"
X-MGA-submission: =?us-ascii?q?MDFGuU7xcBVO8LnXMG31eTkdQIsPEpoOevYLZj?=
 =?us-ascii?q?JdLO/2jk8EOFQ8XOMYfzJe66esjbLhr1ewfmeLK1RIkTbUzAnPAxLORc?=
 =?us-ascii?q?pdV8FnRXwhYozc/nBWvc+F2xTjdvUTAkVbfCwQzyq88SY0K/pHMplIZv?=
 =?us-ascii?q?/+2mJVwGGDfCCnhsSJCzH4RA=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 21:37:09 +0200
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A9A002A0;
	Fri, 24 Jun 2022 19:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9A002A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1656099425; bh=x4wbdnxAg9IQfvLXt0JnRMgyxywI8bO2mXS6K1R4n6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mnneccn9+DDS2JB+u6+j5T5Ltk2U/SKqUehWNDuJuvUSwpuW8dSPLiDjIo9Tb951p
	 gRIJLOG734+W+QpKDiUNih9bg4x4merQ8WGtjYOlM3DIhMVkJF22hLXmFW7s+Vy78i
	 QaWDsGuffwM3qLDVNFuyGEqe4t4XV0ZyUuhJ3uiPE3N21EqsQVGlyMG2XPpzPJN2G1
	 l7JttZXrSrnFsRWYQJ/LOoXBSse6lI3aZY+KfgGTRHue8i6iprhQgegp8y6tGFONOJ
	 kTVwf+408frXWkrmxsJSgigm90Up1GrdoVLyv2vvjzRqSeLiYGYhYXkvnHLrJAvubA
	 tK0t2vZhMWj8A==
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <mudongliangabcd@gmail.com>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>,
 Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
 linux-doc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
References: <20220613071243.12961-1-dzm91@hust.edu.cn>
 <Yqbu8TwmaXdBiIBs@debian.me>
 <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
 <CAD-N9QUOk938-+1CtGfWNKUvWowknKScLuFXXkFAv59M=-F84g@mail.gmail.com>
Date: Fri, 24 Jun 2022 13:37:04 -0600
Message-ID: <877d554zvj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] dev-tools: fix one invalid url
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 457
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/877d554zvj.fsf%40meer.lwn.net>

Dongliang Mu <mudongliangabcd@gmail.com> writes:

> On Mon, Jun 13, 2022 at 6:12 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>>
>>
>> On Mon, 13 Jun 2022, Bagas Sanjaya wrote:
>>
>> > On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
>> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
>> > >
>> > > Fix the invalid url about Semantic Patch Language
>> > >
>> >
>> > I think what this patch doing is to point SPL reference URL from old
>> > Coccinelle documentation (doc root) to actual SPL doc entry on new
>> > Coccinelle page, right? If so, "fix invalid URL" may not be right patch
>> > description and title.
>>
>> Agreed, thanks for the suggestion.
>
> Okay. Let's modify the title to "modify SPL reference URL to actual
> SPL doc entry".

Normally, the way to effect such a modification is to submit a new
version of the patch reflecting the change.

I've applied the original patch and made the change, but it's better not
to ask maintainers to do that.

Thanks,

jon
