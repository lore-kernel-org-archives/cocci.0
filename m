Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D001DE7719F
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2025 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IYpdx2tJuicZv1490eETrjohiHSGOzCBH7GBFAzPDvo=;
  b=OVVTVLJ2HCHYXt432cdhI+217wcmcC4PzOPV46e/o6fByFmsg7SlMVux
   le5QhLlQx97rY/Xax42GJ4WZ4YlAIQ20WX6fn9pNaGl8fol86+FUQubWC
   na8wmFIpKzbmLNWtj7Yp2kuwyvDxNT+xgkvxX0reTpZDv3qDQdaHXtx7e
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
   d="scan'208";a="202788878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jan 2025 13:09:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C4E35E0D1E; Mon, 13 Jan 2025 13:09:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0481FE0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 13:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IYpdx2tJuicZv1490eETrjohiHSGOzCBH7GBFAzPDvo=;
  b=Xv5TyiQVqh7wuQ6L8DJyAwMy6lpZReoNMjF94HUETKhkbcErZtkFcDug
   Cyzu3nM3L1KizepIt3NL/6uZk7Gv8hG2Vhm4Luj1DIyv5puAgXUTMgy7E
   8v8KzaIwJ9eR0nlAUm9cnr8KWpMogfaf4dyvGm8RhSteEmw2JvU34l+3n
   w=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202788868"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:09:30 +0100
Date: Mon, 13 Jan 2025 13:09:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jani Nikula <jani.nikula@intel.com>
cc: cocci@inria.fr
In-Reply-To: <87plkrhqu9.fsf@intel.com>
Message-ID: <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr>
References: <87plkrhqu9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2199
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/40a550cc-984f-8d-6c3b-8c9c0a7fa5c%40inria.fr>



On Mon, 13 Jan 2025, Jani Nikula wrote:

>
> I want to use a non-trivial match rule in multiple other rules, in
> multiple .cocci files. I'm trying put the match rule in a separate file,
> and #include that in the other files, to avoid duplication. (I'm
> referring to the "include_cocci ::= #include string" usage of #include,
> not transformations.)
>
> It works when the current working directory is the same as the file to
> be included, but I seem to be unable to make it work from another
> directory.
>
> It doesn't matter if the .cocci files are all in the same directory or
> not, it doesn't seem to matter what I pass as -I to spatch on the
> command-line. I see #include mentioned in the SmPL Grammar as well as
> some tutorials, but I can't find any proper, working examples for it.
>
> How is the #include and the search path supposed to work? There seems to
> be some conflation in the documentation about include_cocci in .cocci
> and #includes in the .c files.
>
> Specifically, I'm running spatch in my kernel repo, and I keep the
> .cocci files in a separate directory outside the kernel repo.

I don't think there is any search path for .cocci files.

I see an example in tests/gadget_soa_defs.cocci that contains

#include "tests/gadget_match.cocci"

There was a problem about the files coming in the wrong order in the case
of multiple included files.  I've pushed the recent changes out to github
just now, so that fix should be there.

julia
