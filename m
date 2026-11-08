Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745E606A31C
	for <cocci@archiver.kernel.org>; Sun,  8 Nov 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=tLf7ex+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=F3etujamXLM+JK5u10HNwuJrSi6r/c5zK5W8rx8FsA4=;
  b=tLf7ex+XIQlbhqyeiqrZAP5/3709XTIETE7XwViViUh+4EHI5js2jWqn
   3qy4KG99KbqE5bxaUcmzzhUhXshHiMsSmposX7GJK0Ju/taZwqJgCWIyN
   v2nnc3Pn7Iv58CzF51wGyEM+mLoNhz3f7fXRr7RPTLx3lkYW/ZFmrYFGu
   M=;
X-CSE-ConnectionGUID: rzUSQFd2S1uqaYfX0frQXw==
X-CSE-MsgGUID: H3V1Md9ASfmAYhof54M7Bg==
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
X-IronPort-AV: E=Sophos;i="6.27,202,1787004000"; 
   d="scan'208";a="304431590"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2026 21:10:51 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 99DCD80D37; Sun,  8 Nov 2026 21:10:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 13F47806DF
	for <cocci@sympa.inria.fr>; Sun,  8 Nov 2026 21:10:46 +0100 (CET)
X-CSE-ConnectionGUID: TCStX5SfRXSUR1SP29vOCg==
X-CSE-MsgGUID: 5SqyVe4rS7aazcmnjwQLsw==
X-IronPort-AV: E=Sophos;i="6.27,202,1787004000"; 
   d="scan'208";a="304431582"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 21:10:45 +0100
Date: Sun, 8 Nov 2026 21:10:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Chad Aldreda <ca@modelmiser.com>
cc: Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
In-Reply-To: <20261106193517.3267013-2-ca@modelmiser.com>
Message-ID: <18f23c2b-d76a-8b94-bc4d-f298354c8f8b@inria.fr>
References: <20261106193517.3267013-2-ca@modelmiser.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH] coccinelle: api: add a checker for device nodes
 in devm_ memory
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3786
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/tzREJYj5bw8chaSYayNV5Q>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Fri, 6 Nov 2026, Chad Aldreda wrote:

> A struct cdev, struct miscdevice, struct video_device or struct
> v4l2_device embedded in memory from devm_kzalloc() and friends is freed
> when the driver unbinds, but a file that user space holds open on the
> node outlives the unbind. Its later file operations are a use-after-free
> when they use that memory, and for a cdev or video_device so is its
> close(), where the core touches the object and the v4l2_device the
> video_device points to.
>
> Add a script that reports such allocations: by two rules when the
> allocation, as an assignment or a declaration initializer, and a
> registration of it or of an address taken inside it are written directly
> in one function, and by a third, type-based rule when the struct is
> defined in the same .c file and the node is a direct member of it. A
> registration in a helper function on a struct defined in a header is not
> seen, so cx231xx is reported only through its v4l2_device.
>
> On 7.4-rc1 it reports 101 sites under drivers/, 50 of which are found
> only through a v4l2_device. Not all are actionable: some drivers cannot
> be unbound, and some miscdevice drivers never use the allocation after
> open(); the header lists the false-positive classes and the misses.
>
> Tested with spatch 1.1.1, with make coccicheck MODE=report and MODE=org,
> and on small test files for each allocation form, a struct in a header,
> a registration in a helper, a node in an array member, a registered
> pointer to separate memory, a v4l2_device, an embedded node that is
> never registered and a kzalloc() control.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> ---
> The type rule uses --include-headers-for-types, which reports the same
> 101 sites on every run. With --include-headers it also sees structs
> defined in headers: run on one file at a time, that adds 22 sites on
> 7.4-rc1 (xilinx-vipp and ultrasoc-smb among them). Under --dir, as make
> coccicheck runs it, some are lost. spatch --include-headers --dir
> drivers/media/pci/intel/ipu6 reports nothing, even as a single process,

I get the same result for

spatch --dir drivers/media/pci/intel/ipu6 scripts/coccinelle/api/devm_file_reachable.cocci -D report --very-quiet
spatch drivers/media/pci/intel/ipu6/ipu6-isys.c scripts/coccinelle/api/devm_file_reachable.cocci -D report --very-quiet

Both report the line 990 issue.

What version of Coccinelle do you have?

The output can vary due to some parsing issues.  Some patches from Kees
Cook should help make things more deterministic.

julia


