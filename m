Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02CFC7EE22
	for <cocci@archiver.kernel.org>; Thu, 11 May 2023 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vI+ZbZ+xQD/T1koQjbckTSXUFM61OOaof8vAy7/Pjt0=;
  b=f0/aZVYkpwZYO3JF5W8VsSmEaan1mGWU7zq7HbKGE4p3oCDZMuBZoWBS
   3jxGrqQRiUmbfu8KzPfp7xdwNpkDtydQPTuN6VopYr86ma9NkHgCdmceH
   havrpGw88FUguT1CD8rRj4TdP835noyH1ruey59q2rLjA2dTbqIzLTV98
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.99,266,1677538800"; 
   d="scan'208";a="107456396"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2023 14:47:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AC686E0D50; Thu, 11 May 2023 14:47:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E570E0D4C
	for <cocci@sympa.inria.fr>; Thu, 11 May 2023 14:32:45 +0200 (CEST)
IronPort-SDR: 645ce06d_LVvg15zb3w855dE7f1ORmfXZhQaAg8A+Zfi765c5aw2UNw6
 8BdUVZJ9vVtkVTibeU/MFlxHrDWYXS/DR2+dFHg==
X-IPAS-Result: =?us-ascii?q?A0HQBwDP31xkfzXQVdFagQmBT4IugUsvBFGNToZIJwMGj?=
 =?us-ascii?q?SOCGoQufIpAgUA+DwEDAQwBQgIEAQEDBIR/hVUCHQcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEiGQcODimFaA2CNyJ9TQM4AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQQCLDoBIRYVEwYBG?=
 =?us-ascii?q?x0BAxJuEQEFARZBhQQBAzEDBJ43gQRCizGBARYFAhaBAYIJBpwOChkoDWyBW?=
 =?us-ascii?q?wIHCQEIFoEahEEjgm2FPYNOgSGBAxWBEIEViHqFdQSZMwkBAwICAwICAwYEA?=
 =?us-ascii?q?gICBQQCAQUCDgQQAQECAgEBAgQIAgIDAwgOEwMHAgEGBQEDAQIGBAIECwIFA?=
 =?us-ascii?q?goBAgQBAgICAQUJAQMBAwEMAgIHAgMFBgQCDgIBAQMCAgINAwIDAgQBBQUBA?=
 =?us-ascii?q?RACBgQHAQYDCwIEAQQDAQUHAwYDAgICAggEEgIDAgIEBQIEBQIHBgECBAQFA?=
 =?us-ascii?q?gIEAgQDGwIDBQMOAgICAgEJCwIDBwQDAwEFAgILAQMYAwICAgICAgEDBwoEC?=
 =?us-ascii?q?wIFAQIBBAsBBQENBAICAgICAwIBAQMGCAYDCgIFBAMDBgkPDwgDAwEEAwIDA?=
 =?us-ascii?q?gEIBwIDAgIECAIDAQICAQYCAwECAgECAgELAQECAwUCAhEBAgICAgIBAQIDA?=
 =?us-ascii?q?gMBBwECAhwGBAUDAwQCAgEEAQIGBQsCBAMBAQECAgICAwIKAwUDAQYDAwoHB?=
 =?us-ascii?q?AEIAgUDBAIFBgQGAgICAgIBBAEECQMEBAMDBgMJAgIMAhQCEgYBBAsLBAECA?=
 =?us-ascii?q?gINAwQGAgMDAgUIBAICAgICAwYCBwQCAgMDAgIDAwcDAQICAgMBBAUGAwIEA?=
 =?us-ascii?q?gECBAICBgMEAQcCAgICAwICAwMBAgEGAwICBQICAQgCAwICAgIDAwwBAQECC?=
 =?us-ascii?q?QIDAQEBBQQCAgQEBwECAgICAgwDAgICAwIEAwICAxIDAgUCDQECBAICBgICA?=
 =?us-ascii?q?gICAgECAgICAwUEAQIDAwIEBQMDAgIDBAEDBAEHBAICBgICBQYCAgUDBAECE?=
 =?us-ascii?q?gMEAgECAQECAwcJBgIJARgDAgQCBQMCAgMCAgECBwICAwICAgICBAIIAgUSA?=
 =?us-ascii?q?gICAgMCBBECAgQHBAIGAgIDAgIDAgYDAw0BAQECAQsFAQYBAgEDBAMDCgQCA?=
 =?us-ascii?q?gICAQECAQMCAgQBAgEBAQIHAQoKBgQFAQkIAgEBAgECAgQCAwYCAgEIAQgFA?=
 =?us-ascii?q?gIBAQEOAwEDAgEBBwcCBAIEBQIDBAICAgIEAhYHAQICAgIFAwQEAQIBAgMJA?=
 =?us-ascii?q?QEEAgQDAgIBAQIBAwIBAgICAwIFBAMDAwIEBAICBQECAQIEAQMCAwIDAgMDA?=
 =?us-ascii?q?wQCAQICAgEBAgEVAwMCAgIEAgIDAwMDAQ0DAQMBAgQDAgICAQMRBAIEAQIBA?=
 =?us-ascii?q?gEEAQMDAwIGAQIRAgMDAwEEAQIDAgICAgICAgIFAQYBBQYHBAIBAwMCBQICA?=
 =?us-ascii?q?gQBAgIFBgcKAwICAgEBAQECAQEBAQECAwUDAgIBAQICAgIDBwIBBwIJAgIBA?=
 =?us-ascii?q?QMCAQIBBwoBAgEDAgICAgIDAgUCAgIBAgEPCwIBAgcBAQYDFwISBAEBBwUDA?=
 =?us-ascii?q?wYHAgUBAwUBAgICAwUEAQQDAwIDBQICAwICAgMCBhkMDwMDAiADRB0CCQMjD?=
 =?us-ascii?q?wMLCQgTFygGDAcyBDQBFBEHBwYmBxcVCQUKBCYhAwMcAQQBDgICAwMBAgMFA?=
 =?us-ascii?q?QIDBAIBCwICAgIJAgoDAgMBAwUBAwIJAwEFAQIHAgYBAQECAggCCAIDCwEDB?=
 =?us-ascii?q?QQCAQICAQUCAQICBQMFAgICBA0CBQICAgQBAgcEAgICAwECBgUBAgcHAgUCA?=
 =?us-ascii?q?gMDCgQEBwQBAgIBAQUBAgEDAwEEAgECBQMGAgICAgECAgEBAQgCAgICAgIDA?=
 =?us-ascii?q?widORN5l3yNHaEBB4QFhA6cZk0TlnuSPZgFol2FJwIKBwYQIxKBLjqBXDMaI?=
 =?us-ascii?q?4M3TwMZD44sFoNRj3s/NDsCBwsBAQMJhUMmEwsBhT4BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:1XLRaa3IuxdKoQFS9fmLcwqjBIMkLtp133Aq2lEZdPWaSL39qy
 nIpoVh6faUskdoZJhEo7q90ca7MBDhHPJOkOss1NSZLXDbUQmTXedfBOLZqlWKexEWntQ96U
 4KSdkYNDSfNykesS842mWF+hQbreVvPJrGuQ4W9RlQcT0=
