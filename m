Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B5606A8B5
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=bMlw16sG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:to:from:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pMm1+EQQovWR5YqKZWrJrY9fn+qMfjdL+fLalt4okXQ=;
  b=bMlw16sGzDsteRcXDD8gSw+DWv3Gaf+/TGuKae0Byt8FWIw8H6FsBevq
   I0U9iPofNdcM7cVSGZ+WeUyoQ/3/bY0N9xIGhbarDJMcblFxZ+r5B/W+3
   rj6Rv2NSYY5leQ2aK76V6HXPs7JBEtZa2tChbB6whOMiBKVgzxTvBLRHi
   Q=;
X-CSE-ConnectionGUID: 8IQ+QVQDSpCjhOGM8TdkRw==
X-CSE-MsgGUID: GAmOmiXnQuG7WarXCSzrmA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305038908"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 10:50:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CE648812CC; Thu, 12 Nov 2026 10:50:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 841B38008B
	for <cocci@sympa.inria.fr>; Tue, 10 Nov 2026 18:56:19 +0100 (CET)
X-CSE-ConnectionGUID: AnlDB/17QDyJCqDyb+npug==
X-CSE-MsgGUID: GUDytsqMTiCDc3r3lZOT7g==
IronPort-SDR: 6af35ac2_kNSYgzZ6P6WxBuaJNIqzWFdlncGh7/i/BI/4n+PATC9dS/Y
 RKjzOUV0QsZ2fpCJ/Mm46uuvTU+Fpp/BNiHqNHA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HsAAAUWvNqjxcrRrlaHgEBCxIMggULgkGBC2A0BwhJh?=
 =?us-ascii?q?FiRdJxQgVWBfAIPAQMBDT0UBAEBAQIBA4R+Ao4eAh8GAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQUOO4ZPDYwaA?=
 =?us-ascii?q?TNxgSUBAQEBAQEBAQEBAQEBHQINfgIBAyMEGQEBNwEPJQImAgJWBgESgwIBg?=
 =?us-ascii?q?iIBBksHDQa7Gn8zgQGCDAEBBoJq2UuBaQIDBhQBgQouiGIBhXk7CYJWaXonG?=
 =?us-ascii?q?4FJRIEVg2mIHxmCUYImgQyXYYFKHANZLAFVExcLBwWBaAMqLy1uMh2BIz4XL?=
 =?us-ascii?q?1gbBgWBHYEegRKBB12BKyhdASGBCIF1AoJRggACAUlBDgdFUwklQxJHJCIIE?=
 =?us-ascii?q?gkBExosCoEaNTwJJj8VDGYLGgVhCAINDHQ5EDAeJC8FGiY+Gwp4bT03FRkEl?=
 =?us-ascii?q?BuCIz00AYEOLIERTSAEEQwpkxyzT4QqjCSVOk2HdptMhzCIC5B9I4ttgXqVY?=
 =?us-ascii?q?zeFIYFoOoFcMxoIGxWDIhM9AxkPjiIZg2mFE8knRzICAToCBwIHDgMLkhyBT?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23:Cokj0BOiVrOwGyjn0CIl6nYdBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqor1AaCBNWHuroE07OQ7/u+HzRaoN6oizMrTt9lb1c9k8IYnggtUoauKHbQC7rHSRJ/N
 +l5EGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIVgJ6or1hfFv3REd/lVyG5nIV+YghLw6tut8JJ5/CldtfMs+9RcXankeqgzU
 KBVAikhP20p68LnsgXOQxGS7XUGSGUWlRRIAwnB7B7kW5r6rzX3uOlg1iSEJMP6Vb86Vyyt4
 KtyVhLmhzoJOyY2/2/LhMNwirlboA+6qBxk34HUeoCVO+Fgca7bYNgXWHBOXsdVVyxGH4O8c
 44CBPcPMOpEs4XwoUYFoACgDgewGuzg1j5Ihmf33aIk1eQhDRrG1xEkE94XrXjYsMn5OKIUX
 OuozqfH0C/DYutY1znj6IbFbA0vr/KOUrJ+fsXe1UYhGhjZjlWJs4HpIy+Z2vgPvmWd8uFuV
 fivi2kiqwxpvDWvxt0jhZTUjY8JzlDL6D95z5goKtKiVUV2ZsKrH4FLuiGfMIt5X90tQ2Vtu
 CY70b0Jp4S7cDIWx5Qgwh7ScvqKeJWH7Rz/TuieOyt4hG57d7KlgRa/6Uytx/PiW8S001tHo
 DdJn9nDu30N0xHd5NSLR/p880qjxDqCyh3e5v1aLE0qiafWJJAvz6Mtm5cTvkrOAzH6lkrwg
 aSLeEsk/e2o5P7mYrXgvpKcNJF7ihv4MqswnsyzG+M4MhIBX2Wd5O+y16Xj8FXkTLhJjvA6i
 KvUvIzAKckUqKO1GRFZ34gl5h2iFTmpys4YkmMCLF9deBKIkYzpO1bWLfD9F/i/glCsnC5ky
 v3IILHsDI/BLmDZkLfmYbZ97EhcyA8pwtBe45JYEK0OIPLrVk/wstzXEAM5PhSpz+vkCNhxz
 IETVX6VDqKWPq7eq0GE6+w3L+mJfoAVuTL9K/Y/5/7piH80gUMScrOy0JsSb3C3A+ppI0GcY
 XrtmdcOD30KshAiQ+ztjV2OSSRTaGqqX6Ig+jE7D5qrApvERo+xnLOB3Ty2HoZWZ2BDElCDC
 23kd4SCW/cWaSKdONVtkjIeVbS5TY8uzgmhtBXmxLp/MurU5ioYuIr+2NRt6O3cixYy+z9uA
 cmFzWyDTXl4nnkWSD8o365xu1RwylKZ3qh5h/xUDNNe6v1XXgo0L5Lc1/Z6C9fuWgLGeNeJT
 UypQtSiAT0rUt0xw8cCbFt+G9WjixDOxzKkDbAbmLKVGJI57qTS02DsKMZ40XnGzrUugkE+T
 MVWLWOoibZz9xPLB47Hi0iXjbqne7kB0iLV72eD1WSOs1lYUAFuVaXFWmgSaFHKoNrk+02RB
 4OpXJY6NgpIgeqLNaJObpW9r0hCRf6lHN3Bama1s2a2HxeBgL2WOs6iXWQW2yHUEwA8mgQS7
 T7SMwk1ASOouCTGBThvBXruZkrjt+dk/iCVVEgxmiqKZkEp/r654BMZjLTIQPo727UItSMkq
 i55BhC22NeAWInInBZoYKgJOYB121xAz2+M8lUlZvRITohnj18aKEFsul/2kg5wEsNGmNQrq
 3UjyExzL7iZ2RVPbWDQxoj+b5vQLGS65xWzc+jOwFiL29++/6AD5fA9qk7upkeiEU9xu25/3
 Yxt2mCHro7PEBJUVJvwVkgt8B0vrLjyZy4x6ofR1GZhK++/tTqRk8kxCr4dww27N8xaLLvCF
 AL2FJgCANOyLeUxh1WzRhcNPeQXqPVuZIW+bfya36iuNedk2jmm5YheyKZ61E/Ety91S+qTm
 o0A3+ndxQyfETH1kFamtMnz34FCfzAbWGSlm2DiA8ZKa6t+cJxuay/mKtCrxth4m5/mWmJJv
 F+lCVQc3ca1eB2UJ1Xj1AxU3E4TrDSpgyy9hzBzljgoqOKY0kmsi6zpfTICPWJGQGxjllr2Z
 4OzipFSXUSlaRQoiArw/VzzlOBQoKVyKXWWQF8dJniraT46FPfr8ODZMKstoNsyvC5aUfqxe
 wWfQ7/5+F4B1j/7WnBZ3HY9fi2rvZPwm1p7jnicJTB9tim8G4k4yBHB6djbXfMU0CABQXwyg
 jD/A1+wMt2s/M6ZjdHIteX0BAfDHtVDNDLmy4+Nrn7x7mRCBBqzkvS2m8bqC04x1iqxhJF6E
 C7Pqhj7eIzi0a+3ZPlmckdfD1j588NmG4t6n+Pcnbko0GMBztWQ9HsDyiLoNMlDnLn5dDwLT
 CIKxNjc5E7k3ldiJzSH3dCxWnKYy8pnL960BwFekik0x8VNBKqQ6b1fkDEzqV295Q7cevlym
 D4BxOBmsS5Hxb5R/lZ2iH/GSrkJVVFVJyntiwiF47Xc5O1MaWCjfKLxnEtykNa9Da2T9wRVW
 XL3YJAnTmd76sRyNk6J0WWms9G5PoaIK45I8EfPwHKix6BPJZk8l+QHn39iMGP55jg+zvIjy
 Adpxde8tZSGLGNk+OS4BARZP3v7fZB2mHmlgKBAk8KRx43qEI9mH2BBV5LASPWkHTYXtO/qL
 UCFFzh2+RL5UfLPWBSS7ktrtSeFGJmDMnabKX0czM5vXl+WI0kV00gEGT49mJA+DAWjwsfsJ
 Vx46j4m7Vn9shJQy+hsOkqaMC+XtEKyZzwzUpTaMAtO41QI+RLOKcLHpLE7D2RC85amtgDIN
 mGLe1ECEzQSQkLdYjKrdri2uYuZo7XeWbL4c6OIOfLU9aRfT6vanMLylNQ+uWrVcJ3IZCUqD
 uVniBMTADYmQ4KFwHNXDHZL8kCFJ8+D+EXjq2su9Z35qay1Hlqov9fHCqMOY4o+vUnt3OHab
 7HW3GEjdX5Zzs9enCeZjuJFgBhI130oL373TdFi/WbMSqnUh6NaXSkAcy0pctNS6L472AxEO
 MqdgdO9wLd8irRd505tbVX6gYnpYMULJzr4L1bbHAOQM6zAIzTXwsbxaKf6SLtKjewSuQfi8
 TqcFkbiOHyEmVyLH1i3NvpQiSiAIBFEkIS0cxIoVTO5F5T+cBqnN9lyhDwyh7Y0zn/HLm8TN
 zFgflgF9+3Nq3wAxKkkXTYapnN+SIvM0z6U9ezZNoobvbNwDyJ4mvgbqHU2xr1J7T1VEfx4n
 CyB5tVqolygjqyO0m8+AEcI9W4N2NnN5x4xXMeRvoNNUnvF4h8XuGCZChBR4sBgFsWqoKdIj
 N7GiKP0Lj5GtdPS58oVQcbOe6fleDIsNwTkHDnMAU4LVzmuYCvUjmRYl/2f8niUtZUg7JPrn
 dBdL90THExwDf4cBkl/SZYaJ4xrWzo/jbOBpMsB5H778EKLH4NCpJfbUfSXCPTrbj2Zx+ohB
 VNA0fbzKoIdMZf+0kppZwxhnYjELEHXWMhEvixragJn6FUI6nV1SXc/nl70cg74qmFGDua6x
 1Rl72k2KfRo7jrn5E07Y0bHtDdl2ldkgs3r2HiQaGKjdfftG94OTXav8RJqeoXyRwI/BeVdt
 UljODrAQrNKgqEmfmdu2la0UX5nHPlQQKlBYQQd37ecYPB6iTy0Sw2izE5DoLeeU8AkjBEtb
 ZmqqntB30RobIxsTZE=
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:fvjNxqmndxC2EmnectsYpi7Ncc3pDfIa3DAbv31ZSRFFG/FwWf
 rAoB19726TtN9xYgBGpTnkAsK9qBznn6KdnrNhX4tKMDOLhILsFuFfBOjZslnd8k/Fl9K1vJ
 0IG5SWSueAbmSS5vyV3ODXKbsd6ejCyaTtoevF1X9iQUVLRshbnmJENjo=
