Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069B9C624D0
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2026 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=auNTCVflYZShTS7KADF5m5ds6o48u3ykktX+sl6GW5A=;
  b=CdeADLXqS+giL9SUQ7KyfrI/uLZSbSSrNIc15FajtQJFSUqHjLBUjSjy
   4sgNhU5dZDNjodPLyE/PknPqMBGANuB3ucAEMa4MP2LCnc2iT5sMdAvRg
   I8EtDlrKMCf6gWIhYodBH6ucorEapUdCgC7RVm8JyZlc9wU3c6VX2+RkB
   4=;
X-CSE-ConnectionGUID: CVVTAzMJTpObSbm/rUqgJQ==
X-CSE-MsgGUID: UHWYlOcSR0SEJnuVwhp0xg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,257,1779141600"; 
   d="scan'208";a="292798087"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Sep 2026 14:51:52 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6DD4E80E90; Wed,  2 Sep 2026 14:51:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7FBBD80712
	for <cocci@sympa.inria.fr>; Wed,  2 Sep 2026 14:51:48 +0200 (CEST)
X-CSE-ConnectionGUID: XjNi/LgBQvOlEL/rlUb2kQ==
X-CSE-MsgGUID: rMd6dBv7THWpt7IeEdVZJQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779141600"; 
   d="scan'208";a="155702941"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 14:51:49 +0200
Message-ID: <bf3e5e59-ddb8-48fb-b943-b389025219ce@inria.fr>
Date: Wed, 2 Sep 2026 14:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cocci <cocci@inria.fr>
From: Victor Gambier <victor.gambier@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Coccinelle 1.3.3 release
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3727
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/ieQQI8pvckrxjLvMYAvSpg>

Hi everyone,

We are releasing Coccinelle 1.3.3.

This is a tiny update. We decided to release it because it includes a 
performance improvement by Denis Efremov that may be significant in some 
workflows, and we wanted it to be made available now. Here is the 
changelog:

Bugfixes:
- Improve performance with satLabel cache (thanks to Denis Efremov)

Victor

