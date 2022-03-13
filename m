Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD46C433EF
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=j2YVZ/i5ftSsJdrfQXUGKJTj8ZrWbwKbdxHFYksHXhM=;
  b=AbwAHIlAtpdEjhkfCZtw8OgqtYv/MgzUc+DCmd1YltJh1Dhg0CD80ff7
   4yRAS6bPPvR59JTiPHGPP1z5b9zC18r6HgY7gRkncm45gaInu5v0DP9Cm
   YcT5lg0uMe7Tn6HlWLqu4iz1mKIYzd1Hd+4Hv/abajMf9hY4FbnPr1lGB
   4=;
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25836978"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 08:05:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83F44E004A; Sun, 13 Mar 2022 08:05:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C3B4FE0048
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 08:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j2YVZ/i5ftSsJdrfQXUGKJTj8ZrWbwKbdxHFYksHXhM=;
  b=ZhZA1MZAfg/211dqxC5qqY9L0FJ6ul2Hh/J4gQxNJvZ5G8IUt8bWP460
   a4Sd4Z04Gp01wfxjMYHPw90D2nVXrgioWcfn9wUO3ep6HKNchz+M+CsnF
   PYIJNreRxUqTs17cdrLoe428nLWbkT2hM5bfReQO4WNHtK2+Z56KbN3/d
   U=;
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="8384183"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:05:49 +0100
Date: Sun, 13 Mar 2022 08:05:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203130805150.18925@hadrien>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can Coccinell concatinate or append to existing string
 literals?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 213
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203130805150.18925%40hadrien>



On Sat, 12 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I would like to do something like this:
>
> 	@ a @
> 	constant C;
> 	constant CN ## "_bar";
> 	@@
> 	-foo(C);
> 	+foo(CN);
>
> to produce this:
>
> 	void f()
> 	{
> 	-	foo("foo");
> 	+	foo("foo_bar");
> 	}
>
> It looks like `fresh identifier` can do something like this, but I can't
> get it to work with strings.  Is there a way?

Please take a look at demos/pythontococci.cocci
By using python scripting, you can do whatever you want.

julia
