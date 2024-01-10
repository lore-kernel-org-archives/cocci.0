Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C59C3DA6E
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=S9pBQCz+Xugl78ZljO9c3MQi/tYY/iaK3svNXapNfd8=;
  b=Opfk+UeTQ+xRJ57lgD5L3Af+iK7geTwU4VBTatwpwQAc/wza+nbVZq4g
   4ho/DVdC0t4mZ2FzuPYv6Qayzf16JpN1+83dm10fgjekWLXVKtASn92fL
   QbrMRxv8rzyMKP0fN39/QR1xB/cZDfSpmM2xRMticZ6qfNkhh1s+3AuAS
   s=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145853266"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 12:23:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E559E0CCC; Wed, 10 Jan 2024 12:23:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D9CDFE004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 12:23:54 +0100 (CET)
IronPort-SDR: 659e7e4a_X/NRLXCfUoUUMlascpOuRC2LmgZXCUiqfCroWcYBe7vloTt
 KNNANBFVcDPrb8GpmrnuTpfo6O30gPLjEoy8KgQ==
X-IPAS-Result: =?us-ascii?q?A0EJBgAmfZ5lfQsR49RaHgEBCxIMQIQIfFYyBAtIhFORN?=
 =?us-ascii?q?jCEO48BhGuEBIMWPg8BAwENOwYBAgQBAQMDAYR/Aoc9Ah4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMg?=
 =?us-ascii?q?R4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINO?=
 =?us-ascii?q?kIBAgIBIwQZAQERJgEECwsaAiYCAlYGARICAQGCfAGCKgEDDiMHDQa2Gn8zg?=
 =?us-ascii?q?QGCCgEBBoFFAgwCQ06sch8sIlaBYAMGgRouiBsBhWeDQXonD4FVRIE8C4J4P?=
 =?us-ascii?q?oJhA4Ffg1uCaIVckCJSfx0DgQUEXA8bDx43ERAFDg0DCG4dAjE8AwUDBDIKH?=
 =?us-ascii?q?AshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOwMDBgMKMQMwV?=
 =?us-ascii?q?UIMUANlHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkFgQ0EQkLJgMqBjgCEgwGB?=
 =?us-ascii?q?gldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHe4EXAxkrHUACAQttPTUGAwsbB?=
 =?us-ascii?q?j0ClSoBg3ICRoFNkymTHZ5yNAeCNIFggWEMihiVEwYTL4NukzgOBpJULodQk?=
 =?us-ascii?q?E8gi1SBdpp8gXojgVwzGiSDNk8DGQ+OIIQrgQuDVopmQDUCOQIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 zYzjRZiJ/sg/nHg7gVvTmc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:w/9NJahIs/moMPb0VO2abScJp3BQXtcji2hC6mlwRA09TyX+rb
 HKoB17726XtN9/Yh0dcLy7V5VoIkmslqKdg7NxAV7KZmCP0waVxepZjbcKrQePJwTOsspm/e
 NbU5EWMrfN5TQWt7ef3DWF
X-Talos-CUID: =?us-ascii?q?9a23=3ADwXoVWjFPhwdaWqhTjwWkeOJ9zJuSEDCl2vIHk2?=
 =?us-ascii?q?CJ0VEFbStUHyNyZliup87?=
X-Talos-MUID: 9a23:rWi7kgR5EsLs6uimRXT8hQ5vPeF35piXI0w8mrkbtuKrchR/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76367927"
X-MGA-submission: =?us-ascii?q?MDFTUKDdjetC19Z+JgyGNB/xbBRuX5eEE69xgv?=
 =?us-ascii?q?uKCgOTjEIfwpOdxZ+OF3QbIlFMOk8xAYHggjN+/0MVtKtvKMBBqE/4eJ?=
 =?us-ascii?q?/22vGbSOFrSyFDRAEoXHTicZ19t1/HUlU3u79Asjk4XmoH6FgoqSM18n?=
 =?us-ascii?q?8jsfzFb17A9kOf85shLF+7OA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:23:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704885827; x=1705490627; i=markus.elfring@web.de;
	bh=S9pBQCz+Xugl78ZljO9c3MQi/tYY/iaK3svNXapNfd8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=PUG4aQDLrkNgnWq5WB7Z5IZ5JZu8vJA4mXsuHI13M4/iFgMXMKNd70iwraeIuU64
	 Nb5jFlUGo4A5YzWYP2nh3K+yTkSIRHb5PljEnH4+Azg+hOtX+laFKk0uraA5tCq+K
	 7It6jHMcuVATNjYYCavXENWUCACKthMOEA2EcUl4euZfr0cgrey6FTAq2fV2nByyY
	 P+BbUk+Fw4j95TfkdUGPjmByRopzvCHtfSW7IyNt5A9GUUI80Dg1OrtUB5DqGPwHU
	 0ONz7nAkXc0LAbcWBAQ6FIXM15fxHknlIPv1BrFaUKIRWtgyKx8Mvfuj9ViTgTqPk
	 w2w7Qo+HVjuxi3w6CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1rOHmf3hyZ-00HFqo; Wed, 10
 Jan 2024 12:23:46 +0100
