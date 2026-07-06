Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33461C43458
	for <cocci@archiver.kernel.org>; Mon,  6 Jul 2026 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NMihgdQHm2qG/ecogQ/XIckbPv5W1Xf7tReRmSE4mmk=;
  b=K3sWMxB2A6LGH5zeNmcFfA5VCJ9CW6K1dJD1l3Fxx6RT4k8nByAzRQMD
   DrGxZy99p6XRvsmsS6uJRscBawCjWD0ykKJUENiz03nrr/z6Vb9Vys0XO
   Ir1vR1JtpzdG4BkTbfHIksI/XD02WL4AaN66VMRzWizFqU2zvrqBR0Nih
   Q=;
X-CSE-ConnectionGUID: R5Ekn4aCTDSCBdCnWvcH/g==
X-CSE-MsgGUID: yULZ1B//S+KYvUMmrapNZA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,151,1779141600"; 
   d="scan'208";a="285123692"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jul 2026 20:27:05 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F1ECA80E39; Mon,  6 Jul 2026 20:27:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0720F81301
	for <cocci@sympa.inria.fr>; Mon,  6 Jul 2026 20:27:00 +0200 (CEST)
X-CSE-ConnectionGUID: ZokzsZy9SyCoDXXep04X8Q==
X-CSE-MsgGUID: LI16p8r6THueVxXUIr8MTA==
X-IronPort-AV: E=Sophos;i="6.25,151,1779141600"; 
   d="scan'208";a="285123681"
Received: from unknown (HELO smtpclient.apple) ([37.168.203.181])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 20:26:59 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 6 Jul 2026 14:26:46 -0400
Message-Id: <90E16A8E-6BEA-4492-B0A6-437D873A024B@inria.fr>
References: <86h5mc6m8v.fsf@baylibre.com>
Cc: cocci@inria.fr
In-Reply-To: <86h5mc6m8v.fsf@baylibre.com>
To: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
X-Mailer: iPhone Mail (23E261)
Subject: Re: [cocci] GNU-style function calls
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3594
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/QmNPcXyCUV2rO6mptJYMiA>

There is a =E2=80=94simple-spacing argument where it should preserve the spa=
cing you put in the semantic patch.
Sent from my iPhone

> On 6 Jul 2026, at 13:50, Arsen Arsenovi=C4=87 <aarsenovic@baylibre.com> wr=
ote:
>=20
> =EF=BB=BFHi!
>=20
> I work on GCC, meaning we use GNU-style function calls, where the
> call operator is preceded by a whitespace, like so:
>=20
>  foo (a, b);
>=20
> I've had decent luck with applying Cocci to the codebase, but if Cocci
> rewrites a call, it removes the whitespace preceding the call operator:
>=20
>  /tmp$ cat test.cc
>  void
>  thing ()
>  {
>    foo (a, b);
>  }
>  /tmp$ cat test.cocci
>  @@
>  expression x, y;
>  @@
>=20
>  - foo (x, y);
>  + foo (y, x);
>  /tmp$ spatch --sp-file test.cocci --c++=3D14 test.cc
>  init_defs_builtins: /usr/lib64/coccinelle/standard.h
>  HANDLING: test.cc
>  diff =3D
>  --- test.cc
>  +++ /tmp/cocci-output-157607-636042-test.cc
>  @@ -1,5 +1,5 @@
>   void
>   thing ()
>   {
>  -  foo (a, b);
>  +  foo(b, a);
>   }
>  /tmp$
>=20
> This isn't too much of a problem; I go back and modify the function
> calls manually, but it would be nice if Cocci handled it.
>=20
> Is it possible to keep the spaces in line with the code style w/ Cocci?
>=20
> Thanks in advance!  Have a lovely day.
> --
> Arsen Arsenovi=C4=87
> <signature.asc>

