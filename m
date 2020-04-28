Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17804C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 12:44:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657D3206F0
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaPoyij6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657D3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SChmGk020857;
	Tue, 28 Apr 2020 14:43:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 824137807;
	Tue, 28 Apr 2020 14:43:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B7283DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 14:43:46 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SChisY016794
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 14:43:45 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id y25so10631890pfn.5
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=gBw3cYXB1JrScHWOou+H7b6Q+VxWVe4/1UMFoF1kxow=;
 b=FaPoyij6X6iGa1zkiaXI/2nSQXol/oboQc6mhyhNPE27EoK9HRllPGKuNqZNx8/2R+
 zXbi4/jKWEi4hxpYVcqDgs3/W+zFaYToCTQXJb6ZyZe4MwCW5WTHQiXFYlCCoDaDw69h
 Kq9EZ+xgC5miVgH8ne2UlN1E0zXIpP6kJtsga5YNAOs61LPS6AT+yl1cI0o3sC37rweD
 rJPZ0K5FCjcG08pufWTICvl58ra8bo5XojZ+GazGZchkLxFs4bQEBGD4yMBg/ih2fCim
 6Cbs92dQahfr7pgoEMU/zNEBU0EonftSHjJZ3JfP0tgtHs6LrBbAN0clNawVQDPsuAAf
 Ko8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=gBw3cYXB1JrScHWOou+H7b6Q+VxWVe4/1UMFoF1kxow=;
 b=KjI/cbobRC9kYuzK0OaSmc2qDrmyUCT4O0FJGSL07rf8+FNkUy8SM4gtpc1cvJSSUY
 9HXOzcHTovw+p6Uj8t3OdUMkVoA+8bBeUOuIV785OBB5srYRfd4ZhEH9igHc8S5hDAQD
 oki/udbVEw+2tfKfFr6pfk8DRQrQ/mu+BJpN5+51sIX0ZSUcvDlLYiGG/Wtnkf30P6Qm
 sjvJsGrSVZjmql6oo50lJrcUO9dGKLBtLC+sZqqjJTBFWVa2+msibpeVkfuNmgl8aOos
 luDe3kYENYjA/yBeQB7SfZ/iQPyOteq3jP8aBAq1JsiEXgFMOWxA5XISA6Nk8XluMrCi
 ew9A==
X-Gm-Message-State: AGi0Pub/en5ghJkJJOs0dZnp5HY1tmEDMpdrVrUaX1GSDzVHr9y+1uy+
 v3S3ZfCD2cpJuXWFhOxr3fY=
X-Google-Smtp-Source: APiQypLhV/8SSvecEP/GhNHbUZCHYDyPBtVy80wyIS+4VE5m7GZtwj/36nkXFHvU4YkBECtnmpr/zA==
X-Received: by 2002:a63:2a92:: with SMTP id q140mr6815461pgq.20.1588077824087; 
 Tue, 28 Apr 2020 05:43:44 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id p62sm14824780pfb.93.2020.04.28.05.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 05:43:43 -0700 (PDT)
Message-ID: <60aa6040df72a8ada9107e9e36673e82bf673bcd.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 28 Apr 2020 18:13:39 +0530
In-Reply-To: <alpine.DEB.2.21.2004271931170.12657@hadrien>
References: <20200427120834.380-1-jaskaransingh7654321@gmail.com>
 <20200427120834.380-23-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2004271931170.12657@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 14:43:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 14:43:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 22/23] tests: Add test case for removing
 parameter attributes
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

On Mon, 2020-04-27 at 19:31 +0200, Julia Lawall wrote:
> 
> On Mon, 27 Apr 2020, Jaskaran Singh wrote:
> 
> > Add a test case for removing Parameter attributes. The test case
> > checks
> > correct removal of the attribute when it is:
> > 
> > - before the parameter type.
> > - after the parameter type and before the parameter identifier.
> > - after the parameter identifier.
> > 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  tests/remove_param_attrs.c     | 11 +++++++++++
> >  tests/remove_param_attrs.cocci | 13 +++++++++++++
> >  tests/remove_param_attrs.res   | 11 +++++++++++
> >  3 files changed, 35 insertions(+)
> >  create mode 100644 tests/remove_param_attrs.c
> >  create mode 100644 tests/remove_param_attrs.cocci
> >  create mode 100644 tests/remove_param_attrs.res
> > 
> > diff --git a/tests/remove_param_attrs.c
> > b/tests/remove_param_attrs.c
> > new file mode 100644
> > index 00000000..8ec1ffde
> > --- /dev/null
> > +++ b/tests/remove_param_attrs.c
> > @@ -0,0 +1,11 @@
> > +int func1(int x, __nocast int y) {
> > +	return 0;
> > +}
> > +
> > +int func2(int x, int __nocast y) {
> > +	return 0;
> > +}
> > +
> > +int func3(int x, int y __nocast) {
> > +	return 0;
> > +}
> > diff --git a/tests/remove_param_attrs.cocci
> > b/tests/remove_param_attrs.cocci
> > new file mode 100644
> > index 00000000..43f5a204
> > --- /dev/null
> > +++ b/tests/remove_param_attrs.cocci
> > @@ -0,0 +1,13 @@
> > +@@
> > +type T,U;
> > +attribute name __nocast;
> > +identifier x,y;
> > +@@
> > +
> > +T x(
> > +    ...,
> > +    U y
> > +-	__nocast
> 
> So the idea is that the attribute is removed no matter where it
> occurs?
> 

Yes, if the attribute occurs in the parameter.

Cheers,
Jaskaran.

> julia
> 
> > +    ,
> > +    ...
> > +  ) {...}
> > diff --git a/tests/remove_param_attrs.res
> > b/tests/remove_param_attrs.res
> > new file mode 100644
> > index 00000000..3705e814
> > --- /dev/null
> > +++ b/tests/remove_param_attrs.res
> > @@ -0,0 +1,11 @@
> > +int func1(int x, int y) {
> > +	return 0;
> > +}
> > +
> > +int func2(int x, int y) {
> > +	return 0;
> > +}
> > +
> > +int func3(int x, int y) {
> > +	return 0;
> > +}
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
