Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CEFC04A95
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bTFWboLnYBngPKgNEKrIGcjlJkuJyBTMxJuQOFGFHmw=;
  b=PpOdpv35RsoyXDELp09Nre1ZSrTqHDRdUkr4SslEay5Qfo5EtYV/gsES
   wxHKGC8th+l789HeKhQ9RaaJcYImcUevFWzBd12ENnjGeiytrr7lnhnQs
   uv5/kjGoW3Ed+tfOk9nlsVLbx36ZgaZ+b76DqG8bRL9+WD6N1MIMWAxcj
   w=;
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
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55112998"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 11:07:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE507E0290; Thu, 29 Sep 2022 11:07:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2AEBE0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 11:07:47 +0200 (CEST)
IronPort-SDR: 63356063_mY2JoB53Ot2NY7z35WJ9sp6Bi4eLxrWRuXrs5YYx8yYb9cx
 j4uYTH2oWMx7LAEPrj5UBi4Uq+0bQ/+Ub6qwtgg==
X-IPAS-Result: =?us-ascii?q?A0DBAwAVXzVjh07ASNlagQmDSyiBAVYuBAtFhBE9kRQDn?=
 =?us-ascii?q?xALAQMBDTcIAQIEAQGCEoJzAoRsAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEXCxcHDhAFIoVoDYI1KQGDZAECAgEMFwQZAQERJ?=
 =?us-ascii?q?gEECwUEAhoCJgICVwYkgmwBgmwBAw0jBwyPJ5wXfzOBAYIIAQEGhE4fLCJSg?=
 =?us-ascii?q?VwDBoERLIcWiBp6JxCBVUSBSIJHMD6CYgWBXYNWgmaUfIRKOANEHUEDTTUYA?=
 =?us-ascii?q?xQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk02CAQIBCskDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBTInEAkhHA4aDQUGE?=
 =?us-ascii?q?wMgbwVEDygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDI?=
 =?us-ascii?q?mcFAwMEKCwDCUAHKCQ8B1g6AQQDAhAiPQYDCQMCIoFQNSgFAw0ZJggFIxceB?=
 =?us-ascii?q?Ag8AgUGVxMCChIDEw8GKZlJgSAQWx2BAyFUgUsSN6BtjU+SczQHghuBRYFJD?=
 =?us-ascii?q?IlnlQwzA5ZhBpIKlw2NPJRFhWiBeCOBWzMaJIM2TgMZD445gQ0BAoJJM4otP?=
 =?us-ascii?q?zQ7AgYBCgEBAwmFRwEBhHMBAQ?=
IronPort-PHdr: A9a23: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
 chXIle6fFkyC+9cFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8vmVsaH9IcpO0n5HpLqEKseALOsnbusQ8zAXPo5KKSC9Ffbo7/
 xG/c5rtyMc7Qx7ZJhOo6HkBEDtex3hHL9OkO0s1PKZLW/bUQiTQL2Kj7GM/9SIIUSXm9K1l5
 0QCpSXzbbLfD9HZK3BkWqF+rgboeVvi5rY/9s31B1WPHxXgkxbnntEIzfeLm0zYAVdH5I2GN
 6g9tNKzgDQAkj+V66AdwY4t2Ovnbf2qK4=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55112978"
X-MGA-submission: =?us-ascii?q?MDGPL7SFSSRe1h3lYA3hojTkfFn6+fuaBMYuSy?=
 =?us-ascii?q?6lVRvJ4l5nyPVpa3RA81ldHKrgpAz/iKSL9Qsgh/5J2r0JSj0asQhsAj?=
 =?us-ascii?q?LIglBB5suphVQi8OtSbQC6hyVhtl6iw/t/qwY2fBgVT67hw+TR2CLWS/?=
 =?us-ascii?q?TjKwJEtHLwz0HC0a4ysdnZog=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 11:07:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664442456; bh=RxdIYsruKzX5JyRbHRDbBiT17H8aDYbcBl4wMPVu+hM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RG5MRtkPCgk+eqsAZr7/3cwrbZKxLemQCJ3dXrlOO64MG6KfCj/MnlfWqRa911XIe
	 VAIPl1jfqItyLr/A2UacMq7NhtR5uJWqSCBFZ0xnmNszLI3AjJwHvetbcQDTuZUm5t
	 s78RalChlSm7PrBELxmGzjYcz3ctq8ngC315n3K0MVqTzTs8uKG6n+dR/7OLXHLQrF
	 kEVvGoUxi4ZNemP5tu/HT12DNWvzo37Z13RbrBMLF2kd051qQ8VKdhMXAuC2TpGvAH
	 fciZG+UxSlcATvRtvCoTNxCSKmdZL1WldY3uqnuPv37b40VuIyjc8D3jM5BLF4VwPv
	 Hmpp2/Wx/e2YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap27.server.lan [172.19.172.27]) (via HTTP); Thu, 29 Sep
 2022 11:07:36 +0200
