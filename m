Return-Path: <SRS0=LaBa=KW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD3C4708B
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 10:14:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B80B6109F
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 10:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B80B6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14RAEjmX007461;
	Thu, 27 May 2021 12:14:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0CFE97737;
	Thu, 27 May 2021 12:14:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5F3287648
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 12:14:43 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14RAEfqr015664
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 12:14:42 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id c3so243204oic.8
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=fbNFFxI6eJekQ0LfuKk6uf28S9UWw1jN/qr9xTWYVlE=;
 b=WqtiPiU1wF1Nl+IwhVIQnq9IQfGca/Rt7gWO5nILzIVicE52qN1IuKrsN+ymiAfpGc
 BZ20DnGAzj5c6moP4olYvrADy/pGQXu7oA4x97BmbAVst25ftCfkJwlocDYx5FpDe2hK
 H80ldfOpicuRwQDCs0i19/IiY3tbRl6j46YsdOViyyq1eTovADU1aUrPQ0/jeCIQOEpo
 WhnTibbU4nhq3b3TZylKTNT2nxuIbckyxo3a/EUUem2r2ncVGWI8BZ15KryXZ2+rE46F
 gcDaqftWfc9CVSOhum7ZpvIhkoqC803LcWRdeRTkxVkXLKrGKqO6338r9bg7R8tkbmpa
 LQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=fbNFFxI6eJekQ0LfuKk6uf28S9UWw1jN/qr9xTWYVlE=;
 b=KC32NanR1suerFNyDCfy1Re3BEDjV9ArhPaad/6ydhtnnLcu4uhN3pDSZzlJnf5Qoa
 SbCuGOgfD/QIrEsZgNvI+7IXP3T6qnVsF9WoNqC7Y1bpkGFhxlbsRnw6ACwjSN1HxVk3
 VIIFnfeKt27G6E3kFUQRQp+Q/LUGUjKZuBzKNCAGZngSrH7xOpUPwmfynMmH03DQab4U
 KMIozRnkDfax1mZSHV/0wfjYsCGrjRnJ4hNXi1baCk4a6JUitcCcdud0R4izfBLPlplW
 F1P/sWClButHj/9dufRkmBPaMSzBW9uLNAApz1N85J1RAa+uKvRn25i+Q33dxILy/Mqd
 2tkQ==
X-Gm-Message-State: AOAM532VfCFCUYZbG6wmZaQyEP3fxgQLl7ui43cc94KN/PLpuI4N1NeB
 GJj8v13hAAKrVaHUjm5a2O7eiCm3nCMUFOC5L01vLwig/qK03Q==
X-Google-Smtp-Source: ABdhPJy8uU1t52WWF3I8csTl0GCOf9Wj0C/5jXlY9jBrWingk9TXZ9xtnA0O2AciAXLrOSeWEkRKoGWFHPmh+CDD39s=
X-Received: by 2002:aca:4244:: with SMTP id p65mr4848172oia.8.1622110480771;
 Thu, 27 May 2021 03:14:40 -0700 (PDT)
MIME-Version: 1.0
From: Fuad Tabba <tabba@google.com>
Date: Thu, 27 May 2021 11:14:04 +0100
Message-ID: <CA+EHjTzCieJgFQOgiP5YQWurpV9dOj=bw+jF=GsTtum4vy67Ag@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 12:14:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 27 May 2021 12:14:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Adding a line to a function after all variable declarations
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

I'm trying to write a semantic patch that would add a new line to a
function, but would like that line to come after all local variables
(if any) have been declared. For example (distilled from what I am
actually trying to accomplish):

@@
identifier f, s;
@@
f(..., struct mystruct *s, ...) {
/* after any variable declarations*/
+ x = s->x;
 ...
 }

I would like it to patch as follows:

int function(struct mystruct *s) {
+ x = s->x;
return 0;
}

as well as

int function(struct mystruct *s)
{
int y;
+ x = s->x;
return 0;
}

or

int function(struct mystruct *s)
{
int y, z = 10;
float f;
+ x = s->x;
return 0;
}

Any suggestions on how I could do that?

Thanks!
/fuad
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
