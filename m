Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1DAC25B7C
	for <cocci@archiver.kernel.org>; Mon, 27 May 2024 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Q3snwzwmWuoJD/WMzTv7X0Z3Dos/RKpUUf3kUzMbFkI=;
  b=nMHLUGubzY4zZ4d3hf1tJBiODBMgrFpZ4ubHtwgXCai+J1Vy/76nFQY3
   D2znyTBf6hnLGNY4RNIjvLOjFbDjFQdt0qopT4jC0nXAHofiprtZM7Owu
   4g6G4l5r7Tn6AG1BzOZJRuercgFVQ/64qMQDijvTyroc6S/SxELTMgz9v
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,193,1712613600"; 
   d="scan'208";a="167684914"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2024 21:51:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2A28E0CCA; Mon, 27 May 2024 21:51:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C324E00B7
	for <cocci@sympa.inria.fr>; Mon, 27 May 2024 21:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q3snwzwmWuoJD/WMzTv7X0Z3Dos/RKpUUf3kUzMbFkI=;
  b=XxfKlNffEX4U+45+4yhIKbR9JyMVXsFlPoR+7xU84Mj1JrMmRZj055D5
   zqjEDdW4i+yof9sfgJ5nMRHJto0/m2G/ywePMze2HuJpScribZXF9Sdf1
   d8DnTauqHqzF4AzZElh1EueqjVdJ9i1VArmaI9h11aC/bPieICIG5ncgf
   k=;
X-IronPort-AV: E=Sophos;i="6.08,193,1712613600"; 
   d="scan'208";a="167684911"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:51:35 +0200
Date: Mon, 27 May 2024 21:51:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Uladzislau Rezki <urezki@gmail.com>
cc: "Paul E. McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>, 
    cocci@inria.fr
In-Reply-To: <ZlTjIDrnPb25UTUn@pc636>
Message-ID: <alpine.DEB.2.22.394.2405272151000.3330@hadrien>
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz> <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr> <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop> <ZlTjIDrnPb25UTUn@pc636>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1762
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405272151000.3330%40hadrien>



On Mon, 27 May 2024, Uladzislau Rezki wrote:

> On Mon, May 27, 2024 at 12:27:14PM -0700, Paul E. McKenney wrote:
> > On Mon, May 27, 2024 at 10:13:40AM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Mon, 27 May 2024, Vlastimil Babka wrote:
> > >
> > > > Hi,
> > > >
> > > > one bit from LSF/MM discussions is that there might be call_rcu users with a
> > > > callback that only does a kmem_cache_free() to a specific cache. Since SLOB
> > > > was removed, it's always ok to use kfree() and thus also kfree_rcu() on
> > > > allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
> > > > call_rcu() users might be simplified to kfree_rcu(). I found some cases
> > > > semi-manually, but I'd expect coccinelle could help here so if anyone wants
> > > > to take this task, feel free to.
> > >
> > > Thanks for the suggestion!  I will try to look into it.
> >
> > Thank you both!
> >
> I wanted to take an action on it but Julia was first. So, please go ahead :)

If you want to try, please go ahead.  We can compare results.

julia
