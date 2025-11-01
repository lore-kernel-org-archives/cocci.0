Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA7CCF9F8
	for <cocci@archiver.kernel.org>; Sat,  1 Nov 2025 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Vt7k7t7721P4QonACx4SOu9++B6JxYbqnaj7pAcbUus=;
  b=TagaxMdk/nRo4/Dtoo3DITFs8GB2/bi6NiBaThDPH6SJ9yHGVWDVaLGX
   SNGQdJmwyd6ogxfNoCND7VMysuhmLJztl19KbIaabeGtll8XSZ0ZM8IP4
   MLQL3sLkF4aW4dAQYiuQ+u8iYN6w5Xih4TKjS2IiexSLotoeOHjxCRzqG
   g=;
X-CSE-ConnectionGUID: wfRPc7U0SaS5mo30cYqD5w==
X-CSE-MsgGUID: zw66xiAwQiSyCny/eR5KSA==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247089575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Nov 2025 10:39:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E24AE0172; Sat,  1 Nov 2025 10:39:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C957E0171
	for <cocci@sympa.inria.fr>; Sat,  1 Nov 2025 10:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Vt7k7t7721P4QonACx4SOu9++B6JxYbqnaj7pAcbUus=;
  b=diMcktqYJzU19MJFhGB/c3HdqJDUuEKRe/uk3HfHd24YXCiWjjDWsudU
   I409WcvuTZsZyJSt69ZZ63KDGq2tl7VKzHX3cBm4Zrw4cANNmuHggTsGP
   hSNxw0Bh2v3kn7Y2/Yx/NpP7MkJcVqjFLjytUo9jPphTaWu6S1KzAYF/+
   w=;
X-CSE-ConnectionGUID: h+HeN/bkTkOC00Lq5FlQ7A==
X-CSE-MsgGUID: JjA+r/AeSz6RmerWJNrisw==
X-IronPort-AV: E=Sophos;i="6.19,271,1754949600"; 
   d="scan'208";a="247089569"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 10:39:22 +0100
Date: Sat, 1 Nov 2025 10:39:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <3e448c59-e62a-4199-847a-91c479fe3395@web.de>
Message-ID: <1b1c1655-4cf0-5b74-1eaa-f46253aae837@inria.fr>
References: <8586e8c0-a756-4d43-8bf5-2e26fccceeff@web.de> <603a30da-628-2e4e-8044-a9b686e42a5a@inria.fr> <3e448c59-e62a-4199-847a-91c479fe3395@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Improving expression list selections with SmPL
 ellipses?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3134
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/1b1c1655-4cf0-5b74-1eaa-f46253aae837%40inria.fr>



On Sat, 1 Nov 2025, Markus Elfring wrote:

> >> *my_action("Hello!", ..., ...);
> >
> > I have no idea what you think this should mean.
>
> Can such a search pattern indicate that three parameters (or expressions) should be passed?

No.  Unless you put an expression metavariable you have no guarantee that
there is exactly one expression.

julia

>
>
> >                                                  How is it different than
> >
> > my_action("Hello!", ...);
>
> It is tried to express another constraint, isn't it?
>
> Regards,
> Markus
>
