Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF30C3DA79
	for <cocci@archiver.kernel.org>; Mon, 26 Dec 2022 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+kmVrPJT6wmZ7VmvU1mmEfsN78phQI+o6/F68wLRcRo=;
  b=YVqGbW+HC4sUUAHy7Ov8rZe7QKcfB7sghjYOUwhP9pJhDo1ywoEolwtu
   JKHvVtVXZp6cWCUeFk2Gh8a4tzt3Uj/s5+FJHyjvXA6M1//d1+ZQU/gm4
   W7Putu5UD4ijG1u5rz8yjfqXEE0S2ew/35J1BRad/tjJuf7whM8HP2XDL
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="85077070"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2022 12:12:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44E86E0138; Mon, 26 Dec 2022 12:12:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B492E0128
	for <cocci@sympa.inria.fr>; Mon, 26 Dec 2022 12:12:12 +0100 (CET)
IronPort-SDR: 63a9818b_fwvpZ4kKzGLNspb8dcLKjE0PTWlVRlawF28NNl/Uotu7KvD
 j4LvAL1mkK7HjBBmiiBVMqQcSswkQUJpig+lzTg==
X-IPAS-Result: =?us-ascii?q?A0FkBQAkgaljhwwR49RagQmDfIEHVi4EC0WET456giiEK?=
 =?us-ascii?q?45Wi3g+DwEDAQ09BAECBAEBAwMBgguCcwKFEAIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI4KQERZIEIA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR1M9A?=
 =?us-ascii?q?QICASMdAQERJgEECwsaAiYCAlcGDQgBAYJ6AYJtAQMOIwcMrx6BMoEBgggBA?=
 =?us-ascii?q?QaBQAGaRx8sIlOBXgMGgRQskCl6JxCBVUSBPAyCRzA+gmIBA4Feg1eCZ45ng?=
 =?us-ascii?q?wCHNAqBPX2BJw5kJQQOAxkrHUACAQs7MgpBNQkCDEsrGhsHgQoqKBUDBAQDA?=
 =?us-ascii?q?gYTAyICDSgxFAQpEw0nJmsJAgMiYQUDAwQoLQkhHwcVESQ8B1Y3AQQDAg8fN?=
 =?us-ascii?q?wYDCQMCH09wAi4RFQUDCxUqRwQINgUGGzYSAggPEg8GJkQOQjc2EwZcASoLD?=
 =?us-ascii?q?hMDUIFPBC9efwoGKSiabYNagWgbkxCwDzQHgiKBT4FQDIl3lHgGEy6Wdg4Gk?=
 =?us-ascii?q?hqXRo1GlTOFBYF5I4FcMxokT4JnTwMZD445hAyBC4khQDQCCTACBwEKAQEDC?=
 =?us-ascii?q?YVHAQGGWgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lLcnyqAdRRMVQi/lHel455DYdb4zR+YMi2TDGXoBLCC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,275,1665439200"; 
   d="scan'208";a="43650720"
X-MGA-submission: =?us-ascii?q?MDGxpYuQEZwNeR39k371b2j/kpO9+rUZLw2vy5?=
 =?us-ascii?q?ujAL0XQpWVcjtFZXA8VilCu0VNd6PrYPNq21IVugorYzCMscyTF/wlk1?=
 =?us-ascii?q?sbV62LjMmNyEFGtz3BVs2rY7XRADdxtvybx2n38aQrJvl2c6j6YyKKmm?=
 =?us-ascii?q?yqkgSrh+yijTJ3Zc6NcMZoMQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:12:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1672053131; bh=+kmVrPJT6wmZ7VmvU1mmEfsN78phQI+o6/F68wLRcRo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iNyUTfDpBVzlVGH1JIcmwxo6T2GqEPt9HvHnQXnWG5M8UMaDNsn8eCalnxrHG4+Nw
	 ZteYgCgrhuDlUjukYmLL7lgkfY1OfYHceCk0q/hrAaeB6UXKtCqPzQoCBjX2fDN95y
	 VK05aOIirHqjaAsJBcBpxa7Fiv86yoz3IdLWjUe35XnJSx856IbIJLP6DLnmCXCGPW
	 jWfTAXkqQjbnv2OlN5EJZ7LF4srIQI6HIEe4SeMpOgDR5IW2+/WibpKfLR+sNtuysC
	 5SCRuuZ2h7WCAOCVobPJVmcogt2+8/23IzwZPCLvZ+ECv6oW7+BTneq5synatkf/f/
	 aB5AOzX+QR/Ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1om6mu3tgA-0171Ov; Mon, 26
 Dec 2022 12:12:10 +0100
