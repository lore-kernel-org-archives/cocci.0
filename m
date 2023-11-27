Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922AC4167B
	for <cocci@archiver.kernel.org>; Mon, 27 Nov 2023 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yCDOyNX7DnFqMK3ax/MVs4lFPzHmsXqlQ4IFdXsEDyU=;
  b=lkNxiHEKxVudX4Lz/hWNFz3f4kNbne1TX7xkTJPdjDVKePhaXTF9YLza
   M5NKrqmuwtwL7dNpFZAm4dG9Xk15ix84VETZY3OBiO40X0xWLeEIjoicx
   rkzNNLWkfByI9fjCqjzKQ3JptKVKcGEMfp+vK6r6clfdHiopZ0UDS64H2
   o=;
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
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138855504"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Nov 2023 20:57:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56621E0CCC; Mon, 27 Nov 2023 20:57:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9DDBE0AF1
	for <cocci@sympa.inria.fr>; Mon, 27 Nov 2023 20:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yCDOyNX7DnFqMK3ax/MVs4lFPzHmsXqlQ4IFdXsEDyU=;
  b=hUXgko2u8eI0oIccgU1Ef5kg/jvlp5DU7HbfaM6E7VRJjSQsJpmxkBfO
   SZnXcL2/JZgj5svJEjgKQstgs9U6hPMVkb6wpabgnQTLALzS/Ql4UJvr+
   7ESf2GLogf7UCjAOyLKA5kcTbmUWDuTTcO6442oNkY4G/jAkdvkqSEijq
   c=;
X-IronPort-AV: E=Sophos;i="6.04,231,1695679200"; 
   d="scan'208";a="138855502"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:57:51 +0100
Date: Mon, 27 Nov 2023 20:57:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Richard Weinberger <richard@nod.at>
cc: cocci <cocci@inria.fr>, Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <101903006.275.1700570321591.JavaMail.zimbra@nod.at>
Message-ID: <alpine.DEB.2.22.394.2311272057320.5171@hadrien>
References: <1735034650.197.1700567751120.JavaMail.zimbra@nod.at> <101903006.275.1700570321591.JavaMail.zimbra@nod.at>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-17434925-1701115071=:5171"
Subject: Re: [cocci] Updating all call sites of a function?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1343
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311272057320.5171%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-17434925-1701115071=:5171
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 21 Nov 2023, Richard Weinberger wrote:

> ----- Ursprüngliche Mail -----
> > Von: "richard" <richard@nod.at>
> > An: "cocci" <cocci@inria.fr>
> > Gesendet: Dienstag, 21. November 2023 12:55:51
> > Betreff: Updating all call sites of a function?
>
> > Hi!
> >
> > I would like to inquire about best practices for updating all call sites of a
> > function.
> > During refactoring, I changed the name and arguments of a function.
> > For example:
> >
> > ubi_rmvol(libubi, dev, n);
> >
> > becomes:
> >
> > ubi_rmvol_wait(libubi, dev, n, 10);
> >
> > What approach do you suggest to catch all call sites, especially where the call
> > is
> > part of a non-trivial expression?
> >
> > e.g.
> > ret = ubi_rmvol(libubi, dev, n);
> >
> > if (ubi_rmvol(libubi, dev, n)) { ...
> >
> > while(0 != ubi_rmvol(libubi, dev, n)) ...
>
> Johannes pointed out on IRC that I think too complicated and gave me an example.
> This does the trick:
> @@
> expression uctx, dev, n;
> @@
> - ubi_rmvol(uctx, dev, n)
> + ubi_rmvol_wait(uctx, dev, n, 10)
>
> My fist version always had a trailing ";", so they matched only trivial callers...

Exactly.

julia
--8323329-17434925-1701115071=:5171--
