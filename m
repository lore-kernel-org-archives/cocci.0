Return-Path: <SRS0=tAXx=6P=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC5C4724C
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 13:52:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117EF20836
	for <cocci@archiver.kernel.org>; Fri,  1 May 2020 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="S1y38QHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117EF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 041Dq3RG022552;
	Fri, 1 May 2020 15:52:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A2DE757C;
	Fri,  1 May 2020 15:52:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CB2833DC8
 for <cocci@systeme.lip6.fr>; Fri,  1 May 2020 15:45:29 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 041DjSDV007807
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 1 May 2020 15:45:28 +0200 (CEST)
Received: by mail-wr1-x444.google.com with SMTP id f13so11542134wrm.13
 for <cocci@systeme.lip6.fr>; Fri, 01 May 2020 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9Gw502fe+s/9rBHG1RoJTYQJCKXMfTxD54Y/lYycXbk=;
 b=S1y38QHjsZS3JJfFSjwQGjwi1pwTdhJt/+xnLbJJn1kDZEE9Dwh5i9N1PxcAhruErQ
 wnX2WXxqnDJEMUYP2iVk/EBCBSOOXleCsO+MVRIJGdk5CvOCv4GdyIo0RlsnkY8gD+Cq
 j4wLxvVzIdQa3CH3ZVa/kfuo/KTXAiy3O9LSUy0mIUeygLpzzQeglra6JWr0lS38RmWT
 Q8gfDAU821GTpjoDNJVVsXqcb6fZPdoqGiuCCFVrH5qD/YZsF/DcKU7sdqZtDeUwwT71
 U/tsumLyMWvkcjb4NdNFLN1vG7ZLVT7A0kptvkmk7eYG7aVp+KDB7J6c9ihaRAkjay4y
 HXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9Gw502fe+s/9rBHG1RoJTYQJCKXMfTxD54Y/lYycXbk=;
 b=fWCS/WB2nuyPx6g1SHnmQBMN2VSmrdKFkjMG2D3aX5UJ6puKY8Dqt2HjrVcvjwpV1k
 t7+9DulfjnbhmkUEzw4Ull42K1ogO1Ir/fd7HYU59ANsWEQzBsNik4oN8yRinzr4D/92
 bl8wzW2lcfeSuO4+Lo4YQJQNkbLpCfhqsNSRGigNeeGPq0C+19mFL3SZXhPMbbQLCXil
 +3iIcbb7SLHVtiwP73Gyiu3DTqoxnfWO6E5gZaRM8JbZs06xcoHZXV5ng8xWv/Z4ktZl
 d1CYgUcdNKPJ00M6A5eUMecB3tdG4Rv9J5aTp/m7jY5BJ3/RqKouvupAXzFnQJ+yWb54
 Ys4g==
X-Gm-Message-State: AGi0PuZPUDAZKBxnF8u68zurQlGCWU4mMnEnFB1OuUr+olg4aG5xTxMt
 HohjJYjVgumwZLBcIQZ0QJxx
X-Google-Smtp-Source: APiQypL8q4aSyyLL59B+r4p1VzBuZBmdmd5sgIEa08wFFENrguYS6XVgAHtJ2hDPqq/upWLPRwmdVg==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr4390169wrl.308.1588340728631; 
 Fri, 01 May 2020 06:45:28 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id n6sm4861692wrs.81.2020.05.01.06.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 06:45:28 -0700 (PDT)
Date: Fri, 1 May 2020 15:45:27 +0200
From: Paul Chaignon <paul@cilium.io>
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Message-ID: <20200501134526.GA6030@Mem>
References: <20200428101124.GA18321@Mem>
 <alpine.DEB.2.21.2004281943320.3273@hadrien>
 <20200428181746.GA8848@Mem>
 <1153360396de8df1736cf050819099a71e7a1f90.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1153360396de8df1736cf050819099a71e7a1f90.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 May 2020 15:52:03 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 01 May 2020 15:45:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 01 May 2020 15:52:02 +0200
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

On Thu, Apr 30, 2020 at 09:10:17PM +0530, Jaskaran Singh wrote:
> On Tue, 2020-04-28 at 20:17 +0200, Paul Chaignon wrote:
> > Thanks for the quick answer!
> > 
> > On Tue, Apr 28, 2020 at 07:44:15PM +0200, Julia Lawall wrote:
> > > 
> > > On Tue, 28 Apr 2020, Paul Chaignon wrote:

[...]

> > Unfortunately, my semantic patch now leads to the following changes:
> > 
> >   -	struct icmphdr icmphdr __align_stack_8;
> >   +	struct icmphdr icmphdr __align_stack_8 __align_stack_8;
> > 
> 
> Hi Paul,
> 
> Just FYI if you want to avoid the double attribute problem there,
> disable the optional_attributes isomorphism for the rule where you add
> the __align_stack_8 attribute. Example:
> 
> @disable optional_attributes@
> attribute name __align_stack_8;
> @@
> 
>  int foo
> +	__align_stack_8
> 	= 2;
> 
> With this, any attributes that you don't specify in your SmPL won't be
> matched in source code either.

That works great! Thanks a lot!

[...]

Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
