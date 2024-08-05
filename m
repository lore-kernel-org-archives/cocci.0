Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED08C3DA7F
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hWdjkVwqoyHEIxE8mgYnl2P+KJAqCTTx+T8p6v19MG0=;
  b=Xz3ZnUNfaS9WANlLtAI8vDknsM6KvTI/U2HGP8Hv2gauY1cGRyDyYpPz
   +Ed1I28XDQSMEZevQiHlni0QQur4VgU17if01Nr89xWfNxMctSWj1CUAU
   ArjR4Fth/lVbq3gJMHLAH0UvulkqOC0oAvsSFSVgX2/GryJePC/EMvLVP
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178113603"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 10:48:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58698E013D; Mon,  5 Aug 2024 10:48:38 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A716E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 10:40:02 +0200 (CEST)
IronPort-SDR: 66b08fe2_ZHzIJra3FQpmbKBbcFXEi1NqhLE+Lua68KMP/E782YxJdQy
 GO+49KGBvYhEVICkuftTLsje2VV1ZcYZgZgEBQA==
X-IPAS-Result: =?us-ascii?q?A0E5BACEj7BmgDHQVdFagQmBT4JEfVozBFOEVoh8hlCDO?=
 =?us-ascii?q?J58DwEDAQwBPQcEAQEDBIR6A4lOAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBC?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBOwcOEimFdQ2CYIEqgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g2BFhEdAQE4JQ8CJgIjEgEFAVeCX4JkAxGhVoEFQos7gTKBAYIMAQEG3B2BY?=
 =?us-ascii?q?wMGCQEKgQYugleFcwGBaoN4AYN8eicbgg2BFTWCPQeDUAQYghODDoJpkiaLe?=
 =?us-ascii?q?yZNj0gmCR0DBwcOK0kPBRwDWSECEQFVExcLCQVkiGeDLYIahBiFL4FrAQsBY?=
 =?us-ascii?q?IligT6BX4NBSoVmQgI/gmNXHUADC2ILPTUUG0ykP4VCyFeEH4RvhyWVPzODc?=
 =?us-ascii?q?gGTSZMCmHCNe5pxAgoHBhEjgVokLoEuMxoIKAhsBoIwTwMZD5cvwjVBNTsCB?=
 =?us-ascii?q?wsBAQMJjCSBSwEB?=
IronPort-PHdr: A9a23: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
 5UKR/lQU1lnTpvy5WxuHMYFJZZqW3Uji7HJ1aY1
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:Linq96+WCsL1fLh4yq1uk+ACI+orL9Y04lQ7vn2ZKCYlCPBw8v
 rFoB11726StN98YgBFpTniAtjkfZq/z+8N3WB5B97LN2mW21dARLsC0WKI+UyZJ8SRzJ8n6U
 6iScRDIey1I1xzjcO/xhK5HdYmyNzC1Kyzn+/RwzNMYGhRGsddBsVCZzpz3ncYeOCOP/RJdq
 ah2g==
X-Talos-CUID: 9a23:en+7wmGmPf+Owr6xqmJ46EMVJ/wPL0fn1XjuenKzF0FWYr6aHAo=
X-Talos-MUID: 9a23:6grlkwjnE0yiNK6ZXhJsT8MpBdV6/4mzNGUxoKol5+edGTRyJC+GtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178111119"
X-MGA-submission: =?us-ascii?q?MDGXg+bxOSclGeBTUQ0C/8jFUxbn12/aHf3oZ7?=
 =?us-ascii?q?0SC3buTndZab41dpeCEIyY8MrjS463+tGTjxMhrnJd9swGN1SVxfhV+y?=
 =?us-ascii?q?D0qmdjTB/OqchE1ESLyenPXpHFrl5gEBAqIifSrfeFJxtSZ7pLIQtbFJ?=
 =?us-ascii?q?wKbzw80F0adNMM96p0p6oXYA=3D=3D?=
Received: from mail-ed1-f49.google.com ([209.85.208.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 10:40:01 +0200
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so11767745a12.0
        for <cocci@inria.fr>; Mon, 05 Aug 2024 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722847200; x=1723452000; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hWdjkVwqoyHEIxE8mgYnl2P+KJAqCTTx+T8p6v19MG0=;
        b=ZT2W5c8uiHf+Au8FDOLRi1oIhtz4K1PM/JBLKU2TJnamHzNTtNbLogiEgBM4xfQeck
         l1d244F9PLtVSO8dDZNwo2cCoh2tYSQ8IkKOfakh+HcCbq9Er5haH6awH+qU0dXZcFZ5
         C0KpdvKyOgo4iwtZQipo7rpCFHQNRjoAJtDwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847200; x=1723452000;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWdjkVwqoyHEIxE8mgYnl2P+KJAqCTTx+T8p6v19MG0=;
        b=m/8vqcKM5t3LR43v+Aq0QNptxhLvzCXaM69B+HfEebTFrw1gO7sMd0Hb0dBEfxj067
         XYl1Xbqz2Mf4L2iWFtr/gWMtpryTJwXm1aajg94GMfGAODb4cn4zUyPjPB7Vf05p9GnA
         99ShUTyTEo4O+28Zk4nPhZOZIO92pZH9x+YUYw0koiDRDfHwhlZsl3zKWiBAZke289rp
         myA6wgx/19AYgWWoqm9+gbauirhyXyIRmFb2wMms5Mzl4jfrHqUW3XcsNqpeNZB1zMbb
         HA3gc1ebZHjmDEET+6j8Pthobh5S9I4fDn9f48BuAm6W2LrgvMXvi7xJj+s2doRqSk+o
         rpsg==
X-Gm-Message-State: AOJu0YysjLSflWgUmYNWgDRTqoNmt8fYXzviNy+F35qd8uyPlXToABzh
	PDepVLnTRqWlcz0VGNoa+JY64VX0XbV822GhNx7xI07KXQNaQTVrwiBwIsJm/Nt6YzbWgIiBPZE
	gJg==
X-Google-Smtp-Source: AGHT+IGquD95UB+8eGTVTiQ0+eNsbqS3YX8GNM/M/24WPMT6CH2SBjE14A5vKP5+beBw80Tf1YM4vg==
X-Received: by 2002:a17:907:d92:b0:a7a:b9dd:7757 with SMTP id a640c23a62f3a-a7dc4fd8a6cmr997230966b.12.1722847199978;
        Mon, 05 Aug 2024 01:39:59 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8cd5sm422631266b.213.2024.08.05.01.39.59
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 01:39:59 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so12740808a12.2
        for <cocci@inria.fr>; Mon, 05 Aug 2024 01:39:59 -0700 (PDT)
X-Received: by 2002:a17:907:6ea3:b0:a7a:a4be:2f95 with SMTP id
 a640c23a62f3a-a7dc4fdf818mr803310266b.5.1722847198833; Mon, 05 Aug 2024
 01:39:58 -0700 (PDT)
MIME-Version: 1.0
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 5 Aug 2024 10:39:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
Message-ID: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1830
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/CANiDSCvmboKBK%3DZ7uS9tnN_LcPA16rx0j_iWeEoQ%3DjO%2BpEgLiA%40mail.gmail.com>

Hi

Our CI went from 5:40

https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1225915/test_report?job_name=static-upstream

to 42:13

https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1235432/test_report?job_name=static-upstream

We launch cocci this way:

make coccicheck M="$dir" MODE=report

Is this something expected? Or shall I investigate at my side of the cable?

Thanks

-- 
Ricardo Ribalda