X-Talos-CUID: 9a23:x8U3nGOTERmf7u5DcS9j2GRTQ58cXmz/5278MkX7D350R+jA
X-Talos-MUID: 9a23:E3lu9AiquMLNrEEKdD1hl8MpG/pE8ri1EWUxkL4qsJKebihCHAvCg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,206,1787004000"; 
   d="scan'208";a="162325388"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFtN2821WU3YUSqC+REPf2gmPThalu3lxShy6?=
 =?us-ascii?q?nosb9xAHLUP/4zWEOr757/CGXBpo2+KO0YJyoEqEiteYiw0W7YLaLQN7?=
 =?us-ascii?q?rxnt/0v0CJjFPowji+1O6sLYf5k959SHQl8HtSbnushQjp+6YEfZvTYh?=
 =?us-ascii?q?wX6yOGq6o/GAkBZEXRPC2rLg=3D=3D?=
Received: from mail-4323.protonmail.ch ([185.70.43.23])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:56:19 +0100
Date: Tue, 10 Nov 2026 17:56:12 +0000
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
From: Chad Aldreda <ca@modelmiser.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org
Message-ID: <20261110175607.1617450-2-ca@modelmiser.com>
In-Reply-To: <20261106193517.3267013-2-ca@modelmiser.com>
References: <20261106193517.3267013-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 7328148d371cae6b74cc8b5197c3167d78f810c7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v2] coccinelle: api: add a checker for device nodes
 in devm memory
