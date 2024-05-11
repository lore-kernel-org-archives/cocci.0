Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D23C04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9uaQr6rAw5x5KlPqlE3lwGeltKfcuFh3HUNLkiOmFxY=;
  b=EarbhUuKAeYhpX21rX6dmIlFId7f+zyEM3QkPcd4tRv3Jt/LH+c89BA1
   rJE0gXggUwJHiarLOcmo6D4GlEdkGBKkrKZHEBw8MHVMyIcVA7QY1zDhL
   Z8bdwMOA4OVSikNShIZKkfZtiyzDqLdTP8SJFWybKC0SNd+RuYCpzcm2D
   Y=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165200987"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 18:35:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8F42E0CCA; Sat, 11 May 2024 18:35:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 849E9E004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 18:35:29 +0200 (CEST)
IronPort-SDR: 663f9e51_5lYiyZnSrB8CCVcGelPoVoRNNyhLyQ78jxJ7EBbEUmjgxms
 G3CB62bj+ToHC3K8+lvqJ4eOqBhzYVBU92tH0uQ==
X-IPAS-Result: =?us-ascii?q?A0GbBABInT9mhw4P49RagQmDayiBVDMEC0iEVpE9MIQ7h?=
 =?us-ascii?q?zmHT4hxgxY+DwEDAQ1BAQIEAQEDBIILgmoKAog9Ah4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcBEIEOgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjHQEBEScPCxoCJgICVgYBFAEBg?=
 =?us-ascii?q?nyCMAEDDiMHsxOBMoEBggwBAQbaWR8sIleBYwmBGi6ILgGFfIRAJw+BVUSBP?=
 =?us-ascii?q?IJSMT6EQ4NbgmmaJJBPVH0cA1kyAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCE?=
 =?us-ascii?q?gwGBgZZIBYJBCMDCAQDEDQDIHERAwQaBAsHdYF8gTUEE0QDgTiJdgyDMYF3K?=
 =?us-ascii?q?YQdCENsFYN2gXcOYYNahFFmgS0dQAIBC209NQkLGwYiAR2mcYFwsn+UTzQHg?=
 =?us-ascii?q?jaBYIFhDJ9EBhMvlzgOBpJomGIgqGeBfCOBXDMaJIM2TwMZD446gRUBCIJ2y?=
 =?us-ascii?q?nNBNTsCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:nsKAgKpdVWRMzUjRb+HaD94aV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AsgFKk2k0OARkTneIaN9r0WVZYwnXOSzc8nTNP0T?=
 =?us-ascii?q?nNVtkd62/ZVPB0aF5nMU7zg=3D=3D?=
X-Talos-MUID: 9a23:+V+zfAqsL+9j7snEhWEezy9jMetqyb2BM1gcv49Zuee/HH1bAQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,154,1712613600"; 
   d="scan'208";a="165200986"
X-MGA-submission: =?us-ascii?q?MDFyX2sMUbTKcQyDqi04J1hlXaoTVMrOHViPbm?=
 =?us-ascii?q?cLuzo//UieVUYxe0G7gHST6DL8vU36aTRMjkvwSHiPeG3l7n3TzcDpMo?=
 =?us-ascii?q?wsy0xJTen0TeiESNrZB1IEpWd3Ay0KIDz+pYekDeKldQvE7V9ERWTfXV?=
 =?us-ascii?q?+KgV1qw87WLUcGOkNXoQu07w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 18:35:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715445328; x=1716050128; i=markus.elfring@web.de;
	bh=9uaQr6rAw5x5KlPqlE3lwGeltKfcuFh3HUNLkiOmFxY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OW74cw6usNUrk9aM4jTSHkHIGuA21aNVvGRQlMwaYle+seSjT+xoJOzAnNCoYZOJ
	 GZSao757D7nmsJ60wR6skCb+xkdTy7YYImsj5JNt16kGVSHzopWfvTmTxqIzzh38N
	 LBjeq+sJB1fy0l0tZMXBy0D1II8jdEONm6aCbw+ZAnYMdmQuA2j/xKCzg8hRjPasH
	 Eagj3tVHZoxQanzDCBJh1jumxsGU+veF8/DtMvJuoRQIHmRxZM2wRRdkt+k0JfjPL
	 QkXGNSMoopbQWwXzAcJcM4MGxiI1wTyONxIbmWSU3oFZOVwKQlsQcAFzxmQCA7XvY
	 aCvEza6t0RMtJ4Z2Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWi5s-1s86rw1Hc8-00PxO9; Sat, 11
 May 2024 18:35:28 +0200
