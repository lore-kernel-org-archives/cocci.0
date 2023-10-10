Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BB5CD8CA9
	for <cocci@archiver.kernel.org>; Tue, 10 Oct 2023 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9FJwAU28iuTv/7nCKDXq9E5+1x1YwYFBxD8benLUCJo=;
  b=iPsKcqjiGZBH3lpFttwD76JVCErvFx2noTCsZTcAiyI0YKMQbk+jIf2x
   GkxH9Z+rcvGbjwkGQnqGiYwQUCoqsckXpGmI75ymzsT97KSwEOVITbkMt
   LFmw6RenLPdalHNvEkJLiMzEu+MSLVTVGHA2yIw+LkgvUGyNcd9+DK8+f
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
X-IronPort-AV: E=Sophos;i="6.03,213,1694728800"; 
   d="scan'208";a="130495430"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Oct 2023 18:11:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38440E0CD6; Tue, 10 Oct 2023 18:11:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F216DE00B7
	for <cocci@sympa.inria.fr>; Tue, 10 Oct 2023 18:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9FJwAU28iuTv/7nCKDXq9E5+1x1YwYFBxD8benLUCJo=;
  b=t3CQTzLmOiWH7ZebcX0dJMdBkY1Ade1HaaJpBfkXTF9ewtNXh0zYeBy/
   QZsrfKH4AJcJkFheWzNzXG6NTe3OR3Wx3ZrdS59FsjrWjvlmk0cL8v1JJ
   VPUot77JI2GuymEWdKhfDQAt5LGmKz5+TFpt4J8faCUzxS0dzFHWesBe0
   4=;
X-IronPort-AV: E=Sophos;i="6.03,213,1694728800"; 
   d="scan'208";a="130495417"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:11:16 +0200
Date: Tue, 10 Oct 2023 18:11:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Anton Eliasson <anton.eliasson@axis.com>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
Message-ID: <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-2-07d2d900a52a@axis.com> <alpine.DEB.2.22.394.2310072140340.36842@hadrien> <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1252
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/b37c26-154a-2db9-4944-26a8aa8af7af%40inria.fr>



On Tue, 10 Oct 2023, Anton Eliasson wrote:

> On 07/10/2023 21.41, Julia Lawall wrote:
> >
> > On Tue, 3 Oct 2023, Anton Eliasson wrote:
> >
> > > This helps automating coccicheck runs by discarding stderr and only
> > > looking at the output of stdout. In report mode the only remaining
> > > output on stdout is the initial "Please check for false positives"
> > > message followed by each spatch warning found.
> > What is getting dropped is the spatch command lines indicating the
> > semantic patch.  Is this desirable?
> >
> > julia
> It's not ideal but it's the best compromise that I have found. The problem I'm
> trying to solve is to be able to diff the output of two coccicheck runs and
> notify the developer if any new warnings were introduced. That requires the
> output to be stable. spatch is always invoked for each cocci file in the same
> order. However, the output from each spatch invocation is not stable as it
> examines each source file in an arbitrary order.
>
> My workaround is to sort the output before diffing. The line-by-line sorted
> output only makes sense if the input is one line per warning found and that is
> why I try to discard all output except the single line per spatch warning.
> While the terse output doesn't tell which semantic patch file generated the
> warning, it does usually contain the offending file, line number and a summary
> of the issue.

Why does the command line pose a problem for sorting?

julia

>
>
> Anton
> >
> > > Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> > > ---
> > >   scripts/coccicheck | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/coccicheck b/scripts/coccicheck
> > > index 95a312730e98..7e7c44125f47 100755
> > > --- a/scripts/coccicheck
> > > +++ b/scripts/coccicheck
> > > @@ -146,8 +146,8 @@ run_cmd_parmap() {
> > >                   echo $@>>$DEBUG_FILE
> > >                   $@ 2>>$DEBUG_FILE
> > >           else
> > > -                echo $@
> > > -                $@ 2>&1
> > > +                echo $@ >&2
> > > +                $@
> > >   	fi
> > >
> > >   	err=$?
> > >
> > > --
> > > 2.30.2
> > >
> > >
>
>