Reply-To: Chad Aldreda <ca@modelmiser.com>
X-Loop: cocci@inria.fr
X-Sequence: 3789
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/a4S983kTW3jUgYX7iEDhJg>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A struct cdev, miscdevice, video_device or v4l2_device embedded in
memory from devm_kzalloc() and friends is freed when the driver unbinds
(Documentation/driver-api/driver-model/devres.rst), but a file that user
space holds open on the node outlives the unbind. Its later file
operations use the freed memory, and for two kinds of node so does the
core on close(). For a cdev, __fput() calls cdev_put() on it after the
driver's release(). For a video_device, v4l2_release() reads it and the
v4l2_device it points to, then drops a reference on it; at the last
reference v4l2_device_release() follows it to the v4l2_device again.
For a miscdevice, nothing on close() touches the miscdevice except the
driver's release().

Report such allocations in two ways: when the allocation and a
registration whose argument uses it (x, &x->f, ...) are in one function;
and by type, when the allocated struct embeds the node directly and is
defined in the .c file or in a header it includes with #include "..."
(spatch's default). A node registered through a pointer copied out of
the allocation first is found only by the type rule; one nested in
another member or in an array only by the first rule.

With Coccinelle 1.3.3, on 7.4-rc1 it reports 124 sites under drivers/,
47 of them only through a v4l2_device. Known false positives: drivers
that cannot be unbound while a file is open short of removing the
device, such as open-dice (platform_driver_probe() sets
suppress_bind_attrs, and the open file pins the module); nodes no file
can be opened on, such as the miscdevice in dw-xdata-pcie, which has no
file_operations, or a v4l2_device that no device node points to; for the
type rule, an allocation whose node is never registered; and a
registration of memory only reached through the allocation, such as
misc_register(x->ptr). Coccinelle 1.1.1 found 116 and 115 of the 124 in
two runs, and nothing else: it loses some structs defined in headers
when run with --dir, and cannot parse one probe function.

Fixes sent for sites it reports:

  misc: nsm: https://lore.kernel.org/r/20261107114433.3789830-2-ca@modelmis=
er.com
  ptp: vmclock: https://lore.kernel.org/r/20261107150344.3946529-2-ca@model=
miser.com
  platform/chrome: cros_hps_i2c: https://lore.kernel.org/r/20261110123230.1=
251547-2-ca@modelmiser.com
  platform/x86: dell-smo8800: https://lore.kernel.org/r/20261107204950.8895=
2-2-ca@modelmiser.com
  ACPI: pfr_update: https://lore.kernel.org/r/20261108233900.4043941-4-ca@m=
odelmiser.com
  ACPI: pfr_telemetry: https://lore.kernel.org/r/20261110144436.1529000-2-c=
a@modelmiser.com

The script supports the context, org and report modes. It has no patch
mode: the fix is a lifetime change (a kref, or a reference held by the
open file) that differs per driver.

The script and this message were written with an AI assistant (Claude)
and checked by hand. The six sites with fixes linked above were
reproduced in QEMU under KASAN before each fix was sent; the other sites
were not tested.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
v2, for Julia Lawall's points:
- Accepted fixes: links in the message; their status is at the end of
  this note.
- -I: two things lost ipu6 line 990 for us, and -I fixes neither.
  Coccinelle 1.1.1 misses it with --dir, with or without -I; and v1's
  Options line (--include-headers-for-types), which make coccicheck
  applies and a bare spatch run ignores, makes 1.3.3 miss it too. v2
  drops that line; with 1.3.3 (git 11b93adb6), spatch --dir drivers and
  make coccicheck M=3Ddrivers, which passes -I, give the same 124 sites,
  990 among them.
- Header cut to two lines, and depends on org || report dropped.

v2, for Markus Elfring's points: the two allocation rules are one rule
with a disjunction (x is now an identifier, so x->f =3D devm_k*() is
reported by the type rule); the argument pattern is <+... x ...+>;
context mode added; one report helper; f-strings; "devm" without the
underscore; the close() paths per node type are in the message. With the
same Coccinelle and options, the report over drivers/ is the same line
for line before and after these changes.

Counts are for Coccinelle 1.3.3; v1's used 1.1.1. The 47 replaces v1's
50, which was measured with v1's script, 1.1.1 and the old Options line.

v1: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com

On your question about accepted fixes: Rafael Wysocki applied the
pfr_update fix to linux-pm (bleeding-edge) for 7.5, as dacb7cef6f32.
The cros_hps_i2c fix is at v2 after Tzung-Bi Shih's review, and
pfr_telemetry at v2 after Rafael asked me to address an automated
review of it; nsm, vmclock and dell-smo8800 have had no reply yet.

 .../coccinelle/api/devm_file_reachable.cocci  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_file_reachable.cocci

diff --git a/scripts/coccinelle/api/devm_file_reachable.cocci b/scripts/coc=
cinelle/api/devm_file_reachable.cocci
new file mode 100644
index 0000000000..09d139eb6d
--- /dev/null
+++ b/scripts/coccinelle/api/devm_file_reachable.cocci
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find a cdev, miscdevice, video_device or v4l2_device in devm memory,
+/// which a file still open after unbind can use.
+///
+// Confidence: Moderate
+// Comments: Drivers that cannot be unbound while a file is open, and node=
s
+// without file operations, are false positives.
+
+virtual context
+virtual org
+virtual report
+
+@initialize:python@
+@@
+seen =3D set()
+
+def warn(print_fn, p, msg):
+    key =3D (p.file, p.line, p.column)
+    if key not in seen:
+        seen.add(key)
+        print_fn(p, f"WARNING: {msg}")
+
+@alloc exists@
+identifier x;
+type T;
+expression e, e2;
+identifier fn =3D~ "^devm_k[mzcr]";
+position p, q;
+@@
+
+(
+x =3D fn@p(...);
+|
+T *x =3D fn@p(...);
+)
+... when !=3D x =3D e
+(
+misc_register@q(<+... x ...+>)
+|
+video_register_device@q(<+... x ...+>, ...)
+|
+v4l2_device_register@q(e2, <+... x ...+>)
+|
+cdev_device_add@q(<+... x ...+>, ...)
+|
+cdev_add@q(<+... x ...+>, ...)
+|
+__video_register_device@q(<+... x ...+>, ...)
+|
+video_register_device_no_warn@q(<+... x ...+>, ...)
+)
+
+@embeds@
+identifier S, f;
+type T =3D {struct cdev, struct miscdevice, struct video_device,
+          struct v4l2_device};
+@@
+
+struct S {
+  ...
+  T f;
+  ...
+};
+
+@bytype@
+identifier embeds.S;
+struct S *x;
+identifier fn =3D~ "^devm_k[mzcr]";
+position p;
+@@
+
+x =3D fn@p(...)
+
+@depends on context@
+identifier alloc.fn;
+position alloc.p;
+@@
+
+* fn@p(...)
+
+@depends on context@
+identifier bytype.fn;
+position bytype.p;
+@@
+
+* fn@p(...)
+
+@script:python depends on org@
+p << alloc.p;
+q << alloc.q;
+@@
+warn(coccilib.org.print_todo, p[0],
+     f"devm memory registered at line {q[0].line} as a device node or a v4=
l2_device")
+
+@script:python depends on report@
+p << alloc.p;
+q << alloc.q;
+@@
+warn(coccilib.report.print_report, p[0],
+     f"devm memory registered at line {q[0].line} as a device node or a v4=
l2_device")
+
+@script:python depends on org@
+p << bytype.p;
+S << embeds.S;
+@@
+warn(coccilib.org.print_todo, p[0],
+     f"devm allocation of struct {S}, which embeds a device node or a v4l2=
_device")
+
+@script:python depends on report@
+p << bytype.p;
+S << embeds.S;
+@@
+warn(coccilib.report.print_report, p[0],
+     f"devm allocation of struct {S}, which embeds a device node or a v4l2=
_device")
--=20
2.43.0


