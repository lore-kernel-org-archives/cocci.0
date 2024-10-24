Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577DFCE8E8A
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=yqcopEmqHoBXD/KybT2sGmEGb2HHbG6ktbFoSSfUBQ4=;
  b=Ew1DCs5CWFsrsbvsXTr4i832QCiAm8x2r/1VFceTqh7PkXgnf8r7B28F
   WJLHieM8aWXGH/wv94uJUIpwM9LEzfh+bD2klPWLzPgE0uAXztLznAeAU
   OWR3O71tqlCh5HL18u4kzoOvHnS1YK9e6Tg07UzO0RGlKwf9dyoDNyckH
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190596736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 17:38:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BF13EE0D1F; Thu, 24 Oct 2024 17:38:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B31F1E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 17:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yqcopEmqHoBXD/KybT2sGmEGb2HHbG6ktbFoSSfUBQ4=;
  b=Uv6v4rfQO/VEXxTMbFp3BQx0PTfuReLTvuSLWUzeNmoBVsP15QhNLhvl
   KvkdkaYS8Xslkeg+nz/h1A2ceRLJ9837irh5FukB7genzlmt36Xk3l+AK
   NX9n67hKdfavwszCOvbMqcbWOFNVhy8uMlMhHOPjdydBdwXTzIrP+lQF+
   8=;
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190596726"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:38:44 +0200
Date: Thu, 24 Oct 2024 17:38:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk> <alpine.DEB.2.22.394.2410241646040.3352@hadrien> <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk> <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1924
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/alpine.DEB.2.22.394.2410241736480.3352%40hadrien>



On Thu, 24 Oct 2024, Derek M Jones wrote:

> Julia,
>
> > > Is there an option that reduces the overhead, or perhaps
> > > an alternative way of writing the pattern?
> >
> > Maybe using when exists on the ....
>
> Would checking an always true condition have the
> desired effect?

... when exists
    when any

might be faster than what you have now.  But it will still b slower than
necessary.


> > But the solution I proposed was created for precisely this problem.
>
> I did not understand your comment about any position variable.
>
> Would changing the current code
> printf(",%s,%s\n", loc_2[0].line, loc_2[0].column)
>
> to use
> p[0].current_element_line
> make a difference?

Not in itself.  In my solution you only need one position variable, which
is the one on the top {

Every position variable contains complete information about the enclosing
object.

julia


>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
>
