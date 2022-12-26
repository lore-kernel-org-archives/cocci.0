Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD51C3DA79
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sqK4q7bujNM4kSre2MVQx4PVuszaNJK1X9ucdRbiYcc=;
  b=ndMa9wW65LJuPQ78O6XW2EMyME5vK1P4ZUJzw3VWkcKNu4JTz10q5gBK
   RG00p2ach/M6Eb8B69DqECwnSeVyExRKbRHlvu2awVMxtYgmd52c/esgv
   9sz2FTr2q2ToGdlF9QQ8Nt7XJoyifZVbTs1dyhq5u9LpXDMK+0oXA8LJC
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85087549"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 15:10:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6EFEE0141; Mon, 26 Dec 2022 15:10:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CD37E0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 15:10:17 +0100 (CET)
IronPort-SDR: 63a9ab4a_ivzgKJQKLawvPuTNIQIancqW+SQRWMMJObLD4ba555J5FMH
 NQ97zayZyo+xICebvh5tsHmBLePkfC2AgNOwCiA==
X-IPAS-Result: =?us-ascii?q?A0GABQDaqaljhwwR49RagQmDfIFdLgQLRYRPjnqCJQOEK?=
 =?us-ascii?q?4clhTaNcz4PAQMBDUEBAgQBAQMEhH4ChRACHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QBSKFaA2COCkBEWSBCAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BAgIBIx0BAREmAQ8LGgImAgJXB?=
 =?us-ascii?q?g0IAQGCeoJuAQMOIwevF4EygQGCCAEBBpwIHywiU4FeCYEULIx7gy56JxCBV?=
 =?us-ascii?q?USBPIJTMD6ERINXgmeOZ4o0CoE9fYEnDmQlBA4DGSsdQAIBCzsyCkE1CQIMS?=
 =?us-ascii?q?ysaGweBCiooFQMEBAMCBhMDIgINKDEUBCkTDScmawkCAyJhBQMDBCgtCSEfB?=
 =?us-ascii?q?xURJDwHVjcBBAMCDx83BgMJAwIfT3ACLhEVBQMLFSpHBAg2BQYbNhICCA8SD?=
 =?us-ascii?q?wYmRA5CNzYTBlwBKgsOEwNQgU8EL15/CgYpKJ0GYIJJkyuwDzQHgiKBT4FQD?=
 =?us-ascii?q?J5vBhMulnYOBpIal0aieYUFgXkjgVwzGiRPgmdPAxkPjjmEDIosQDQ7AgcBC?=
 =?us-ascii?q?gEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
 7AncYrsJT0E/9+GpaMh
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/CFiIanEEYlb36Jre7olk3inH2rpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85087548"
X-MGA-submission: =?us-ascii?q?MDFvYU2KuvFbKuy0p4aaLL0dRbLu36ex9L8J8f?=
 =?us-ascii?q?J7/H8ArZHwehzNuD+8MSHIguAHXtqA2Bf/5vJeMRdTJR+B/I/fqaPvvK?=
 =?us-ascii?q?tXIZvvZCOxX7Ud9xJ8ZNnOBMd/c9ddKYcmoxhe+40cYuyHnRXcTyRHC1?=
 =?us-ascii?q?nRmt52NqJlo0EjJlEGqFYnIA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 15:10:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672063816; bh=ABFxBRZcD9jD5HKYp20rHlVADGgTttQ+QoNjReDMlRU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZqAUbzE1HgcU22sfkNFsD8fmz9pNx438+gqN0AT0IJ8cWdocQM7sruMP+1i1naar0
	 sVxsomIuM4VQbI71baz8NjTAD4ffOvx6xm1W9UIjnIN5Vw9Oy1pMHAJCOAi1IUnJa5
	 M5tueDU6HVALwdHhdXjKSh20j2Wfybg/cMQWDM4R8gII8G5VbFcf5/8Kbd1Vq6JOm8
	 anxwUZJDcJta7WzoKlDckWxsyZYUcIQeHUIKqMa4VYv+ghZJfJjgncg5wdHbOfPG5D
	 V0/JY30oUKt4EoFDrXjhYcHCEwNqPV0gt1Mv+3zKtvHM2jlKrlPguIWcSjJFd093Km
	 kb9fZRJsaNryg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFlo-1ofRFK1L5G-00eXxN; Mon, 26
 Dec 2022 15:10:16 +0100
Message-ID: <0332ed22-dc0c-c3a5-7aff-84893746fe33@web.de>
Date: Mon, 26 Dec 2022 15:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2cADxY8q0bRjMWIhrPjmhcU6x0JP65VPrxLG24XIpQso5SxZgS
 1v+PEqtCJq6yVivyC2iGmmQcqZ9WkHqjguOQCA9IzSndbAYpku/wX74FZOnfASMWHftMA+r
 dQJ21ML8ZQyfXQxTQCsMeSaxra6IwZtD2VKWe9U060MswuFymVgJhnpnkfzytHxGHCUH05R
 OlObivRxZt5DhPicNieug==