X-Talos-CUID: =?us-ascii?q?9a23=3AdxkBi2kv/m/1a4JoDammZsTuYknXOXLawU3XIxP?=
 =?us-ascii?q?oMkNoQaC3TBi58b5at9U7zg=3D=3D?=
X-Talos-MUID: 9a23:IdauUgh3wsaZPmRWRwaGXsMpBPU2zfmKClIxiYgr6saNMn0rYCe4tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,266,1677538800"; 
   d="scan'208";a="107452236"
X-MGA-submission: =?us-ascii?q?MDGhZ52wsStCxfHMFO9/70QTQD5RyUj6dbP68B?=
 =?us-ascii?q?8vwZRJbBc5HpcYMh2QqEwXselVCmreobdddw0Zc6uDWAUFmS5qFYmfL0?=
 =?us-ascii?q?WPA1pM7Wb2U998reW0B4bSf+I/P2sbTUIXwHvziBjViLVObYCLCMDSCo?=
 =?us-ascii?q?UdhUROW25hREGy6hjHAiLmWw=3D=3D?=
Received: from mail-ed1-f53.google.com ([209.85.208.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:32:45 +0200
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so15766970a12.1
        for <cocci@inria.fr>; Thu, 11 May 2023 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683808364; x=1686400364;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI+ZbZ+xQD/T1koQjbckTSXUFM61OOaof8vAy7/Pjt0=;
        b=W73P55rL2j7g3+HdgrLpVkaiQRl8Fe2if+SIyMnaznPINjNR3a7S/CKmyUEaKOkg4f
         xq1w1qg2pps0naWSE7pz3OIdMfZpBQRuFqXavNoIoxwhQ67GMRb7xi6DAZHDT4LYvtIp
         BRSC68tLYoLJNdBlEU5Gq9ZuwLJyhB6g2ShAcCSTcQ+ThOwqpvb0L5SccpljfY5Ic0a6
         7ANY4Hlogz8mQTt6VXOJDqrp8nPPlQVfO8qT+tE2hgNiXPZAdiM2bGc1kuNSae0lNU8r
         JPMh5iGCn88hS7n9lTcWbQAbamY05XduXD6gqT446gylXeu4SnN6B6phjxxwfOYxYlpZ
         hMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808364; x=1686400364;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI+ZbZ+xQD/T1koQjbckTSXUFM61OOaof8vAy7/Pjt0=;
        b=MOu+tXOalUdb5kDQcqHOVHiqMS/b4MJqLTBM7JxMwmkvgroOpRwKGmDoDPcwqzS82W
         48mugHQMVz1C/+CJIDg27pyE7GaQ5lsux8byPhZwa6bVXK5Ah+OU4Z0a9Yw5+JxlNxXt
         bWMU9wAPIfQSryaSB8PUxkrqCbY7Sc9hH/+PVr8yJ2OhI4ZY2Ga/QhDZf6jMcrRhg73n
         zgBCJu8B08OTKgLT1pKLJ2NBWEgVbK6DTiBg5QKi9zCp2AA6VdcGGXRoTWBlYvsl41Bj
         Cabq1pTF5Jpx9P8XOd8WvvTQ8KSyfouwrJhld1swF1U8UD2kRAupQkab+sO4vBRtKR42
         H17Q==
X-Gm-Message-State: AC+VfDwS3wodwcEjnF5hT7wT0XFGj3JuG04tFdygx/hLeePWz2t3leIO
	RDrApsbyHAf3ANvioGqqJcb+qc9/A84=
X-Google-Smtp-Source: ACHHUZ4odGiShNWwyOzjGpIlXwgHDbKFOHVvPwmT6gDyxj+GtADwgZitMxLNnIAogq8P/27QV25VJQ==
X-Received: by 2002:a17:906:7312:b0:961:800b:3f5e with SMTP id di18-20020a170906731200b00961800b3f5emr19058262ejc.72.1683808364220;
        Thu, 11 May 2023 05:32:44 -0700 (PDT)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id hb38-20020a170907162600b009661cf921b4sm3852159ejc.202.2023.05.11.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:32:44 -0700 (PDT)
Date: Thu, 11 May 2023 14:32:09 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: cocci@inria.fr
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Message-ID: <20230511143209.23065a5e@nbbrfq>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] parser error with loops
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1143
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/20230511143209.23065a5e%40nbbrfq>

Hi!

I'm encountering parser errors with loops.
Is this a known limitation that is maybe fixed already or am i doing
something wrong?

$ for i in /tmp/dummy-1.cocci /tmp/dummy.c ;do echo "# $i";cat $i;echo EOF;done
# /tmp/dummy-1.cocci
@ rule179 @
expression V, IX, INDEX, VAL;
@@
- for (IX = 0; (IX >= vec_safe_length (V)) ? false : (((void) (VAL = (*V)[IX].value)), (INDEX = (*V)[IX].index), true); (IX)++)
+ FOR_EACH_CONSTRUCTOR_ELT (V, IX, INDEX, VAL)

EOF
# /tmp/dummy.c
int i;
EOF
$ spatch --c++=11 --smpl-spacing --in-place --sp-file /tmp/dummy-1.cocci /tmp/dummy.c
init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
minus: parse error: 
  File "/tmp/dummy-1.cocci", line 7, column 0, charpos = 221
  around = '',
  whole content = 

$ spatch --version | sed 1q
spatch version 1.1.0 compiled with OCaml version 4.11.1
# off debian


PS: i get a similar error for other kinds of loops:
@ rule428 @
expression NODE, VAR;
@@
- do { tree var_ = (VAR); SSA_NAME_CHECK (NODE)->ssa_name.var = var_; SSA_NAME_IS_VIRTUAL_OPERAND (NODE) = (var_ && TREE_CODE (var_) == VAR_DECL && VAR_DECL_IS_VIRTUAL_OPERAND (var_)); } while (0)
+ SET_SSA_NAME_VAR_OR_IDENTIFIER (NODE, VAR)


thanks,
