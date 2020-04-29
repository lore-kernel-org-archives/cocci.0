Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7560AC83004
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 19:21:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB492205C9
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="CAsymf5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB492205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TJL0gr008195;
	Wed, 29 Apr 2020 21:21:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D2E217816;
	Wed, 29 Apr 2020 21:21:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2013C7807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 21:07:38 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32a])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TJ7bje029236
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 21:07:37 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id 188so3262414wmc.2
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2RuybLYNiBDaVq/vi0Cq98iCvyxCFyujtGSlmnbKlOY=;
 b=CAsymf5H0tgn/ay2+OF2oca+AAyTl/8CX1pCKc55lxl3vGz2erH9aAVT55huUx1TMp
 QeDBPmKOxvKNHLvhFw6mgGqnNYCgpdeNnc1jT7nLSdJamW/6tY5zMCvniOAtMh+VZ2fT
 bSxNxKrFp17iNmUm1kdNiLafLUxxBjnljJ72tLc2spX4gflgE69PMe14B5b+xQQ21QGf
 YTC60WhQ+A/qoUCR13bW32pQzMNpearTOh+dSn9XfFX2BCNyPHeldlo+uoUHHVtM2oXj
 IxnmFYB44dyZLexWNZUyFclGUCeaYw1Vb++V0eYZ16K5RQafJC06OTzREw3SN3sVNlmT
 zp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2RuybLYNiBDaVq/vi0Cq98iCvyxCFyujtGSlmnbKlOY=;
 b=uLMZBjuwwotiMlgvV8sh6H1zATlfd/bXNa/jQfFbdfnavcrN6e0Oglv0R3m2CrGmYW
 e3PgOsi8yYCCE/shjw0sBfRmorC4A5Um5unOoqffD4S/RRVbL2hFoJID2QntVuh6ABLl
 3qCZim+/AEcDgQfmgKHdOlklpYJtjlq3t67b/ope+nPsERaKrmVxECFhvoJ6QnN2XH+Y
 GPE3B0R+n244JuG+Rp/bkZyjp+Wyqav639cxlzeFFLd8QPWUxx7T6wxpve5wHHNheYOi
 GeWX0IbSm7+F1/16PxUcKUUqyvSVbWpxc4xIwLBH7kp3+7STSkEMtiZmqrdUEn/GBQGi
 aUhA==
X-Gm-Message-State: AGi0PubpD6tRsi4EIN/ZYBiolNAMlto3cuhbcL3AxR8xal+4Xi+jQkTY
 Hqu0ntQZA8HCGeBrrtUYGg2J7iLSPnxU
X-Google-Smtp-Source: APiQypLXzXX4IM+niCVSTJIWY1yv3DJBlYIuV7gC9otrrjsd74pEbJ5KvCnzedvvERXf1aX2CMy7UQ==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr5091327wmc.53.1588187255930; 
 Wed, 29 Apr 2020 12:07:35 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id z10sm247956wrg.69.2020.04.29.12.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 12:07:35 -0700 (PDT)
Date: Wed, 29 Apr 2020 21:07:34 +0200
From: Paul Chaignon <paul@cilium.io>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200429190733.GA5695@Mem>
References: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6c5ae24-f24c-a0d5-796a-8e9cbd17a7d6@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 21:21:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 29 Apr 2020 21:07:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 29 Apr 2020 21:20:59 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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

On Wed, Apr 29, 2020 at 08:40:10PM +0200, Markus Elfring wrote:
> > I am trying to exit spatch with a non-zero exit status when required
> > changes have been found.
> 
> I got used to the interpretation that a zero exit status
> should indicate a successful execution of the program.

I agree, but I guess what successful execution means is a matter of
perspective. For example, grep returns a non-zero exit status when it
doesn't match anything. Yet, I generally consider that a successful
execution when I use grep.

> 
> 
> >   @finalize:python@
> >   @@
> >   exit(cnt)
> >
> > where cnt is incremented by another Python rule everytime a required
> > change is found.
> 
> I suggest to handle the desired search result counter
> by an other data processing interface.
> How would you like to treat program execution failures otherwise?

I'm trying to run SmPL programs as part of a CI pipeline, so execution
failure and (buggy) code pattern not found really mean the same in
the end: a human needs to take a look :-)

I understand that is not a common use case and I'm fine using a
workaround. Just wanted to check I wasn't missing something obvious.

Cheers,
Paul

> 
> Regards,
> Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