UI-OutboundReport: notjunk:1;M01:P0:u0yYn08dKrY=;xPtkrXiImPm3TjJnLKVWu7t+1kA
 /VfK6MamuXFJ3pOCqYXH4bjAIrtBYiaMlNKfxVY/wu2IWZkmbRoe2g3Y+LtNA/jSGTt+TfQhy
 0gR0QdjVS5uMDTqrqyxb2l8dzBrgMTN22ycPn9KNcJsESowIV5//TJaHRBfkOw85ci7LeIWzc
 +k4xomS4tpkt/E8AXwMNdffMLagmEGXm0D9z+8U2IRzum7HoyxzPZGOUeLRbVhFNLBEEbuSVv
 I08pxxoX9W4M8qiOiNYhK7nx5y8laGE6LzxKFFirt6PAlFUIYAuO63T1lk15EBUK8bErA7/oa
 abJuHB/JhowMkZMhf9Rg6bnYJXEAI/2uoirpl/PDtiXh8ieSYubfluCBMB3WrLW9YtAXd/axq
 eCX6zKjZIPS9xyv9dSXe7oU5f1ArxEtmfFwiZ82/612+Huz+lCTRJOVfNPh2fmJ+46org6uXf
 79eHJCvs9tsDSbpDPZPGo8cQ9rMnxuNEGtjHk2v0D+KnV0iGFQCuzfjor1+MRERZZ50BAvbb6
 DIsuyUC2QdUmqaf6sSUyPa7l2fFsN+vGXT9xWJaeJF2ObsXjf7b1EqmDhfBCjvOM25HIiabpg
 VbXz0XY/Hc/zmOf9R+NW67tfCl2N1rQ6DennE4p/nhtrH8okHM+BjUtyiuSBl+RIi3FzmUxs6
 eXjRru0PzBH/bCn6kHszi937XlEcjrVtwV2jinSEKo9WZKwZPq09KupEqhUGPOdm311Xbl7xn
 QhVPAfAf2Un56w0rpvsFuiDBVkGZ19DzmmuvBA821DTOJN599dhuhGHJD25SCHoeA5t/OP6Hl
 C2N6u6Qemk+27EHRE5YW+FU/h2HY5QfpGaWkobA0wP6KzSRK5CY2tI2cxrWLbyUwJPnK28dFP
 XjcdDOjvb7/H7zv2Lho35ChlZ1Fb/T6I7fbjk1NGy3w2uWsrUlIVSKEFuXrDjvUt6bk5TAaSU
 HT7KpQ==
Subject: Re: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 792
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/0332ed22-dc0c-c3a5-7aff-84893746fe33%40web.de>

>> Does the specification of this metavariable type indicate the expectati=
on
>> that the applied metavariables will receive contents?
> No, it should not.  Lists can be empty.

I checked another SmPL script variant once more.

@replacement disable neg_if, drop_else@
bool active;
expression call;
expression list el1, el2;
@@
=C2=A0<+...
-if (active) {
=C2=A0=C2=A0=C2=A0 call(el1, active, el2);
-} else {
-=C2=A0=C2=A0 call(el1, !active, el2);
-}
=C2=A0...+>


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi cppcheck-11402-suggestion3-20221226.cocci
=E2=80=A6
@replacement@
bool=C2=A0 active;

Would you like to reconsider the detail why two words are delimited by
two space characters at this place?


=E2=80=A6
@@

<+...

=C2=A0 -if -(-active-) -{
=C2=A0=C2=A0=C2=A0 call(el1, active, el2);
=C2=A0 -} -else
=C2=A0 (
=C2=A0 -{
=C2=A0=C2=A0=C2=A0 -call-(-el1-, -!-active-, -el2-)-;
=C2=A0 -}
=C2=A0 |
=C2=A0 -call-(-el1-, -!-active-, -el2-)-;
=C2=A0 )
...+>

I got the impression from such an SmPL representation that a compound isom=
orphism
was applied as expected for the discussed use case.
Can subsequent messages be confusing then?


warning: iso braces4 does not match the code below on line 7
{
=C2=A0 call(el1, bool active/* bool=C2=A0 */,

Why was a comment added for such a parameter?


el2);
}

the following code matched is not uniformly minus or context,
or contains a disjunction:
Stm:
{
=C2=A0 call(el1, bool active/* bool=C2=A0 */,
el2);
}

I would interpret the shown code fragment in the way that it does not cont=
ain
elements which were mentioned by the message.
How do such details fit together?

Regards,
Markus
