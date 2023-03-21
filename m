Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7189DC6FD1D
	for <cocci@archiver.kernel.org>; Tue, 21 Mar 2023 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XXleG++6MeURy/E/vOgvu/1108sao7Di03RTgqbkGWA=;
  b=g+TNGHC0TG2EVstGV4x/10s7WLCjaRHuuwsuXTzhmd4KFhtd90wiM5ar
   afjTGeiSwQL0jJUaXYYonfq9rdxXGymBsIHbYr+sxJq3K3OGgNgxl4e/u
   nQSbkD1lvGlahdRI23uEecIp/Q+1JSi7jg9Jmi86/CzvjpJUC5Hq0aNnQ
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="98200803"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2023 07:54:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CD48AE01A8; Tue, 21 Mar 2023 07:54:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1ED65E0131
	for <cocci@sympa.inria.fr>; Tue, 21 Mar 2023 07:54:55 +0100 (CET)
IronPort-SDR: 641954be_W2QpHIRjoFi9kNloWIQ3sXutgQJd7hXn7l7gGZ2O9TqyhC1
 N3+xyST/d0W5c+S//VM1E7192riPA1C6uiMLmjw==
X-IPAS-Result: =?us-ascii?q?A0EVBgD6Uxlkh07ASNlaHgEBCxIMQIN9gUsvBAtGhFOPC?=
 =?us-ascii?q?oF3MYQvhyyHOoRnhxg+DwEDAQ1BAQIEAQEDBIR+AoU2Ah0HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARgLFwcOBQsFIoVoDYI3K?=
 =?us-ascii?q?QERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQECAgEjBBkBAREmA?=
 =?us-ascii?q?QQLCxoCJgICVwYNCAEBgnqCKAEDDiMHszB/M4EBgggBAQacCh8sIlOBXgmBF?=
 =?us-ascii?q?CyQOnonD4FVRIE8DIJ3PogcgmeNdIshCoE0dYEgDoE9gQQCCQIRa4ESCGuBf?=
 =?us-ascii?q?UECDWULDnKBSwKBYSUEDgMZKx1AAgELOzo/NQkLIQZYawIsERMFAwsVKkcEC?=
 =?us-ascii?q?DkGGzQRAggPEg8GJkQOQjc0EwZcASkLDhEDT4FHBC9efAoGASYknQ98G0SCW?=
 =?us-ascii?q?oxihT2DLAGNBowskXaCAjQHgiiBVYFZDJgUhngGEy6DfYxmhiUOBpIjLoctk?=
 =?us-ascii?q?A+oGoF5I4FcMxokgzZPAxkPjiAZhAyPR0A0OwIHCwEBAwmFRgEBhRxfAQE?=
IronPort-PHdr: A9a23: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
 nO6RjtGvFys1OWCmGIPbQ==
IronPort-Data: A9a23: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
 xmVBFYf5e7BsfiovPkyDBkPnutSOwDWBurEGw==
IronPort-HdrOrdr: A9a23:NeV82aALHsga+SzlHemg55DYdb4zR+YMi2TDtnoBLCC8EKSj/f
 xG+c536faaslgssR0b+OxoW5PwI080l6QU3WB5B97LN2WIhILCFvAA0WKW+UyGJ8SIzJ866U
 4ZSdkbNOHN
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,278,1673910000"; 
   d="scan'208";a="50759058"
X-MGA-submission: =?us-ascii?q?MDGCfbv1P4ebDJkrnI5J2SxlfE/FaNjlvsCq1n?=
 =?us-ascii?q?nL5J/na3mDVUhMw4868rFGJdN1SDF5WFJimf3VvEgVAsV/npjSBBgzDF?=
 =?us-ascii?q?KNqmXwVAsMkylf2jTpot493U/azZ8R64mkHqsvp3kJJDL2MJi932n6ho?=
 =?us-ascii?q?7tUXxbNcz+i9lI//W1FhN9aw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 07:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679381687; i=markus.elfring@web.de;
	bh=XXleG++6MeURy/E/vOgvu/1108sao7Di03RTgqbkGWA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ct+7pVgmenY5Jwo9XuK+OiUmU+eysI50+S87bPkTnQxzAhIyHT+G8h2vA7YaBhvwJ
	 ZrLUS9GIcanoIbmGbjDmuLXwicnl5QD54BLwFPGtwQArL1NCjlJ1cGFZt6l34VCjtI
	 P8CjzMqEJQ/v4uncLJlteTrDcSzi047HeJfRYrMXSy154fPKlVbsLegVCgOfZ7d+sN
	 Z0qrI988CU7gPGZoSftA0zROXL4I3wTZrepnM3BpouxWAVO19iuLl77jKhWGM74fFC
	 aKslXn2aI9oHVdic2fg8enOEp1oOtwegtveN1mJGLzqFnca17tTtHSL9i2UZQAY8Dy
	 8HhV8fzvZblPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgub-1qUYqe1PMV-00v9Ns; Tue, 21
 Mar 2023 07:54:47 +0100