Message-ID: <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
Date: Mon, 26 Dec 2022 12:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ob2eT99esdRqvP52ew/jLLa7ORQMuRydDVvCuAWzAPOaAousq6
 KVpdK8cdmKu6ecCZwamEnG/KAZmsb8Mdl3DnfUtYlTaihEA4tfDrkb5QcFmBkdChRERDqVR
 qvSfUqp7bmEgo63WQfu8VpMFWudX3353MPG9AyogY8R1trVQQ6Jnlh5PYsW5ThioaVIcn15
 UybqX/yNjh3PyQA595QPQ==
UI-OutboundReport: notjunk:1;M01:P0:q0rfGKS2H2w=;O5Cw/SatNGd9N6NvDcDFtsmoCmn
 BBFoYePptaC1r7UsRcHQA3h6mhShd24eFJaQJzcxdKcqPzquhV5nK3QmwFn5Rr8bosi0mPzbG
 WMQus/sxv4UkZgbqQO/mkPQJCoVljnrAOmLwDi3EcLZtlRix4Naze1ligKCeAn0D4PCqbElSP
 bIdJaAN6cx3G0xbVIAF24fQ0sMk08VbhNybPOqmh/tQIc+a2f+qnaQmkiSXNp07eSOL9bpa1Y
 uNnB7m8K6IMaVdgUnqIQ7C19V3l6uqXYKyUpWBxB7fLeiGsgO9inEjAd8XSoV6U2/6vFab7aF
 4wnbqzwUZ3c6ylQajUjb+CRvoVLRGdkkNkAF4fRqb/2mf0D/R/P6rsJWIZ4oVnfP92asdT9cj
 5Pc6fVfu1NgCa0Ln4i9f7R4ap1u6WIWyW4zDEZGNLTEBpmLb4mlqzasSYT6SzM+D1rmB2TPhs
 mCEw4nCNge6G2pYPJwQXEUMGC6qNzBXJNd8pE+8sWvXV72dg8bkFpEZEdvR7kS315YDkw8W0O
 BPqvNYRuJVRbcKCA/xFmkIRuilOO9ZbasRSlmF/4Dsm9BvHjGCdyOSTqOr1BMMNg2WBUDM1dD
 RlE/p85XQxyj5qTK/z0eOnoxwpnglfgeD5k273dSE4EQuZKybUZGC8SpkF1nzQZ1cGu+s3SYe
 8ENT2ntz3wDi5Mhc2KSlPoU7Q2r5MOQrafimOmmq12QTFtC6V6aSa/q7FdG+lcAcQ8rHY52NP
 wY84SO3qIpT1mezTBJQh5oLA3Hk0ySlvdyNkV+nrbjyTaAqOq2XEvTRGZlk6ychG3TsFul2xh
 RNnbq26g8A4VCxs7b+GLQCgISHmqrtl74TZOtULbuXfe4di4As+JSn/h6uSsWNIUkRzAvufJm
 HV4u7THxwY5nBi6KA7BYnlx4rAHlOk23yzKrWWtWDHG9Etv1Cc94l/Som2TnOM28gqPyLJqAW
 1TswkA==
Subject: Re: [cocci] Transforming source code according to the usage of a
 predicate
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 789
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/ae73c3b9-1f8e-4069-5bce-9380a187e1ac%40web.de>

>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --pars=
e-cocci cppcheck-11402-suggestion2-20221225.cocci
>> =E2=80=A6
>> warning: iso braces4 does not match the code below on line 7
>> =E2=80=A6
>>
>>
>> Will the chances grow to simplify and improve the shown SmPL code any f=
urther?
> Unlikely.

We come along different views for corresponding development possibilities.



> Your semantic patch also seems strange.

I hope that the presented SmPL script version can help to clarify involved
implementation details.

Thus I specified that a boolean value can be passed as the first
or last parameter.



> Don't you want something like
>
> expression list e1,e2;
>
> and then call(e1,active,e2)


Does the specification of this metavariable type indicate the expectation
that the applied metavariables will receive contents?

The boolean value can occasionally occur also between other parameters.


Branch (or compound) isomorphisms are supported to some degree.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/87350d742df39d847b15a=
f39865329c2fe23460d/standard.iso#L492

It seems that I am looking also for further software evolution according t=
o
the comment =E2=80=9Cmaybe a cocci patch should require something that loo=
ks like
what is on the left above to occur in a if or while=E2=80=9D.

Regards,
Markus

