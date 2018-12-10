Return-Path: <SRS0=GhGO=OT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2362DC04EB8
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 17:42:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBFC20851
	for <cocci@archiver.kernel.org>; Mon, 10 Dec 2018 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttGnFcWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBFC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBAHgd4P028162
          ; Mon, 10 Dec 2018 18:42:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 24F7276D5;
	Mon, 10 Dec 2018 18:42:39 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B76076AB
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 18:42:35 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBAHgYHK010436
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 18:42:34 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pg1-x544.google.com with SMTP id v28so5282682pgk.10
 for <cocci@systeme.lip6.fr>; Mon, 10 Dec 2018 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KHF3oQol3wmLSdnSALcqQnavMTeBGDMLnvc7Y5o0oeE=;
 b=ttGnFcWldOqERKfAsF2shGHqxPFQa8TNutFhwrVaFfdmoSTpCQJRQIfqUIx9FnmPUE
 SeMJPlgDHqH2BtGiUboROAPjV13mn0tw6v7FHjFErZWG0cafqg7vmEQ+6u5pzyRM3vpZ
 0zRyXGBiERfEXqob3+RmBOp5ht+nr62pCO0m3de2eho92GdaK6pm95658hA7GtSQ8fq+
 InX6CGPNErMRFK4C4gpVCDu3I1RMZQqOmNShn8S22LOivQPjPF82Aaei7RcF5bk1fwuE
 vYAC9Lm+Pwi29K7G66hffhPm6TJGkw99J7eyeSEvIGJl4lTntZU1toMbV/WOnHxHTLJK
 03bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KHF3oQol3wmLSdnSALcqQnavMTeBGDMLnvc7Y5o0oeE=;
 b=peWiyrHA1Gq+sLm5rKtUuqEePKskdbGZTz60vFK1QGEBX+q+6oJnuYoDv4lvsO4a5y
 qa76/YaAtGcHeqqECBDbPIstOXiUWpgIaVxm8tNiP+c07fAaJGB4nVjD+mDYUJeZHQ9q
 pEW8CnsJsrwsCfl+Gs+oLvJVRQj3GBxfcefBATXMxo0umsgaHPs+x32+NNAgpuazejq0
 GQhzjcu8rzKo2mZn9jlAc9e9rSBHd1iyzAg/HVSzKc/tyCxmGfCbvD+Mul8u7PEh6HnA
 6XS52yqcBKATTPyOS6Up68hlX5uQOH6seL8Wjpv9SWW4pOfSUuoXasGqoYTD8H2C6eax
 pPTw==
X-Gm-Message-State: AA+aEWaIqaxdlU93BMLP3XMBFIIsexq9NtUoqzIh+3smFyhMZUNkvgng
 XE+W1/VJn7RpdYqDOSAxn5w=
X-Google-Smtp-Source: AFSGD/Vra2l5FGrzB4WwAtHoiVfMBvIwMCoqiuIhlbBK/hNIVC0qSBvrD213PYoKRoQVPDci0X94Cg==
X-Received: by 2002:a62:65c5:: with SMTP id z188mr13637810pfb.64.1544463753549; 
 Mon, 10 Dec 2018 09:42:33 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
 by smtp.gmail.com with ESMTPSA id f67sm17034415pfc.141.2018.12.10.09.42.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 09:42:32 -0800 (PST)
Date: Mon, 10 Dec 2018 23:12:27 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Oliver Schwahn <schwahn@cs.tu-darmstadt.de>, patrik.flykt@intel.com,
        flavio.ceolin@intel.com
Message-ID: <20181210174227.GA2063@himanshu-Vostro-3559>
References: <ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de>
 <alpine.DEB.2.20.1812101554470.3486@hadrien>
 <9957435e-f4bc-92aa-0a9e-295c0d77345b@cs.tu-darmstadt.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9957435e-f4bc-92aa-0a9e-295c0d77345b@cs.tu-darmstadt.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Dec 2018 18:42:39 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 10 Dec 2018 18:42:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
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

On Mon, Dec 10, 2018 at 04:42:05PM +0100, Oliver Schwahn wrote:
> > > Do you have any suggestion for a workaround?
> > 
> > Can you upgrade to 4.06?  I also have this problem with 4.05.
> 
> Thanks for the suggestion. OCaml 4.05 was indeed the problem. I upgraded to
> 4.07 and that worked fine.
> I also had the chance to check on configurations with OCaml 4.01.0 and
> 4.02.3, which also work as expected.

FYI Patrik & Flavio,

You too need to Upgrade and try again.

https://lore.kernel.org/cocci/ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de/

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
