Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BAC433FE
	for <cocci@archiver.kernel.org>; Tue,  4 Oct 2022 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dPcRhAyRLyPrhPo1DIzVLtbRB5IVmf1mlJ9045mlFyE=;
  b=X3NR3EnR+Z7HSX/oCF6YnbpYjkgljsVKgR89IgPlpLbbwFZjEPoPW0FR
   1l0uubmq61+HbVV7YWqylkUEKcMEBtwJuVxr2qQqAyshpy9Uob/w42GTv
   6jH3Gj7G/PAolXLNLIMJXtCrO9jfVypiRDf6bVXEFftMZkOOgRIVupygo
   A=;
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
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="55981265"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2022 20:11:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6698E028F; Tue,  4 Oct 2022 20:11:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E4A41E0076
	for <cocci@sympa.inria.fr>; Tue,  4 Oct 2022 20:11:09 +0200 (CEST)
IronPort-SDR: 633c773d_CLOLbPna+gyOZpagkK6CElIajaYcSqJY7SvF1bAk/BzFKb6
 Wtnx18QiRALFilFGp+0bjXD+51j4oeK5xU6j75g==
X-IPAS-Result: =?us-ascii?q?A0BlAQAsdjxjhwMP49RUBh0BAQEBCQESAQUFAUCBPgUBC?=
 =?us-ascii?q?wGCI4FXLgQLRYROkRiEKIcYhyWMKwsBAwENPwECBAEBghKCcwKEbgIdBwEEM?=
 =?us-ascii?q?wYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOBQsFI?=
 =?us-ascii?q?oVoDYI1IoNsAQICASMdAQERJwQLCxoCJgICVwYBDAgBAReCYoJtAQMNIweqK?=
 =?us-ascii?q?4EygQGCCAEBBoROHywiUoFcCYERLAGQKScQgVVEgTyCTDc+hDQQg1aCZpR1h?=
 =?us-ascii?q?QYmBA4DGSsdQQIBC3YDFQMUAwUhBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hMFAgJNNAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHE?=
 =?us-ascii?q?xgbGQEFMicOCSEcCgQaDQUGEwMgbwUKOA8oL2kQGx0bCoEMKigVAwQEAwIGE?=
 =?us-ascii?q?wMDIgIQKjEUBCkTEi0HK3MJAgMiZgUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiP?=
 =?us-ascii?q?QYDCQMCIhNGdgIxERUFAw0ZJggFIxccBAg8AgUGVBMCChIDEw8GJ0oPSp9yw?=
 =?us-ascii?q?V00B4IbgUWBSQyeTwYTLpZoDgaSCi2WYCCnS4F3JIFbMxokgzZOAxkPjiAZh?=
 =?us-ascii?q?AyKLT80OwIGAQoBAQMJhUcBAYRwAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:V6veJKMwy1Z8vsBcTu+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7N5BRB7PoT+2ODYq4dKTS8gduVbd619QYWcengBpsL0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="55981247"
X-MGA-submission: =?us-ascii?q?MDE8NYUsCXbOXusk2x4o09yq+YGA7JbAbmOcoS?=
 =?us-ascii?q?xO7xfiK4Pigf2IzZbIJQ+SZcPSIqvpkTLhg/qbpF2f6y6b+lQDFhytHL?=
 =?us-ascii?q?wggoUz0h3XloPv+kzUWDaH8CVxJv8GnuJsZVyZc2pAGmgansmF8GCiBo?=
 =?us-ascii?q?dDOT/kSrY2/JAiWznv6trEiA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 20:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664907068; bh=XJw4NisrgZ8k9w2ag7eDdMwky+bKxMiJMD6a6GDFrls=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=RKT6Jam/UFjYSg2evJhGd8E7UDKbEt1QAaod2ewVVZETsVpI+c9eVmB+cyJELtPMM
	 rbE2zXlvWyrwMlC7+2199gZGiu4IkkMly4VhCsp8m/KAoyAmpXDAUn1c2SgA1sfSEH
	 2mQlSYX/sLOyvgtMyxx0mx7XFnnloWwCUG6tPLJePRBRs8TYNYC5mo94XtKrcdxSgo
	 oXgIYcboEgPt14SrbWbUL8bWpKXaIsrCC+ye7Y48D/K7IgT4sjIAzunDmriR2g+fK3
	 Ss2vtQwM3CIVSRVYmY6PK1K6U/SiXU7k1vpb+wWIjKVe+lXn6dj8AG1wEw0YiIynNy
	 E/xATUJrqmJlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2KQ-1onv461kyk-00SC0l; Tue, 04
 Oct 2022 20:11:08 +0200
