Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08196E7716C
	for <cocci@archiver.kernel.org>; Thu,  5 Dec 2024 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MqyFYjI91vAC+GFu4DManPlz8RNFxWnRmAYMgGaxbiU=;
  b=leT0wubuNJ9/qZ6vfyhyw3kB3RMluX6zPcZrRIFtwL7xfBWkqUm42Ode
   Y5W7efJHOUbl7XlNB8Z+ll5RSp5Fy1A59oRGnJIpmNE4lUifUZDOTc740
   J7yTbPyffCf5fzytkhzeXfzNFgrmXTrmqtDbmJc0ydML4Z4ROsc36BT9l
   c=;
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
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="197478234"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2024 09:52:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E1D33E0133; Thu,  5 Dec 2024 09:52:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B1C3E00B6
	for <cocci@sympa.inria.fr>; Thu,  5 Dec 2024 09:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MqyFYjI91vAC+GFu4DManPlz8RNFxWnRmAYMgGaxbiU=;
  b=UUJJktWJCOWRT1+ihK9dDt/zSDwXW1OeFuRwQsNHRQ4SmQzA2ercb5AM
   kq7Gb7kS96o+bck4g9UkCPYgN+UVWBlgeCGmO0V2YBdNbQPOyDYiE5Zmp
   yndAeiXRBmrmz/BE3NJuDY43llHuiVDLzz94cOC3XwV7rpqF4z3evFnJm
   w=;
X-IronPort-AV: E=Sophos;i="6.12,209,1728943200"; 
   d="scan'208";a="103498040"
Received: from unknown (HELO hadrien) ([5.148.126.126])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 09:52:17 +0100
Date: Thu, 5 Dec 2024 08:52:16 +0000 (GMT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Zack Rusin <zack.rusin@broadcom.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
Message-ID: <1995b696-6825-a144-fcb-c5f9f3b1094@inria.fr>
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com> <6b81d431-36e9-7a7a-687b-2d7fc7aa6c31@inria.fr> <CABQX2QP0Vk5UZPDFDXThvzuw-gkam-4wU_xq3rbSmwi9x7cBHw@mail.gmail.com> <dff4cbd9-00c1-47a9-b2f7-fb2e98d04433@web.de>
 <CABQX2QPZB9uHMxKKoZA6f=+4f0ifHfft-rHcqd-Ck9rjo7-ShQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-599806276-1733388736=:3172"
Subject: Re: [cocci] Replacing type names
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2160
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/1995b696-6825-a144-fcb-c5f9f3b1094%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-599806276-1733388736=:3172
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 4 Dec 2024, Zack Rusin wrote:

> On Wed, Dec 4, 2024 at 2:56 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > From the sample_case.c I linked before the two constructs I'm having a
> > > hard time matching are function names in definitions and type names in
> > > parameter list, i.e. in
> > > static bool SomeDeviceLocalCompare(SomeDevice *localDevice)
> > > neither SomeDeviceLocalCompare or SomeDevice seem to matched via idexpression.
> >
> > * Did you find scripted SmPL constraints more attractive somehow
> >   than script rules?
> >
> > * How do you think about to choose more appropriate context information
> >   and corresponding metavariable types?
>
> Sorry, I'm not sure what you're asking. Nothing has changed since my
> first email. Coccinelle is a wonderful tool, but currently it doesn't
> work for this use case. The type replacement is matching multiple
> times and to my knowledge there doesn't seem to be a way to convert
> arbitrary function and parameter type names. This is an all or nothing
> type of problem - either all of it can be replaced or a regex script
> has to be used (clang-tidy with readability extensions also misses a
> bunch of constructs) to convert from camelCase to snake_case. So
> afaict there's no way to solve this problem without using some regex
> replacement script.

Sorry I haven't been following along with this.  Could you remind me what
part doesn't work?  Just because something isn't matched using
idexpression doesn't mean that it desn't work.  For the function name
just match the function definition, declare an identifier metavariable,
and change the name.  I guess that there is currently nothing like idtype,
but you could have a type metavariable with a regexp that prevents the
match from containing spaces.  Or perhaps it would be better to just use
script code to reparse the type, to address cases with * [] etc.  This is
a bit more clunky than one would hope for, but it seems like it would be
safer than a regexp.

On the other hand, we don't propose anything to do updates in comments.

julia
--8323329-599806276-1733388736=:3172--
