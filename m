Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12366F459F3
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2026 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eTlXD+fEi5OyNbu4TxRTwpDmEzFd2ThBwniicSqJG9M=;
  b=a3tT0ol7t0BGw9cn2RzKx8d242EKI0T/PZ67QA8e/XSPsxvxEglp/i0q
   R+LEEb/p8JHwhqhQwwM4LrDSNXhu/7SUCwa6LjBV6niIMrrykZZJk0eCb
   NZHhl399WaTgHdzhfVJpqlj8OevCEBk+HFTcJlg6xWtuLkTKJpvYsCFfm
   8=;
X-CSE-ConnectionGUID: dfWJlLdPQsqwP8Wcxnaa8A==
X-CSE-MsgGUID: x8Yu6NbgSTeLFD3WAHQjJw==
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
X-IronPort-AV: E=Sophos;i="6.23,171,1770591600"; 
   d="scan'208";a="271909952"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2026 17:26:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 415C382B01; Fri, 10 Apr 2026 17:26:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id ED31082980
	for <cocci@sympa.inria.fr>; Fri, 10 Apr 2026 17:19:09 +0200 (CEST)
X-CSE-ConnectionGUID: 2J41/A1+Q3m+zfTjHqVAIQ==
X-CSE-MsgGUID: 1KKYwGI9SgGyubctqLe1jw==
IronPort-SDR: 69d914e7_izBKb5ZXneD1ECRIrGXtwg4wivSPQnan/4GR1iiIPW93gTj
 oSUs+pva4yqof4MJlaat6DoZtzpKeCVZG/79Y3Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAgBRFNlphQscCRJaglmCQUEBgSQnDAQLSYRYiHuIf?=
 =?us-ascii?q?JxFgVWBfwYJAQMBCwEBUQQBAQMEhHwCAgKNLB8HAQQxCA4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBFwIUdwEBAQMjDwENAQE3AQ8LGAICGA4CAisbEAYBE?=
 =?us-ascii?q?oMCgiMCBEsDAwK1LIEygQGCDAEBBtwTAQmBdAkVgQouiFcBgXCDEloaO4Q/Q?=
 =?us-ascii?q?oINgRUygng+iB6CaYESgRSBDoUHhUWFMwk/Cnh4LAFVEw0KCwcFYUIQMwMgC?=
 =?us-ascii?q?gsSEhQEFQIUDRASDwQWBS0dcAoCJxIPHRcVH1gbBwUSISpug3t2Ll4aDiICO?=
 =?us-ascii?q?QMyBCNKPgtSBYF2AoEdgQADCxgNSBErATcGDhtBAUAuB4sFJYI2ApsRr1YKh?=
 =?us-ascii?q?ByBX6BGg3EBpnkuh2WQcyKodAIEBgUCFwGBagM1gVxyE4MiTwMZD446hFKOU?=
 =?us-ascii?q?7A5JzU+AQcCBw4CgXOEXotWgUsBAQ?=
IronPort-PHdr: A9a23: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
 Viw3Oc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:f+MfY6naARumRXjxq3cAQZiYO1vpDfIp3DAbv31ZSRFFG/FwWf
 rBoB19726MtN9xYgBHpTnkAsO9qBznlaKdjbN8AV7mZniChILKFvAE0WKB+UyCJ8SWzIc0vs
 pdmupFebnN5DNB7PoSjjPWLz9Z+qjkzJyV
X-Talos-CUID: 9a23:DIKp3mzKXKiinLovVCfMBgVOOJx8NVSEj06LJgyqB1praKSrYH6prfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A/Mk/JwzKJ/lE3DZsU8ldWvWMbymaqP2NK3ESvrR?=
 =?us-ascii?q?XgMarJDF6MCuEqDnuQJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,171,1770591600"; 
   d="scan'208";a="271907955"
X-MGA-submission: =?us-ascii?q?MDHV49e1fMq6W6Fe4TVozVFc8Rw3szdzYXoOd7?=
 =?us-ascii?q?12O+zZ2aQAfOIJElwgxD4dHzK6AUao/2Wh5yVLpz4rhx6KEPOqBkzjIB?=
 =?us-ascii?q?FJZBmN8wNoO+VI6vBL6MsOxxMuK5vfYnbLnOYNgAsGzURImpjdGUzWZK?=
 =?us-ascii?q?ywbNUYiNTbSa4yY+dk4Wy7jQ=3D=3D?=
Received: from outgoing-auth-1.mit.edu (HELO outgoing.mit.edu) ([18.9.28.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:19:02 +0200
Received: from trampoline.thunk.org (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63AFIonm015842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:18:51 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0D7462E00E1; Fri, 10 Apr 2026 11:18:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
        bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
        dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
        gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
        sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
        Philipp Hahn <phahn-oss@avm.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Date: Fri, 10 Apr 2026 11:18:40 -0400
Message-ID: <177583430870.2758959.6171961359325912353.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-4-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 04/61] ext4: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: "Theodore Ts'o" <tytso@mit.edu>
X-Loop: cocci@inria.fr
X-Sequence: 3475
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/7lTN3FDgpX5bFgMShl_gdA>


On Tue, 10 Mar 2026 12:48:30 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.

Applied, thanks!

[04/61] ext4: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: 1d749e110277ce4103f27bd60d6181e52c0cc1e3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