Message-ID: <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
Date: Tue, 21 Mar 2023 07:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Nathan Lynch <nathanl@linux.ibm.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87pm9377qt.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7Kuxt/8RJeURdT0ekwdlRTjO+znwTwfklysqtixQNqfsAEVZXCm
 37TgaXMOOE+ST41juFnzukMWOtaFhrpoTCMvamNmvTLy5TFJ4F0JEX7VG70u0M8umU9Ejxx
 WjcwIpdJy6Ak/yNJz7cAd85rIkSWjp15mS++Xqw3jlrZkUHBvxgOlUiuyiG1/gECncwgKEW
 9/tuJih+uV9Oa7OH2/WWA==
UI-OutboundReport: notjunk:1;M01:P0:vDaPWzYeOp8=;WBSZDpG4NMLE0ZKPLVAjK13ag4S
 xvAOonxBcha1mdjqJU8DPaakQ+ufdXKmD/XnNrRyfTTUwgXLeg52hbeFr+HjcbPdUuF4jlZqa
 fEmfD5mwIoey/X+T0aGfgEIq0/IG4ONFGraA6IFffqLd1RaMgwQ7dkB/Cd/83mzSbpZIjxhJj
 CX2luKPeC8283bfxtCOMXAX1m+yFI5Dq98j3mVBt+lF31ac35a9JLB9e7w5WeScy3IbEvIXvI
 x0FKYQc3qCUe39d3258zYltTJOPxf8FoOqWrCmzwxgvqcfRjm/C5zihmqp//lo7yYSabpV5GV
 c+WAxZIz90g8qmb/4W+BNd7cDY+SJI/nR3SJgCTi+bOK0mF9jFtPQPWoPLCsj5I3IZ3OK7Oqt
 q2jh4fq91HddShijl37Z9+sxAsSDYHiPjW1UxrhWdFPoTRe1Gm5FxGOHP+Fw4Jl21GSvXMkF2
 wwpKpOhpiNdpT2y8NcN3DoNBjuZmYuNBbjRWcbnWIwbykBPAoIxkh6xcBWe9dfpvWA6KGy94b
 D/gLhibYYcUISSIkSQLzmrfYP96jvGOmkyYJ+wUuAHuHHSdir9JP9AtJid99L2BMHdHRGerK9
 rverVzFGr84LtAs0E3Y5Ern2DsX85HZxaGk6aR+7ShG4tgHrOqO841mARS07f0d8C60HWn8HB
 lcIh8XoVKzVzsdfa4JdNAIF5GMRar/BcesJPLhr0kAu0Fws9TMKGYjKBjis1P0pPeUXwPvTBm
 iwgr9b1BuwGFFPhzUz9IyCrCs6t+X0gc8IwkFaVuu4NcIkQAvAAz8N0B4iJDZ9hHiADgkPbir
 QzXQInbT2qCAPzioe+46GgVdjJNwnmNA1EseAShICGizIFLbq7qzXVfmbWyLfgYSfr2BI6DdM
 n/okfeDE0KlJwFvTsyc8nUiDHfJfPdHlK7oekO7PivRI/VYO5hKx15tWn5lofFPt8dupGQezH
 txNxrw==
Subject: Re: [cocci] powerpc/pseries: Fix exception handling in
 pSeries_reconfig_add_node()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 905
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/afb528f2-5960-d107-c3ba-42a3356ffc65%40web.de>

> It's been brought to my attention that there is in fact a crash bug
> in this function's error path:

How do you think about to mention any other contributors for attribution
according to this issue?


> np->parent can be an encoded error value, we don't want to of_node_put() that.

Will the development attention grow for any more cases?


> I believe the patch as written happens to fix the issue.

Is it interesting how many details can still be improved (by my change suggestion)
also for the discussed function implementation?


> Will you please write it up as a bug fix and resubmit?

Another proposal will follow.

Regards,
Markus
