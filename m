Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D23C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2Nu18HOdOOEr8quyLdgCS5DSPREXeqqtf0mGAF0bPbI=;
  b=ffTDThAGQgyqK9PKijwrPPSpYjPC4D6KQ77zTbGxlS+W/Yla0xB2Ut6V
   hLbAurvXMdyNK2qO0WJCHA4LjmY009+rzYpMssQP42dizRRrDcG+bHu9q
   0knnU3QG7VhnGV8vP0shdsY799ZJCNsk5Ck0rXO43K+6/auqIP0YxSt+5
   s=;
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
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207464371"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:23:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DC579E0D21; Mon, 10 Feb 2025 12:23:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2B495E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 12:23:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=2Nu18HOdOOEr8quyLdgCS5DSPREXeqqtf0mGAF0bPbI=;
  b=hSTT+i196pZr8MTGUq4AVtV0nCXbmDUfKGKMOU8kq70ehuxO0FrMSyOP
   r/qEizfetKHfoWIDF6YacwEbXO/RNRwHQXiicK59zuuUrPvXaAyZnpKt2
   Jstaa9KOJVcA8zbkD80bpwSk80m9YRbK9BcrRyg1EDjv2LyzfqPry11eu
   U=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207464362"
X-MGA-submission: =?us-ascii?q?MDFf5KzGt1okeBhQkmhhM15mStTMGtzczXV6Nz?=
 =?us-ascii?q?YNENuK/vBjZTRCBRmp1brp5LcnLN5Ehmzl+4xeGRakP0i79LplitWQPZ?=
 =?us-ascii?q?G9PMWe+12LdTYADQi85SPjpo6OCdGIH6s6L0rUvHWrBd7gN9PZF2oEuA?=
 =?us-ascii?q?8I1tblmBmQAmPTaHPRohxAbA=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:23:39 +0100
Date: Mon, 10 Feb 2025 12:23:39 +0100 (CET)
From: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Message-ID: <1948830352.8646779.1739186619092.JavaMail.zimbra@inria.fr>
In-Reply-To: <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr> <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.254.23.3]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - GC131 (Linux)/10.1.5_GA_4734)
Thread-Topic: Creating function definitions from function pointers in a struct with coccinelle
Thread-Index: /4nBg5NSLU6RdAqJUN6O/IsgbQYmaw==
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2389
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1948830352.8646779.1739186619092.JavaMail.zimbra%40inria.fr>

Thank you for your prompt response

> I'm not really sure what you are trying to do here.  Maybe if you could
> give an example of source code an the results you want to achieve that
> would be more understandable.
> 

I have structures defined as such in the code base but this is a problem for 
the work I want to do. 

struct save_ops {
    void (*start_copy)(void *data, const char *filename);
    void *(*copy_finished)(const char *filename);
    void (*check_copied)(void *data);
};

The aim of my patch is to define the following functions from the above struct

 
void hvm_start_copy(void *data, const char *filename);
void *hvm_copy_finished(const char *filename);
void hvm_check_copied(void *data);

void pv_start_copy(void *data, const char *filename);
void *pv_copy_finished(const char *filename);
void pv_check_copied(void *data);

The python m_rule I have permits me to match the list of function pointers
and the python script permits me to rename the pointers to the function names
as I have them here. Having at least the pv functions will be good for me. 

The issue now is to be able to write these to the resulting patch. 


Caleb
