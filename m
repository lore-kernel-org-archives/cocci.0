Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B1CD2ECF7
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=N+z6N1pu/0Ue3TCkVFiyRptKXwwik0wm2/2sQS05rB8=;
  b=MlqGqRJ2WWVf4l5JoCJD1MU/8PKPQURMP1v2dVGm+9Xl+Z2C1o+LHTBi
   RawpNo+tGqTjLb/LV0eRZPC8NFFvpl0z/NMuGv/mJB3sIL6zTIfk2iqKw
   8vnuHg014sktcM/UY2boKlVRMdU70oLhMDP7B+BgZuEx8tQoocQ632JGe
   U=;
X-CSE-ConnectionGUID: jJGT9kF/QvCwWkQCJ7r8Ug==
X-CSE-MsgGUID: 6HahI3dlSm+m1C2lqwPXhw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259464275"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 14:30:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DE52E83AA8; Tue, 20 Jan 2026 14:30:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1971483A9B
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 14:30:10 +0100 (CET)
X-CSE-ConnectionGUID: ZHDma1aHTn2CXVv9GtSVnw==
X-CSE-MsgGUID: i+9GyirwS46E56jKau7/8A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259464252"
X-MGA-submission: =?us-ascii?q?MDFOoNfa7Zz3AvWfxXQcRcgfQ2Vvw6TLFLiwPa?=
 =?us-ascii?q?xHV/41zhshn5Rb1UCNR9OYGqTikzmWtI3GhxG7LH0HtlC7HmSjd4Vc+3?=
 =?us-ascii?q?ufiCKwApshhcFFDzWm2xqQYMO8tgEGBa1r4M0SeO6U6MPT/gloPpzpcQ?=
 =?us-ascii?q?5g6PjZ3JkSUGvDtGtfII647g=3D=3D?=
Received: from zcs2-store9.inria.fr ([128.93.142.4])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 14:30:10 +0100
Date: Tue, 20 Jan 2026 14:30:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci <cocci@inria.fr>
Message-ID: <1496228462.18059952.1768915809347.JavaMail.zimbra@inria.fr>
In-Reply-To: <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de> <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr> <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de> <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr> <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de> <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de> <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr> <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [128.93.179.59]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraWebClient - FF147 (Linux)/10.1.14_GA_4838)
Thread-Topic: Checking data structure member accesses after function return value assignments?
Thread-Index: 5DdbXOJ1ey4PUXWjn/C0lI0k/dBfDw==
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3289
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/U7g8qcOc9eVQwp6zkRLBiQ>



----- Mail original -----
> De: "Markus Elfring" <Markus.Elfring@web.de>
> =C3=80: "Julia Lawall" <julia.lawall@inria.fr>
> Cc: "cocci" <cocci@inria.fr>
> Envoy=C3=A9: Mardi 20 Janvier 2026 08:23:48
> Objet: Re: [cocci] Checking data structure member accesses after function=
 return value assignments?

>> And yet I made another suggestion that you completely ignored:
>>=20
>> * pointer =3D action(...);
>>   (<+...
>> * pointer->member
>>   ...+>);
>=20
> Can such an SmPL code variant prevent the interpretation as an =E2=80=9Ce=
mpty
> statement=E2=80=9D?

Yes, because as already explained the () forces the <+... ...+> to be consi=
dered to be an expression.


>=20
>> This should you give what you seemed to want, with pointer->member in th=
e
>> immediately following statement only.
>=20
> Another SmPL script variant can be tried out:
> @refined_display@
> expression action;
> expression * pointer;
> identifier member;
> @@
> *pointer =3D action(...);
> (
> <+...
> *pointer->member
> ...+>
> );
>=20
>=20
> Corresponding test result:
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bi=
n/spatch
> --no-loops
> =E2=80=A6/Projekte/Coccinelle/janitor/show_questionable_statement_combina=
tion7.cocci
> drivers/regulator/fp9931.c
> =E2=80=A6
> @@ -438,8 +438,6 @@ static int fp9931_probe(struct i2c_clien
> =E2=80=A6
> -       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> -       data->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
>        if (IS_ERR(data->regmap))
> =E2=80=A6
>=20
> real    0m0,175s
> user    0m0,150s
> sys     0m0,022s
>=20
>=20
> Regards,
> Markus
