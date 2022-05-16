Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689DC433EF
	for <cocci@archiver.kernel.org>; Mon, 16 May 2022 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=H8hJCQRNMqeQaG9xnrMBwafztrsPwx6OH0x1bSvswa4=;
  b=WjQ4X+vqhXtmS7dfobhF3TpV4NdFlAGXPBoDsv1tirWD+y1GVH2Kv8VE
   1Iu6nYIOOrmL9c/2r+Y6o1hXYipMDTm/SN0X1BUCMnJno0FtT6MTye7xF
   3OZzrpLfjpv7idziWKuR3lfn/uogrZ7E/XtLYC6Zjz5mnIDZSlMfxUUS7
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.91,230,1647298800"; 
   d="scan'208";a="36570926"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2022 22:22:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E79CCE4370; Mon, 16 May 2022 22:22:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7DD75E436E
	for <cocci@sympa.inria.fr>; Mon, 16 May 2022 22:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=H8hJCQRNMqeQaG9xnrMBwafztrsPwx6OH0x1bSvswa4=;
  b=b7Gev4UlDoOmZ2T1jC1Ua5BZznxc6ZV6sFCsgP4B2bred5sfm5GBws7h
   jwLgSGApbA/DuD1tAAYwo3KBRMacYowL/EO8w1warFgQDZzjFME9CK8CG
   iEySBcuVRTJ7HQf6xtnE3w6tbxT8b4hmciU4fc2C3VtLd5/UQb7loCP4o
   c=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647298800"; 
   d="scan'208";a="14248569"
Received: from unknown (HELO hadrien) ([109.190.253.11])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 22:22:04 +0200
Date: Mon, 16 May 2022 22:21:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Phil Edworthy <phil.edworthy@renesas.com>
cc: "cocci@inria.fr" <cocci@inria.fr>
In-Reply-To: <TYYPR01MB7086CFE025C9A65F40613D61F5CF9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2205162221140.2918@hadrien>
References: <TYYPR01MB7086CFE025C9A65F40613D61F5CF9@TYYPR01MB7086.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Matching an if statement with just one func call
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 392
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205162221140.2918%40hadrien>



On Mon, 16 May 2022, Phil Edworthy wrote:

> Hi,
>
> I'm trying to get my coccinelle test to detect code in
> the Linux kernel similar to:
> if (!clk)
>    clk_disable_unprepare(clk);
>
> So far, I have got:
> expression clk;
> position p1,p2;
> @@
>
> if@p1 ( \( !clk \| clk != NULL \| !IS_ERR(clk) \) )
> { ...

Drop the ...

> clk_disable_unprepare@p2(clk)

Add a ; after the above.

julia

> }
>
> However, I don't want to pick up code where something else is covered
> by the if statement, such as:
> if (!clk) {
>    do_something_else;
>    clk_disable_unprepare(clk);
> }
>
> I know it's related to the ... but I can't get it to work.
> Sorry, I'm a coccinelle newbie.
>
> Any help appreciated!
>
> Thanks
> Phil
>
