Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45229C35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 08:09:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86A020656
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdHdnhew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86A020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01989BSd003317;
	Sun, 9 Feb 2020 09:09:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2E04772F;
	Sun,  9 Feb 2020 09:09:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E3A177718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 09:09:09 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 019898CJ008143
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 09:09:09 +0100 (CET)
Received: by mail-pj1-x1043.google.com with SMTP id dw13so2806916pjb.4
 for <cocci@systeme.lip6.fr>; Sun, 09 Feb 2020 00:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=XjnYSbo/KE3goqFdXH4TdQryBvxwMnkJjPuwH8uI2Ew=;
 b=bdHdnhewogxh6NNyDo8lpkJHD08rhckEKQPhbcmSc2s5s75VnvvV3Oa/dlR5KJzOnZ
 l52CIuCKac+PWI86UUTjiK7oSQJJqKq3IYKYF6tyANzPvS7dA2PNOcOI86i5160tuXPP
 YA3XgC4J/KbCWmgxVsBgzDmjQkchXhNt5fcbrnvFNMSsi5yN9T0V69r9Bnj1HV1r3M6f
 zXuvWi+ZwFIxGmKCztU67FETMO2Tqc//uxMC3Mq7RVJ7VCF6aUlJaJTP2dMZR3LLv03f
 PxGGiLhiWiKaGJPOhMc695VGhjrp8BDIy+y1grN/9BdCKSr/WWEE6OsDVlUzDEH1vAKp
 f6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=XjnYSbo/KE3goqFdXH4TdQryBvxwMnkJjPuwH8uI2Ew=;
 b=PItw+/kj+XMgwwA3gpOQXfJGEmj4Pw+Ne6VaewVIFPwd0tlehKmSYqNNlR0pcS8wJT
 jA5Ocw0P330Fy5HPpwhF8PX6UxEDu9HAfsEA1oeDTDklEtjieQXYAHnOZx3Q4AL4ZbbQ
 3kL+e7WvuaGxplriNujR/0BLSuPFPtabLrl7yC1kTyWBItjXllidSTeljsYZld2BHzp1
 jqL4KXK7Gdgjo7/Oc5uAf48vQ8DaBBGStIso0j2VW830VfDwDYfnsv2d6zC8Ep+yZiuP
 wpqty1r+ikzhJxZFIdVNI36sIkWX78GNc8nRASE6RnXyYDNQO7Pemvg0cfwteVsxxXjx
 RLYw==
X-Gm-Message-State: APjAAAWSvSi/rPh+D+IdHaYFqoYcNDbwRMCsITKNlFCEFU5BELdShXbI
 P7dWgD8aZmobmkO6r57FUy0=
X-Google-Smtp-Source: APXvYqzUe2c2BqN8NpjiFZo3i8DVNiVsjCVgznvPozyHWWYbbdp6Ylh0QxoWjh9nxi/Za3IDkQ4OUw==
X-Received: by 2002:a17:902:aa0b:: with SMTP id
 be11mr6956587plb.181.1581235747592; 
 Sun, 09 Feb 2020 00:09:07 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166e:dca2:8d98:ad42:3c3b:8544])
 by smtp.gmail.com with ESMTPSA id a13sm8694280pfg.65.2020.02.09.00.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2020 00:09:07 -0800 (PST)
Message-ID: <9d3417cda37f48a88c510f6cc6a0cd26e01914dd.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 09 Feb 2020 13:39:03 +0530
In-Reply-To: <alpine.DEB.2.21.2002090906090.3430@hadrien>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-3-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2002090817580.3430@hadrien>
 <c97f4e5641f8c68e35ae6f0e00940762c84dc2ac.camel@gmail.com>
 <alpine.DEB.2.21.2002090906090.3430@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 09:09:12 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 09:09:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2 2/2] tests: Add test case to match const
 pointer variants
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

