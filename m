Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1132AC83F1A
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NLH5oe2VaX4zHxYr4u0xdH3HSQsaMG/7aoL21wv5YT0=;
  b=biKqX6y7eh1pF3g032lELnVoATpOfb6RztjNCNyRMlZbSseX+YBjjcVo
   D2Q27qs0NnIO7/HaF8fZ104mRA6oF9KY31U54J0iL8Hdr4BZS6dX01oEK
   lnCgaIc6VBpsiXDWaUpWbUNtbBhfo98v4n6/eHj70dZxBlg5xufQRTqPF
   s=;
X-CSE-ConnectionGUID: ujOfPEK+TW+X7EKTo7sdZg==
X-CSE-MsgGUID: GnH28s6tRzO9Ja6qhA6sog==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231554829"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 11:54:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2CEC2E0261; Mon, 14 Jul 2025 11:54:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ED242E007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 11:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=NLH5oe2VaX4zHxYr4u0xdH3HSQsaMG/7aoL21wv5YT0=;
  b=LDaLYP+XAk230gTEY6SNu5HF0H2DOxJWMzOeZo5DuprYZYVOhpZiXXRR
   AA/1Vv3gJso4W+PXlmROnVi0KYaDj76SrqyvCNljF0h7nGPjjz2NCP4gh
   QFJ6iz2/o58YA841RH+wXDPUo6Br7fOf93QeG4B2b6n8Vpb9bqrSdDczf
   0=;
X-CSE-ConnectionGUID: 8WPzETIXQOiPVVc10NRMrg==
X-CSE-MsgGUID: 2ikeCTHBSr+1psEzyexKUw==
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="121331972"
Received: from unknown (HELO smtpclient.apple) ([172.59.115.247])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:54:45 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Mon, 14 Jul 2025 05:54:33 -0400
Message-Id: <846C89C9-9894-46AA-BEC3-29FD12796C88@inria.fr>
References: <89cd029d-b68d-4d9d-92da-ff2ee2bcbe10@web.de>
Cc: cocci@inria.fr, Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <89cd029d-b68d-4d9d-92da-ff2ee2bcbe10@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2867
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/846C89C9-9894-46AA-BEC3-29FD12796C88%40inria.fr>


Sent from my iPhone

> On 13 Jul 2025, at 03:21, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BFHello,
>=20
> I noticed another contribution.
>=20
> I got into the mood to construct another script for the semantic patch lan=
guage.
>=20
>=20
> // See also:
> // [PATCH net-next] ipv6: mcast: Remove unnecessary null check in mld_del_=
delrec()
> // https://lore.kernel.org/lkml/20250712092811.2992283-1-yuehaibing@huawei=
.com/
> //
> // https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L786=
-L813
> @deletions@
> expression x;
> @@
> if (x)
> {
> <+...
> -}
> -if (x)
> -{
> ...+>
> }
>=20
>=20

It expects a real statement inside <+=E2=80=A6 =E2=80=A6+>

> Questionable test result (by the software combination =E2=80=9CCoccinelle 1=
.3.0=E2=80=9D for example):
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci delete_duplicate_condition_checks2.cocci
> =E2=80=A6
> minus: parse error:
>  File "delete_duplicate_condition_checks2.cocci", line 12, column 1, charp=
os =3D 307
>  around =3D '}',
>  whole content =3D -}
>=20
>=20
> The transformation approach is working as expected if the specification =E2=
=80=9C... when any=E2=80=9D
> would be applied instead of the SmPL nest construct.
> Which software improvements will become more desirable for such an use cas=
e?
>=20
> Regards,
> Markus

