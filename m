Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4B3C433F5
	for <cocci@archiver.kernel.org>; Mon,  9 May 2022 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=DknOXq3iSTbWrP5qSCBzwxYR1F8pg7eJu2ZepuIwHVY=;
  b=rxkFI+fPvebJcU9CM6bUjswaXVaW8D2BhnfzC5mTRHw+imScnfzblAOo
   p7o9Q02fmQTbVauTa1f+AsgtUE/PxfLThV3IaprKSKBFPvFHj4v4M+WwO
   UtOJvXoYI+3hvNmVwl6bz7nvCV4suWm31oVsTBGdB0iA1ZF33Ee/aGgjy
   8=;
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
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35345247"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2022 13:49:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7DA5EE010F; Mon,  9 May 2022 13:49:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DF347E009B
	for <cocci@sympa.inria.fr>; Mon,  9 May 2022 13:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DknOXq3iSTbWrP5qSCBzwxYR1F8pg7eJu2ZepuIwHVY=;
  b=LeAOXb6stB0+I6j0m5fA4SLJpANSAtROii/ZgjwRfWX54L30T9tUy7OF
   F6w8tZDftOe4Mi7AMYHmxyNSbKpKpkaZHXJJNVAvmkrqgz2qppCiAgJtV
   JfnvZDau2GmkdBSWbpzHQpV+MUPsPbviFZRia5Deuvtlas4kjI8LEjjRm
   0=;
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="35345233"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:49:26 +0200
Date: Mon, 9 May 2022 13:49:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205091344430.2394@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.22.394.2205091344481.2394@hadrien>
Subject: Re: [cocci] Fwd: List global variables.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 369
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205091344430.2394%40hadrien>



On Mon, 9 May 2022, Alessandro Carminati wrote:

> Hello Julia,
> The solution you sent indeed does what I expected.
> Although I needed a solution for this specific case, and yours fit my needs
> perfectly, I'd love it if you wanted to explain it to me.
> Would you mind add a short explanation of this statement:
> `position p : script:python(i) { p[0].current_element == i};`
> I probably have a simplified understanding of what a position is. Maybe it
> is worth digging deeper and having a more concrete knowledge. Any read you
> want to suggest to me?

Position variable have a collection of information about the position,
including the name of the containing object.  So if the name of the
containing object is the same as the name of the declared variable, then I
consider that the variable is a global variable.  If the name of the
containing object is different, then the declaration is inside a function
definition.

I think that if you have done make install for Coccinelle, then you should
be able to do man Coccilib and then find out about the fields for position
variable.  You may also be able to use reflection in python to get a list
of the field names.

julia
