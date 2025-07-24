Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C7C83F1A
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:content-transfer-encoding:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=ag7BAYZQfvgvv+5eXld2nGdP5pFdZquuYm4nQieYUgU=;
  b=FSKvPs8mN8LoChKqRDbDqtD6fjHowtS6KL+ON6Rs6mJ2UmWl0mSdPPVb
   S80CrXory770gPM3cfxf/sOCIys99zgUmPdxO1M9FDD5Oe1trKxfIBaRb
   1XecIdryPv3AsynIiFmvER+dmbD5afKAdzGKrkOE02SnQisSF5A1CyhZN
   s=;
X-CSE-ConnectionGUID: UOLXBx/eSCOMxj3tBA4Yxg==
X-CSE-MsgGUID: Z8MERlI+TFuW69KoBcGADg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chud.cyou
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232889459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 08:45:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 34310E0CD5; Thu, 24 Jul 2025 08:45:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 82CB9E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 08:45:02 +0200 (CEST)
X-CSE-ConnectionGUID: VBv7l04HTxGy8kS2mpUnFQ==
X-CSE-MsgGUID: T+jBCzVxQ2CwXeSvutwilA==
IronPort-SDR: 6881d66d_fyQw6zedSxyEFNfoNS+F0Nj2o7ywjIPI1bZ9wqJdYzY494C
 DOC0khLZ4FqmhL7Nzk4Ektd3a/TRiAYq+BUh67g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GcHwCm1YFo/yIc7sJaHQEBPAEFBQECAQkBFQyBSYJCg?=
 =?us-ascii?q?VkSIgcISYRViHuHQAwBhWePSocuhGQPAQMBDRQTKgQBAYITgnRRFYszIAYBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAoEKE4V7DYJFG?=
 =?us-ascii?q?oQtDwEFCAEBOBgcAiYCcwEBgn6CIgJLB5hFnEWBMoEBggwBAQaCadk7gUoaC?=
 =?us-ascii?q?YEbLgGFbIJkAYslgTtSgTyFEQGDBziDDoJpgiZEUopXhhOIMYFKHANZLAFVE?=
 =?us-ascii?q?xcLBwWBYwOBD24yHYEnhRiEJytPhRCBGYNTJG0PBoEYg0FAAgELbT03CQsbB?=
 =?us-ascii?q?j2TFYcAxwgFhCYFgV+DDJNNiR4GDwQvgUupIJkGqT+BfyaBWTMaCDA7gmdPA?=
 =?us-ascii?q?xkPji0WhAW/dkQyPAIHAQoBAQMJj3mBSwEB?=
IronPort-PHdr: A9a23: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
 G3ZrsNi5Vq3lfTdk1KPtTJFqitHwomaulgwYc3k
IronPort-Data: A9a23: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
 A3wUVY=
IronPort-HdrOrdr: A9a23:J0+egK5iMTgFXQPokgPXwPvXdLJyesId70hD6qkDc20yTiX+rb
 HXoB17726MtN91YhpPpTnuAtjifZqxz+8R3WByB9eftWDd0QOVBbpv54vv3DHscheVl9K1vp
 0QF5SWZueAamSSwfyKgjVQC+xM/DCcysyVbPnloEtQcQ==
X-Talos-CUID: 9a23:W0hJyW7uNKtpHh+7a9ssymQKRcR9Ll3h3FjBc0yDU2Nxdbu7cArF
X-Talos-MUID: 9a23:vA4mMQu/KJpMyKQTfM2nuHJgHux63bSXUmsSoZg9pdSYKi10EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232889450"
X-MGA-submission: =?us-ascii?q?MDGk6RICZGe5DzIRspzmtJHnq9n4UT3AwH67PI?=
 =?us-ascii?q?NCaD2kdGmMwrrnmCFWRZiBmtzekpv/QzBAAQrXEynqlCUO7/mIwno6LP?=
 =?us-ascii?q?AloP1zgy88JcCySotIx16xU7GkymFRVASB6/+YZ+pXfohmHntuAQBMIK?=
 =?us-ascii?q?mum2UntTBbzmlDs1BtYXoe6g=3D=3D?=
