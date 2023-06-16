Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2989EB64D7
	for <cocci@archiver.kernel.org>; Fri, 16 Jun 2023 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3KQXFlP/CT9NdjdNME8ufpOsdmKsATO3hXuinjYNhWw=;
  b=PMHcsxDsjbJgfTRry5XUmYBc3ue6GQCJ1SKtnYDG2qtaT18wKG/kUK3Z
   I325dW1/NtDsp6R6sGT2FPAWCDnQW+tbfdcnszaNubf2E8hELaL1vYQdf
   kDO+yUHb8rFBdZoZ4yOAPOy+xC2SRD5rwZe6nqMpL4YtmQRRHtQdsWpZX
   s=;
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
   d="scan'208";a="113202491"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2023 11:56:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04C54E03AD; Fri, 16 Jun 2023 11:56:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56402E03AB
	for <cocci@sympa.inria.fr>; Fri, 16 Jun 2023 11:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3KQXFlP/CT9NdjdNME8ufpOsdmKsATO3hXuinjYNhWw=;
  b=VigWTRZkJCvE9TB3x5+HQBiC5JvJ9L43hp5WSjXQrJcaoJJGh9T3BVig
   9PnVFjEfk6noPGHYzAZIOa/mu4/o12cVXlu2h93i+CkHGtcWIeroPt9L2
   /BzL9/x5BKj/aZhUpTYCvseSOaUIRkvnS7f8Yxhu7P8XfGM+jUM3Nyd87
   I=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="58901507"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:56:48 +0200
Date: Fri, 16 Jun 2023 11:56:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel@sipsolutions.net>
Message-ID: <6b3be36a-6b1d-3e5f-ade7-443dcd6f0de@inria.fr>
References: <a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>  <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr> <80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] macro parsing issue?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1186
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/6b3be36a-6b1d-3e5f-ade7-443dcd6f0de%40inria.fr>



On Fri, 16 Jun 2023, Johannes Berg wrote:

> On Fri, 2023-06-16 at 11:44 +0200, Julia Lawall wrote:
> > > @@
> > > identifier test.fn;
> > > type test.t;
> > > expression pos, exp;
> > > identifier ret;
> > > @@
> > > t fn(...)
> > > {
> > > ...
> > > (
> > > +#if SOMETHING
> > >         ret = strsep(pos, exp);
> > > +#endif
> > > )
> > > ...
> > > }
> >
> > The code parses fine.  The problem is that ... requires that the pattern
> > before and after the ... is not matched in the ... region.  You probably
> > just want all calls to be modified whereever they occur, so you would want
> > <... ...>.
>
> Hm, yes, I think I want <... ...>, I can never remember this properly
> and erroneously tried <+... ...+> and ended up with this ... oops.
>
> Still though, getting verbose output shows it's mismatching some macros?

True, but that just affects the macro definitions, but not your change.
There isn't a BAD or bad in front of any function code.  BAD or bad lines
are not getting processed.

julia

>
> ERROR-RECOV: found sync end of #define, line 37
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 37
> parse error
>  = File "net/mac80211/debugfs_sta.c", line 37, column 1, charpos = 1146
>   around = '',
>   whole content = }
> badcount: 7
> bad: #define STA_READ_D(name, field) STA_READ(name, field, "%d\n")
> bad:
> bad: #define STA_OPS(name)							\
> bad: static const struct file_operations sta_ ##name## _ops = {		\
> bad: 	.read = sta_##name##_read,					\
> bad: 	.open = simple_open,						\
> bad: 	.llseek = generic_file_llseek,					\
> BAD:!!!!! }
> ERROR-RECOV: found sync end of #define, line 45
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 45
> parse error
>  = File "net/mac80211/debugfs_sta.c", line 45, column 1, charpos = 1380
>   around = '',
>   whole content = }
> badcount: 8
> bad: }
> bad:
> bad: #define STA_OPS_RW(name)						\
> bad: static const struct file_operations sta_ ##name## _ops = {		\
> bad: 	.read = sta_##name##_read,					\
> bad: 	.write = sta_##name##_write,					\
> bad: 	.open = simple_open,						\
> bad: 	.llseek = generic_file_llseek,					\
> BAD:!!!!! }
> ERROR-RECOV: found sync end of #define, line 49
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 49
> parse error
>  = File "net/mac80211/debugfs_sta.c", line 49, column 2, charpos = 1466
>   around = 'STA_OPS',
>   whole content = 		STA_OPS(name)
> badcount: 4
> bad: }
> bad:
> bad: #define STA_FILE(name, field, format)					\
> bad: 		STA_READ_##format(name, field)				\
> BAD:!!!!! 		STA_OPS(name)
> ERROR-RECOV: found sync '}' at line 84
> ERROR-RECOV: found sync bis, eating } and ;
> parsing pass2: try again
> (ONCE) CPP-DEFINE: inside function, I treat it as comment
> (ONCE) CPP-UNDEF: inside function, I treat it as comment
> ERROR-RECOV: found sync end of #define, line 447
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 447
> parse error
>  = File "net/mac80211/debugfs_sta.c", line 447, column 1, charpos = 12210
>   around = '',
>   whole content = }
> badcount: 8
> bad: STA_OPS_RW(agg_status);
> bad:
> bad: /* link sta attributes */
> bad: #define LINK_STA_OPS(name)						\
> bad: static const struct file_operations link_sta_ ##name## _ops = {		\
> bad: 	.read = link_sta_##name##_read,					\
> bad: 	.open = simple_open,						\
> bad: 	.llseek = generic_file_llseek,					\
> BAD:!!!!! }
>
>
>
> (though with 1.1.1)
>
> I had interpreted that as it getting confused about the macro layout in
> the file ... sounds like that was wrong!
>
> > You don't actually need two separate rules for what you are showing, but
> > perhaps that is an artifact of the simplification process.
>
> Indeed, the =~ line was much more complex, and I needed two modification
> rules, and didn't want to duplicate the =~ line.
>
> johannes
>
