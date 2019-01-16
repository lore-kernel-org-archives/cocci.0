Return-Path: <SRS0=UzGm=PY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B2C43387
	for <cocci@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684BA20652
	for <cocci@archiver.kernel.org>; Wed, 16 Jan 2019 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szk9RcVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0GLjfhc003389
          ; Wed, 16 Jan 2019 22:45:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E3DF76E1;
	Wed, 16 Jan 2019 22:45:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95FAD7635
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 22:45:40 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0GLjdAM021717
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 22:45:39 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pf1-x442.google.com with SMTP id c73so3681300pfe.13
 for <cocci@systeme.lip6.fr>; Wed, 16 Jan 2019 13:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+6cu7Szyng11fZJcMoFfoAPi5B0sVDbHzLkXKvIkA8U=;
 b=szk9RcVTi7srhbGbaPaJfHvO9doPoQ7eE4Kan8CIyayT+9mK3CXjakjCZcHwMqXrtK
 qBn6191R5R3NpGruE1hm6448p7OQKsLY5cL5X/QP4wsUf72RBygm9CRaIwkorZazVsnn
 N6XaL8HPsGZxSqLPF7fHXqW1IkHEO4HQgkn4LC50dJ6FJ0Cgny9a2CX2AI0o4HeSULNG
 XsJYM2kxu1l9WP7zeP9SRa/TLe7/MRk7isMIaGv+nvnezj4eZjgQ0Hw2xsFdZkCVda1o
 wgx8W6uYE/ZIpHg0DHaHR4XzOBmSylxxniTIdI4UUowiw0ufHWRIN9ijbCfPI+I1EjFD
 KkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+6cu7Szyng11fZJcMoFfoAPi5B0sVDbHzLkXKvIkA8U=;
 b=Fh6LadCn3UPuBjAgm7XbMLf5YHTNAJCzqfAYAlbNZKEKEs1xSdTt4A831ITnDDnyGa
 lpSwv7zHanM5rpE/itz2ZkEgorAwVn3gWujZTBVRdivTEBX9naSXeBaPxX/TboVz7HVJ
 +wJMhOdVfA0DIGSVPY49RHJrdzQvgUVosriSDq/M0ojDz2CVFrM3NUZBvCbvtaHeOxty
 DX0Z65gmhCJPK64f5HB+wFsfIld+mbLjOSXLu055E6qHtS/dhBck9dIJ5y4lmf5diimw
 vCH88Zo2HqRN+TBDUfQUkPTdZikUomhgDgXUlv59npKuOt3MfLrWPD+65OrID3BEw/oZ
 ueBA==
X-Gm-Message-State: AJcUukduycBdlBu32eBaS+DJr1PpdzCa3WUp8eXYm9EKlV+/t68BuLmR
 lQGEx6gDRt1JtNbGsMxQpJYN4KxL
X-Google-Smtp-Source: ALg8bN7eSjeCMaHXwZ5lRBGtU8OzljjdmCabg/IMYmg2oy4BZVfuNHect5adkKcXe4AO6VPWj1hKHw==
X-Received: by 2002:a63:4456:: with SMTP id t22mr11061640pgk.0.1547675138770; 
 Wed, 16 Jan 2019 13:45:38 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id 12sm9343193pgt.33.2019.01.16.13.45.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 13:45:37 -0800 (PST)
Date: Thu, 17 Jan 2019 03:15:32 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Julia.Lawall@lip6.fr
Message-ID: <20190116214532.GA13641@himanshu-Vostro-3559>
References: <20190116210455.1091-1-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116210455.1091-1-himanshujha199640@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 16 Jan 2019 22:45:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 16 Jan 2019 22:45:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Flavio Ceolin <flavio.ceolin@intel.com>, cocci@systeme.lip6.fr,
        Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: Re: [Cocci] [PATCH] standard.h: Add Z_SYSCALL_HANDLER macro
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

On Thu, Jan 17, 2019 at 02:34:55AM +0530, Himanshu Jha wrote:
> This patch allows coccinelle to parse the Z_SYSCALL_HANDLER
> macro for transformation.
> 
> Cc: Patrik Flykt <patrik.flykt@linux.intel.com>
> Cc: Flavio Ceolin <flavio.ceolin@intel.com>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---

Please drop this patch Julia.

I misunderstood what you suggested and it works fine using
`--macro-file` flag:

himanshu@himanshu-Vostro-3559:~/zephyr$ cat mymacros.h; spatch --sp-file test.cocci drivers/dma/dma_handlers.c --macro-file mymacros.h
#define Z_SYSCALL_HANDLER int xxx
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
init_defs: mymacros.h
HANDLING: drivers/dma/dma_handlers.c
_impl_dma_start
_impl_dma_stop


Sorry for the noise.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
