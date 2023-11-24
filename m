Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61888C61D97
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 07:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3zNa54xCfF1xYhyBN3dnUYCSrFKOC53MpaF9p4klzco=;
  b=mYmF8ND3vZnK/4af2zoWefQoPYPsbkHGa6icYFiooaChpeA4zGcs/5Q+
   okQ4CF1mqj8qIxbXUcjBkSSK8f+IP+Ljclhnt87i6FX8fiYZEc6GjI5X8
   CS24kb3km6nk3PtU6wMfMcMgRzgUvJp/PBx1EFsM4M1u1l92DLrVW08PB
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138246703"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 08:11:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 95E4EE0CCA; Fri, 24 Nov 2023 08:11:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B20E5E004E
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 08:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3zNa54xCfF1xYhyBN3dnUYCSrFKOC53MpaF9p4klzco=;
  b=ZUyymzc/D8EfX4xQ3YrU3//1/xmS3mlF6kKywFhwH8/vXyKOSU3bB72t
   Iq4i8EanwGaTJC7WgsY6vBcSh5TQmnL+O+hFqOmUX47Ob/i9+JoqbWxeI
   2kJ0b24K1v1p9Zpno9v/fEL6JQoQxdzF1Iy9fXimr4z/M/MsDWb7DSujl
   I=;
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138246701"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 08:10:58 +0100
Date: Fri, 24 Nov 2023 08:10:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
Message-ID: <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-927989397-1700809857=:3349"
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1326
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311240807170.3349%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-927989397-1700809857=:3349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Nov 2023, Markus Elfring wrote:

> Hello,
>
> I tried another script variant out for the semantic patch language
> (once more according to the software combination “Coccinelle 1.1.1-00571-g162a9149”).
>
>
> @initialize:python@
> @@
> import pprint
>
> @find@
> position pos;
> @@
>  return@pos ...;
>
> @script:python display@
> places << find.pos;
> @@
> pprint.pprint(places)
>
>
>
> Corresponding source file example:
> int main(void)
> {
>  return 0;
> }
>
>
>
> Test result:
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> spatch display_position_information_for_one_return.cocci only_return_from_main.c
> …
> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)

The type of a position variable in python is an array.  In OCaml it is a
list.  This is completely independent of the number of element involved.

> Why was a tuple constructed for a single source code place?
> https://docs.python.org/3/reference/datamodel.html#immutable-sequences
>
> Can a “Location” object be provided directly according to a metavariable type
> like “position”?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8d66511d00b27de44e5c21b60d41938d32321b1a/python/coccilib/elems.py

I don't understand the question.  I guess that a position variable is
mapped to an array of locations.  So if you want a location, you would
take the first element of the array.  But again, I don't know python, so
perhaps something else is going on.  I guess you do know python, so you
could figure it out yourself.

julia
--8323329-927989397-1700809857=:3349--
