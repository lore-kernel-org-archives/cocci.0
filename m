Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA53C433F5
	for <cocci@archiver.kernel.org>; Mon, 10 Oct 2022 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VqaOMMPhRp6HDc48G/UbeH4Kd0n3MDpeEEFbXpQVaOQ=;
  b=AFaOTlpgtTKPnSn6yjDyA2rIq0fW5ozRLbMyeQSaVCpsZOiaq5sdwGA4
   CrW7MarwjE7KJUWMSbEz1QlT9RmDo5F5phegkfKI8uYDlaY2BF2HZjJgP
   /jGyyR+Lx+eTj7y8oWO6t8fFHV3quDB2ZVX4m40q6930+KZw66zOHeEJU
   s=;
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
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="56917128"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Oct 2022 21:12:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D6C8E028F; Mon, 10 Oct 2022 21:12:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 278F7E0121
	for <cocci@sympa.inria.fr>; Mon, 10 Oct 2022 21:12:16 +0200 (CEST)
IronPort-SDR: 63446e8f_QzCCC4zU/UrjXiEom9yhJchzoF77jZfReKYpjmO2Nrkgafc
 r7Pno0Sc1DxuAsJawWG0VJTJ24CrXdGDShSmbTw==
X-IPAS-Result: =?us-ascii?q?A0BFAABpbURjhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYF7KIEBVi4EC0WETpBnLgOEKJhtFIFoCwEDAQ0yDQECBAEBghKCc?=
 =?us-ascii?q?wKEdAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBA?=
 =?us-ascii?q?RkJFwcOEAUihWgNgjUpAYNkAQICASMdAQERJgEPCxoCERUCAlcGAQwIAQGCe?=
 =?us-ascii?q?QGCbAEDDSMHDK1LgTKBAYIIAQEGgUABgw0fLCJTgVwDBoERLAGMBoQpJxCBV?=
 =?us-ascii?q?USBPIMDPoJiAQECgRcfKD+DGIJmg2aRCYVhJgQOAxkrHUACAQtCNQMVAxQDB?=
 =?us-ascii?q?SEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskDwUCBy8FB?=
 =?us-ascii?q?C8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTGBsZAQUyJw4JIRwKBBoNBQYTA?=
 =?us-ascii?q?yBvBQo4DygvaSsdGweBDCooFQMEBAMCBhMDIAINKTEUBCkTDy0HKXEJAgMiZ?=
 =?us-ascii?q?QUDAwQoLAMJIR8HKCQ8B1g6AQQDAhAiPAYDCQMCJFlzAi8RFQUDDRcmCAU3G?=
 =?us-ascii?q?wQIPAIFBlITAgoSAxIPBidJD0o+OxcImj2BIIFWV4IfEheSKhSvIjQHghuBR?=
 =?us-ascii?q?oFJDIlplGkGEy6WaA4GkgqXECCNIJovgWgCMYFbMxokgzZOAxkPjiAZgQ0BC?=
 =?us-ascii?q?YJCM4otPzQLMAIGAQoBAQMJhUcBAYMFgkcBAQ?=
IronPort-PHdr: A9a23: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
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cePGL6880ytD5El7dYxuk+DNI+orL9Y04lQ7vn2ZKCYlF/Bw+P
 rFoB1273LJYRcqOE3I+urgBEDjex3hHPdOiOEs1NyZMDUO1lHGEGgb1/qB/9SaIVycygeD78
 xdT5Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,173,1661810400"; 
   d="scan'208";a="56917122"
