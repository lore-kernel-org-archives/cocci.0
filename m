Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90435CCFA13
	for <cocci@archiver.kernel.org>; Sat,  8 Nov 2025 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9jzQCVcM8/zx7DQrQn+aVAnAjpTgmdSQnLLuUGe8AuY=;
  b=Tu+se9EhJKx8wAssQ27ekPEvrj16gRkayJOxxA1mdBvJgREWK6Dt3oad
   8WeFOEOFwblbgiWWtyq4XBIFio2eNyHZuLvI8dXsnuBS2as+2y+PzIuWA
   Mpt11KKpR0kBxwTRu/r35ZXLY8/FUo9PudepRry+/dUULINswPRIgVFGZ
   c=;
X-CSE-ConnectionGUID: P/6S4dsJTLOOGhP2YO6cEA==
X-CSE-MsgGUID: HjG2v5oDQr6glYieMtIGfQ==
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
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248307607"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2025 15:15:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B518E0BE9; Sat,  8 Nov 2025 15:15:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D93EE0171
	for <cocci@sympa.inria.fr>; Sat,  8 Nov 2025 15:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=9jzQCVcM8/zx7DQrQn+aVAnAjpTgmdSQnLLuUGe8AuY=;
  b=FXKVSsPsIsGloM7S9vgvWVWLhpEx1IWO8ri7eMd0qJ35CKCOaCYpA6Yh
   KYl3k0yx4XnMbKJNnhgHPlHOXS8X2GEiJ7AXcsJGHxzzL29kCi9OFxFwA
   3boB6pfMocJSOheaMFWnhV1HJF5tFcOcPfl4MyHHfflU2lxnX4sOlPE7i
   o=;
X-CSE-ConnectionGUID: 8J9+9i6YTd+PilAMhgm8Vw==
X-CSE-MsgGUID: i29zEVtIR52rm4+n7rXyJQ==
X-IronPort-AV: E=Sophos;i="6.19,289,1754949600"; 
   d="scan'208";a="248307597"
Received: from 32.14.23.93.rev.sfr.net (HELO smtpclient.apple) ([93.23.14.32])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 15:15:05 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 8 Nov 2025 09:14:52 -0500
Message-Id: <3AFDEDD4-46FE-4E5A-A9F2-72D491568D78@inria.fr>
References: <d0ebb438-c60e-407a-8cfd-77fe0862223a@web.de>
Cc: cocci@inria.fr
In-Reply-To: <d0ebb438-c60e-407a-8cfd-77fe0862223a@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Searching for switch statements with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3142
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/3AFDEDD4-46FE-4E5A-A9F2-72D491568D78%40inria.fr>



> On 8 Nov 2025, at 08:30, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BFHello,
>=20
> I would appreciate if another source code analysis can be achieved
> also by the means of the semantic patch language.
> Thus I tried the following SmPL script variant out.
>=20
> @display@
> constant c;
> expression e;
> statement s;
> @@
> (switch (e)
> {
> <+... case c: ... break; ...+>
> }
> |
> *switch (...) s
> )
>=20
>=20
> Unfortunately, I am wondering about the following information.
>=20
> Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_switch_without_break2.cocci
> =E2=80=A6
> minus: parse error:
>  File "show_switch_without_break2.cocci", line 8, column 1, charpos =3D 68=

>  around =3D '<+...',
>  whole content =3D  <+... case c: ... break; ...+>
>=20
>=20
> Under which circumstances will such data processing become better supporte=
d?

None. All cases are directly attached to the { of the switch, like if branch=
es are attached to an if header. So the nest doesn=E2=80=99t make sense.

>=20
> Regards,
> Markus

