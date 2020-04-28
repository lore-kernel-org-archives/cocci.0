Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE6C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 18:36:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2A3208E0
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="QqYA72Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2A3208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SIaQRH008849;
	Tue, 28 Apr 2020 20:36:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C28487807;
	Tue, 28 Apr 2020 20:36:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AA0FF3DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:17:49 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SIHmGJ019861
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:17:49 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id t14so25796576wrw.12
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TQJ1/xf+QKWzmZy6Ybmlh+DfZ6nYnG8cJLu5tyHWklM=;
 b=QqYA72Lt0u9iOogyL4tE8OEPt/hcBirl7fh4SjrItbdWaYRXHNHuBXYE9P117r5IR4
 Ko8OxasxmHafWPBgbUNPliIAXgFouXkIPTUz9BL2yP++0UWwH1WmqPAkXHWm+pAOJtm6
 rBeqBryc/TGyOpbLqkgwPubPuopvP33RoMDnCSLMLil46F5M2aBNbW1RpL72b/c8+No7
 cIznSc66kK0YC7BmWvENDVx15GX+kxLAqPls3J9hSYzfHAED/3CIpUt1+XCFPW+8Ncu8
 Qm/Linb+vvqRvfBqgiQtMFTlljMASO9PME+4L1XNAlqOYTepEEKgHyOCODFGICg/4MMJ
 drHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TQJ1/xf+QKWzmZy6Ybmlh+DfZ6nYnG8cJLu5tyHWklM=;
 b=LNWOWy8r4n3dcsYX2wnBuAgFe5+VA8sVXSQKkHJOw2yquIQYeoVnsyCuynbv1CUYV/
 Y+F3zdgyIch6+kp7Vhucak7hd3zA39+v36/sXPZ0WAK2eWcwC2k6MXDBtkYIOy3N1W5U
 fXIByiCLjcFFPYMadskay756OHTbgsUP24NRUk8rqtILVXCGkjaniv2AL++LS+6Hyc3e
 ImkhopP76OgtT79xe98k01FVg9Qz8tn5l3yTKCp/M2I6ClCLPqJT7ofnwIqYKGivxjuJ
 OzgwWVZ9nWe8qotmrV0bgPza7Q9zKdBwSw3/IA2uGywh0xsOmEtmTa2WZn1mZmf2vVX6
 JZSg==
X-Gm-Message-State: AGi0PuaxVHYTNS12Ifc6UXzRN/Ibpx2+hZylTn8OnHMNrJ33jQUshcrW
 kGvSrXeWvtY+iW2otNh3VtJK
X-Google-Smtp-Source: APiQypLWz1EYIXTFq4kLjMtcstmJBXeJw3ET6iRnSfm2tIMWTXoF0GNVGgm5tMtZzc68Pu1Xq+eR7A==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr34659564wrw.228.1588097868676; 
 Tue, 28 Apr 2020 11:17:48 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id c25sm4095938wmb.44.2020.04.28.11.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 11:17:48 -0700 (PDT)
Date: Tue, 28 Apr 2020 20:17:47 +0200
From: Paul Chaignon <paul@cilium.io>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200428181746.GA8848@Mem>
References: <20200428101124.GA18321@Mem>
 <alpine.DEB.2.21.2004281943320.3273@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004281943320.3273@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 20:36:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 20:17:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 28 Apr 2020 20:36:25 +0200
Cc: cocci@systeme.lip6.fr, paul.chaignon@gmail.com
Subject: Re: [Cocci] Using a macro for variable attributes
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Thanks for the quick answer!

On Tue, Apr 28, 2020 at 07:44:15PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 28 Apr 2020, Paul Chaignon wrote:
> 
> > Hi all,
> >
> > I am working on a small semantic patch to annotate specific variables in
> > our codebase with __attribute__((aligned(8))). The following program works
> > fine.
> >
> >   @r@
> >   expression e1, e2;
> >   identifier x;
> >   @@
> >   (
> >     struct \(icmphdr\|icmp6hdr\) x
> >   + __attribute__((aligned(8)))
> >     ;
> >   |
> >     struct \(icmphdr\|icmp6hdr\) x
> >   + __attribute__((aligned(8)))
> >     = ...;
> >   )
> >     ... when exists
> >     ctx_load_bytes(e1, e2, &x, ...)
> >
> > However, when I replace __attribute__((aligned(8))) with our internal
> > macro __align_stack_8, it fails with the following error:
> >
> >   plus: parse error:
> >     File "/home/paul/cilium/contrib/coccinelle/aligned.cocci", line 7, column 2, charpos = 77
> >     around = '__align_stack_8',
> >     whole content = + __align_stack_8
> >
> > I've tried adding '#define __align_stack_8' in a file passed with
> > --macro-file, without success. Is this a known limitation for macros or
> > am I missing something?
> 
> Try adding the "metavariable" declaration:
> 
> attribute name __align_stack_8;

Awesome, that worked. And I think I understand: undeclared identifiers are by
default considered symbols, leading to the parse error.

Unfortunately, my semantic patch now leads to the following changes:

  -	struct icmphdr icmphdr __align_stack_8;
  +	struct icmphdr icmphdr __align_stack_8 __align_stack_8;

I would normally add a first case to my conjunction to match on
already-present attributes, but Coccinelle can't match on attributes yet.
Any workaround?

Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
