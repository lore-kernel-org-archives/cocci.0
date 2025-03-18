Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A710C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Y57N1EJxFdN26s7uyzNK7XmQQfz93zfEr2AmGjtcjTc=;
  b=Koq9OJEdJWtWuHXum00W49AJo7KQopmiTVVSWtlJoiFvOAojMv2ecFjr
   dyow4wET9dJPUURLMYJp6UOo+BmyWXnqG1bKfQQZ0R1NLEGH2OOwq8//E
   3l1OAGnfhBcz42rOOWJmX+yzD2etoBhbp6ue0ubA24ZQc2LbWWPX64xJw
   o=;
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
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="213581558"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 23:03:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 093EAE0264; Tue, 18 Mar 2025 23:03:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9EEA0E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 23:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=Y57N1EJxFdN26s7uyzNK7XmQQfz93zfEr2AmGjtcjTc=;
  b=ssQIXa6QWO5ocxgyGqCHUj+wNUaotDN/T8cpE5oQ6k9JmdQJKP4nEpSO
   Z3xeGX3QeYgviV1aOpH5LnUKwh34NeAXDIFrJIDg3owO6reO4hntcVi0v
   rxF3ka9dJwdHGl2aKqC8G7Hr0KxgqeP9FyLsU3t2nhSmZXvEe32RvwULB
   U=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736809200"; 
   d="scan'208";a="111959551"
Received: from static-81-27-112-106.teledata-fttx.de (HELO smtpclient.apple) ([81.27.112.106])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:03:22 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Tue, 18 Mar 2025 23:03:12 +0100
Message-Id: <2EF77FCB-B7CE-4B0D-8E79-3240588502E5@inria.fr>
References: <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
Cc: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
In-Reply-To: <27f57368-6a2d-4ea4-8a81-b8bee42e2d5d@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] the future of bundles in coccinelle.git
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2632
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2EF77FCB-B7CE-4B0D-8E79-3240588502E5%40inria.fr>

The bundles are used if you don=E2=80=99t have the software.
Sent from my iPhone

> On 18 Mar 2025, at 22:53, Jacob Keller <jacob.e.keller@intel.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 3/18/2025 3:19 AM, Julia Lawall wrote:
>>=20
>>=20
>>> On Tue, 18 Mar 2025, Olaf Hering wrote:
>>>=20
>>> While looking for the proper way to import pcre2, I realized that the
>>> way configure.ac looks for required OCaml libraries is ... weird.
>>> There is no way to force the usage of the variants in bundles/, the
>>> version provided by ocamlfind is always preferred.
>>>=20
>>> I think since a while the required build environment is easy to create
>>> with either 'opam install $ALL_BUNDLES', or 'zypper install $packages'.
>>>=20
>=20
>>> Hence I suggest to remove bundles/ and all code referring to it.
>=20
> Why not go the other route and optionally use the bundles?
>=20
>=20
>>=20
>> No, we don't want to do that.  The idea of bundles is to limit the
>> dependencies.  We don't want users to have the be highly integrated into
>> the OCaml ecosystem.  Typical Coccinelle users don't care about OCaml at
>> all.
>>=20
>> Perhaps it is just a personal preference, but when faced with some
>> software that eg asks me to install 20 python libraries, I choose some
>> other software.  I guess others may have the same reaction to software
>> that requires installing opam etc.
>>=20
>> julia
>=20
> It can be tricky if asked to install dozens of libraries which aren't
> packaged within the distro I'm using. If they do come with the distro
> repositories, then I am quite less concerned.
>=20
> On the other hand I get a bit concerned if I see a couple dozen bundles
> which I have no way to know if they stayed up to date with any recent
> regressions or vulnerabilities.
>=20
> That being said, I have had numerous issues in the past when building
> coccinelle from source where things failed to compile because of changes
> in the versions I had installed by distro vs what was expected. I am not
> certain if these were real conflicts or just artifacts of an incorrect
> build setup, but I remember my experience being frustrated quite often
> any time I had to rebuild from scratch.

