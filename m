Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E508EB64D7
	for <cocci@archiver.kernel.org>; Fri, 16 Jun 2023 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=T3JdRM4vzLSOQsvu51kUSAalkpJ28ZNZxdIsbKVrT7s=;
  b=ldoDgDPGSUhfIZ6c4Cpx96Pfwkce2Tpd9WlIvRkO4UzNiIG7eWJhUKE9
   EStCqx+x2cI1xWoBiNJbiDI6S9+REkQ0stgVNqbl9EbQti/GH8YdajqcH
   xoCfk8dUk+LJTAijyeOMrmqMOUPQjdE0fFtsQ9br/Do7kZFl+zK+Km6l7
   0=;
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
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113199656"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2023 11:45:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FA28E03AD; Fri, 16 Jun 2023 11:45:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DCA1EE0157
	for <cocci@sympa.inria.fr>; Fri, 16 Jun 2023 11:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T3JdRM4vzLSOQsvu51kUSAalkpJ28ZNZxdIsbKVrT7s=;
  b=JXrVbCDt5NlvoJldgr8y0oY8sNEOINse3LxYOySEcPx59fNVyfPW/u2e
   xv+EdHyZ6hcWBDrv2xiDt1r88nOyGal8VCIlkJOeHjhEUeO8+i/yUH7uk
   UqeGpiFMY2tP70eZBx+B7wb6ctwszFeySRyYmTPN4fgILX8tnJKWIJwSF
   E=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113199631"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:44:55 +0200
Date: Fri, 16 Jun 2023 11:44:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci@inria.fr
In-Reply-To: <a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
Message-ID: <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr>
References: <a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] macro parsing issue?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1184
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/d4f38fa8-e590-e62b-c311-ab7f6a868070%40inria.fr>



On Fri, 16 Jun 2023, Johannes Berg wrote:

> Hi,
>
> So I was trying to do something (related to locking, changes in Linux
> net/mac80211/debugfs_sta.c, in sta_agg_status_write), but it looks like
> spatch doesn't parse the entire file correctly?
>
>
> Here's a simplified test that should work on the current upstream
> version:
>
> @test@
> identifier fn =~ "sta_agg_status_write";
> type t;
> @@
> t fn(...)
> {
> ...
> }
>
> @@
> identifier test.fn;
> type test.t;
> expression pos, exp;
> identifier ret;
> @@
> t fn(...)
> {
> ...
> (
> +#if SOMETHING
>         ret = strsep(pos, exp);
> +#endif
> )
> ...
> }

The code parses fine.  The problem is that ... requires that the pattern
before and after the ... is not matched in the ... region.  You probably
just want all calls to be modified whereever they occur, so you would want
<... ...>.

You don't actually need two separate rules for what you are showing, but
perhaps that is an artifact of the simplification process.

julia

>
>
> It does nothing, but seems like it should? It ends up skipping that
> entire function, I think, because of parsing issues with the STA_FILE()
> or STA_OPS_RW() macros?
>
>
> I've patched it regularly for now, which is fine too. So this is more
> FYI.
>
> johannes
>
