Return-Path: <SRS0=V3/9=PR=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450EDC433F5
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 19:12:15 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C1960E76
	for <cocci@archiver.kernel.org>; Fri, 29 Oct 2021 19:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92C1960E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,193,1631570400"; 
   d="scan'208";a="1212171"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2021 21:06:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3243DE027E; Fri, 29 Oct 2021 21:06:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C65BEE0072
	for <cocci@sympa.inria.fr>; Fri, 29 Oct 2021 21:06:10 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=mcgrof@infradead.org; spf=None smtp.mailfrom=mcgrof@infradead.org; spf=None smtp.helo=postmaster@bombadil.infradead.org
IronPort-PHdr: =?us-ascii?q?A9a23=3Ai5zBJRbWPzsN2nJvYZJ5jB3/LTHB0IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gePB9mGoKse26L/iOPJYSQ4+5GPsXQPItRndiQur?=
 =?us-ascii?q?oEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZ?=
 =?us-ascii?q?vJuTyB4Xek9m72/q99pHNfwlEniSxbLxyIRm5sAndqMobipZ+J6gszRfEvmFGc?=
 =?us-ascii?q?PlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2Au+c3krgL?=
 =?us-ascii?q?DQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4qx2ThLjl?=
 =?us-ascii?q?SUJOCMj8GzPhMJ+jLxVrg+iqRNw34HbfZqVOeFifq/BYd8WWXZNUtpPWyFHH4i?=
 =?us-ascii?q?yb5EPD+0EPetAqYf9uloOrQCjDgSyBOPg0DpIiWTo0q0g1+QuCwDG3Ao9FN8Jt?=
 =?us-ascii?q?XTbsNr1NL0VUeC716TIzivMb+lQ2Tjj7IjEaBchoeuDXb9pd8fa1EYgGR/fgFq?=
 =?us-ascii?q?KtYzlIy2a1v4Ls2WD7edsSP6jhW4jpgx1rTWi2Nsgh5THi44Ly13J+jl0zYUoK?=
 =?us-ascii?q?NCmSEB2fN6qHZVRuiyEKoZ7TN0uTn91tCg0y7ALu5i2dzUExpQgwh7Qcf2Hc46?=
 =?us-ascii?q?Q7x3+SumeOjZ4i2hjeL6lgBay60egx+vhXce3yFZHtjdJn93Pu3wXyhDe5MqKR?=
 =?us-ascii?q?uFj8ku9xzqDzR3f5+9KLE0yiKHVMYQuwqQqmZoWqUnDHjH5mEHxjKKObUok/e2?=
 =?us-ascii?q?o5P/9bbr7p5+cM5V4igD4MqQggMywG/k3PRYUUGeG4+i806fj/ULhTLVLiP05j?=
 =?us-ascii?q?LXZvYjHKckfpaO1GRJZ34gh5hqlETuqzMoUkWMaIF9Ldh+Ll43pNEvPIPD8A/e?=
 =?us-ascii?q?/mVOskDJzyvDDIrLhDY/NLn/NkLr6fLZ97UBcyBApwt9C+Z1bEKwOLOj0Wk/ru?=
 =?us-ascii?q?9zUFgU5PBCsw+b7FNV90ZsTVn6IAqCFLKzSsESF5vkvIumJfI8aoizxK/kj5/7?=
 =?us-ascii?q?0jH82g0URfaez3chfVHftFfNtKESxYHz2g95HH31ZkBA5SbnOlVyZGRVTbnO4U?=
 =?us-ascii?q?rg47zA9QNajBojZQY6Fg7Gb2iq/WJpMaTYVWRi3DX70etDcCL83YyWIL5o5+tT?=
 =?us-ascii?q?lfbKmToUo2RCq8g78xaBuIufd9msfr52xjLCdCMXSkx8o/DB5Bsjb1HuCHTkcd?=
 =?us-ascii?q?oYgRjk4xqlzrEVxjFCZ3vog68E=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AK7vZBaIEtrkyf9f7FE+RtpQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC4hz0l3zMOy2EZDWiDOP/ZNjOjc9p/Ody+/BkFv5+Hyqc2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHuCtULS?=
 =?us-ascii?q?s1h1ZHGeIdg9x0XqPpMZi2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?vlbPxe0ELRvjTOwaUg3ZbUqTkhQJNzsAw+v9qZLxFMhgR0W3T2Ykqk72htrToI?=
 =?us-ascii?q?estFqjHl/4aXTFZFS9kNKFL8bOBJmKw2SCW5xScKiG1nK0G4EYeZ9ZAorkpWAm?=
 =?us-ascii?q?i78cwIzcGZRGrnPOz2Lv9S+92h81lItODAW+1kmU4mGyfV+J/FMiFG7GQsIceh?=
 =?us-ascii?q?Wdu2NQVSK6YOt5GPBNxSj/FRTFPHHYeLq4kuvPx3iynN2VMwL6OjaAw5mLawA1?=
 =?us-ascii?q?1lrnrPsDcdtGDSYNShEnwm44PxEyhajlyCTBV4WPtHrOQau7zcefTUoUXHrS09?=
 =?us-ascii?q?/osgVud3GUfBRQaE1yhrpFVT2bWt813cyQpFugG9MDeN3BHivH8WROiqXKJtxJ?=
 =?us-ascii?q?aXMBfewH/wGlh1YKMizt0xQE4ovppadoorsY6SDUmkFiTkLsFwBQHXKK9ERqgy?=
 =?us-ascii?q?1tfkd9+1eX544PPie/ogDbpO+Xenbw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AggJxJap0nW6AHWs2YAKyU18aV5o6eYIsimQD?=
 =?us-ascii?q?101hICG9Vvbo9fxG/c5rtiMc7Qx7ZJhOo7290cW7LU80lqQU3WByB9aftWDd0Q?=
 =?us-ascii?q?PDEGhM1/qG/9SKIUPDH4BmuptdTw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CrAAAlRXxhmIXKicZaHgEBCxIMQIFOC?=
 =?us-ascii?q?4MhVjsxkzJTCgaBP4sLkR+CBwEDAQ03CgQBAYdUAh0GBjEIDgECBBUBAQUBAQE?=
 =?us-ascii?q?CAQMDBAETAQEBAQEBAQEJCxAGOiSFaA2CNSKELAYBATcBED4iLIMlAYJhJg+vH?=
 =?us-ascii?q?oEzgQGCCAEBBoFSQYVMAwaBOo49HH2BEIFLgzKCYwSCK4Uwj14qAoI9oTSdOYM?=
 =?us-ascii?q?9BZ8mpyaQb4UfpiiBYgGCEn0IgyRRGQ+OIIkGhWokMAI2AgYLAQEDCZJvAQE?=
