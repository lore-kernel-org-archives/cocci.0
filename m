Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF113105A591
	for <cocci@archiver.kernel.org>; Thu, 12 Mar 2026 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
  b=FjiJVF5s5uyzmMfHlfXEIEvFcWVuJGXmNRAbcssCO+KvMjG+bh+R2MOu
   e4UtnYZ8dN7GJx8FKSLUBPgTZsEx0nk0RQYFWQ+ytvg4rUVTKJD9xXIWW
   tD/GNeUJGdVAbaPchGyWEBY1CV5L2kNsw4zq18CEcUQb+YUyGEwdb83DL
   4=;
X-CSE-ConnectionGUID: Sl1IT3bnQAGpWCsm/YrUEg==
X-CSE-MsgGUID: meukRxm9TCWi93+0Qv8f3A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267476755"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2026 13:58:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1E1C9834AC; Thu, 12 Mar 2026 13:58:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7E054834A1
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 13:57:33 +0100 (CET)
X-CSE-ConnectionGUID: CxXOJUapRkerAvaSIbgUyA==
X-CSE-MsgGUID: eeyzijs4SU2QqMJrPn/Dvw==
IronPort-SDR: 69b2b83d_ybVzDOAFr0749nVE7Jrubc7eyuix/F3nM9VTU3u9rtRzK2W
 9pPc4Q1HSfjL6qk8Dkw0ofQXblszDo31tSyksTA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FUBACbt7JpgaugVdFagQmBUIJBgWYzBFSUK1oBAQEGg?=
 =?us-ascii?q?UGLdJQjAg8BAwELAQFPAgQBAQMBA4UAAo0jAh4HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw2CWzuCFiwNfgEBA?=
 =?us-ascii?q?QIBEigGAQE3AQQLCzQSMwEFARwGDCmFAwEGIycDogSBAkKLO4E0gQGCDAEBB?=
 =?us-ascii?q?twqgWcJCQELAYE3iFQBhVoahAB6Jxt9gRCBFYE7gW8+iweCJnoUiQeKGlJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFB9YGwcFEiEqgUR4ggEPhmcBe?=
 =?us-ascii?q?QMuXhoOIgI5XDgSPgtSBYItAh4DC209NxQbBI8kPYIiE3oJgjN6xjeEJqFYB?=
 =?us-ascii?q?BYzl1KTGS6HVRCQc6kWAgoHBxEkgVokgVxNOIMiTwMZD44tFhyCbskeKTU8A?=
 =?us-ascii?q?gcLAQEDCYVFjFmBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Owj
IronPort-HdrOrdr: A9a23:BVsxl6i5GrWSDqtZQv3CvEY/sXBQXm4ji2hC6mlwRA09TyXBrb
 HVoBwavSWE7Ar5K0tQ5OxoWZPwMU80mqQFmbX5UY3SPjUO21HYX72Kj7GSuAEIcheWnoU2uM
 sOHckfeb7N5DNB/KHHCXyDYq8dKa68gcaVbInlvhJQpEpRGt1dBk9Ce3mm+5pNNXt7LIt8HJ
 SV/coCrya8eHgRc8SwDmQEWe+GvNHQiJf6e3c9dmsawRjLiSnt5K/xEhCe0BtbWTtLzbAu+X
 OAiQDj5qm49/G90ALV0GXeq5Ra8eGRtOdrFYiJkNZQKTnph0KuaJp6XrGeoTwvydvfnGrCvu
 O80isdAw==
X-Talos-CUID: =?us-ascii?q?9a23=3AVXjhwmjqI/OW63oDxBhl2wWK/jJuWW3t61XtKle?=
 =?us-ascii?q?CCmtzYaOccn6a9551up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALwkZZQ6GoV7Wwj1mwwoQxkGPxoxl7rW8CUIWza4?=
 =?us-ascii?q?74fCdEA5qAzHaoCqoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267476549"
X-MGA-submission: =?us-ascii?q?MDGSEPQwJ2yECpZlGI089II1JyQkiEZDsMZ2CS?=
 =?us-ascii?q?kwhZA/tVArQjYNazpFBMp9vTndwb22OpIPGCwyR90OWU3T9ntemW+LzA?=
 =?us-ascii?q?v7acXFOWpY84m5QjiD0uUD6NV6iVVo4WdrAlR1atjn9F+jvkEbV0T++H?=
 =?us-ascii?q?3HE78Ek8tDGRU7pPRvtYFIOw=3D=3D?=
