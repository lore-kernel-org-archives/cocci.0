Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11622C46CD2
	for <cocci@archiver.kernel.org>; Wed, 24 Jan 2024 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/dbESF01XU8uWF04o4lvEoePLzDYTSvQdMZXxHA7DiQ=;
  b=bztRmAGLR23SqGY7wKdGanJKTvGG3VDwmiuj2K9UFAdpTPKts2JhCZWa
   TSa8tezuli2opgbQF3uxKh/EbFwobXtosqGeMpY60Q3/EZjQ0nD9y6UEK
   y1nHeZUDX+0W+/ZXe7i9F2p0jL3EikwgwS8UEReYtLzlyjO/u0iAMa+T2
   8=;
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
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148462812"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jan 2024 18:56:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E15FE0CD6; Wed, 24 Jan 2024 18:56:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B4625E0035
	for <cocci@sympa.inria.fr>; Wed, 24 Jan 2024 18:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/dbESF01XU8uWF04o4lvEoePLzDYTSvQdMZXxHA7DiQ=;
  b=JRYwzhzszNKHYJN/2GI+D8Ut0fKyPUnCyUbBdZNbgtiPMZXt445vayW6
   NjguOoinrLYhFcU2KAvw8/T3+EfQguettsVcpvGePu0aVdeTUOcE4H+Jd
   Vmm+m9X5kwojyT7K9r0LLJlMg4HxBkVMb9U2QVPhIMvEVbumMa8v/4kMg
   s=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148462807"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 18:56:44 +0100
Date: Wed, 24 Jan 2024 18:56:44 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
Message-ID: <297bf3e1-8262-a599-20ff-dc8086d5b87a@inria.fr>
References: <4604ee8e-a876-4545-b0cb-e4fba2e187a2@web.de> <c5407d97-913-f788-7ffb-11b65373cb5@inria.fr> <23ff96d1-8cf2-4736-be84-c00600b15a73@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Checking a parse error for detailed SmPL rule
 properties
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1479
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/297bf3e1-8262-a599-20ff-dc8086d5b87a%40inria.fr>



On Wed, 24 Jan 2024, Markus Elfring wrote:

> >> May SmPL rule identifiers be chosen freely?
> >
> > It seems that they should not be keywords.
>
> Should such SmPL identifiers be independent from an applied programming language
> like OCaml?

It has nothing to do with OCaml.  or is an alternative form of || in C.

https://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B

julia