Message-ID: <46f3f9c1-cfee-a7fc-69b2-71c9f80fceaf@web.de>
Date: Tue, 4 Oct 2022 20:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 cocci@inria.fr
References: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWnJKNn2K3NePc2VMz6wrby7wqn3cn5watJx0Cb5g1rIXQ+trbP
 dl1mFjMBLxq+jCqyvNZtCLBtKdJPFBnPy4Ncp8Bju4NQACjyRapUpXuOLRO9n7eIIFGrtNN
 FR4rkSRytNorVr/blK7xkeeYAG1UsNZCa0chLWj9VBI9OuJdcOj+Yd+JMtiOePYOj853ZAc
 SEQI0yOR/uBJPHJ2wCF7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PMo2Z9/sQQ=:tQHBGd5frtlBzwjZ08ZJOf
 ms9LR6jusGzE6FiMQsj1TyrAJZRUiRqIb3YWXf10EQn/BvSeJy3Cj0v9YTrH5Njoq73JCh30z
 Ix9F87+d54EuZfXc+KuvE6aF32h4KFfzhVSy4X0pDz3Ypp+VD8XJ3S6VJ/FJXRXIXn74fNpbz
 UhNsnNYYqvqyTo2LZFuwztB+dgj2wtn3Z89PytXjph+K1iZXXwJq6A/6X+4pIy5wmUdpaeGyH
 AZnvb+2W56lFukEWxJmbfrqoIrr6PIq1o4gI2RYDXkkiO76vLMUClaQGXMdhdXgX2ZBpBystp
 5P+ie4Lt+Dp/KWpMY11RqlU2E1Ar043+4n7sbAGI1fHarprMOKC7dtGHT72WCMUTkhZ3FM1QS
 sE2FDPvJXAKx49GAjhLWD7VFE1o30wnDXsZheKH3h8L2JAJh15Pz3XRM87em7p6nwSskVvgQu
 5iQbKzTS7rsd/cq0rmkt4Z9hAR9FPkWpmlhTc3Acvt8ZbvCGfIbHecoqK2UxKN/eyaOHNULtL
 97xCAnigO8TAdKGOWNCzxwK98q831okpNjdZLJArKxOPhs1yJZP14/+tmhlKpkVK7NO9NjL+t
 VOKBnNPQgFrDB4yRuq+hELFYs150bKhWZ3zy6YOJzggH3nBL+PosR4FHxTaSOqrVUHZ4l2xj7
 N1JZxpJ2YPTCo0hwW5uk8X5hl7bYaVeJHE5NZQc8tg/O3DokU8S/WFWAFQkplUQk/fTP4c0m2
 mV4JD+kcJHXtFbK8PQM0UPkoA2ZHzEVVtoAZDzCo4TGqZW1Hj4N3WibhF+SmybWnpBQU4WTiE
 +w5PnqDwKujtN+kjY3bKPluO0PB3xNXKYeIHHCK4WZ8lm4iu0jWSiGOZFRZmPiH4uDbjvzSzJ
 JIHHX5Z2mTKW1hdb5Ee7N8G+sAjODLNind2LcqT7wha3kz7Vrgp4bwDhN1usj1hAkJFKo1rbG
 UCgN5XnIEiTUURmKJ5dPTlBh6KhfhvJ0nZgXz0Li7ImufQEl18BRMB+n03AYKCx3K7TKu70Zz
 U3U9e3rTzDQDUl40ZEdKhoo10amNHVdwnWle2UA5/nP3MfCpMya+rVWVHz8pjloqdIIbEMO7n
 ZQwZ8PxO0w/PczJkinkWQOmsiJvHXGUapi6M8704i9iw7+EuZmJRZhmwIHLXxMXFtJDI+Ii0w
 5NzkhsYdRJVV1cNrKgkO436cY0
Subject: Re: [cocci] Matching against struct_group()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 615
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/46f3f9c1-cfee-a7fc-69b2-71c9f80fceaf%40web.de>

> say I would like to replace an instance of the struct_group macro in the
> Linux kernel:
>
> 	struct_group(algs,
> 		char verify_alg[SHARED_SECRET_MAX];
> 		char csums_alg[SHARED_SECRET_MAX];
> 	);
>
> I'm guessing this is not supported by coccinelle because of the
> "unusual" syntax?
=E2=80=A6
> Is there any way I can still make this match?


Probably, yes.


Corresponding solution approaches depend on the detail how many software
development resources can be invested for the support of the desired
source code transformation.

I imagine that it will be needed to achieve also support for the proper di=
stinction
of macro calls from function calls by the means of the semantic patch lang=
uage.
Would you like to influence evolution for affected software components any=
 further?

Regards,
Markus

