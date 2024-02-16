Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AE3C48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Gmm0VgAqmbSQWhxoT3A4OdyLW7jq6s2iufi60yqPmYo=;
  b=CQz6TXNgfaxIDjtlgYVp5UIoTngmYsnzhsjMm06c/XFyzGWq6Y6xBFWM
   cIP2NPlXBfPzMAmEaIlr94hdCxGRUZC8c1KEs29D1J+ukpgWQdVb/T8KV
   XsZLIu9cXrHyH2QxCRhC+jRpMaJEnEu3HfBIttPno601ie0ObaJYViacb
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152275369"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 10:51:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAAEEE0CD8; Fri, 16 Feb 2024 10:51:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A8DBE008A
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 10:51:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gmm0VgAqmbSQWhxoT3A4OdyLW7jq6s2iufi60yqPmYo=;
  b=NARlgwFN7wKIcJ6rkaSKuibaP8hYRy4RlcnNeF67ByEPuBg7q3OukXga
   fVxDN1aHMTSdEt9jqx4kBih3aqjxB0bcHCVuRarGiXk/F6I0EXTNyCSHk
   3rXpdzwIlRpxYtk6Grtxl/grPT3Vv/VbArS4GO4hCbMfD7dOokOV8jfxb
   c=;
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152275357"
Received: from wifi-eduroam-84-002.paris.inria.fr ([128.93.84.2])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 10:51:44 +0100
Date: Fri, 16 Feb 2024 10:51:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
cc: cocci@inria.fr
In-Reply-To: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com>
Message-ID: <654c2ee-755b-d245-d1c9-371b314d9efb@inria.fr>
References: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-496292471-1708077104=:65272"
Subject: Re: [cocci] Spatch 1.1.1 backward incompatibility
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1565
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/654c2ee-755b-d245-d1c9-371b314d9efb%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-496292471-1708077104=:65272
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 16 Feb 2024, Christoph Böhmwalder wrote:

> Hi,
>
> I recently(?) got a new version of coccinelle from Fedora:
>
>
> $ spatch --version
> spatch version 1.1.1 compiled with OCaml version 5.0.1+dev0-2022-12-15
> Flags passed to the configure script: --build=x86_64-redhat-linux-gnu
> --host=x86_64-redhat-linux-gnu --program-prefix=
> --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr
> --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc
> --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64
> --libexecdir=/usr/libexec --localstatedir=/var --runstatedir=/run
> --sharedstatedir=/var/lib --mandir=/usr/share/man
> --infodir=/usr/share/info --with-python=/usr/bin/python3
> --with-menhir=/usr/bin/menhir
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
>
> And it broke a lot of our semantic patches. I now get lots of these
> warnings:
>
> warning: rule starting on line 248, node 45:
> kunmap_local(...)[1,2,20,21,25] in recv_dless_read may be inconsistently
> modified
> warning: rule starting on line 248, node 42: decl:mapped[1,2,20,21,22]
> in recv_dless_read may be inconsistently modified
> warning: rule starting on line 273, node 18: src = ... ;[1,2,8,9,11] in
> drbd_csum_bio may be inconsistently modified
> warning: rule starting on line 273, node 20:
> kunmap_local(...)[1,2,8,9,13] in drbd_csum_bio may be inconsistently
> modified
>
> (By the way: these are reported on stdout, I'm not sure that's intended
> either)
>
> And the patch output is noticeably different.
>
> This all works fine on 1.1.0, and curiously it also works on the 1.1.1
> version in Ubuntu:
>
> $ spatch --version
> spatch version 1.1.1 compiled with OCaml version 4.13.1
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
> I'm trying to come up with a minimal reproducer right now, but just
> throwing this out there in case anyone has an idea.

Thanks for the report.  If convenient you could try the github version.

I really need to make a new release...

julia
--8323329-496292471-1708077104=:65272--