Received: from chud.cyou (HELO mx.chud.cyou) ([194.238.28.34])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 08:45:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1753339499; bh=rXdqnPDjyRUf6Qg7/Xv7bTGI0EUrOoCXNIWC9sBsIBE=;
	h=Date:From:Subject:To:From;
	b=ee8Ufz6lzHRcEsXTuZeyrFzJJX9EVi8dj5KhrmXh0tCh2sOhesMBiaWY8TYUEKEFo
	 q7dPXFAUBsOrMeaJXanCbn2+Gqyvbw9rFqF3c6lbtabkBGZkH6FQPGs4Uz33mWn5aX
	 PaKAKPNX8i6IWuz2fP5fVKDW/iE9pctJnWrK68ngnX4PmRLRoXHsxH8z+kpmovjrjh
	 LhKL3TjHYENO4jlwTxRgKr5nlM6R/aWn90HuuTzc48bMNLbBjrvW4rriTPaTFsZP+/
	 PGGfyWmgXRj5DTR1QFIegNfjMwCz/VWD/aNKvbdRWQpMPbg699XcqQG6fKTlpL/0A1
	 xd7II3JZyLrHQ==
Recieved: hidden
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chud.cyou; s=mail;
	t=1753339498; bh=rXdqnPDjyRUf6Qg7/Xv7bTGI0EUrOoCXNIWC9sBsIBE=;
	h=Date:From:Subject:To:From;
	b=N/gBbqUVSX6+k1Ud1lIfgsLFdy/w9QR+HbyIhxoecJ788qc6RIWMdWtID/ltRFaDb
	 QNsQFZPNFqpxgZE38il/3N8Btmsq9WQeX2ATXxUC84EpfMUiuh62yZvOLlHnmdEe53
	 yt3gAYYIZPfnyk0ouLoI3zFXzFp26jfCCDM4IItaItxlM8CNWT2YQrpYq/5vvYAgnO
	 x5SXQRaq8UCEK9y8KvL5ePKdl58ea998MCNiWjG3azNp7S2xvrsYpuy0vLaQjL00x4
	 qArZLY40EV9oW+G4uTZ9N/apemQmwYwo46V8kOacGt8zfbcjg2mvXw4ldETIFzpuUe
	 XNrMtEE67ukgg==
Recieved: hidden
Message-ID: <0ddb6d0c-b974-490f-b498-52e41c319368@chud.cyou>
Date: Thu, 24 Jul 2025 08:46:24 +0200
User-Agent: Mozilla Thunderbird
From: Anon Anonson <anon@chud.cyou>
To: cocci@inria.fr
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [cocci] Trouble replacing function declarations.
Reply-To: Anon Anonson <anon@chud.cyou>
X-Loop: cocci@inria.fr
X-Sequence: 2903
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/0ddb6d0c-b974-490f-b498-52e41c319368%40chud.cyou>

Greetings,

I am trying to introduce hot-reloading into a project.
This involves swapping out every function definition and declaration to 
function a pointer.
Here is a minified example of what I'm doing:

virtual def
virtual decl
virtual find_decl

// -------
@ depends on def @
type T;
parameter list ps;
identifier F;
fresh identifier F_fn = F ## "_fn";
@@

- T F ( ps ) { ... }
+ T ( * F_fn ) ( ps );

// -------
@ depends on decl @
type T;
parameter list ps;
identifier F;
fresh identifier F_fn = F ## "_fn";
@@

- T F ( ps );
+ T ( * F_fn ) ( ps );

// -------
@ depends on find_decl @
type T;
parameter list ps;
identifier F;
@@

* T F ( ps );


Example C input:


void f(void) {
     puts("...");
}

void g(void);


Now, `def` works like a charm and `find_decl` indicates that the 
matching part works,
yet `decl` yields (with --debug on; spatch version 1.3-gbaf73ae compiled 
with OCaml version 4.14.2):


dependencies for rule rule starting on line 17 satisfied:
binding in = []
binding relevant in = []
      transformation info returned:
           transform state: 1
                with rule_elem: -T  -F-(-ps-)-;
                                  >>> T  (*F_fn)(ps);

                with binding: []
      binding out = []
      transform one node: 1
SP line 25: Not found a value in env for: T


I would like to know what I'm doing wrong or whether on off chance its a 
bug.


Thanks for your time, amazing software;
Cheers!