Received: from mail-qt1-f171.google.com ([209.85.160.171])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:57:32 +0100
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5094b54a250so5475751cf.2
        for <cocci@inria.fr>; Thu, 12 Mar 2026 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320252; x=1773925052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1SF1XBHkHR0j7NZVucv0LxpGoGXl67PUefLsfwpAbo=;
        b=I0cTockelUPRnrUhyVcbY+nUZWVJbNx15LmjOCd4FaMTDC/68Ggt+Hmz+6lnkWSmEt
         uAWxR7G0egXOdeCPUNQxNNQKrM/hMSyohYFqMXsktK/EnDbEOT+/OEHswQjcF2+BEiK7
         aizp+wgUcQSHqUGAn9ZeYPNBHFOSUp5GDWsoaIx3ohcDJehgvKfd1PmH254FGhaDIxys
         FjUg3Z4nChn8DMrfRddraU5oSb7v2ECzUbZSGUKmZ86YsTYf2ItX7zPiLcXBsHHsCRNW
         WRsTtGYvi9a021nM0bYpnmTVikhhCP1bHzHXUMqqn21xu6ZZObQ+m9baBq4hsPJwMlTr
         zjQA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNp3gzFM2yN7tFEhOyqeG/xZMzmVCZ3tQXArOKEp/+5gpNO9Z1P4kjjI41V0vEu1HEWD88w==@inria.fr
X-Gm-Message-State: AOJu0YwYSWRBnknhCW9/zpLBVVb8FL/czIPTUJGA6FnExgd91O9avRpN
	1mp8sy9An86udHfGxIZyInW7eW4x8CeaJ62vB9Mh/H0zPz+sYw4F4hsXpoVD2oqDHeQ=
X-Gm-Gg: ATEYQzzJrSaDW81yvnlteqAUAXKHmZ37Q19lBBuUqooJQzKQagNpg860YYW5gffYWNK
	PvnZoDtjE8wpq9gh1y3H5LLqoX0pYFF9C0+eu4ulI3Lh8ZoomssGxMjQ7cpfkibr5lUqZEmlQQV
	2iDG3bTgP17HV7wcYR0iNCCWg9WBsbMFXLhXXyFNgHm//0vyQawAlS1HKtgIfId5x4KVfSwRdvW
	LeU/akwh/7n4C6eqHVB7PQ/btTwUuMuZxxDpV58sSqFO8UbvSm8k3C0/RD0kY2Ghdl43dI3VZlc
	05jSU9ofpqVDgbJ2oWVar+RDCu4OFASXvPLGmTHsI3W4Dm7xrBDX/zZG+uTFAHejtT0fg6oDvq/
	YKUw4atRhJDLnO02zc8XyUwh3bUMouxraEKIua383NMc0FGw8Wi8DMqpctwLFynEx8pglr5QtZB
	WwtnZrxQPTbE3RyF+iuFtij/TyN+9f7eC8UlFtDVaytgF3mopMIsdG2CGsll/nTP6R8BZpif/Jd
	ihyDMl2
X-Received: by 2002:ac8:5d4d:0:b0:509:cbc:127b with SMTP id d75a77b69052e-5093a1bd58fmr77950521cf.60.1773320251710;
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm33341196d6.8.2026.03.12.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:57:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fbW-00000006fKD-1POa;
	Thu, 12 Mar 2026 09:57:30 -0300
Date: Thu, 12 Mar 2026 09:57:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr,
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
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Message-ID: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBlpGKO842B3yl9@google.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: Jason Gunthorpe <jgg@ziepe.ca>
X-Loop: cocci@inria.fr
X-Sequence: 3419
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/FaUfWvrfF8y3O12Du7eAVA>

On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:

> IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
> flawed API design. It usually implies that the caller is unsure whether
> a failure results in an error pointer or a NULL pointer. 

+1

IS_ERR_OR_NULL() should always be looked on with suspicion. Very
little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
implies ERR and NULL are semanticly the same, so fix the things to
always use ERR.

If you want to improve things work to get rid of the NULL checks this
script identifies. Remove ERR or NULL because only one can ever
happen, or fix the source to consistently return ERR.

Jason
