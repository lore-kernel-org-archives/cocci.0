Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E4C4332F
	for <cocci@archiver.kernel.org>; Thu,  2 Nov 2023 21:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z1NpHf+ickCZ3JZZnaLgy5uvJFGYSq4e+2hH9vxGT6o=;
  b=DB6iY8pNcI0Jm/2q90t9zRbEc9vcQ3y9XzzNdYSMs7hGRhb3yvbXggfF
   HR6Pa9cRZiO2x4J7FV5znRfr8884MxP+RbaoIVsaJM1kisERZMunop0+O
   TRvvXq29+972A1OeJ4G/xpY4pR8rUrCK9DSUs1NEQpvmv9Av55VM7TEMB
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.03,272,1694728800"; 
   d="scan'208";a="134394954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2023 22:28:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE4A9E00BA; Thu,  2 Nov 2023 22:28:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 244FCE00B6
	for <cocci@sympa.inria.fr>; Thu,  2 Nov 2023 22:27:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=Z1NpHf+ickCZ3JZZnaLgy5uvJFGYSq4e+2hH9vxGT6o=;
  b=IHMb2YOCDY/Dv59PibWzdT7rnd/tiFfKfWS8YWCLriD7l9Y5xWoRpLUC
   r/KtHrOrr7Kdrfa3mignup/JCpmeEaMI4ppoaLscBml/CpoW1TYzzRXPb
   xwrSAB1hhcsh9M9M8drp/q6RryA1smqfYEtDxPsc8QYKEWz6XqFG2WT0p
   o=;
X-IronPort-AV: E=Sophos;i="6.03,272,1694728800"; 
   d="scan'208";a="134394949"
X-MGA-submission: =?us-ascii?q?MDEeuemg07ECtdgWwyBF/gXCatUf0rYEVG2UuN?=
 =?us-ascii?q?CMQzu8WX+yqMTLVDDYMsQipOJ8h8IkBPjzTs7OXOBRZ2e0dhDAtxC34L?=
 =?us-ascii?q?5EmbC4dC1LSlo7HgZLTxfzrEUT6x5t/GDDzk3DzsWq/D2DGrZXU1K3oG?=
 =?us-ascii?q?MnpCc/Zg1XYaJew9Ktk91WJQ=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2023 22:27:56 +0100
Date: Thu, 2 Nov 2023 22:27:55 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anton Eliasson <anton.eliasson@axis.com>
Cc: nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, kernel@axis.com
Message-ID: <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
In-Reply-To: <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [92.89.85.231]
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - FF119 (Linux)/8.8.15_GA_4570)
Thread-Topic: scripts: coccicheck: Return error from run_cmd_parmap
Thread-Index: /FuP+QpGx8nmd9ShkUiiXS4mQsbSqA==
Subject: Re: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from
 run_cmd_parmap
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1287
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/978265928.4471013.1698960475973.JavaMail.zimbra%40inria.fr>



----- Mail original -----
> De: "Anton Eliasson" <anton.eliasson@axis.com>
> =C0: "Julia Lawall" <Julia.Lawall@inria.fr>, "nicolas palix" <nicolas.pal=
ix@imag.fr>
> Cc: "cocci" <cocci@inria.fr>, "linux-kernel" <linux-kernel@vger.kernel.or=
g>, "Anton Eliasson" <anton.eliasson@axis.com>,
> kernel@axis.com
> Envoy=E9: Mardi 3 Octobre 2023 16:25:14
> Objet: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from run_cmd=
_parmap

> Exiting on error breaks the chain mode. Return the error instead in
> order for the caller to propagate it or in the case of chain, try the
> next mode.
>=20
> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> ---
> scripts/coccicheck | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..95a312730e98 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -153,7 +153,7 @@ run_cmd_parmap() {
> =09err=3D$?
> =09if [[ $err -ne 0 ]]; then
> =09=09echo "coccicheck failed"
> -=09=09exit $err
> +=09=09return $err
> =09fi
> }
>=20

I tried disabling OCaml in my version of Coccinelle and then ran make cocci=
check with this patch.  But I didn't see any improvement.  On the other han=
d, it keeps going if I just remove the exit line entirely.  Is that what is=
 wanted?  One can still see the coccicheck failed message.

julia

> --
> 2.30.2
