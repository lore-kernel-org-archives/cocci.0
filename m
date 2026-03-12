Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C512D105F791
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+eQe65zRbvRfUUTjQaiTy4y7ybT8nkDdQuy9ftpxsxQ=;
  b=ojZJFaxIbrtJs+moEYETBv50s9QJWibKtiQvn6ybj8jZzmlfMaJLhOAB
   x/VqPkYmoC0Qq0N8j1krtlOleIX56R78+JSe5bYDFErT30NsDCiRrJodg
   8v2nI4WmIY0TkHiSYXP3bN2hfblJdJ+yiUAoPSWmPidD3zioVIrXFCoFN
   U=;
X-CSE-ConnectionGUID: FkeM29+jQHa0UNXu/XrJEA==
X-CSE-MsgGUID: BfOxvU2oSPqtOZavS1LOKA==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267642866"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:19:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8A8F581D16; Fri, 13 Mar 2026 11:19:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B49378360E
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 16:32:43 +0100 (CET)
X-CSE-ConnectionGUID: f7HXTi3vR6eX7Ny3rT4n+Q==
X-CSE-MsgGUID: P0TpuFDuSN6NWbwhdvRHyQ==
IronPort-SDR: 69b2dc9b_+u/k04akZMCTurZ9rJ+3hCxxIMmw9e506cd9YbG4GX8354a
 GH8A2NYdOg3BUIX6NQQ7ik7RcX7r4Jc76aqJqdg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAgDl27Jp/61vJcZaHQEBAQEJARIBBQUBQIE/BQELA?=
 =?us-ascii?q?YFtUwc6ASZ+MwQLSYRYj1OCJBOcMoNUDwEDAQ1OAQIEAQEDAQOFAAKNIwIeB?=
 =?us-ascii?q?wEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAoEKE4ZPD?=
 =?us-ascii?q?YJbO4IWLAhjAQEeAQEBAyMdAQERJgEPCw4KAgImAgJWBgGFNwJPAwEEr1mBM?=
 =?us-ascii?q?oEBggwBAQaCadlBgWcJFYEKLgGFboJlAYFwg2oaO4Q/Jw+BVUSBFYE7gW8+i?=
 =?us-ascii?q?B6CaYImgQ6JB4odCUl4HANZLAFVExcLBwWBI0MDKi8tI0sFLR2BIyEdFxQfW?=
 =?us-ascii?q?BsHBRIhKoFEeIIBD4ZoeQMuXhoOIgIoEVxKPgtSBYItAh8DC209NxQbjyk9g?=
 =?us-ascii?q?iITegmBTsdiNAeEH4FkDKA1qmsuh1UQkHMiqG4xgX4ngVlNI4M3TwMZD44hP?=
 =?us-ascii?q?oNCyHInNTwCBwsBAQMJhUYBASGMNYFLAQE?=
IronPort-PHdr: A9a23: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
 p4X7sUZWJKr1ROARfo=
