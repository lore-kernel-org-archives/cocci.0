Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC35C282D1
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w7MTCX4AVT3c2wAv14z25ZizCjdw3VNpyif5iMRokMI=;
  b=tpmRAM32Tm/oNtrqzq4JSpy2REOqoYdHZ9gZCE/xACyygkq6fSojwske
   lcBFOWMsf0xAcLqj57v9eWI9MKLvyqqfiMvnN9CQOhIwgIqiyJVQEOmgT
   YRDm9VD1ov/j8KCqjvyybxkvBrBo7olEfWAoPnbElSAED2Fc1iaZoSgs4
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,227,1736809200"; 
   d="scan'208";a="211663314"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 01:55:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 466A6E0D1E; Fri,  7 Mar 2025 01:55:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D2175E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Mar 2025 01:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w7MTCX4AVT3c2wAv14z25ZizCjdw3VNpyif5iMRokMI=;
  b=rhMBOMxDZQw8koIfWMJ8pqCuEJ8Fvv/1rUK2suLLcZqa60eL2yTfsGQv
   LeKxNYZp9Bal8KOSfA52XniYgUDoXaRxqzax3nbpwxj2ZMsf1DB9wx6mL
   NoW1OKs5Bd6/et2zBS1naeS3Yp6NbeGHo9K9QdFO9I3M3qXJYm2CaXjQ3
   U=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736809200"; 
   d="scan'208";a="110910481"
Received: from unknown (HELO hadrien.lan) ([172.59.112.6])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:55:31 +0100
Date: Thu, 6 Mar 2025 19:55:30 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jacob Keller <jacob.e.keller@intel.com>
cc: cocci@inria.fr, Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
Message-ID: <d31415e8-8ab7-cac-2ba6-3ba26bb2331@inria.fr>
References: <67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] behavior change in semantic patches since c36b51ffc889
 ("don't drop down on single statement")
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2569
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d31415e8-8ab7-cac-2ba6-3ba26bb2331%40inria.fr>



On Thu, 6 Mar 2025, Jacob Keller wrote:

> Hi Julia,
>
> We use semantic patches for code cleanup regularly, and recently noticed
> a change in behavior some some semantic patches that are run as part of
> a build process. I've provided the patch and an explanation of my
> discoveries thus far. Hopefully help track down whats wrong and whether
> we need to update these patches, there is some other workaround we can
> do, or there is actually a bug in coccinelle/spatch.

Thanks for the report, and espcially for the bisect.  I don't think it
would be good to just revert the commit, since it is solving a real
problem.  I will see how to get your cases working properly.

>
> I have the following semantic patch:
>
> > @@
> > void * void_ptr;
> > type T;
> > T * typed_ptr;
> > @@
> > - typed_ptr = (T *)void_ptr
> > + typed_ptr = void_ptr
>
> Its goal is to find and remove unnecessary type casts where a cast is on
> a void pointer that to another type.
>
> This is used for our build process as we have some code that is shared
> between C and C++. The C++ compiler requires the casts to avoid issues,
> but C warns about them.
>
> With spatch 1.2.0, this patch works and finds and removes casts.
>
> However, I updated to the master branch of the coccinelle project and
> noticed that it no longer finds all of the casts. In particular, it
> looks like casts which are part of type declarations don't always get
> reliably caught.
>
> I also noticed a behavior change in another patch:
>
> > @@
> > expression hw, ptr;
> > @@
> > (
> > - ice_free(hw, ptr);
> > + devm_kfree(ice_hw_to_dev(hw),ptr);
> > )

This doesn't need the starting and ending ()
This is just a comemnt, it won't solve the problem.

julia


> This patch updates some code that used an internal wrapper function to
> use the appropriate kernel function directly.
>
> Since switching and testing on the master branch which looks like its
> the 1.3.0 release, this now transforms code like this:
>
> if (something)
>   ice_free(...)
>
> into
>
> if (something) {
>   devm_kfree(...)
> }
>
> When the function is inside a block like this, it is transformed to
> include braces. This often violates our style guide as braces around
> single line if or other scopes are not desired.
>
> These changes break our ability to deploy the new version of coccinelle.
>
> I ran a git bisect to determine when these changes broke, and both
> changes appear to occur due to the following change:
>
> c36b51ffc889 ("don't drop down on single statement")
>
> I do not know why this commit causes such a behavior change, and am
> reaching out for guidance and hope that a suitable workaround can be found.
>
> I was able to partially work around the issue with the type cast:
>
> I was using spatch --parse-cocci and saw some warnings about the patch
> file, and refactored it to:
>
> @disable drop_cast@
> void * void_ptr;
> type T;
> T * typed_ptr;
> @@
>  typed_ptr =
> -(T *)
>  void_ptr
>
>
> This fixed so that the patch does find all the typecasts, but has often
> left us with undesirable white spacing, for example of there is code
> like this:
>
> struct something *a =
> 	(struct something *)data
>
>
> Then before it translates to:
>
> struct something *a = data
>
> but now it translates to
>
> struct something *a =
> 	data
>
> The ability to automatically condense the lines was very nice, and
> losing that is a bit annoying.
>
> From the commit description, I doubt you can simply reverse this change.
> I was hoping your expertise with semantic patches could help us identify
> modified versions of the patches which will reliably work for us in both
> the function transformation and cast removal patches.
>
> Thanks,
> Jake
>
