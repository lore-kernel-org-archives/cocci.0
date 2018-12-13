Return-Path: <SRS0=Zs5K=OW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC0BC65BAE
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 18:33:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E4820811
	for <cocci@archiver.kernel.org>; Thu, 13 Dec 2018 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIzeX+Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E4820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBDIWica008719
          ; Thu, 13 Dec 2018 19:32:44 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1A12E76D8;
	Thu, 13 Dec 2018 19:32:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6EFF476D5
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 19:32:42 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBDIWe4V019793
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 19:32:41 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pf1-x444.google.com with SMTP id h3so1531221pfg.1
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 10:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Sv/REMY6F6vaRm9MgfXEB0MHGaNCgc1sEDIWpB2ECCw=;
 b=UIzeX+GfYy8b/thiZZhGRtF04IlD1Yx5HJT24/hUJtw9bwzgx9qN4/lV/6iU6Ik8fs
 Ya/oo1skHlBjeeD0qcIYuvByQJMfVKD+jOI/9rJIqn9iin4txg3prA5sxhloIXO1wEPT
 4Nv36TikFGrnfeClm1JFcwFV0p7JBsM+5GSJskERIy1zAdkZfPljM++9Q0Cd9q+gkxAo
 wZB6Wf87CC8JIp9fb6DKe01HSqeUQLeCx7fP4VEbsmACPAzSc8uqZNaokefDJFsDuSvx
 mxzGy3f8JomP8/5Obd1OQ9HyD7fmhLi3X7opyWOPqrxoSFrOI4K+W+OYCYPF2OVLsjP2
 xnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Sv/REMY6F6vaRm9MgfXEB0MHGaNCgc1sEDIWpB2ECCw=;
 b=OKvK93c6VAT4SDXCSewC9F0LvP7qoPaimFEr16tnzo1VSeAiqAL1j0uk4KxStEHYkR
 SMuh7bKQHeKkVVkg2eyggNPtdTJzks0U7jcLZe2/UyLI74Fb8Pi5WWK9duDiuPweCFuq
 YM23S/izIabUYD1c5vchRV+6gdWW25lGWd0k2Rp20NN1lroe5WebHtD6REkmDzX/m+mR
 dZNe/pUZL7fWB6Cy9a9X4lTu6yDuEQYipu8e6gJYo4xduoxQgqYfSmdpOQEAZP3Ul+kC
 7rXMuDf2tQRXXFNygrCA7DrlGLqwpABTy1/0Qww3kbJxsZLBIKbX9YoNm91HUQeQl6sw
 H1IQ==
X-Gm-Message-State: AA+aEWYH3kqoLoQ8vc5bqGh5iex4MboLCnGedaxUaxRHpagSxKlTdxKK
 AQCfxpy8N3QU7sExXkbH6+w=
X-Google-Smtp-Source: AFSGD/W1/ZNZXHRix02JjJcFxb14j4u8nXO/iTpMzYD34o9DMCiDbyPEteFHrxUUFy1DAiUS8N6Pvg==
X-Received: by 2002:a62:109b:: with SMTP id 27mr24508670pfq.227.1544725959972; 
 Thu, 13 Dec 2018 10:32:39 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id s2sm7257013pfa.167.2018.12.13.10.32.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 10:32:39 -0800 (PST)
Date: Fri, 14 Dec 2018 00:02:33 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: "Flykt, Patrik" <patrik.flykt@intel.com>
Message-ID: <20181213183232.GA10283@himanshu-Vostro-3559>
References: <ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de>
 <alpine.DEB.2.20.1812101554470.3486@hadrien>
 <9957435e-f4bc-92aa-0a9e-295c0d77345b@cs.tu-darmstadt.de>
 <20181210174227.GA2063@himanshu-Vostro-3559>
 <d94f90c42069e3fca6075fcff761d5070012daea.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d94f90c42069e3fca6075fcff761d5070012daea.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 13 Dec 2018 19:32:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 13 Dec 2018 19:32:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "Ceolin, Flavio" <flavio.ceolin@intel.com>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Build issue after stdcompat upgrade
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

On Thu, Dec 13, 2018 at 06:06:28PM +0000, Flykt, Patrik wrote:
> On Mon, 2018-12-10 at 23:12 +0530, Himanshu Jha wrote:
> > On Mon, Dec 10, 2018 at 04:42:05PM +0100, Oliver Schwahn wrote:
> > > > > Do you have any suggestion for a workaround?
> > > > 
> > > > Can you upgrade to 4.06?  I also have this problem with 4.05.
> > > 
> > > Thanks for the suggestion. OCaml 4.05 was indeed the problem. I
> > > upgraded to 4.07 and that worked fine.
> > > I also had the chance to check on configurations with OCaml 4.01.0
> > > and 4.02.3, which also work as expected.
> > 
> > FYI Patrik & Flavio,
> > 
> > You too need to Upgrade and try again.
> > 
> > https://lore.kernel.org/cocci/ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de/
> 
> Debian testing with ocaml from stable, i.e. ocaml 4.02.3-9, stops with:
> 
> OCAMLOPT  parsing_c/ast_c.ml
> OCAMLOPT  parsing_c/includes.ml
> File "parsing_c/includes.ml", line 159, characters 9-22:
> Error: Unbound module Parmap
> make: *** [Makefile:424: parsing_c/includes.cmx] Error 2
> rm parsing_cocci/parser_cocci_menhir.ml.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml

Timur Tabi had exactly the same error and disabling parmap helped him.

But disabling parmap isn't recommmended AFAIK it supports
parallelism in coccinelle.

https://lore.kernel.org/cocci/CAOZdJXVDqxHBsOKK=+M_oazwO5Hc3uR7EsgACeg+2H3QwcWo4w@mail.gmail.com/

In future for any other issues, you can try to search the archives
like https://lore.kernel.org/cocci/?q=includes.cmx
first and perhaps there maybe someone who hit the same issue as
observed above :)

> Here Ubuntu OCaml seems to have a difference against Debian. Ocaml
> 4.05.0-10+b1 is unfortunately the latest in Debian testing and
> unstable. It seems I have to sit and wait until also Debian gets
> updated.

Debian, heh..

Then probably you would need to wait for more time since TSC decided to
raise the min CMake level 3.13 as well ;)


Thanks for the effort though Patrik and hopefully updated PPA will soon
be available.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