IronPort-Data: A9a23:fIpZaq233/2diG/CR/bD5ep1kn2cJEfYwER7XKvMYLTBsI5bpzdRz
 jAaXm6APqyKamD2Ktonb9u3/EkHu5+Hy9RhTFdl3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDl8B56r8ks14qyp4WlA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28P49m6t4wZJ
 OF2iHCFYVxB0psgNwgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKxMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lYE+jt963m6yBFORc2eIyd9PXYIVcgyQ1pd3ZJa5OrZHrR6zP4sVR33Ewj8ZVEPDGb
 tAFbzd1dxTBe1tEPVJ/5JAWxbb4wCKgNWQB8RTM+vFfD2v7lGSd1JDPOd/YYZqgQtlJmUOcq
 3Pu/23/GRwcLNWF1TyI6Gmsh/eJliT+MG4XPOfmqaMw2QLCnwT/DjUuDWejvNeVl3WYBfRgI
 VMU9jQUjbkLoRnDot7VBEDg/iDe4nbwQeF4GOox4wCl0bvR+w/fB24eTzcHZsZOiSMtbTgj0
 1iTltCvBTVpq7CTUXuH6rGZtyiyODBTJmgHDcMZcecby9e8gLEPj0nRdIhuIPGTn4bvJW32g
 Anf+UDSmI4vYdg3O7JXFG0rbhqor53OVAc2oAXeWHmo6BtwfpKjapaz6VnDq/1HKe51r2VtX
 lBZy6ByD8hUVflhcRBhp81XTNmUCw6tamG0vLKWN8BJGvTE0yfLkXpsDM5CyLdBaZtcJ2GzP
 Cc/SCtQ/I9UdH+uZsdKXm9wYux0pZXd+SPNCaqON4sTOMksHOJFlQk3DXOtM6nWuBBEuckC1
 V2zLa5A1F5DUf0/ngmlDfwQy6EqzS0YzGbeD8KzhRe+3LbUIDbfRb4ZORHcJqo0/YGVkjXzq
 tx/DsqtzwkAcevcZiKMz5UfA2pXJlcGBLf3ifdtSMi9HiRcFloMMcThmYEaR9Q9noB+tPv5w
 XWma0oJlHv9nSLmLCuJWFBCaZTuf7dOki8pDxNxBGeY+SApZLi+5/0fb5AcILstrrRi6dVWT
 PA1XdqKLdoSazbA+hUbNYLcqq47fjuVpAu+BQiXSxlhQIxBHivnosTFeCnr/wkwVhuHj9M0+
 eCc51mKUKg9SBRHJ+eITvCWlnean2UXwcB2VGv2euhjQl3mqtVWGnagn80MAp8+LDvYzWGnz
 CeQOxAToNfNr6IT8NXkgaOlrZ+jI9BhH3h1TnXq0rKrCRb0pmaT45dMcOKtTwDvUGnZ/KaDZ
 +IM69reNPYBvkhBsqsiMrJN4J892eDSpO5h/lw5JEnIUlWlMaM/A3+k2cIUiLZB6IUEsiSLW
 2WO2OJgB5O3BO3fHmU8Gi8Zf8WY9PRNmjDt/fU/e0r7wyls/Yu4a0ZZPjjSqSlNLLFKYZIU/
 vw8seE49gfltAchHfiXgg8J82+KCHsJY4w6h8tLHK7qlQsZ5VVQarPMCiLNwc+uavcdFmIIM
 zOrlK75qLAE/XX7cl03Dmnr4epRob8sqSJ65gYOCHrRk+WUm8Jt+gNa9AoGazh8zzJF4rpVA
 XdqPUgkHpe+1W5kq+YbVl/9BjwbIgOS/3Hw7F47lGf5aU2MfU6VJU0fPde9xmwow1h+TBN6o
 o7BkH3EVAz0dv7fxiExAE5pi8LyROxLqzHtppqVINSnLbIbPxzena6cVUgZoUDGAOQwpnH9i
 8tEweJSUZD/ZAks+/AVKo/CzrkBagG2FEobS9Fbwa45N2X9ejaz5DuwF36Mav59f8Ltz0vpJ
 PFtd+RuVgu/3hmgtjo0J7ABCJ4qke8L5OgtQKLKJ2kHupSxszEzjo/b2QbviEB2R95ot8E0G
 qrMRmjTDk2RmnpmtGvfp+ZUOmeDQIclZS+t+MuX4ek2B5Y4n+U0Sn4L05ywpGSzDAtr2zm2r
 THzTfba4MI6wLs9gra2NLtIAjuFDO/aVcOKwViViMtPZ9aeCvX+nVoZhXe/NjsHIIZLfcp8k
 ImMl9vF3EnlmrISeEKBkrmjE5h53+mDbNB1AOnWckYDxTCjXfXy6SQt42q7cJxFsO1M7/mdG
 jeXVpGCSs43afx8mltudClsIzQMAf/Wb4Dhhx+HgdaiNxw/6THDffSbrSLHTGcCeiExbsi0T
 ke+vvu1/dlXobhdHBJOVbksH5Z8J0SlQqc8McH4sT6DFGSzn1eeof3YmAE97S3QQGyxeCogD
 UkpmjClHPhzhE3J8D2dm4h7uxoNBXU7geA2ZU8b49dslza3FnUGLPxbOpIDYn2Rfuoey7mgD
 AwhrkN7Yck+YdiAWRX15s/uWB+WHPAIN83iJj0xuUiTbk9awaueVaB5+H4ID2heI1PeISLOF
 T3a0l35OAO8xKlgX/oV6+aggeZ/gPjdwxrkPKw7f9PaW34jPFnB6JCt8Mehm8AK/wEhWXgn/
 VQIeF0=
