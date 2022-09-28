Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B1C32771
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 05:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=gWzKGv7ReSAIH4DneQWl5fiCWt4LtZZ79FmYwJ148Qw=;
  b=PF3t5sDwI4KSlRU2NyWqMdizZDc1Fsygq8pvVhE8Xy974J2Aq70dis6S
   nZugOS2aZg2aTdre7/8yEV6dKbhv7v/wXlb4wD07WDgUxWI0OE3cFMCy5
   OVZC8z1S+NAJmbUnYfDjKc6hCGzsBWYMVjzuvpKDJ+lwQ5n+HNZC9mc/t
   s=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54847903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 07:23:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D60C0E0241; Wed, 28 Sep 2022 07:23:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D0004E0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 07:23:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gWzKGv7ReSAIH4DneQWl5fiCWt4LtZZ79FmYwJ148Qw=;
  b=RbJqOYELmywi2qpCX++yU160vSfYahRTsW7BlXZBmn835XbUq1FoPh6K
   pu5K2iHgPeoYtksxOibNMJE45ze2xahWUTamv91k4fUxPHjdGRaV1xbEL
   nQfLFSDHtniIk6cGlqcw/YIqMNE+V3G5OiJz5As6iRrUCKnB1iPGd2qpc
   w=;
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54847897"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:23:44 +0200
Date: Wed, 28 Sep 2022 07:23:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, linux-hardening@vger.kernel.org, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <202209271425.50502D365C@keescook>
Message-ID: <alpine.DEB.2.22.394.2209280722150.2844@hadrien>
References: <202209260912.8DCCD70@keescook> <alpine.DEB.2.22.394.2209262259030.2915@hadrien> <202209261505.9AE38B8@keescook> <alpine.DEB.2.22.394.2209272235060.2842@hadrien> <alpine.DEB.2.22.394.2209272304030.2842@hadrien>
 <202209271425.50502D365C@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch --jobs N missing matches?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 596
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209280722150.2844%40hadrien>



On Tue, 27 Sep 2022, Kees Cook wrote:

>
> On Tue, Sep 27, 2022 at 11:09:35PM +0200, Julia Lawall wrote:
> > The problem is fixed in github.  Coccinelle was doing some caching of
> > header files, that was not desirable in the case where one actually wants
> > to match the code, and not just get type information.
>
> Thank you for the fix! I can confirm things appear to be working
> correctly now. (And took 124 minutes to run.)

OK, long, but at least you get the result.

> > [...]
> > Actually, there are not that many memcpys in the considered code.  Then
> > there are not that many that refer to the last element of a structure.  If
> > level2 produces nothing, then level 1 should not be applied.
> >
> > In the original rule order, all of the pairs of a flexible structure and
> > any structure are considered, regardless of whether any memcpys are
> > present.
>
> Ah! Yes, I keep forgetting to start with the narrowest part first. :P
>
> I also forget that I can do a "depends" on something that has no other
> matches, but if it's built on prior rules that I use in later rules,
> then it limits that rule directly. I haven't quite managed to think
> sideways hard enough. :)

Actually, that is the only purpose of depends on.  Your original rule had
a depends on level2 that was unnecessary, since the rule couldn't match if
some metavariables from level2 were not bound.

julia
