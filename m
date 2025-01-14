Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86381E77188
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9zUH9Wje89xeYLhFimPLvIFQZexIlQNvNoaHAT6RyJM=;
  b=Q2P0SkT3nYozV7WGJxzOuGzq+W0YtGKwiDJ7preC0uWJAXwIqiQb7uSz
   MGD2EjD1jaWjC1xut9dqJncyn4GRZojcWY+wqhVo6vTFHaj2qOt5faIL5
   WRFWkTT1U44lL9b7oxocfYBd/eo/Pb0+quTLwdRXUzPcycQPMvn5MOUtC
   E=;
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
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="203121464"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 18:50:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E184FE0D1E; Tue, 14 Jan 2025 18:50:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 90D15E0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 18:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9zUH9Wje89xeYLhFimPLvIFQZexIlQNvNoaHAT6RyJM=;
  b=v29LCBe3qyXtgUjQjxvYgIyK/Lv59nbpUtv+q7uqvbVlfKFGHOf3lTpo
   S5mjRldC8pyq7uRYb8aMsEKXZFp4oDtFERrbbPL90+9RADQBuclDiDCx4
   DpAL1zSrBGmx0cRdM9u4JLHu8oAX6qxc1KTYAVJva4noq4UPky4vvsu3Q
   k=;
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="106344862"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 18:50:47 +0100
Date: Tue, 14 Jan 2025 18:50:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jani Nikula <jani.nikula@intel.com>
cc: cocci@inria.fr
In-Reply-To: <877c6yirab.fsf@intel.com>
Message-ID: <ab896f98-63c5-7412-2959-8ae88a9c6d1f@inria.fr>
References: <87plkrhqu9.fsf@intel.com> <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com> <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr> <877c6yirab.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2206
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/ab896f98-63c5-7412-2959-8ae88a9c6d1f%40inria.fr>



On Mon, 13 Jan 2025, Jani Nikula wrote:

> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
> > On Mon, 13 Jan 2025, Jani Nikula wrote:
> >
> >> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
> >> > I don't think there is any search path for .cocci files.
> >>
> >> Oh, so it's always relative to the current working directory? That's a
> >> bit of a bummer.
> >
> > It's not a well developed feature.  If an include path for it would be
> > useful, we can add that.
>
> It might be. Or do you have any other ideas for reusing match rules or,
> say, "iterator name" lists, without duplicating them into all .cocci
> files?
>
> So I guess I can try working around not having include search path by
> running spatch outside of my kernel repo. Does spatch otherwise handle
> that scenario well, or any caveats there?

It should be fine.  I always have my semantic patches in another place.

spatch sp.cocci linuxpath

Not sure about make coccicheck though.

julia

>
>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel
>