On Sun, 2020-02-09 at 09:07 +0100, Julia Lawall wrote:
> On Sun, 9 Feb 2020, Jaskaran Singh wrote:
> 
> > On Sun, 2020-02-09 at 08:20 +0100, Julia Lawall wrote:
> > > On Fri, 7 Feb 2020, Jaskaran Singh wrote:
> > > 
> > > > Pointer to const pointer and its variants would not match
> > > > previously.
> > > > Add a test case for matching these types.
> > > 
> > > I don't get any matches for this test.  If I split the semantic
> > > patch
> > > into
> > > four separate rules, then I get the change for id2 and id4, but
> > > not
> > > for
> > > the other two.
> > > 
> > 
> > That's weird, it works fine for me. I get this on both bytecode and
> > native builds.
> 
> OK, you're right, it's OK.
> 
> Can you fix the *const problem?  I still see that one.
> 

Sure, will send v3.

Cheers,
Jaskaran.

> thanks,
> julia
> 
> > --- tests/constptr.c
> > +++ /tmp/cocci-output-31326-084eed-constptr.c
> > @@ -1,7 +1,7 @@
> >  int main()
> >  {
> > -	const char * const * id;
> > -	const char * * const * id;
> > -	const char * const * * id;
> > -	const char * const id;
> > +	const char * const * id1;
> > +	const char * * const * id2;
> > +	const char * const * * id3;
> > +	const char * const id4;
> >  }
> > 
> > 
> > On the other hand, I get the id2 and id4 result with upstream.
> > 
> > --- tests/constptr.c
> > +++ /tmp/cocci-output-5387-a9b63b-constptr.c
> > @@ -1,7 +1,7 @@
> >  int main()
> >  {
> >  	const char * const * id;
> > -	const char * * const * id;
> > +	const char * * const * id2;
> >  	const char * const * * id;
> > -	const char * const id;
> > +	const char * const id4;
> >  }
> > 
> > Could you check if you've applied 1/2 first?
> > 
> > Cheers,
> > Jaskaran.
> > 
> > > julia
> > > 
> > > > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > > > ---
> > > >  tests/constptr.c     |  7 +++++++
> > > >  tests/constptr.cocci | 19 +++++++++++++++++++
> > > >  tests/constptr.res   |  7 +++++++
> > > >  3 files changed, 33 insertions(+)
> > > >  create mode 100644 tests/constptr.c
> > > >  create mode 100644 tests/constptr.cocci
> > > >  create mode 100644 tests/constptr.res
> > > > 
> > > > diff --git a/tests/constptr.c b/tests/constptr.c
> > > > new file mode 100644
> > > > index 00000000..13fe064c
> > > > --- /dev/null
> > > > +++ b/tests/constptr.c
> > > > @@ -0,0 +1,7 @@
> > > > +int main()
> > > > +{
> > > > +	const char * const * id;
> > > > +	const char * * const * id;
> > > > +	const char * const * * id;
> > > > +	const char * const id;
> > > > +}
> > > > diff --git a/tests/constptr.cocci b/tests/constptr.cocci
> > > > new file mode 100644
> > > > index 00000000..29f0aa96
> > > > --- /dev/null
> > > > +++ b/tests/constptr.cocci
> > > > @@ -0,0 +1,19 @@
> > > > +@ r0 @
> > > > +identifier id;
> > > > +@@
> > > > +const char * const *
> > > > +- id
> > > > ++ id1
> > > > +;
> > > > +const char * * const *
> > > > +- id
> > > > ++ id2
> > > > +;
> > > > +const char * const * *
> > > > +- id
> > > > ++ id3
> > > > +;
> > > > +const char * const
> > > > +- id
> > > > ++ id4
> > > > +;
> > > > diff --git a/tests/constptr.res b/tests/constptr.res
> > > > new file mode 100644
> > > > index 00000000..0af4de9a
> > > > --- /dev/null
> > > > +++ b/tests/constptr.res
> > > > @@ -0,0 +1,7 @@
> > > > +int main()
> > > > +{
> > > > +	const char * const * id1;
> > > > +	const char * * const * id2;
> > > > +	const char * const * * id3;
> > > > +	const char * const id4;
> > > > +}
> > > > --
> > > > 2.21.1
> > > > 
> > > > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
