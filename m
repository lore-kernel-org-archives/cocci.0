Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C518C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a6YdSPj16SLy7G9JwgmepwtJZKE9GqsUkHzgwTEWwlQ=;
  b=CNLXHELqdd8maPwatu9xThlFaPoxTOFnEdoQh660yMzVAQEQ+XjA1O8G
   9DffNO0t/Hkn0vozOaZozeCxCdTFUlPa9kpf8Jaovwr8RSh8BrkV00Zyo
   fQAms9nGBAkGxRnJeu/BOD7lQzDtzEr+ZZEfwI2aVpwq+NQ8NSpNGaykl
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 16:43:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A39F2E0D24; Tue, 18 Mar 2025 16:43:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DDB81E0261
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 16:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=a6YdSPj16SLy7G9JwgmepwtJZKE9GqsUkHzgwTEWwlQ=;
  b=Ce95gvSeX8hADKQdmuMDptwil10YDUL3UVgCo7TRywo6gZQ4rgZ8hb2l
   ABAgKgDhGSdTpQ20t6wUQV5lH0FJefC/egPU7eWrvvyAin9hZ3+yPdO3V
   krLcWWjeMzrhWcVX8T/p9IcvXTFFWIibstLqGbmhrdbmBM+s3JHcAIIGf
   0=;
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534426"
Received: from static-81-27-112-106.teledata-fttx.de (HELO smtpclient.apple) ([81.27.112.106])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:43:40 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Tue, 18 Mar 2025 16:43:30 +0100
Message-Id: <14B17EC1-3D43-4D47-8A0C-9DFFA06D23E8@inria.fr>
References: <202503180837.790801EF6@keescook>
Cc: cocci@inria.fr
In-Reply-To: <202503180837.790801EF6@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2625
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/14B17EC1-3D43-4D47-8A0C-9DFFA06D23E8%40inria.fr>


Sent from my iPhone

> On 18 Mar 2025, at 16:39, Kees Cook <kees@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 18, 2025 at 12:13:15AM +0100, Julia Lawall wrote:
>> It makes the call just disappear.
>=20
> Right, unfortunately this breaks replacement, because the __free
> vanishes completely even in the replacement:
>=20
> -       struct platform_profile_handler *pprof __free(kfree) =3D kzalloc(
> -               sizeof(*pprof), GFP_KERNEL);
> +       struct platform_profile_handler *pprof =3D kzalloc_obj(*pprof, GFP=
_KERNEL);
>=20
> How do we get __free to be treated like any other variable attribute?
>=20

It would certainly be good to supp=C3=B4t it better. But I have the impressi=
on that you are removing and recreating the whole part to the left of the eq=
ual? It could work better to remove and recreate only the kzalloc call.

> --
> Kees Cook

