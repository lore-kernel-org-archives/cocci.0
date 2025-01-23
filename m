Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9ECC02182
	for <cocci@archiver.kernel.org>; Thu, 23 Jan 2025 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dbfDJ/k09PVtgRlqpZDqymDGaVxZJA3ma97dfqcsdl8=;
  b=cZ8xF1RXBIvvgdBcWD50h1vbDtGRSACco2erOm3pt0cR3WpMnWJxX6dY
   hBB2TwF7QJNhOFk9qvui+W0kVClF9DBi7QY/UUNG9OHc+yHYdqdpHO6TG
   NhklCKmhlCZtCZe1jdLjL+5MylMY9sHcQp3DF1wsiyNZTZkIdXehCUEKT
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204679641"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 15:41:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 94168E0D1E; Thu, 23 Jan 2025 15:41:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 93159E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 15:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=dbfDJ/k09PVtgRlqpZDqymDGaVxZJA3ma97dfqcsdl8=;
  b=YphXPVJ7h+H85iWD+NdV6/gYUJrS8CB7nmijpKZkYCNBZtkkJvSMTDBE
   jxqzXcM2dpy0yqc1XiDWoIZKHl5adK6TKdJok1rAPturgzX63v72HYjoL
   PtmjFTRkCv7PGvpC3LQUfIXjOPl7/7qouCC56bGiB+8dHh5oHqwjlymLS
   g=;
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204679619"
X-MGA-submission: =?us-ascii?q?MDECtWvDdlGyUwzysxzBtlxef+aN/d0gMUlzIN?=
 =?us-ascii?q?xiwlxtrA0WhQeK92vlvVW6rjzw89DSRR6zMfmqZ4N3qB6av887bRvEJH?=
 =?us-ascii?q?rO72g0xnHpRxPRVWCz9KcB6RXfy/M2pYmmBlYV3g1f+/v9K6aNuVwbPo?=
 =?us-ascii?q?paaW7UDNV+tOgPaEKnX2gmVA=3D=3D?=
Received: from zcs2-store7.inria.fr ([128.93.142.7])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 15:41:25 +0100
Date: Thu, 23 Jan 2025 15:41:25 +0100 (CET)
From: Victor Gambier <victor.gambier@inria.fr>
To: Ricardo Ribalda <ribalda@google.com>
Cc: cocci@inria.fr
Message-ID: <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
In-Reply-To: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.93.66.153]
X-Mailer: Zimbra 10.1.3_GA_4699 (ZimbraWebClient - FF133 (Linux)/10.1.3_GA_4703)
Thread-Topic: linux-next: virtual rule report not supported
Thread-Index: uv2PjGpgrGulfGjDqPDpsuSgye4BSQ==
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2222
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/1176708922.5283093.1737643285348.JavaMail.zimbra%40inria.fr>

> Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"

That script was added to the linux kernel in December. Which version of Coccinelle are you using?

On my end, with Linux 21266b8d and Coccinelle d4309c2, the following command executes without error:

.../linux $ make coccicheck M="drivers/media" MODE=report

Victor
