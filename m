Return-Path: <SRS0=cEHO=6O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D38C47247
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 15:40:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA27620661
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzhrxPsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03UFeRWQ027761;
	Thu, 30 Apr 2020 17:40:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B66C7816;
	Thu, 30 Apr 2020 17:40:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 794757769
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 17:40:25 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1036])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03UFeNnS027530
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 17:40:24 +0200 (CEST)
Received: by mail-pj1-x1036.google.com with SMTP id t40so852277pjb.3
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=amEITohKjbSbG66IcMAJT/g8wyE8M8m2Yhcn4IXquEw=;
 b=JzhrxPsIZ7EkhQLOEpoALtylyJbn0ECHV45kUBQGgq8Zz/8yp8wc2iwKObLzAdBBl9
 UV7l58d3uCASB8/mD+hFUGxAp8ZF71gNT/+X7dMR8M2TNU+w9T8lAm216mFSk7LkCtZd
 VE3fLv8k14Z0pQkSGgII7LMf97tUa5H7Hv3/ZsvwBZ9TOX+rI5spVnviWf3zvtn/dEuK
 XMx+agbYoZ+vkankpxPUT9Z5mV0lSqEY0FgneCDa4Pg/zu3cUVHbwYDC8fLCoPZwzcxe
 URaYiGAu52OVt7pdY1/idvjyu4J4FjKpoPGamPXPUQ9BBnhzRYeAKmCuHOdMVN+RN5c5
 WeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=amEITohKjbSbG66IcMAJT/g8wyE8M8m2Yhcn4IXquEw=;
 b=aDn7Fp3qFHz0MDHZvbhobGXKsdtFkKZRpSLGno1tuU/GyzWF/5G6jsqUoiLdPU5TX9
 ZKtE98WyRquQqmzIAE0gn8zu1FVTEXn77DlTJSfxAcf69FAVdFdOv48LX/+mg04gLXBF
 hc3RHVVe8A+6zc/t9KYJcpi8aGBzsDJVPnBl1vU8K6xUcUEisuEsQH+ty4PnMQ/HgwLZ
 AOo9QSQ+fZLmHEFy0yhTkmN27QKruY1pT83YBrHd1jr83cwG77RRC3d067JyYSoKwAoK
 lDZUcqAajfSN57dnbSIxjagq3KmmIMiWTqE8IzbK0rgMpMXbCV0Gf4Ce6Al1+p3dfGAA
 a2Vg==
X-Gm-Message-State: AGi0Pua/ztwsHc0+bOZIhET6Q+B5dB+wkopJgM8A+y4/b/7DQ1V1Otlt
 M++vcsCSElkMYtubzGKn00k=
X-Google-Smtp-Source: APiQypJNrKWUOzM0S+P4im0iAqU+V0K9bB7LgShyRwq1S5Q3JHsCBFnfpFmkwaHb/GdWbB8V8d9qGg==
X-Received: by 2002:a17:90a:3268:: with SMTP id
 k95mr3511962pjb.185.1588261222857; 
 Thu, 30 Apr 2020 08:40:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:67d:d5aa:2f71:af45:32fc:c98a])
 by smtp.gmail.com with ESMTPSA id t3sm169751pfq.110.2020.04.30.08.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 08:40:22 -0700 (PDT)
Message-ID: <1153360396de8df1736cf050819099a71e7a1f90.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Paul Chaignon <paul@cilium.io>, Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 30 Apr 2020 21:10:17 +0530
In-Reply-To: <20200428181746.GA8848@Mem>
References: <20200428101124.GA18321@Mem>
 <alpine.DEB.2.21.2004281943320.3273@hadrien> <20200428181746.GA8848@Mem>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 30 Apr 2020 17:40:27 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 30 Apr 2020 17:40:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
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

On Tue, 2020-04-28 at 20:17 +0200, Paul Chaignon wrote:
> Thanks for the quick answer!
> 
> On Tue, Apr 28, 2020 at 07:44:15PM +0200, Julia Lawall wrote:
> > 
> > On Tue, 28 Apr 2020, Paul Chaignon wrote:
> > 
> > > Hi all,
> > > 
> > > I am working on a small semantic patch to annotate specific
> > > variables in
> > > our codebase with __attribute__((aligned(8))). The following
> > > program works
> > > fine.
> > > 
> > >   @r@
> > >   expression e1, e2;
> > >   identifier x;
> > >   @@
> > >   (
> > >     struct \(icmphdr\|icmp6hdr\) x
> > >   + __attribute__((aligned(8)))
> > >     ;
> > >   |
> > >     struct \(icmphdr\|icmp6hdr\) x
> > >   + __attribute__((aligned(8)))
> > >     = ...;
> > >   )
> > >     ... when exists
> > >     ctx_load_bytes(e1, e2, &x, ...)
> > > 
> > > However, when I replace __attribute__((aligned(8))) with our
> > > internal
> > > macro __align_stack_8, it fails with the following error:
> > > 
> > >   plus: parse error:
> > >     File "/home/paul/cilium/contrib/coccinelle/aligned.cocci",
> > > line 7, column 2, charpos = 77
> > >     around = '__align_stack_8',
> > >     whole content = + __align_stack_8
> > > 
> > > I've tried adding '#define __align_stack_8' in a file passed with
> > > --macro-file, without success. Is this a known limitation for
> > > macros or
> > > am I missing something?
> > 
> > Try adding the "metavariable" declaration:
> > 
> > attribute name __align_stack_8;
> 
> Awesome, that worked. And I think I understand: undeclared
> identifiers are by
> default considered symbols, leading to the parse error.
> 
> Unfortunately, my semantic patch now leads to the following changes:
> 
>   -	struct icmphdr icmphdr __align_stack_8;
>   +	struct icmphdr icmphdr __align_stack_8 __align_stack_8;
> 

Hi Paul,

Just FYI if you want to avoid the double attribute problem there,
disable the optional_attributes isomorphism for the rule where you add
the __align_stack_8 attribute. Example:

@disable optional_attributes@
attribute name __align_stack_8;
@@

 int foo
+	__align_stack_8
	= 2;

With this, any attributes that you don't specify in your SmPL won't be
matched in source code either.

> I would normally add a first case to my conjunction to match on
> already-present attributes, but Coccinelle can't match on attributes
> yet.

Granted, attribute matching on Coccinelle's master branch is far from
perfect, but I think it should work for declarations/assignments.
Hopefully I can get these patches out soon :)

Cheers,
Jaskaran.

> Any workaround?
> 
> Paul
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