X-MGA-submission: =?us-ascii?q?MDH5IBcd43zKv6o5RHy3FyeZR9th6wLnWWf2rK?=
 =?us-ascii?q?QsvOLqzdT+jnbh70wQ0tdUZq1o3KzY8NnKBYlASLJcVZuh+tBhN3nn/X?=
 =?us-ascii?q?PQ4vjf2cKxaBJELz/CrSVi6fEwRGsKzmbQwuwhZsXVPrVkrD4T4LsvK3?=
 =?us-ascii?q?50g3fZ7uFMV3tpKlXAaYzAVQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 21:12:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665429133; bh=VqaOMMPhRp6HDc48G/UbeH4Kd0n3MDpeEEFbXpQVaOQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=HbZy4xwOw1nUvSzCwj5JcfHVFnUie59219TJ37Fw7HJysRC/i9t8FqLu0AVTylU+T
	 jCzJH2Oc4RsjKj2P1QjMi+MWfzyRo3g1chbb9Gqx38A8IKon1jgwoDUDPCkM68CqPe
	 gYpem3HZZq0DH5W33cej3k8g8POTOUhYTHDx6W0PX5fN8Tf9p2Kg1JGOVVN2A3FWLy
	 2aOPAfM+8OKtYopbv7Tk8k2h9A3AhD30upHo+BlMawgHe+JkA60/Zp1t3OUlzv1E51
	 gzXdvAy8H78wpwTfSd5ynZrek8Vcyjso8TwUlH3J2Bk0K8lY2EofnwGoZ1nSzcv7Ft
	 iHiD8Kxej420A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB86-1osMzr2fVO-00Cvlp; Mon, 10
 Oct 2022 21:12:13 +0200
Message-ID: <c4640a3e-746b-a434-710e-fbcb296ab9fe@web.de>
Date: Mon, 10 Oct 2022 21:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-GB
To: Kees Cook <keescook@chromium.org>, cocci@inria.fr
References: <202210071600.078A2101@keescook>
 <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
 <202210090808.AFE4016@keescook> <202210091035.7D63B5FB@keescook>
Cc: Julia Lawall <julia.lawall@inria.fr>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202210091035.7D63B5FB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:61IplgFa3pqQiLPtkSExFl5BgqqHY2XoPXjvzFPy+ArmR0rrpNk
 qYJvSxqCy316Law301VwtIwUy4xqteit+myArGBgL2v6eRGujySYECKXDZt/4PryxOmbVII
 PoW49mY6tFBI6HXtfDjQya+PU6s2ziixW7DoTzKYc8XWT0hr0ye2lVjXKO77pYx1UthTJgr
 QcTKha25epXX/gRjCzfOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnVPXnPI8V4=:S1Z3Sp0JJZCz/featcV3KW
 COdIrcLAWWzLd7Hil/nnQaI+4bquy/gt16JDez087Ayw8rJKWM8nTMBSxcroGPUmG4OrtrdYU
 ICqnS6cIW7Ejxu8SNCkM1ETeQFFTjre3EMTNCALRL9w/4E55wbcDiSSJV4gyqgKf7Ubn2z8Vu
 0QmoLk8+khy8YHrPmhUqSCC/N5+NZBZziqsFkRMsrJo//yiWANIsscMKj7m5ZT8OnUt4Cl+Tn
 6G3sKQDjbY8VE5W0bTEUqc8qpANZ/KYPerWVbT3QIJ7k1DYM7kAWhu/P3IiwZzb3IgZ69bQMs
 DMPjMYwmqw04tC7w4PDh/fml6KeRHUs1lvVZSe8sjMR2YpAjHuzZwEJfTXuiTYM57u5ffVBfj
 8H5keGe7/ixtPqFqN/iMfDvdGnyK0iTXTsr9Z/CNYRFgWH77FCFmKT7MHcARhazZSkBINl8hl
 lcoFndjYWUQOI1nI8tnTq/7HWkWn45FRrmdKbqJe7ccVkpcuTe8rZeoHl321Yph4nItrigh/e
 Rc6cEWRYBH3U64x7kRzWQ+sHlRMhjw2A5RmyDUG+H3gqhc2Suw2a7j29LFS2+LlbN16Lrswa7
 46K9usPlkwL14FpDcnHQ5ebVmtqqP7S7B5O/6ZWSsF9Dd4HplfjCy4OUaBlzs7ZI+UvfWUXUX
 Mjpa0lqMHsYnXTg6LrUR3rVPMmdNqxF1dzjqzYK95WqwvC3GSeXoNkCM3f0300OC70Eac7QiT
 2MkIyyuzk+3ONoGRo2lCKRkwXEWaSajzMWm0MfRIMSwX45SjoovLeEzSLZWTCuvcF4dp384TX
 L8nL1MWrGitBcli7jeFzVbYAJvz89RocdxGpsqRTyIsa5MQ2SPTCEFXJyKbAivPldyQZx3Hzx
 f/LhWnqRb87bckV8qTmeJaaPsdQycOkGH0rBweDwVpFMVB6v7E2BnnhTI0r47uoFQRiHGoOSN
 uZYKwhTEWV6dI4d2ezv372pqaRFy1lZKegPTWI+2LvJzA18dWryagKEWfuguZ4exz2G1N3Lie
 H2u3i+bIo12plIvC/6tVV+oFGc2QoFJjW3SwOyuIccmC+TXEhzPh+lB9UYjhZEufaJT/RTi5/
 UWBkTlqFsy1+d0Wj2Rv7LgwuucRUM3sqw2bYwnhIOK+vJOhnEMF7/EpkQpH/nlTNFINjQvO4U
 Pg9vpkGbWBAykjLBP74TRggOLi8k+kn1ZF9Jy9iIx7eiaOGH2OSId6ob1L38gp5W8X20ICXs5
 ATd63jBsKH8GkbCqEaRiUun0/vXm4rk831b8ez6rrjTCPr+Nu+gFSyqTTAssxcpOdHtt55QPa
 18oHEbwaVffErke9wmPoFM4wE3z4t/a7oexhl7rJmh/pRclKd4U6i7UQ1CI784b+Z16opm7yD
 9HleisI9JdT/6NwezTlWkWX4NV0q2TPc7cG8DKxZd+IPYy7R8qk7tv179tPr2IcikQLoJHKAe
 +9gcKw+gys64fmyfFgDWCpaetSqeQkFbj/cX8Z6EUCQWkHUeuL5Cne1b6AAKzLraKiNcauiWO
 QHgCAt19ohwmevsCpfigZ3SiHV0Oz5oVRVBTWpjbiypeg