Message-ID: <3c953d7c-561d-4ba8-ae23-ffeb12840d02@web.de>
Date: Sat, 11 May 2024 18:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MH3NEwExpVQ9nCNy/YZhM871Kba/cLpz7d9DOfn5RETOIGZjXtn
 tKZZ/uas8qDqJBX+VP2oQSQz4L6CMAS6l2wsIc9cajOoAi5XHfYqG9jY/sH3aGxrZt99dYq
 FMiz7gGcB3c6qw/KEVd2H+ZqydepUC2tTGj7fQDEHbjbHVOXpTyLb0wQTESfsIxTYQRYrXN
 1KyfWT0Y382tHRTFA3ncQ==
UI-OutboundReport: notjunk:1;M01:P0:VYDOkw5rZpE=;neCA2qv50/WKBhN3YDgvjE5zfa+
 a5l7apZoEsq29yjTT2YUciVDLfZGFr2SVEY4J4O0l+JSmE4GrTZ4oAga13hpDTsmAFdcpmSHO
 S2CR3W3zzJ8/C2Gdx+NNSXG6NnKB0nEz8diG1NGC1cghLLyrlsNmzgeBo42f1C3WZsW3s6uc0
 BRc9SWYkaoE/erGi9JcPvtFJHbyGXqZsSLmBEsg1OkygpJRpUz2IT/uFFybk9b3ChunrG39ia
 VkaFPalODh0DINXUO6gUtWnDSCQIvGCgKLRQ/A37NJ9WryIW5Ax6ZrCdL1bhVSwYm32rHtMvU
 HQlNZCUdKrYlBxhT4ee56BYFgKp93z1ShvnaNURLBiJt6APKaqyKxXoZnefI7g8NjLuEcIS0E
 MnppPREVMCp+wrBVPnBkYNi+okbe+N+zLrioYY6DBLVzLdyLzbR39AHnoJ6sEAcBstxvtPdPF
 BixFp+m3hcxA9p/w3g1uCkcolan+oCyW0k94Uw28YS3deFsrR7NgN+0qdG+wWCt7ihfzEq4zM
 6zFe4ZTCFTca8OelG9EUgrgniTIxtZ+MXdLO8eKyEohL1Qmfsg08vtNgfK4+aTFm16GlSM/u8
 LtbfPn5NZYd42Nx6imjew26yxDgJeiqUeREoP9QhkTj17Mu+1yp4L/9dCZyCKzzNn8fO3mBeW
 BaCTY1E8Y9SsNu03qZ1DLuYFIzkBEFvOdV1XgVpRm+E4zbTAX/1jLCR8Lziz+g4/G1dNNt68w
 EXZCrzKeBE0ahMHFCXaY3PHA52ZSyi1aJC9Nild6yp90nAcEb53m5bDJLU62/JPxDt1k6xevJ
 XMfVVqSa85kP3RH36qFbQoU6Hxq5+mqENrGcvYVbwSwxs=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1715
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/3c953d7c-561d-4ba8-ae23-ffeb12840d02%40web.de>

>> Why is no diff output generated by the software combination =E2=80=9CCo=
ccinelle 1.2-00008-g75525032=E2=80=9D
>> so far?
>
> Your semantic patch needs to be:
>
> @display@
> @@
>  my_action(...);
>  <+... when any
> *my_action(...);
>  ...+>
>
> Without that, a call to my_action is forbidden in the region matched by
> the <+... ...+>.  Because any kind of dot thing matches the shortest pat=
h
> between what comes before and what comes after (here the end of the func=
tion).

Thanks for this quick feedback.

It seems that we expect different data processing also for the shown test =
case.

The SmPL construct =E2=80=9C<+... =E2=80=A6 ...+>=E2=80=9D supports a sear=
ch for code parts
which occur at least once.
Thus it seems that the specified search pattern needs be duplicated before
if you would like to find code which should occur at least twice.
I would appreciate if undesirable duplication of search patterns can be av=
oided here.

Regards,
Markus
