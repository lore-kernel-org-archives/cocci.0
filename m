Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7E5C021B8
	for <cocci@archiver.kernel.org>; Sat,  1 Mar 2025 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XUhcavnEhYZqSknC9Fw4u4uivkQbnFdzz0pQ/vIEAVg=;
  b=PFdRsFbSQlmwt+HQR3HddFcrodSI3TDNPNxh0rTG7Zcv7oj54WxCtVGO
   ssfzEQYjipF060iY4hRUAR/+Sg9hMz881VfhmQNdeKoZ+ejPXgopcvEKj
   oNDEQTUOiN5zXVKJLfeuQspIm7KWbwag8Z2gMSof2SGv/78LJAcfNeW41
   w=;
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
X-IronPort-AV: E=Sophos;i="6.13,326,1732575600"; 
   d="scan'208";a="210709196"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 00:45:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4AE1FE0D1D; Sun,  2 Mar 2025 00:45:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 29944E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 00:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=XUhcavnEhYZqSknC9Fw4u4uivkQbnFdzz0pQ/vIEAVg=;
  b=uCo4cPhON2/YfLMdbUdoWLLHcq090IosX3KRhs/TXijkmMhUSR2b5Znm
   oYbRAnIjgANrfMLlAuHhee0HxP/pZhElbK4rdTfqg4VcwTKFc0Qhfq/WG
   KaYvU4OVGsjDX1Mq5KNytSTgUee5NbOqYX+PGROh5C1P4Y97hbv4/mxhi
   0=;
X-IronPort-AV: E=Sophos;i="6.13,326,1732575600"; 
   d="scan'208";a="110407601"
Received: from 180.165.185.81.rev.sfr.net (HELO smtpclient.apple) ([81.185.165.180])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 00:45:02 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 1 Mar 2025 18:44:49 -0500
Message-Id: <E43F88D1-E2A5-456F-9315-D5788162848F@inria.fr>
References: <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
Cc: cocci@inria.fr, Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <410c55e5-0a41-4c7e-84ba-55e936795813@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Replacement of the form `x |= function()`
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2464
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/E43F88D1-E2A5-456F-9315-D5788162848F%40inria.fr>

Probably you are missing a space after + ?
Sent from my iPhone

> On 1 Mar 2025, at 08:36, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>> What version of Coccinelle do you have?  For me it works fine...
>=20
> Under which circumstances will a transformation approach (like the followi=
ng)
> become better supported?
>=20
> @adjustment@
> expression lhs, rhs;
> @@
> lhs
> -=3D
> +|=3D myfunc(
> rhs
> +         )
> ;
>=20
>=20
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --version=
 && spatch --parse-cocci suggestion1_for_Alyssa_Rosenzweig-20250301.cocci
> spatch version 1.3-00043-gcca22217d-dirty compiled with OCaml version 5.1.=
1
> =E2=80=A6
> plus: parse error:
>  File "suggestion1_for_Alyssa_Rosenzweig-20250301.cocci", line 10, column 1=
, charpos =3D 227
>  around =3D '|=3D',
>  whole content =3D +|=3D myfunc(
>=20
>=20
> Regards,
> Markus