Subject: Re: [cocci] Reconsidering selected SmPL code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 645
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/c4640a3e-746b-a434-710e-fbcb296ab9fe%40web.de>

>> I'm starting to realize I should document my set of "with cocci, how do
>> I ...?" answers somewhere.
> Okay, initial dump is here:
>
> https://github.com/kees/kernel-tools/tree/trunk/coccinelle

I suggest to reconsider published implementation details a bit more.
https://github.com/kees/kernel-tools/blob/0d128055b31a7737eaa23c040e57a0f3=
4a41e6c1/coccinelle/README.md#user-content-use-regular-expressions-to-quic=
kly-match-identifiers


@display_with_regex@
identifier func =3D~ "^(?:get_random_(?:int|u32)|prandom_u32)$";
@@
*func
=C2=A0()


@display_with_disjunction@
@@
(
*get_random_int
|
*get_random_u32
|
*prandom_u32
)
=C2=A0()


Would you like to compare software run time characteristics in more detail=
?


https://github.com/kees/kernel-tools/blob/0d128055b31a7737eaa23c040e57a0f3=
4a41e6c1/coccinelle/README.md#user-content-limit-matches-when-variable-con=
tents-arent-used-again

I propose to take additional SmPL script design options into account.


https://github.com/kees/kernel-tools/blob/0d128055b31a7737eaa23c040e57a0f3=
4a41e6c1/coccinelle/README.md#user-content-match-variables-of-a-given-type

Will further collateral evolution happen according to mentioned metavariab=
le declarations?


https://github.com/kees/kernel-tools/blob/246d5fe3c1abf0a25778acc5d3b8af02=
511241b0/coccinelle/examples/rand-pass2.cocci#L1

I wonder why the source code search pattern =E2=80=9Cprandom_bytes(...)@p=
=E2=80=9D was not used for the SmPL rule =E2=80=9Chit=E2=80=9D.

I imagine that the addition of constraints for metavariables with
the type =E2=80=9Cbinary operator=E2=80=9D can help to avoid duplicate cod=
e in related SmPL rules.


Regards,
Markus