X-IPAS-Result: =?us-ascii?q?A0CrAAAlRXxhmIXKicZaHgEBCxIMQIFOC4MhVjsxkzJTCga?=
 =?us-ascii?q?BP4sLkR+CBwEDAQ03CgQBAYdUAh0GBjEIDgECBBUBAQUBAQECAQMDBAETAQEBA?=
 =?us-ascii?q?QEBAQEJCxAGOiSFaA2CNSKELAYBATcBED4iLIMlAYJhJg+vHoEzgQGCCAEBBoF?=
 =?us-ascii?q?SQYVMAwaBOo49HH2BEIFLgzKCYwSCK4Uwj14qAoI9oTSdOYM9BZ8mpyaQb4Ufp?=
 =?us-ascii?q?iiBYgGCEn0IgyRRGQ+OIIkGhWokMAI2AgYLAQEDCZJvAQE?=
X-IronPort-AV: E=Sophos;i="5.87,193,1631570400"; 
   d="scan'208";a="1212170"
X-MGA-submission: =?us-ascii?q?MDGO2ECz/vlhKN5jMBLw0NFZWQSnpp2LW9GxRi?=
 =?us-ascii?q?NslGiJgptN0h+4uCmPoQLmGQNUhf1597MuKChKwJypetKUKbwS0Toq5W?=
 =?us-ascii?q?zF4xMRDcoxeWmLCfW17hdanimuWysb0erCPeRBa4o2HfgWN8pZHYqcKK?=
 =?us-ascii?q?8xWFR3pjDC9+EoXZYY8uMWug=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 21:06:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EPbQpob5CMU27sGWaJMoqO1WYQOI9+BnLtKFzV3IQoI=; b=C5ZfDk4WJJf6xCQqLtgrPsm/vw
	+/DUzkNLZ3w6DlGRR7RE3CKoWUfF4S3Bv2MG82aZKM//TrAeUGneypeWNphH3w1jEt6y0GDCHneBl
	0V3aJMn0059VgrbVxVylbIuTEQ91ZHPBY2OF8j9ea9CnMXa/5NLssU+OpPWFIf9S8IZ8aiAv82pXq
	TPGmCoahu2OSutvsJIsUaqVg2yWc54iQxsyLzl7/wJtZkIVHFgSaBd2QuVO9AW/yLGzfxDpubNU/R
	xUGAH/BqR1IGsBQ8thodCDTyPkM2lJ0+t43b3G+ugMI9IkZs1xaqozVi18KxAJtJR77U6oK320HgU
	h/8vStZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgXCX-00BvEo-0c; Fri, 29 Oct 2021 19:06:05 +0000
Date: Fri, 29 Oct 2021 12:06:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: cocci@inria.fr
Cc: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cocci-request@inria.fr
Subject: [cocci] Cannot infer Python version: when no /usr/bin/python
 symlink is found (resend)
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 50
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/YXxGHEuS0zi%2Bsbft%40bombadil.infradead.org>

Debian and OpenSUSE Tumblweed no longer have the /usr/bin/python
symlink, at least this is explained and spelled out on the Debian
Python Policy [0]. This guideline specifically requests that scripts
do not use `/usr/bin/env`, do not use `/usr/bin/python` and instead
use the exact version desired.

When running coccinelle on a system without this /usr/bin/python
symlink Coccinelle will complain when using a python script on a cocci
file:

Cannot infer Python version

Fixing this is just to create the symlink, but I *really* don't want
to do that. And so I think we may need to support:

script:python3
initialize:python3

Maybe it makes sense then to always look for python2 if a version is
not specified, and if that does not exist look for python3 as new
systems may not have python2.

[0] https://www.debian.org/doc/packaging-manuals/python-policy/ch-python.html#s-interpreter

  Luis