MIME-Version: 1.0
Message-ID: <trinity-ccfe7d99-bf56-490a-88bf-74fad2b21b9c-1664442456545@3c-app-webde-bap27>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Sep 2022 11:07:36 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <8076a3d9-6a67-5e48-4046-8f33f261f4bd@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
 <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
 <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
 <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
 <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr>
 <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27>
 <8076a3d9-6a67-5e48-4046-8f33f261f4bd@inria.fr>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:CwDt0SgZdrElnzBv7Xc3d8cmaEWfPyLhP41a0/05o5Wf2BmupG12cuZ7drUGeNWNHLa5P
 he1f/PagrLwWc/fn8CsCjXu8Wm1X/dZ0+mg8E3GregosK4vNtwhUVTuyNm7VvUK4At411KOZ8g0D
 vEzP6zoRToCgOM0W8KITjOfPa0Y+t/LYDmx4L3uK6cD7bNhs5qC4ylF9rR6B+aMb0uhTba2VBMDs
 v93Mif32csmV3Ed1THr1gYG7NYBiHzSUqF0J2jhTJGoURDMNUtZA5qjF4hf97LeIZHGSbs+jHGPJ
 6o=
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvbCLYZ+fNw=:q8tMfxTLaUv7CJhVE1b/Lt
 HHhicTste7yxcK6Fzgb/4iglxgqeAqGroWbT7FaZIH1FEyEOGHvAVE8RzGdFM7rH8zGPSl9a0
 pIdnSCsytZnT3KP4lv3PBeKhYk0HbNrRtlUKNW2Vg5nYbbX+wbf6aelCT30N+kLvMEyWaQZhx
 xQ7GH9VnNc86nV9ZC8P/QegYr1qQr+3zUPw3I2cCi7EbTNBDjHATWjb6YusvcAQtBbiifZonE
 I8j7Tdna/Po4Rt1jLVP9YFdNy1Q4ZS7/kT2sle8idWuuziGWf58apnJlvxoNtIwLnxIJRm1dE
 SqsaVt17jnbcYiiqzjeYZS6ljONIkv364TAW/NG98x99ZYmU5Se7mFY+ZwIccHech/gMhjzX8
 pDuc6JE5kpstANSfzh+RnWfLnRFuisoOUNL1de2PUUk4X27J9jHKxucOQQKl6VdGu8R+E3TCO
 yFLEnCzdkEAEDzeMOmLB14RzvM6j43pkfPnhQlU9ldBBN43MUj60pC9HRDYdE1sRCD49jdmQC
 VgVZzZXf7rQlI8CGJzKpu5+oagsxWolPyNPQcnwcBfN0rJ5Ly79uZMV6sazzU2NEvCO906bVJ
 UhWZ+PXeuQxDAy3OpMldfeytXBJgulXLty7ASnadSom60f5TDTv/XzO87l4OK/1GsUUf9W+aI
 ZsOj4FjJT4uNwwTIu0Bv9boVA1ziK2bAQPuDxU4nmYUPoBodC7UBWFsfLkEQRfb8jD02n0iv+
 /aLrYHq5sD5OeP3KuKL04apwYcpaWRY/+fFc0ifJTkAiBuYPXfB+bRRMCPee/CXs17UJlECuq
 tLBGZ7j
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 606
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-ccfe7d99-bf56-490a-88bf-74fad2b21b9c-1664442456545%403c-app-webde-bap27>

> > > Huh?  Why would I want to use identifier?
> >
> > I interpret the SmPL rule =E2=80=9Clock=E2=80=9D in the way that sourc=
e code should be found
> > that fits to calls of selected macros (or functions) which get address=
es passed
> > from data structure members=2E
> > The address determination would usually start with the evaluation of a=
 variable name,
> > wouldn't it?
>=20
> Sure, but in &a->b->xyz, the type of a is useless

The item =E2=80=9Ca=E2=80=9D can be used for a member access operation=2E


> in figuring out whether this is a pointer to a lock,

Such information should be provided by the identifier =E2=80=9Cxyz=E2=80=
=9D (at the end
of discussed expression variants), shouldn't it?


> and in relating this expression to other expressions, perhaps with the f=
orm
> &q->xyz that may refer to the same lock=2E

I find the indicated concern unclear=2E


> So we dont' care about the thing that is immediately to the right of the=
 &=2E

I got an other impression according to the proper selection of a correspon=
ding
source code filter=2E


> We care about the complete thing that is between the & and the ->xyz=2E
> And that thing is an expression=2E

I agree to this view=2E


> > How would you like to improve the desired scope (or name) resolution f=
urther?
> > https://en=2Ecppreference=2Ecom/w/c/language/scope
>=20
> What is wrong with it as it is now?

I got the impression that the representation of corresponding scopes is st=
ill unclear=2E


> The type inference of Coccinelle follows the scope rules of C
> (like any type inferencer for any language)=2E

This can be=2E

Do discussed data structures (like simpler source code search approaches
or the used OCaml data type =E2=80=9CHashtbl=E2=80=9D) trigger other softw=
are development views?


> > > and second the thing in the matched position is not always an identi=
fier,
> > > as in &a->b->lock=2E
> >
> > How would you call the item =E2=80=9Ca=E2=80=9D then according to such=
 an expression example?
> > Which terminology would you prefer instead?
>=20
> a is an identifier=2E  It is also an expression=2E

Would you find the SmPL term =E2=80=9Cidexpression=E2=80=9D more appropria=
te then?


> But is not not useful in this semantic patch in any case=2E

I find the double negation confusing in this wording=2E

Regards,
Markus
