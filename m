Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E1C0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4M3Rmr1YRhjDyjB4N8gbnQXWamjIxXzmPuauv0PR3vU=;
  b=cBeurH0fd/nyDd50RjOcIez+C2nSgfTiSvNuxEaXkcI/Otcg8zZvikMb
   nW8XGcNh3zzKJ6FBqQXElD7nkGzNf568vNUzhDH8H30QVhDxUtY6fM9ey
   gjgSrMNyRy991C9zPF8jC63EaXIO5XfFwXcgLI6vORFeUUnPbzW6Y802o
   g=;
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
   d="scan'208";a="207775808"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 18:50:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69D7EE0260; Tue, 11 Feb 2025 18:50:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AD45AE0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 18:47:08 +0100 (CET)
IronPort-SDR: 67ab8d1c_dNyaW0ML5ObzNoMLPb1K01sQnxFYP8UThMc7FVBKGPfvyBX
 vnPYtzoBHt0zZMRFeiIiJxpYLDQM2STCzQHtfjw==
X-IronPort-AV: E=Sophos;i="6.13,278,1732575600"; 
   d="scan'208";a="207775394"
X-MGA-submission: =?us-ascii?q?MDGVDo6MJnHcf9DPNzfRnZeAse3UlwbHwr7Rhy?=
 =?us-ascii?q?JOH3gjiz3+VAVsyPOm8MxoUb9JEdVRTjDV/en6bqyphx/ogUCFBl4BBy?=
 =?us-ascii?q?UKjzl1255Odzaa/cLOYgWZHJFOd6PAEoXeJkDeowfghNhiK3VuAkAjNh?=
 =?us-ascii?q?DC3T7/W0xKVpJb3Q+Xyw5Zyw=3D=3D?=
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 18:47:08 +0100
Received: from zmtaout06.partage.renater.fr (zmtaout06.partage.renater.fr [194.254.241.62])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id 89E7DBFCC8;
	Tue, 11 Feb 2025 18:47:06 +0100 (CET)
Received: from zmtaout06.partage.renater.fr (localhost [127.0.0.1])
	by zmtaout06.partage.renater.fr (Postfix) with ESMTPS id 82B771000B0;
	Tue, 11 Feb 2025 18:47:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaout06.partage.renater.fr (Postfix) with ESMTP id 7DF5D1000BC;
	Tue, 11 Feb 2025 18:47:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaout06.partage.renater.fr 7DF5D1000BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=synchrotron-soleil.fr; s=9F6402A8-1C0B-4606-AB49-0E95EABF6935;
	t=1739296026; bh=4M3Rmr1YRhjDyjB4N8gbnQXWamjIxXzmPuauv0PR3vU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=rfxXimkItqgi/IcCCR1ixKSF+Lx6kcdT042OaIHs3tFa+y3nE7fBiJl6R/c8FGa24
	 uyyrPeNKJDgZfNIb5tTO7zAXiPpMMV+fy33eUKMwUrIWn/5lbfYGoL8FV2g6fyPGA8
	 WMAzofr/R+HPjv90E80n0Ti6IXvIxJwP8xBMQOx9Ff8CvczNJLrv4fIIg+QLZh1GQu
	 KwTSmihPdiuiBEwBtPHGOAkM/RMMP4yXzMWiklzz390+uqtR/6lxHg0GMgyw+HDzw8
	 s87+u5Vqw9t6C68TINeI/EaMvAwsZztsyJaNr4XqhYmLss0EjX4C1nrT3U2/i+N53j
	 9A6+IHXlLCg+g==
Received: from zmtaout06.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaout06.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2NeKjpvtANaA; Tue, 11 Feb 2025 18:47:06 +0100 (CET)
Received: from zstore-b3-012.partage.renater.fr (zstore-b3-012.partage.renater.fr [10.254.240.145])
	by zmtaout06.partage.renater.fr (Postfix) with ESMTP id 67AFF1000B0;
	Tue, 11 Feb 2025 18:47:06 +0100 (CET)
Date: Tue, 11 Feb 2025 18:47:06 +0100 (CET)
From: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Message-ID: <1295029600.54623953.1739296026146.JavaMail.zimbra@synchrotron-soleil.fr>
In-Reply-To: <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr>
References: <537594832.54620672.1739295352359.JavaMail.zimbra@synchrotron-soleil.fr> <24871c64-9c5d-238c-201e-d76988bed1a@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4652 (ZimbraWebClient - FF128 (Linux)/8.8.15_GA_4652)
Thread-Topic: how to write an spatch in order to replace guard vs #prama once
Thread-Index: Sig9Fk/2KmMQYgdZ5I07VgF4v+xAWg==
X-Virus-Scanned: clamav-milter 0.103.8 at clamav01
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefkjghfufggtgfgofhtsehtjegttdiitdejnecuhfhrohhmpefrkfevveetucfhrhgvuggvrhhitgdqgfhmmhgrnhhuvghluceofhhrvgguvghrihgtqdgvmhhmrghnuhgvlhdrphhitggtrgesshihnhgthhhrohhtrhhonhdqshholhgvihhlrdhfrheqnecuggftrfgrthhtvghrnhepleefkeeujefgjeeigefgffffudegheefgfeffeethfetkedtiedvhfeijeeifefgnecukfhppedutddrvdehgedrvdegtddrudegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedutddrvdehgedrvdegtddrudeghedphhgvlhhopeiishhtohhrvgdqsgefqddtuddvrdhprghrthgrghgvrdhrvghnrghtvghrrdhfrhdpmhgrihhlfhhrohhmpehfrhgvuggvrhhitgdqvghmmhgrnhhuvghlrdhpihgttggrsehshihntghhrhhothhrohhnqdhsohhlvghilhdrfhhrpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepjhhulhhirgdrlhgrfigrlhhlsehinhhrihgrrdhfrhdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] how to write an spatch in order to replace guard vs
 #prama once
Reply-To: PICCA Frederic-Emmanuel <frederic-emmanuel.picca@synchrotron-soleil.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2411
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1295029600.54623953.1739296026146.JavaMail.zimbra%40synchrotron-soleil.fr>

something like this


// replace guard by pragma once

@@
expression E;
@@

-#ifndef E
-#define E
+#pragma once

...

-#endif


where the #endif is the matching one of the first #ifndef


Fred
