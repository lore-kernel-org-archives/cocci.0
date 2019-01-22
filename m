Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEFC282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:47:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B5F20870
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 19:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqJ7QO1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B5F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJlQmW029126
          ; Tue, 22 Jan 2019 20:47:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D3FDA76F2;
	Tue, 22 Jan 2019 20:47:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 12A2F76EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:47:26 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:135] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MJlPSR013536
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:47:25 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-lf1-x135.google.com with SMTP id z13so19000959lfe.11
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=DI9BRIF5BeMkqo5ut80kX9S7sE70TpAyrwiJLl/6TTM=;
 b=jqJ7QO1/4/5jPaq2NtbnXRb4zes5F4eo2jx1VUdDHBMwnlV52UVkfuCgOCAIk36FYk
 PokdymaigxD/VPSnTFE3z2XRJCrPHDpo4Lw+gYpaE0zyJk72u9JtqbzHtTLZ5vRaeog/
 FiBDVP6nGzs5zCyFkAj0fQKdydGatxdU06aWkPfcdCHGdETEagJavDTmRBixt3sCPfYS
 tSIB1M3AMwOwWB7pAIARJsaAU8C0D+RomBQFqmMvROqy7Vv/qdh1lMAisabywlxKUdh4
 +zMj2/wRThvOLKt66SIpaSVwl7dbMH6KFVeleeQgYVeQpHamw4fU/ZW1VPEqGvvFyJ+G
 XU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=DI9BRIF5BeMkqo5ut80kX9S7sE70TpAyrwiJLl/6TTM=;
 b=ZC2h39Pttnt14v5PXQaoO74wbsHFFe7PuDoVH71IPPlwnYzdNVfuiaD1UW2IXm92j8
 nIU4vp/2llAxOxxYtMxSUV+vPlRTc5fbeSresj98w7gabEEvESc9bkyPg/FrbuBw+PY9
 XIcsBAYqPOYAJ/R30iv44KouVJ9cTnVTmkhOB585sZECo040+bhqTagDQjsgq4Hfh0o1
 NI7iMno66bjccslFHpyTkKVDeM8acqnsk1J4+fWB+LMDRcrtfEejaSAEbgqE3fGTFWWP
 ducwdHZc/E9SxI4Hz5sDayqt2jzNNESZUQmx6z2XzniI16qAmoyhl8OMDbDpH9wi+H0c
 OLVg==
X-Gm-Message-State: AJcUukecW4phUzdxWBmSkOM+omjx6Yhj+aWA72IwsknaA7G0JlmZ5wH3
 7RV24Mty9winfirDzkydtw2szvj3UeThctNnZ8yoL17Q
X-Google-Smtp-Source: ALg8bN4dFj/TFBkc8vL0N3xNW6ccrZFPe1lbNaC/FxX2XpiGVFAKy4x4cxYIb/Hha0gxjq/iIXx9NmmmKBjJu0ZSYlI=
X-Received: by 2002:a19:739d:: with SMTP id h29mr23057839lfk.85.1548186444724; 
 Tue, 22 Jan 2019 11:47:24 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?6Jek5pys5aSq5biM?= <fjtkut@gmail.com>
Date: Wed, 23 Jan 2019 04:47:13 +0900
Message-ID: <CADa4oMX2YL+ZLy2QA+=HELLTvFyMxw_dxueceLBH30Pk6+se3A@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 20:47:27 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 22 Jan 2019 20:47:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Questions about coccinelle
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
Content-Type: multipart/mixed; boundary="===============2107721647=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============2107721647==
Content-Type: multipart/alternative; boundary="000000000000157ce90580113f2a"

--000000000000157ce90580113f2a
Content-Type: text/plain; charset="UTF-8"

Hello.
I am a student of Kochi University of Technology in Japan.
I have asked a question before.
Thank you for all your help on that occasion.
This time I have one questions about to create rule.

I would like to apply rule2 only to routes that did not match rule1.
What should I do?

--000000000000157ce90580113f2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello.</div><div dir=3D"ltr"><span style=
=3D"color:rgb(69,69,69);font-family:&quot;Helvetica Neue&quot;;font-size:12=
px">I am a student of Kochi University of Technology in Japan.</span><div><=
span style=3D"color:rgb(69,69,69);font-family:&quot;Helvetica Neue&quot;;fo=
nt-size:12px">I have asked a question before.</span><span style=3D"color:rg=
b(69,69,69);font-family:&quot;Helvetica Neue&quot;;font-size:12px"><br></sp=
an></div><div><span style=3D"color:rgb(69,69,69);font-family:&quot;Helvetic=
a Neue&quot;;font-size:12px">Thank you for all your help on that occasion.<=
/span></div><div><span style=3D"color:rgb(69,69,69);font-family:&quot;Helve=
tica Neue&quot;;font-size:12px">This time I have one questions about to cre=
ate rule.</span></div><div><span style=3D"color:rgb(69,69,69);font-family:&=
quot;Helvetica Neue&quot;;font-size:12px"><br></span></div><div><font color=
=3D"#454545" face=3D"Helvetica Neue"><span style=3D"font-size:12px">I would=
 like to apply rule2 only to routes that did not match rule1.</span></font>=
</div><div><font color=3D"#454545" face=3D"Helvetica Neue"><span style=3D"f=
ont-size:12px">What should I do?</span></font></div></div></div>

--000000000000157ce90580113f2a--

--===============2107721647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============2107721647==--