> while the same command on drivers/media/pci/intel/ipu6/ipu6-isys.c alone
> reports line 990. With six jobs the rest vary as well: five runs over
> drivers/ found 15 to 17 of the 22, a different set each time.
>
> So I kept the deterministic option. Is the --dir difference expected,
> and is there a better way to give the type rule header-defined structs?
>
>  .../coccinelle/api/devm_file_reachable.cocci  | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 scripts/coccinelle/api/devm_file_reachable.cocci
>
> diff --git a/scripts/coccinelle/api/devm_file_reachable.cocci b/scripts/coccinelle/api/devm_file_reachable.cocci
> new file mode 100644
> index 0000000000..3847710798
> --- /dev/null
> +++ b/scripts/coccinelle/api/devm_file_reachable.cocci
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Find a struct cdev, struct miscdevice, struct video_device or struct
> +/// v4l2_device embedded in memory from the devm_ allocators.  The memory
> +/// is freed when the driver unbinds, but a file that is open on the node
> +/// outlives the unbind: for a cdev or a video_device the core touches the
> +/// object, and the v4l2_device the video_device points to, on every
> +/// close, and for a miscdevice the driver's file operations usually reach
> +/// it through file->private_data.  Allocate such state with kzalloc() and
> +/// free it on the last reference; see
> +/// Documentation/driver-api/driver-model/devres.rst.
> +///
> +/// The first rules need the allocation and a registration of it, or of an
> +/// address taken inside it, written directly in one function; an
> +/// allocation inside a condition or behind a cast or a wrapper function
> +/// is not seen by them. The type rule catches the rest, but with the
> +/// options below it sees only a struct defined in the .c file itself, not
> +/// in a header, and only a node that is a direct, non-array member of it,
> +/// not one nested in another member. So a registration in a helper
> +/// function, or through any alias of x such as vfd = &x->vdev, is missed
> +/// when the struct is in a header or the node is not such a member. Not
> +/// checked: a struct media_device in devm_ memory, which v4l2_release()
> +/// also reaches; a struct v4l2_subdev with a device node, whose close
> +/// reaches it; a static node whose file operations reach devm_ state
> +/// through a global or drvdata pointer; memory freed by devm_add_action()
> +/// rather than allocated by devm_k*(); a typedef'd struct; and a file or
> +/// function spatch cannot parse.
> +/// False positives: a driver that cannot be unbound (suppress_bind_attrs,
> +/// platform_driver_probe()) on a device that is never removed, a driver
> +/// whose remove() waits for the last close, a miscdevice driver whose file
> +/// operations do not use the allocation after open(), a registration of
> +/// an address that only uses the allocation to reach separate memory
> +/// (&x->ptr->misc, &table[x->idx]), a v4l2_device that no video_device
> +/// points to, and, for the type rule, a struct whose embedded node is not
> +/// registered from this allocation.  When an allocation has several
> +/// registrations, the report names the first one found.
> +///
> +// Confidence: Moderate
> +// Options: --include-headers-for-types
> +
> +virtual org
> +virtual report
> +
> +@initialize:python@
> +@@
> +seen = set()
> +
> +@alloc depends on org || report exists@
> +expression x, e, e2;
> +identifier fn =~ "^devm_k[mzcr]";
> +position p, q;
> +@@
> +
> +x = fn@p(...);
> +... when != x = e
> +(
> +misc_register@q(\(x\|&<+... x ...+>\))
> +|
> +cdev_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +cdev_device_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device_no_warn@q(\(x\|&<+... x ...+>\), ...)
> +|
> +__video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +v4l2_device_register@q(e2, \(x\|&<+... x ...+>\))
> +)
> +
> +@allocdecl depends on org || report exists@
> +identifier x;
> +type T;
> +expression e, e2;
> +identifier fn =~ "^devm_k[mzcr]";
> +position p, q;
> +@@
> +
> +T *x = fn@p(...);
> +... when != x = e
> +(
> +misc_register@q(\(x\|&<+... x ...+>\))
> +|
> +cdev_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +cdev_device_add@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +video_register_device_no_warn@q(\(x\|&<+... x ...+>\), ...)
> +|
> +__video_register_device@q(\(x\|&<+... x ...+>\), ...)
> +|
> +v4l2_device_register@q(e2, \(x\|&<+... x ...+>\))
> +)
> +
> +@embeds depends on org || report@
> +identifier S, f;
> +type T = {struct cdev, struct miscdevice, struct video_device,
> +          struct v4l2_device};
> +@@
> +
> +struct S {
> +  ...
> +  T f;
> +  ...
> +};
> +
> +@bytype depends on org || report@
> +identifier embeds.S;
> +struct S *x;
> +identifier fn =~ "^devm_k[mzcr]";
> +position p;
> +@@
> +
> +x = fn@p(...)
> +
> +@script:python depends on org@
> +p << alloc.p;
> +q << alloc.q;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.org.print_todo(p[0], "WARNING: devm_ memory registered at line %s as a device node or a v4l2_device; an open file outlives unbind" % q[0].line)
> +
> +@script:python depends on report@
> +p << alloc.p;
> +q << alloc.q;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.report.print_report(p[0], "WARNING: devm_ memory registered at line %s as a device node or a v4l2_device; an open file outlives unbind" % q[0].line)
> +
> +@script:python depends on org@
> +p << allocdecl.p;
> +q << allocdecl.q;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.org.print_todo(p[0], "WARNING: devm_ memory registered at line %s as a device node or a v4l2_device; an open file outlives unbind" % q[0].line)
> +
> +@script:python depends on report@
> +p << allocdecl.p;
> +q << allocdecl.q;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.report.print_report(p[0], "WARNING: devm_ memory registered at line %s as a device node or a v4l2_device; an open file outlives unbind" % q[0].line)
> +
> +@script:python depends on org@
> +p << bytype.p;
> +S << embeds.S;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.org.print_todo(p[0], "WARNING: devm_ allocation of struct %s, which embeds a cdev, miscdevice, video_device or v4l2_device" % S)
> +
> +@script:python depends on report@
> +p << bytype.p;
> +S << embeds.S;
> +@@
> +if (p[0].file, p[0].line, p[0].column) not in seen:
> +    seen.add((p[0].file, p[0].line, p[0].column))
> +    coccilib.report.print_report(p[0], "WARNING: devm_ allocation of struct %s, which embeds a cdev, miscdevice, video_device or v4l2_device" % S)
> --
> 2.43.0
>
>
>