IronPort-HdrOrdr: A9a23:wf0twat8honbz3bkmk+zxjGX7skDRNV00zEX/kB9WHVpW+SFis
 alh+QDyHbP+VMssb8b+OxoX5PwJk80lKQFhbX5WI3IYOCIgguVxe1ZgrcKhgeQeBEWldQtrJ
 uIEZISNDSYNzET5/oSojPIcerIq+PqzEnHv4njJjtWPGdXV50=
X-Talos-CUID: 9a23:YXthmW841Wt3Zt9Ma+6Vv0BLOvAZcybD9indExCeGD1zdOGTCmbFrQ==
X-Talos-MUID: 9a23:HT8kKgtNHGhcKyO4y82nvGleLNpGz7mVLh4rrp8Zu8WaDwxhAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267521791"
X-MGA-submission: =?us-ascii?q?MDEr/J1vB7EyVos6sZtHd2MVYg2Hw5n0rVreRG?=
 =?us-ascii?q?Z5ma1qt9wZSqSVtU1x6OzP+xPGEV2zocaDT1As4q6Rt56g8+DV/LEayx?=
 =?us-ascii?q?kSDeqUY7U4kF1meG50YncabdngRuTX2pAr60NOLEP0MwsDHY1SAs+3S2?=
 =?us-ascii?q?vY/jDOZZimbtXyDt6z9xLpnQ=3D=3D?=
Received: from lamorak.hansenpartnership.com ([198.37.111.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 16:32:42 +0100
Received: from [IPv6:2601:5c4:4300:d341::a774] (unknown [IPv6:2601:5c4:4300:d341::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 599341C02A4;
	Thu, 12 Mar 2026 11:32:38 -0400 (EDT)
Message-ID: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
  cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
  gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org,  linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org,  linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org,  linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org,  linux-media@vger.kernel.org,
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
 ntfs3@lists.linux.dev,  samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev,  target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net,  v9fs@lists.linux.dev
Date: Thu, 12 Mar 2026 11:32:37 -0400
In-Reply-To: <20260312125730.GI1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <abBlpGKO842B3yl9@google.com> <20260312125730.GI1469476@ziepe.ca>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: James Bottomley <James.Bottomley@HansenPartnership.com>
X-Loop: cocci@inria.fr
X-Sequence: 3420
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/LEcKwRV0VQoRedeen7S_dg>

On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
>=20
> > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > confusing or flawed API design. It usually implies that the caller
> > is unsure whether a failure results in an error pointer or a NULL
> > pointer.=20
>=20
> +1
>=20
> IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> implies ERR and NULL are semanticly the same, so fix the things to
> always use ERR.

Not in any way supporting the original patch.  However, the pattern
ERR, NULL, PTR is used extensively in the dentry code of filesystems.=20
See the try_lookup..() set of functions in fs/namei.c

The meaning is

PTR - I found it
NULL - It definitely doesn't exist
ERR - something went wrong during the lookup.

So I don't think you can blanket say this pattern is wrong.

Regards,

James

