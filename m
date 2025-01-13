Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF0C02180
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2025 12:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/ciPc826knYbWs8TOeYKOlb3n9LIMpW87O3MVWkHmm0=;
  b=iDLVZJeHFJanqei3iuiwP4nHBL5Z/8ILX+4EXSUraSIbZb5mzDPvsE67
   +Uz/mtJJCbIRq7NA489yMZe9B0w36uezJm1j9Nq7RLZPg8bcokCQC2OQ3
   +adykLzChI7wzYMiYg1ivt/npj68u3AnwcG3uGoGmLcFQcXr4HIg6O/i3
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
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202803914"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jan 2025 13:43:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C58CE0D1D; Mon, 13 Jan 2025 13:43:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD361E0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 13:43:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/ciPc826knYbWs8TOeYKOlb3n9LIMpW87O3MVWkHmm0=;
  b=iGzkIv+099o2CtW9nL2xunupaXgKuEtMdPv1CdHWSTXb7cKiP4IubrTl
   d/M3KPvlcDMg9V24GGKn2LnPTVjOOcKdXcZM4z/P4jfmO+SiWNrw/FVep
   Yxxn/vtX3WNzBHjnQSnKp+WtS1DJGU5FHi1igeMuznE5XSMWQw0WPYT6Y
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202803885"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:43:08 +0100
Date: Mon, 13 Jan 2025 13:43:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jani Nikula <jani.nikula@intel.com>
cc: cocci@inria.fr
In-Reply-To: <87frlmj38x.fsf@intel.com>
Message-ID: <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr>
References: <87plkrhqu9.fsf@intel.com> <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2201
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/4ebe30f0-d7b3-59de-4a8b-22668cba59c3%40inria.fr>



On Mon, 13 Jan 2025, Jani Nikula wrote:

> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
> > On Mon, 13 Jan 2025, Jani Nikula wrote:
> >
> >>
> >> I want to use a non-trivial match rule in multiple other rules, in
> >> multiple .cocci files. I'm trying put the match rule in a separate file,
> >> and #include that in the other files, to avoid duplication. (I'm
> >> referring to the "include_cocci ::= #include string" usage of #include,
> >> not transformations.)
> >>
> >> It works when the current working directory is the same as the file to
> >> be included, but I seem to be unable to make it work from another
> >> directory.
> >>
> >> It doesn't matter if the .cocci files are all in the same directory or
> >> not, it doesn't seem to matter what I pass as -I to spatch on the
> >> command-line. I see #include mentioned in the SmPL Grammar as well as
> >> some tutorials, but I can't find any proper, working examples for it.
> >>
> >> How is the #include and the search path supposed to work? There seems to
> >> be some conflation in the documentation about include_cocci in .cocci
> >> and #includes in the .c files.
> >>
> >> Specifically, I'm running spatch in my kernel repo, and I keep the
> >> .cocci files in a separate directory outside the kernel repo.
> >
> > I don't think there is any search path for .cocci files.
>
> Oh, so it's always relative to the current working directory? That's a
> bit of a bummer.

It's not a well developed feature.  If an include path for it would be
useful, we can add that.

julia

>
> Thanks, though.
>
> BR,
> Jani.
>
>
> >
> > I see an example in tests/gadget_soa_defs.cocci that contains
> >
> > #include "tests/gadget_match.cocci"
> >
> > There was a problem about the files coming in the wrong order in the case
> > of multiple included files.  I've pushed the recent changes out to github
> > just now, so that fix should be there.
> >
> > julia
>
> --
> Jani Nikula, Intel
>
