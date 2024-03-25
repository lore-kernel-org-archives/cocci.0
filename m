Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED47CD11DD
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9mAeFFnIWr7AKj/bK4JUXnQOJH6v6tZf6ZuE5rszU6o=;
  b=Kb3Ay1+zLABZo6ZE6Au3yix3i1k7p7da8pNgqXgYrM9xGXuhgArBm5Nc
   fMNYEydEaY600QrsRDcosZkhGdr05GC2DSBejAy+NVTK6g/ZXYKUpJGLO
   6L4wT6J0nElF2KyGalAm6rLF661tYKZBJhxe4mTAlhrIg3ARgsonFlka5
   A=;
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
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="158295908"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 13:04:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D79EAE014D; Mon, 25 Mar 2024 13:04:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E84BE0145
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 13:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9mAeFFnIWr7AKj/bK4JUXnQOJH6v6tZf6ZuE5rszU6o=;
  b=K4DbzbJ61gMawyp2ZMu5OsYHUW4QAvskTCZziev0+iO0qlPdTMYHvONT
   MGQqt4dNHqac+HNdGN6EGXR/UzZ7RCVIhymqj+nY4m0ObKAhrhZkumvVq
   fQ+cJgtm/KzTwlQ+ECyBWBkxXfQPcGQ/QSwbro/KaAZHqqs15Q5P+bP8q
   4=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708383600"; 
   d="scan'208";a="83018150"
Received: from guest-pool2-19-019.guest.nat.upenn.edu (HELO hnt-440.eduroam.wlan.private.upenn.edu) ([128.91.19.25])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:04:48 +0100
Date: Mon, 25 Mar 2024 08:04:46 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <bd02498e-a97c-443f-b2b7-a77e932079c7@web.de>
Message-ID: <52f9f4a8-ba34-f6ec-9bb5-1b96d5fb2674@inria.fr>
References: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de> <9f199353-3997-858-3858-893848adbf9d@inria.fr> <bd02498e-a97c-443f-b2b7-a77e932079c7@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-123148592-1711368288=:3473"
Subject: Re: [cocci] Improving support for argument lists with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1618
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/52f9f4a8-ba34-f6ec-9bb5-1b96d5fb2674%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-123148592-1711368288=:3473
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 25 Mar 2024, Markus Elfring wrote:

> …
> >> Identifiers can occasionally be followed by parentheses in the source code.
> >> Such a code combination can be interpreted in different ways.
> …
> >>   Improve support for handling arguments of function-like macros
> >>   2024-03-14
> >>   https://github.com/coccinelle/coccinelle/issues/362
> …
> > If you have a specific question, please say what it is,
>
> Please take another look at information in known issue trackers.
>
> How many programming interfaces can be shared by the Coccinelle software for
> data processing according to macro calls and handling of attributes with arguments?

Coccinelle makes no distinction between macro calls and function calls.

But if this is again about your question about non-expressions in macro
arguments, nothing is going to happen.  The issue is rare and is not a
priority.

>
> See also another related clarification approach (from yesterday):
> Fix a parse error for the addition of a special variable declaration
> https://github.com/coccinelle/coccinelle/issues/363#issuecomment-2016794266

I don't see what that has to do with macro arguments.  Please don't mix
issues in a single message, especially when the message doesn't even make
clear what the issue is (giving a link dones't count as making it clear).

julia

>
>
> >                                                         and don't expect
> > that I wuill try to infer it from a collection of links.
>
> Would any more developers get into the mood to add ideas accordingly?
>
> Regards,
> Markus
>
--8323329-123148592-1711368288=:3473--
