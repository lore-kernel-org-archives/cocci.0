Return-Path: <SRS0=gjU+=NY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D9C43441
	for <cocci@archiver.kernel.org>; Tue, 13 Nov 2018 07:24:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D4A223D0
	for <cocci@archiver.kernel.org>; Tue, 13 Nov 2018 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfNDeV9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D4A223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAD7OFLh000239
          ; Tue, 13 Nov 2018 08:24:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 78B9076D5;
	Tue, 13 Nov 2018 08:24:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7182A76CF
 for <cocci@systeme.lip6.fr>; Tue, 13 Nov 2018 08:24:14 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:52a] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wAD7ODTS005783
 for <cocci@systeme.lip6.fr>; Tue, 13 Nov 2018 08:24:13 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pg1-x52a.google.com with SMTP id r9-v6so5275441pgv.6
 for <cocci@systeme.lip6.fr>; Mon, 12 Nov 2018 23:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UPlsPH6NLOaK3eTJV0pZiUxHnMxsNdh9zmj+fh05slM=;
 b=kfNDeV9jdgCuZp79YLEpp5s1Ex+alPwiTwRNST6RZx1jEfh8dxEzXLgjCYtadvXjf4
 SKzjq0HJFxsxR0NuAyWhwIhvvGh7iwUOuZ++meANoNyhjBh77N9Ro5BDzMpJi9NrtmgD
 0+Oo+hxIRRVG4cnzXFbYc5eZa4tq0A5jvUY3SQNB1BOi7LygZt5a+7vPJVD8PPhqcaOg
 OgYqZWD7dkKgAvF60Ukzp7CRj37rZF67xA6ib3s/BUyHigtHU5XQpIp2EPpC7cfFGKOA
 /wN4lEy991oZXMVHWwDRr7xNVh2wZCVPNEWI2KGyZ9WQB4iy1TQI+/dEp272Y0YIpfpQ
 bH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UPlsPH6NLOaK3eTJV0pZiUxHnMxsNdh9zmj+fh05slM=;
 b=CKKe/vjWyYAK3rjGgq2Rw4fPIyYC00pauk+y+HMwS6LiJVcJlo8vJJIfGxUfj2Nb+s
 4FG5sl2QA8rQ+1RoCLC5JZ18At4ToSYU4jRyvRuNR2py53o7PPmcVL67zuntqK6B36K9
 F4YI5E3059X3VVtqxQa4JGR9mc6VMryc59M6OJt2+CTVOrxdlj1pRY+I/hAeLpFzQWt4
 a4XevHJaoCmihR1et/JjJ1QpEGQtk2H37G/JLx1K7NGnwuygzPEX0eYdegz5lQcngefK
 eRvpwb2D2baaYFQd+JXIEx2w1cXkrQEDuZtJVn5/Ejd2elVc2ht1iCdCYVeKC/bleY9T
 2tIw==
X-Gm-Message-State: AGRZ1gL8MBm9wSCLFdB6Qbexjtg6WqTSCVqIMgRr00Y6mDfMl1+B6BhQ
 TRAXHeZAUpKqMqJthkE7jy4=
X-Google-Smtp-Source: AJdET5eno9RQ+8djZTBvV13xsJvZTwoNqbfiCJ73JFNZKuwSZd4rWmtxjm0m8EPxDB0M+uVcJTwcNQ==
X-Received: by 2002:a63:e615:: with SMTP id g21mr3809263pgh.290.1542093852456; 
 Mon, 12 Nov 2018 23:24:12 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id c127-v6sm20923329pfa.31.2018.11.12.23.24.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 12 Nov 2018 23:24:11 -0800 (PST)
Date: Tue, 13 Nov 2018 12:54:06 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20181113072406.GA2042@himanshu-Vostro-3559>
References: <alpine.DEB.2.21.1811121018520.2366@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811121018520.2366@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Nov 2018 08:24:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 13 Nov 2018 08:24:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle mailing list archives
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

On Mon, Nov 12, 2018 at 10:21:49AM -0600, Julia Lawall wrote:
> Hello,
> 
> The Coccinelle mailing list is now archived here:
> 
> https://lore.kernel.org/cocci/
> 
> This contains all of the archives that are also on the mailmain site,
> which goes back to September 2012.  Unfortunately the previous archives
> appear to be lost.  If anyone would like to help with retrieving them and
> was subscribed prior to that time with a gmail address, there are
> instructions on constructing archives from gmail here:
> 
> https://korg.wiki.kernel.org/userdoc/lore

One minor comment from Konstantin:

"Just a note that GMail is not a requirement by any means -- the
list-archive-maker script can be used against any mbox or maildir
directory. Gmail just happens to be a place where people have most
complete archives, since nobody bothers deleting anything there."

So, whoever has list archieved dating before 2012 are requested to
follow the procedure in the aforementioned link. There is no problem
is you had some messages deleted as others might have that specific
message.

Yes, various archive donations are then piled up to form a clean
archieve.

> Thanks to Himanshu Jha for suggesting this and Konstantin Ryabitsev for
> setting it up very quickly.

You're welcome!

Now developers who have trouble during installation can easily search
the trunk and possibly get their issues answered.

Send me those archieves and I would pass it to Konstantin.


Thanks!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
