Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E777C0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mfgMtsMSJXsNeZMLC/V+ztuX0rE0JE0HI5uwi/gLUP4=;
  b=MsLTqf6aFwO9FHIsgj4LrahpYmCig8aR48glYIZ/cr72BSwY1aww58yj
   /ZUJ9wxKEPFVFcaot/TszZU3VW1w2mhG044JCjRz+cKqD41QEWWU+eL/y
   Txx0+i13LefjezrOOtoDETxwxCY7vfeZb9gYP5AF2YpVQt12IskDuRbvM
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@synchrotron-soleil.fr
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207777533"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 19:04:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAFC0E0D1D; Tue, 11 Feb 2025 19:04:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 09837E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 18:59:38 +0100 (CET)
IronPort-SDR: 67ab9009_TzWUn0i82054cq/mhxOBNzQ/OK8MPNJf0+Vv10QiJzeT45G
 Z1qg/iFZvhg4oK3yybJhihaGmP9ekgAUmUVuSpQ==
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="108820185"
X-MGA-submission: =?us-ascii?q?MDG/sTD/XhWNCO0ZVDEG1lvbElq7nHWLuEQlT+?=
 =?us-ascii?q?x9F3PJfVp69Q4tMQgroJJwWs4boDjABKV8+6v9H1Arfc9/Co5YtN2lOv?=
 =?us-ascii?q?BqqqdcVwoyX9Wf1dP04iC6tb7qZM67gzvXj87kJRpuRzI5m4yPj2FKfn?=
 =?us-ascii?q?3aPxbavAdXGttam90jjf6Riw=3D=3D?=
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:59:38 +0100
Received: from zmtaout04.partage.renater.fr (zmtaout04.partage.renater.fr [194.254.241.61])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id 7238DBFA85;
	Tue, 11 Feb 2025 18:59:35 +0100 (CET)
Received: from zmtaout04.partage.renater.fr (localhost [127.0.0.1])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTPS id 6ADCC140328;
	Tue, 11 Feb 2025 18:59:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTP id 56A62140395;
	Tue, 11 Feb 2025 18:59:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaout04.partage.renater.fr 56A62140395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=synchrotron-soleil.fr; s=9F6402A8-1C0B-4606-AB49-0E95EABF6935;
	t=1739296775; bh=mfgMtsMSJXsNeZMLC/V+ztuX0rE0JE0HI5uwi/gLUP4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=C5WUuxzkmPFqBKX0/dmZWOa5oenwlC4CcT6Ka5a+8kDg04CIiiNt0xZSG1BvBopp+
	 ugPLSUpMt0jWEYleF7D/JAHaydSGYU0awzDudBMhgUjiYP8jvv2gQJ8VnuNs8fPEvy
	 SCyvFphCLeYbvq/7dvvh3FBdH2lmPBvChEQuw5+Yiqj3+zdgujDPF6Vt7WGfIl9FKe
	 rc+qNm21UXAYvNlQupNibWaB3ajFz8sNuw6Od4PP4MM9zrk5ohdiz23zI2jYia0uLq
	 lxgRohEy+RcXRsZ7WGXYX7mFVmg4aQL9K/ROwSBpdSzcCf+ZH2ROD8B11efAgsVwqq
	 GNdYftuGsPC1g==
Received: from zmtaout04.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaout04.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id z6ngfVoYDi9I; Tue, 11 Feb 2025 18:59:35 +0100 (CET)
Received: from zstore-b3-012.partage.renater.fr (zstore-b3-012.partage.renater.fr [10.254.240.145])
	by zmtaout04.partage.renater.fr (Postfix) with ESMTP id 373E2140328;
	Tue, 11 Feb 2025 18:59:35 +0100 (CET)
Date: Tue, 11 Feb 2025 18:59:34 +0100 (CET)
From: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Message-ID: <1915985522.54632518.1739296774884.JavaMail.zimbra@synchrotron-soleil.fr>
In-Reply-To: <78c94b6d-23aa-fe7c-72e5-3edef225adf@inria.fr>
References: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr> <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr> <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr> <78c94b6d-23aa-fe7c-72e5-3edef225adf@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4652 (ZimbraWebClient - FF128 (Linux)/8.8.15_GA_4652)
Thread-Topic: how to write an spatch in order to replace guard vs #prama once
Thread-Index: wpuuK9tbmCI8X3GQ2u2qV5dWz/ydsw==
X-Virus-Scanned: clamav-milter 0.103.8 at clamav01
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefkjghfufggtgfgofhtsehtjegttdiitdejnecuhfhrohhmpefrkfevveetucfhrhgvuggvrhhitgdqgfhmmhgrnhhuvghluceofhhrvgguvghrihgtqdgvmhhmrghnuhgvlhdrphhitggtrgesshihnhgthhhrohhtrhhonhdqshholhgvihhlrdhfrheqnecuggftrfgrthhtvghrnhepleefkeeujefgjeeigefgffffudegheefgfeffeethfetkedtiedvhfeijeeifefgnecukfhppedutddrvdehgedrvdegtddrudegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvdehgedrvdegtddrudeghedphhgvlhhopeiishhtohhrvgdqsgefqddtuddvrdhprghrthgrghgvrdhrvghnrghtvghrrdhfrhdpmhgrihhlfhhrohhmpehfrhgvuggvrhhitgdqvghmmhgrnhhuvghlrdhpihgttggrsehshihntghhrhhothhrohhnqdhsohhlvghilhdrfhhrpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepjhhulhhirgdrlhgrfigrlhhlsehinhhrihgrrdhfrhdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to write an spatch in order to replace guard vs
 #prama once
Reply-To: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2413
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1915985522.54632518.1739296774884.JavaMail.zimbra%40synchrotron-soleil.fr>

> I'm sorry, but I doubt that it will be possible.  The treatment of #ifdef
> etc is quite limited, and there is nothing to match the #ifndef up to the
> corresponding #endif.  Coccinelle parses the source code, and these
> preprocessor options can appear in places that don't really follow the
> parse tree structure.

snif ;)

have a good end of day.

Fred