Message-ID: <45033ab0-0391-4422-895b-edba845ad226@web.de>
Date: Wed, 10 Jan 2024 12:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, io-uring@vger.kernel.org,
 Hao Xu <howeyxu@tencent.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <aa867594-e79d-6d08-a08e-8c9e952b4724@web.de>
In-Reply-To: <aa867594-e79d-6d08-a08e-8c9e952b4724@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ELaC2EsXYBGmOLrTxwH3QEjU90DDHnUBkMdV1hwkkFSfmCovax
 wGdC8a44VVf2h1Pc6oxjF8q05Rmbg3RQjzKtimYjwbpYfDVxRKDPpdltEjMrodEr1V4gM5i
 THh1OhyVai1699aYIwTgTqZdVjiPrCWGBPsMwigd/cdk4QRjk1PbWGiuBe1HuEvS4ouybZt
 q40lAsmU7F55RKDHRbisg==
UI-OutboundReport: notjunk:1;M01:P0:SCzyDB61MAM=;whxBAaoTIRjG0CSRcDWjKoz3IfS
 HpnmuUrCLQsi6JVACl+mhx6Zo+R6JFxlhhHaY5+WfgUIKulRCTM/+mbTCHOS3hGuxEBmOiECs
 AE2ds7UFK8W+zjkYaezrJmc7jiOrbaNSuhE4cepUG5Zxyqfv5vizfbp/pV78N7jXqIbSmRegG
 wi9LAuN9yGUon1g56JMlkFRfbp24ojvkOfsjlanbPOLwGvxrVikTyVhtxon8Sxp9M/R893nNU
 8AMThUt6QhTzQjDLyQs/pGkm/JiST9HR39/i3gQ0cRdMo1Q3nkNpfXsUM0/20YTuuMwe5TnLn
 qvUYS68GOBQkf5ixnvRCULtPyTce9Ed3fvaz69JWn/5EToJdgGdZXmjpeAZDoQ9t3TOi8VM8h
 CMz4QAzU9z1glBREilVSHfT+fJsQXkvlXUihJG5Or/ZN7Fqw12Xn47NDyHw1QWDiz4cJXxGuG
 QOxubeGB3derH+fKhcFAVjOAXLLNXkfyTYr6tR8g8hFTgAW4qujlAL5WUIR+V/UlhA9t8WTWv
 CgmGXJjgLxr7NRAFNA9nBA0z+Qzwz3CcnV6t9SjyNeOl/LniawzIIgMx3Nkk8b+tznZxU380z
 DEBu2VAxUFq36vI0O+Vxym+ADMnArxNd8DFapHr4USATe64T0dDsEjkPVITPT6YqGQ2bzXi06
 8PPcZW/hizAQW754/5Oa2AsRDIPEGIV9+7WqOsPDotuQzEG6MQLanWhvXU0jbumWZ2cjL/aJ0
 qtGLVAXT5wuRuAnl0JxgBt/Ci+Kz7hlLo2RzdaLqrw4XkgxkA5kNDBMnaO66AUP8WJBtZEhie
 XHvCxtg7BMEdJYIjZnB21RSGgwxEwXcOjnL8i7nO1JroVQIzTJAE6SapBmAkFYhK2faiENGij
 F2hj5dIx5ayIlW6zwDYYPldnwUy2e+y301oaNTZeVOV4LvSfGZBLfbOSgBGMthr8oMhM6AEqz
 dndrXszsSCxQR4HYYIxA8rESMJQ=
Subject: Re: [cocci] io_uring: Fix exception handling in io_ring_ctx_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1444
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/45033ab0-0391-4422-895b-edba845ad226%40web.de>

> The label =E2=80=9Cerr=E2=80=9D was used to jump to a kfree() call despi=
te of
> the detail in the implementation of the function =E2=80=9Cio_ring_ctx_al=
loc=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.
>
> 1. Thus use more appropriate labels instead.
>
> 2. Reorder jump targets at the end.
>
> 3. Omit the statement =E2=80=9Ckfree(ctx->io_bl);=E2=80=9D.

Is this patch still in review queues?

See also:
https://lore.kernel.org/cocci/aa867594-e79d-6d08-a08e-8c9e952b4724@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00114.html

Regards,
Markus
