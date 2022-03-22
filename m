Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A42C433EF
	for <cocci@archiver.kernel.org>; Tue, 22 Mar 2022 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dGPsShgCRxzHlbPxtGXtJTbFwais/v9c8K+RFYoMjHo=;
  b=D1ifJRV9IEjSX2qF9NDxjKr5FB16k1g+SWuD3I/iH++eGiX1cveKzB5X
   rkScQcSXTnVjisqUZpvzwsHLM948X0e4446HNBrUECMZMulVi5dBBktB1
   LwfjTUs3nz931/zgar6MNViNs0jvR2iVa3b32JibQPWZzKRTvFfCXNodT
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@univ-grenoble-alpes.fr
X-IronPort-AV: E=Sophos;i="5.90,201,1643670000"; 
   d="scan'208";a="27496560"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2022 15:30:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58F2BE01B9; Tue, 22 Mar 2022 15:30:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 65724E0069
	for <cocci@sympa.inria.fr>; Tue, 22 Mar 2022 15:30:43 +0100 (CET)
IronPort-SDR: CNxIhxSX4NgUjIMHa/gtmsNlh7TbGfyS1zidU8lX7vNjJNboMVoPR9AaBT5xh30btBb2FMIcpQ
 U0Od1l3UN9DX0TnsJLJvElVzrjZE7ztEk6D5+Zl2DI5PMfOKPo/Xj1UPO7qk05kgAsMilRsWRF
 xofLdfqXysFDOGvyIERkNiDLXRGLaxg6eTPu69kGM+lCK2FytvlzHnpzJNzQFzlhbfsT0ZoVmL
 m76ofzAE58Co7a46zMU9YFtvb+DBMwNncs1DW+fo6wvwC2hZtKYODSA+oV5i/5uWsZx3F5dfC9
 X1ldGJyNvsLV2LDGjUrRlTkc
X-IronPort-AV: E=Sophos;i="5.90,201,1643670000"; 
   d="scan'208";a="27496529"
X-MGA-submission: =?us-ascii?q?MDGx7vZ9Oyf8vsNkhNTyBgESOhRoqX7D8F+pGs?=
 =?us-ascii?q?tDIj2dPuAQ/fw8lJlys8f0Om5nAIKyrY7IupWNYVdXwiL6QnFhy6w3kl?=
 =?us-ascii?q?3FcIAPiAIdc7L+6+62X3t7YqxCDtDSSc9o70zU+FOi1l+wBv1QmslRG9?=
 =?us-ascii?q?2+esrJbwOYGls3esWeI2weLg=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 15:30:43 +0100
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 0535A40282;
	Tue, 22 Mar 2022 15:30:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1647959443;
	bh=6lY6qaq5CPO3sxa8p1b/IBP2TthPIqi4u0V60bEsENs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=2eyPwgco41ZYbbOAYxkb0CfMPWnuqF2NRmvj10yfXntL5KJ0tYKMoBKr7jN9Wqa+h
	 0YCEdlZqOsktEZJRAhoPqwdM3feh7ESbsMvt/DYO+WZNVmsmcKPTtgPKyiMOmmENhD
	 4j+8slvitxdjqsaHQVhlLHQv+AyZaD3ahf0f/0KxhPZZVH/yr5LIefU4wXWO45UIep
	 51nYHzYSPBZFBy0+Dkri3psrHQCMghBH0XaHgiEqotc1lvimNH/7pygwGshCErahYn
	 VtBTPd5z+1VcEeHVWv2PoOhCIfFxhiawGzdkLuuDDv+7LDlqjrF/2PkswXGRs9uqrp
	 FPMS5Fm5qEp4g==
Received: from mailhost.u-ga.fr (mailhost1.u-ga.fr [152.77.1.10])
	by mailhub.u-ga.fr (Postfix) with ESMTP id 03C2110005A;
	Tue, 22 Mar 2022 15:30:43 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhost.u-ga.fr (Postfix) with ESMTP id F2C9860067;
	Tue, 22 Mar 2022 15:30:42 +0100 (CET)
Received: from [192.168.1.50] (lfbn-lyo-1-509-171.w2-7.abo.wanadoo.fr [2.7.96.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 708B74007C;
	Tue, 22 Mar 2022 15:30:42 +0100 (CET)
Message-ID: <b77b2358-50fb-69ff-3205-52781e6bf405@univ-grenoble-alpes.fr>
Date: Tue, 22 Mar 2022 15:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: fr
To: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (41)
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 195.83.24.62
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 284
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/b77b2358-50fb-69ff-3205-52781e6bf405%40univ-grenoble-alpes.fr>

For the record, is it the expected SmPL ?

@ fu @
identifier F,file_chooser;
parameter list PL;
expression list EL1, EL2;
constant U =~ "untitled";
@@

F(PL)
{
     ...
     file_chooser = Open_Filechooser(EL1, U, EL2);
     ...
}

@script:python py@
U << fu.U;
C;
@@

print U # Rewrite U to extract the extension
coccinelle.C = cocci.make_expr("\".gplot\"")

@ replace_untitled @
identifier F,file_chooser;
parameter list PL;
expression list EL1, EL2;
constant fu.U;
expression py.C;
@@

F(PL)
{
+   char newfn[PATH_MAX];
     ...
     file_chooser = Open_Filechooser(EL1,
-       U,
+       get_nec_filename_stem(newfn, C, PATH_MAX),
	EL2);
     ...
}



-- 
Nicolas Palix
