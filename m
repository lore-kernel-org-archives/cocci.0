Return-Path: <SRS0=bjme=D6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E3C4363A
	for <cocci@archiver.kernel.org>; Fri, 23 Oct 2020 03:34:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C532076A
	for <cocci@archiver.kernel.org>; Fri, 23 Oct 2020 03:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnnv4mPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C532076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09N3Y9lg002017;
	Fri, 23 Oct 2020 05:34:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6064875B4;
	Fri, 23 Oct 2020 05:34:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DADEF45D8
 for <cocci@systeme.lip6.fr>; Fri, 23 Oct 2020 05:34:07 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:62e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09N3Y6aG001377
 for <cocci@systeme.lip6.fr>; Fri, 23 Oct 2020 05:34:06 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id ce10so373403ejc.5
 for <cocci@systeme.lip6.fr>; Thu, 22 Oct 2020 20:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=8KKxM6fo3s9YHJqpaeFp50PrkVppl46LOfxJ4Ciz4aM=;
 b=Pnnv4mPtKe5UiHk81S0bep+f5OCCAfBIxBLcgeOGWk1mWKJhZCD0J8MQ4w0rGzsGJu
 y3Dz5WfbhjhPAg3HwGIIri+QwBYtnqVaF8hDErYACYduXHo/V4iDRSWu7PbIYYcHFbWL
 ApvL/DKH0dLCefzXnQ6GwJI2juTcQbcwRqnKb69A7HdP7uY1JRWHTpAZgBoj9dASNtrA
 kKicLnvKrtqr2tD5pArNNK1Qsmzr/tnHWCXxYV+kkQ39TpnS33TpZt8j8YUIiB/0n+nJ
 7VcDVcBcSzlSvgs77TWrOTHU7TFFoD/3Inou45NwbfoxfFGrTnAGo9xXItFWy529+CQL
 vzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8KKxM6fo3s9YHJqpaeFp50PrkVppl46LOfxJ4Ciz4aM=;
 b=Y0+CVk0/ZSG1PyoLzUI6wtDIMMoxUCPAXKolmfFs02ljydrvghwhcc6Y+8lMY0MwIA
 frrSpAyx8za8L9w7IRSjsRoxFP1TIJM/AwRmGg81RCvCqJ6Ts24YIzAWaOLbdROFIqeV
 hBFYzg/dFw/ZPlbAhJ5oBn2PE3plPkPsmSuodfg3qyKcmu1GxGhtf+dQ8VBSvSxgEKRc
 vDD8NeYfmulIyZdy+sR4z9TN2+GqowJeuNYVQWppYySJvYCh6fV3wK5bXVtkWRkId6RR
 0dcOGgrA8Bjue7p5P5BtlZBnnSd4yibxkr4iTQVQFo0R9PqVrhd2lIAz3pEyOB2yaAss
 66Cw==
X-Gm-Message-State: AOAM533EfcPzPhiZit4xn3YLrTSJ9ou9EONPKcX9F3HUrQ9AghoUOhsv
 X4Ilza7RJ5mZTlDaDmKL0XMkkU7xq9N6forPfI1UlZSLUXw=
X-Google-Smtp-Source: ABdhPJzNu3HQh/DnWWOG4jBUBefUM0+KSGh/ffmtnV/e3DR5Kaq9eYR0IANuERAXHPMyn/J0BMIg5leHA6MouZ8zfdU=
X-Received: by 2002:a17:907:42d2:: with SMTP id
 ng2mr98914ejb.124.1603424046290; 
 Thu, 22 Oct 2020 20:34:06 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Thu, 22 Oct 2020 23:33:54 -0400
Message-ID: <CALogXGVr7OYtWhrsZg7gnO+czzu6eM_GGThYSCYezgUmVjwqZA@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 23 Oct 2020 05:34:09 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 23 Oct 2020 05:34:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Newline escape in preprocessor
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

Hi,

I'd like to add a statement after another within a preprocessor
expression, but spatch adds the line without an escape (backslash).

x.c:

    #define X(a) x(a);

(I know the above is not technically correct but it's super common.)

x.cocci:

    @@
    expression e;
    @@
        x(e);
    +   y(e);

output:

    $ spatch --sp-file x.cocci x.c
    HANDLING: x.c
    diff =
    --- x.c
    +++ /tmp/cocci-output-80658-7f90b1-x.c
    @@ -1 +1,2 @@
     #define X(a) x(a);
    +y(a);

I can think of two solutions, if an expression is inside a
preprocessor statement: add a backslash before every newline, or skip
the newline.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
